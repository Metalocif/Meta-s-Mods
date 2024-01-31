Mission_SachielBoss = Mission_Boss:new{
	Name = "Sachiel",
	-- islandLock = 3,
	BossPawn = "SachielBoss",
	SpawnStartMod = -3,
	BossText = "Destroy the Angel Sachiel",
}

SachielBoss = {
	Health = 9,
	MoveSpeed = 4,
	Image = "beetle",
	ImageOffset = 2,
	SkillList = { "Sachiel_Punch" },
	Ranged = 0,
	SoundLocation = "/enemy/beetle_1/",
	Massive = true,
	IsDeathEffect = true,
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	Portrait = "enemy/BeetleB",
	Tier = TIER_BOSS,
	IsDeathEffect = true,	--big explosion
}
AddPawn("SachielBoss") 

Sachiel_Punch = Prime_Spear:new{  
	Class = "Enemy",
	LaunchSound = "/weapons/titan_fist",
	Range = 3, -- Tooltip?
	PathSize = 1,
	Damage = 5,
	Push = 1,
	TipImage = StandardTips.Melee
}		--once coded for real, add something to the SkillEffect to instantly heal

function Sachiel_Punch:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local target1 = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	local target2 = GetProjectileEnd(p2,p2+DIR_VECTORS[direction],PATH_PROJECTILE)
	local distance1 = p1:Manhattan(target1)
	local distance2 = p1:Manhattan(target2-DIR_VECTORS[direction])
	if Board:IsBlocked(target2, PATH_PROJECTILE) then target2 = target2 - DIR_VECTORS[direction] end
	--we do this because the projectile may also end on an edge tile or something
	local damage = SpaceDamage(target1, self.Damage)
	ret:AddDamage(SpaceDamage(p1, -1))		--healing to simulate regen, may use vanilla regen anim
	ret:AddQueuedDamage(damage)
	ret:AddQueuedAnimation(p1 + DIR_VECTORS[direction], "sachielspear"..distance2.."_"..direction, ANIM_NO_DELAY)
	ret:AddQueuedCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)
	--if this doesn't deal bump damage, add a manual push at the end or something

	return ret
end	

function SachielBoss:GetDeathEffect(point)
	local ret = SkillEffect()
	--find closest enemy, if found turn to ball, jump on it, explode
	local targets = extract_table(general_DiamondTarget(point, 2))
    for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:IsMech() then
			local move = PointList()
			move:push_back(point)
			move:push_back(targets[k])
			--turn to ball here
			ret:AddLeap(move, FULL_DELAY)
			break
		end
    end
	
	local damage = SpaceDamage(point,2)
	damage.sAnimation = "ExploAir2"
	ret:AddDamage(damage)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir]
		ret:AddDamage(damage)
	end
	ret:AddDelay(0.25)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4]
		ret:AddDamage(damage)
	end
	ret:AddDelay(0.25)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir] *2
		ret:AddDamage(damage)
	end
	return ret
end