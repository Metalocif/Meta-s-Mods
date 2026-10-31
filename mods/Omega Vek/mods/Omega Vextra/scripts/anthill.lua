OmegaAnthillAtk2 = Skill:new {
	Name = "Fecund Ground",
	Description = "Spawn soldier, flying or worker ants. Spawn stronger ants at higher health. While the anthill is alive, they explode on death.",
	Damage = 0,
	Class = "Enemy",
	LaunchSound = "/enemy/shaman_1/attack_launch",
	ImpactSound = "/enemy/spider_boss_1/attack_egg_land",
	Spawns = {"OmegaWorkerAnt1","OmegaWorkerAnt1","OmegaFAnt1","OmegaSoldierAnt1"},
	DoubleSpawn = false,
	TipImage = {
		Unit = Point(2,2),
		Building = Point(2,1),
		Target = Point(3,1),
		Second_Origin = Point(3,1),
		Second_Target = Point(2,1),
		CustomPawn = "OmegaDNT_Anthill2",
	}
}
function OmegaAnthillAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 7 do
			local curr = point + DIR_VECTORS[i] * j
			local curr2 = curr + DIR_VECTORS[(i+1)%4]
			ret:push_back(curr)
			ret:push_back(curr2)
		end
	end

	return ret
end

function OmegaAnthillAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local mission = GetCurrentMission()

	local spawn = math.min(Pawn:GetHealth(), #self.Spawns)

	local damage = SpaceDamage(p2)
	damage.sPawn = self.Spawns[spawn]

	ret:AddArtillery(damage,"effects/"..self.Spawns[spawn].."_upshot.png")
	
	if self.DoubleSpawn then
		for dir = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[dir]
			local bossDamage = SpaceDamage(curr)
			bossDamage.sPawn = self.Spawns[spawn]
			if not Board:IsBlocked(curr, PATH_GROUND) then ret:AddArtillery(bossDamage,"effects/"..self.Spawns[spawn].."_upshot.png") break end
		end
	end

	if Board:IsTipImage() then ret:AddDelay(3) end

	return ret
end

function OmegaAnthillAtk2:GetTargetScore(p1, p2)
    local ret = 1
	if Board:IsBlocked(p2,PATH_GROUND) or Board:IsPod(p2) then
		ret = -100
	else
		local bonus = 0
		for i = DIR_START, DIR_END do
			local point = p2 + DIR_VECTORS[i]
			if Board:IsBuilding(point) or (Board:GetPawn(point) and Board:GetPawn(point):GetTeam() == TEAM_PLAYER) then
				bonus = 1
			end
		end
		ret = ret + bonus
	end
	return ret
end

OmegaAnthillAtkB = OmegaAnthillAtk2:new{DoubleSpawn=true,Class = "Enemy",Name = "Effusive Ground",}

----------
-- Ants --
----------

local function BoardHasOmegaAnthill()
	-- for _, point in ipairs(Board) do
		-- if Board:GetPawn(point) and Board:GetPawn(point):GetType() == "OmegaDNT_Anthill2" then return true end
	-- end
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(id) and Board:GetPawn(id):GetType() == "OmegaDNT_Anthill2" then return true end
	end
	--not sure which is faster
	return false
end

OmegaWorkerAnt1 = Pawn:new
{
	Name = "Worker Ant",
	Health = 2,
	MoveSpeed = 2,
	SpawnLimit = false,
	Image = "Omegaworkerant", --lowercase
	ImageOffset = 0,
	Portrait = "enemy/OmegaWorkerAnt1",
	SkillList = {"OmegaWorkerAntAtk"},
	SoundLocation = "/enemy/spiderling_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Minor = true,
	GetExplodes = BoardHasOmegaAnthill,
}
AddPawn("OmegaWorkerAnt1")

-- FAnt
OmegaFAnt1 = Pawn:new
{
	Name = "Flying Ant",
	Health = 2,
	MoveSpeed = 2,
	Flying = true,
	SpawnLimit = false,
	Image = "Omegafant", --lowercase
	ImageOffset = 0,
	Portrait = "enemy/OmegaFAnt1",
	SkillList = {"OmegaFAntAtk"},
	SoundLocation = "/enemy/hornet_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Minor = true,
	GetExplodes = BoardHasOmegaAnthill,
}
AddPawn("OmegaFAnt1")

-- SoldierAnt
OmegaSoldierAnt1 = Pawn:new
{
	Name = "Soldier Ant",
	Health = 2,
	MoveSpeed = 3,
	SpawnLimit = false,
	Image = "Omegasoldierant",
	ImageOffset = 0,
	Portrait = "enemy/OmegaSoldierAnt1",
	SkillList = {"OmegaSoldierAntAtk"},
	SoundLocation = "/enemy/spiderling_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Minor = true,
	GetExplodes = BoardHasOmegaAnthill,
}
AddPawn("OmegaSoldierAnt1")


OmegaWorkerAntAtk = Skill:new {
	Name = "Cutting Bite",
	Description = "Prepares to bite an adjacent tile",
	Damage = 1,
	SelfDamage = 1,
	StrikeAnim = "SwipeClaw1",
	Class = "Enemy",
	LaunchSound = "",
	PathSize = 1,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "OmegaWorkerAnt1",
	}
}

OmegaSoldierAntAtk = DNT_WorkerAntAtk:new {
	Name = "Slashing Bite",
	Damage = 2,
	SelfDamage = 1,
	StrikeAnim = "SwipeClaw2",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "OmegaSoldierAnt1",
	}
}

function OmegaWorkerAntAtk:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2,self.Damage)
	damage.sSound = "/enemy/leaper_1/attack"
	damage.sAnimation = self.StrikeAnim
	ret:AddQueuedDamage(damage)
	ret:AddQueuedDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end

OmegaFAntAtk = OmegaWorkerAntAtk:new {
	Name = "Sharp Sting",
	Description = "Prepares to sting an adjacent tile",
	Damage = 1,
	SelfDamage = 1,
	StrikeAnim = "explomosquito_",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "OmegaFAnt1",
	}
}

function OmegaFAntAtk:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2,self.Damage)
	damage.sSound = "/enemy/hornet_1/attack"
	damage.sAnimation = self.StrikeAnim ..dir
	ret:AddQueuedDamage(damage)
	ret:AddQueuedDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end
