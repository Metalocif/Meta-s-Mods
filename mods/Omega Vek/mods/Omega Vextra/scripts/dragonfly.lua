
OmegaDragonflyAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Conflagration",
	Description = "Smoke all adjacent tiles, preparing to explode target smoke. If the user is on smoke, they explode instead, dying and damaging adjacent tiles.",
	Class = "Enemy",
	Webbing = false,
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaDragonfly2"
	}
}

function OmegaDragonflyAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local sound = SpaceDamage(p2)
	ret:AddDamage(SoundEffect(p2,self.SoundBase.."/attack_smoke"))
	for i = DIR_START, DIR_END do
		local smokeMaker = SpaceDamage(p1 + DIR_VECTORS[i])
		smokeMaker.iSmoke = 1
		ret:AddDamage(smokeMaker)
	end
	
	if Board:IsSmoke(p1) then
		local damage = SpaceDamage(p1, DAMAGE_KILL)
		ret:AddQueuedDamage(damage)
		for i = DIR_START, DIR_END do
			ret:AddQueuedDamage(SpaceDamage(p1+DIR_VECTORS[i], self.Damage))
		end
	elseif Board:IsSmoke(p2) then
		for i = DIR_START, DIR_END do
			if p2+DIR_VECTORS[i] ~= p1 then ret:AddQueuedDamage(SpaceDamage(p2+DIR_VECTORS[i], self.Damage)) end
		end
	else
		local damage = SpaceDamage(p2, self.Damage)
		damage.iFire = 1
		ret:AddQueuedMelee(p1, damage)
	end
	
	return ret
end	

function OmegaDragonflyAtk2:GetTargetScore(p1,p2)
	local ret = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsQueued() then ret = ret - 100 end
		if pawn and pawn:IsFire() then
			if pawn:GetTeam() == TEAM_ENEMY then
				ret = ret + 2
			else
				ret = ret - 2
			end
		elseif Board:IsFire(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then
			ret = ret + 1
		end
	end
	if Board:GetTerrain(p2) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
    return ret
end


OmegaDragonflyAtkB = OmegaDragonflyAtk2:new{Damage=3,Class = "Enemy",Name = "Deflagration",}