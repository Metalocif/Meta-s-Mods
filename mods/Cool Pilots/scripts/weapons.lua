local path = mod_loader.mods[modApi.currentMod].resourcePath
local worldConstants = require(mod_loader.mods.meta_mods.scriptPath .."libs/worldConstants")
-- local BoardEvents = require(mod_loader.mods.meta_mods.scriptPath.."libs/boardEvents")
local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")

-- modApi:appendAsset("img/effects/burrow_openclose.png", path .."img/effects/burrow_openclose.png")




local function isDeadlyDamage(damage, pawn)
	--isDeadly doesn't work right with ACID? so I made my own
	--this ignores push, look at Tatu's implementation for that
	if not pawn then return false end
	if damage.loc ~= pawn:GetSpace() then return false end
	if damage.iDamage == DAMAGE_DEATH then return true end
	if damage.iDamage == DAMAGE_ZERO then return false end
	if ANIMS.tosx_whirlpooltile ~= nil and customAnim:get(pawn:GetSpace(), "tosx_whirlpooltile") then return true end
	if pawn:IsShield() or pawn:IsFrozen() then return false end
	
	local damageAmount = damage.iDamage
	if pawn:IsBoosted() then damageAmount = damageAmount + 1 end
	if pawn:IsAcid() then 
		damageAmount = damageAmount * 2
	elseif pawn:IsArmor() then
		damageAmount = damageAmount - 1
	end
	if Board:GetCustomTile(damage.loc) == "tosx_rocks_0.png" then damageAmount = 0 end

	return damageAmount >= pawn:GetHealth()
end

MonsterHunter_Trophy = Skill:new{
	Name = "Trophy",
	Class = "",
	Icon = "weapons/Trophy.png",
	Description = "A trophy carved from the remains of a large Vek. Impractical in battle, but can be traded for reputation.",
	Damage = 0,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 0,
}

function MonsterHunter_Trophy:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	ret:AddMelee(p1, SpaceDamage(p2, amount, GetDirection(p2 - p1)))
	return ret
end

MonsterHunter_ScorpionSNS = Skill:new{
	Name = "Scorpion Sword&Shield",
	Class = "Prime",
	Icon = "weapons/ScorpionSNS.png",
	Description = "Strike a target, then push a target.",
	Damage = 1,
	PathSize = 1,
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "Leap Attack" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_ScorpionSNS:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+DIR_VECTORS[i])
		if self.LeapAttack then 
			for j = 3, 8 do
				local curr = point+DIR_VECTORS[i]*j
				if not Board:IsBlocked(curr - DIR_VECTORS[i], PATH_PROJECTILE) then ret:push_back(curr) end
			end
		end
	end
	return ret
end

function MonsterHunter_ScorpionSNS:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	if p1:Manhattan(p2) > 1 then	--we leapt
		for i = DIR_START, DIR_END do
			ret:push_back(p2-DIR_VECTORS[GetDirection(p2-p1)]+DIR_VECTORS[i])
		end
	else
		for i = DIR_START, DIR_END do
			ret:push_back(p1+DIR_VECTORS[i])
		end
	end
	return ret
end

function MonsterHunter_ScorpionSNS:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	ret:AddDamage(SpaceDamage(p2, amount))
	return ret
end

function MonsterHunter_ScorpionSNS:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local origin = p1
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local leap
	if p1:Manhattan(p2) > 1 then leap = true end
	if leap then 
		origin = p2 - DIR_VECTORS[dir]
		ret:AddLeap(p1,origin)
	end
	local dir2 = GetDirection(p3-origin)
	local damage = SpaceDamage(p2, amount)
	if leap then damage.iPush = dir end
	ret:AddMelee(origin, damage)
	ret:AddMelee(origin, SpaceDamage(p3, 0, dir2))
	--needs animations, damage1 can be AddDamage if jumpy with animation
	return ret
end

MonsterHunter_ScorpionSNS_A = MonsterHunter_ScorpionSNS:new{UpgradeDescription = "Can perform a leap attack against distant targets, damaging and pushing them.",LeapAttack = true,}


MonsterHunter_BeetleL = Skill:new{
	Name = "Beetle Lance",
	Class = "Brute",
	Icon = "weapons/BeetleL.png",
	Description = "Either damage and push an adjacent target or charge at a distant target, damaging two tiles in a row.",
	Damage = 2,
	PathSize = 8,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList = { "+2 Damage" },
	ZoneTargeting = ZONE_ALL,
}


function MonsterHunter_BeetleL:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount)
	if p1:Manhattan(p2) == 1 then
		damage.iPush = dir
		damage.sAnimation = "explospear1_"..dir
		ret:AddMelee(p1, damage)
	else
		local doDamage = true
		local target = GetProjectileEnd(p1,p2)
		
		if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
			doDamage = false
			target = target + DIR_VECTORS[dir]
		end
		
		damage.loc = target
		damage.sAnimation = "ExploAir2"
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[dir]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			ret:AddBounce(temp,-3)
			temp = temp + DIR_VECTORS[dir]
			if temp ~= target then ret:AddDelay(0.06) end
		end
		
		if doDamage then 
			damage.sAnimation = "explospear2_"..dir
			ret:AddDamage(damage) 
			ret:AddDamage(SpaceDamage(target + DIR_VECTORS[dir], amount)) 
		end
	end
	return ret
end

MonsterHunter_BeetleL_A = MonsterHunter_BeetleL:new{UpgradeDescription = "Deals 2 more damage.", Damage = 4,}


MonsterHunter_RockHH = Skill:new{
	Name = "Rock Hunting Horn",
	Class = "Prime",
	Icon = "weapons/RockHH.png",
	Description = "Bash a target, fully upgrading ally weapons for one turn if it kills.",
	OnKill = "Full Upgrades",
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList = { "+2 Damage" },
	ZoneTargeting = ZONE_ALL,
}


function MonsterHunter_RockHH:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount, DIR_FLIP)
	damage.sAnimation = "explosmash_"..GetDirection(p2-p1)
	ret:AddMelee(p1, damage)
	if isDeadlyDamage(damage, Board:GetPawn(p2)) then
		for i = 0, 2 do
			if Board:GetPawn(i) and i ~= pawn:GetId() then 
				local damage = SpaceDamage(Board:GetPawn(i):GetSpace())
				damage.iGlory = 1
				ret:AddDamage(damage)
			end
		end
	end
	return ret
end

MonsterHunter_RockHH_A = MonsterHunter_RockHH:new{UpgradeDescription = "Deals 2 more damage.", Damage = 4,}


MonsterHunter_HornetBG = Skill:new{
	Name = "Hornet Bowgun",
	Self = "MonsterHunter_HornetBG",
	Class = "Ranged",
	Icon = "weapons/HornetBG.png",
	Projectile = "effects/needle",
	Description = "Fires three needles at a target, or five needles in an area.",
	Damage = 1,
	MinDamage = 1,
	Shots = 3,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList = { "+2 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_HornetBG:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(point + DIR_VECTORS[i]*j)
		end
	end
	return ret
end

function MonsterHunter_HornetBG:GetSkillEffect(p1, p2, remainingShots)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if p1:Manhattan(p2) == 1 then 
		local target = GetProjectileEnd(p1,p2)
		local damage = SpaceDamage(target, self.MinDamage)
		if remainingShots == nil then remainingShots = self.Shots end
		damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
		if remainingShots == 1 then damage.iDamage = self.Damage end
		ret:AddProjectile(p1, damage, self.Projectile, NO_DELAY)
		ret:AddDelay(0.15)
		if self.Self == "MonsterHunter_HornetBG_A" and remainingShots == 1 then ret:AddDelay(0.35) end	--more oomph
		if remainingShots > 1 then
			remainingShots = remainingShots - 1
			ret:AddScript(string.format([=[
				local fx = SkillEffect();
				fx:AddScript([[
					Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
				]]);
				Board:AddEffect(fx);
			]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
		end
	else
		ret:AddArtillery(p1, SpaceDamage(p2+DIR_VECTORS[0], self.MinDamage), "effects/shotup_needle.png", NO_DELAY)
		ret:AddDelay(0.1)
		ret:AddArtillery(p1, SpaceDamage(p2+DIR_VECTORS[1], self.MinDamage), "effects/shotup_needle.png", NO_DELAY)
		ret:AddDelay(0.1)
		ret:AddArtillery(p1, SpaceDamage(p2+DIR_VECTORS[2], self.MinDamage), "effects/shotup_needle.png", NO_DELAY)
		ret:AddDelay(0.1)
		ret:AddArtillery(p1, SpaceDamage(p2+DIR_VECTORS[3], self.MinDamage), "effects/shotup_needle.png", NO_DELAY)
		ret:AddDelay(0.1)
		if self.Self == "MonsterHunter_HornetBG_A" then ret:AddDelay(0.4) end	--more oomph
		ret:AddArtillery(p1, SpaceDamage(p2, amount), "effects/shotup_needle.png", NO_DELAY)
	end
	return ret
end

MonsterHunter_HornetBG_A = MonsterHunter_HornetBG:new{UpgradeDescription = "The final needle deals +2 damage.", Damage = 3, Self = "MonsterHunter_HornetBG_A",}


MonsterHunter_TumblebugH = Skill:new{
	Name = "Tumblebug Hammer",
	Class = "Prime",
	Icon = "weapons/TumblebugH.png",
	Description = "Slam a target, pushing and damaging adjacent tiles.",
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_TumblebugH:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount)
	damage.sAnimation = "explosmash_"..GetDirection(p2-p1)
	ret:AddMelee(p1, damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		if curr ~= p1 then 
			ret:AddDamage(SpaceDamage(curr, amount - 1, i))
		end
	end
	return ret
end

MonsterHunter_TumblebugH_A = MonsterHunter_TumblebugH:new{UpgradeDescription = "Deals 1 more damage.", Damage = 3,}


MonsterHunter_PsionIG = Skill:new{
	Name = "Psion Insectglaive",
	Class = "Brute",
	Icon = "weapons/PsionIG.png",
	Description = "Slash a melee target or fire a pushing Kinsect. Deals more melee damage for each different Vek type hit by the Kinsect this mission.",
	MinDamage = 1,
	Damage = 2,
	PathSize = 8,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

Location["effects/kinsect.png"] = Point(-5,0)

function MonsterHunter_PsionIG:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local bonusDamage = 0
	local mission = GetCurrentMission()
	if mission then 
		mission.PsionIGKinsectHits = mission.PsionIGKinsectHits or {} 
		if mission and mission.PsionIGKinsectHits then
			for _ in pairs(mission.PsionIGKinsectHits) do
				bonusDamage = bonusDamage + 1
			end
		end
	end
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if p1:Manhattan(p2) == 1 then
		local damage = SpaceDamage(p2, amount + bonusDamage)
		damage.sAnimation = "SwipeClaw2"
		ret:AddMelee(p1, damage)
	else
		ret:AddProjectile(p1, SpaceDamage(target, amount + self.MinDamage - self.Damage, dir), "effects/kinsect", PROJ_DELAY)
		local dummy = SpaceDamage(p1)
		
		local pawn = Board:GetPawn(target)
		if pawn and pawn:IsEnemy() then
			local vekSupertype = string.sub(pawn:GetType(), 1, -2)
			if string.sub(pawn:GetType(), -4, -1) == "Boss" then vekSupertype = string.sub(pawn:GetType(), 1, -5) end
			if not GetCurrentMission().PsionIGKinsectHits[vekSupertype] then
				ret:AddScript(string.format("GetCurrentMission().PsionIGKinsectHits[%q] = true", vekSupertype))
				ret:AddScript(string.format("Board:Ping(%s, GL_COLOR(150, 255, 150))", p1:GetString()))
				dummy.sImageMark = "effects/kinsect.png"
			end
		end
		ret:AddProjectile(target, dummy, "effects/kinsect", PROJ_DELAY)
	end
	return ret
end

MonsterHunter_PsionIG_A = MonsterHunter_PsionIG:new{UpgradeDescription = "Deals 1 more damage.", Damage = 3,}


MonsterHunter_SpiderIG = Skill:new{
	Name = "Spider Insectglaive",
	Class = "Brute",
	Icon = "weapons/SpiderIG.png",
	Description = "Leap over a melee target, flipping its attack direction, or fire a pushing spider egg.",
	Damage = 2,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

MonHunSpiderlingEgg ={
	Name = "Spider Egg",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 0,
	Image = "webling_egg1",
	Minor = true,
	Neutral = true,
	IgnoreSmoke = true,
	IsPortrait = false,
	DefaultTeam = TEAM_PLAYER,
	SkillList = { "meta_Hatch1" },
	SoundLocation = "/enemy/spiderling_egg/",
	ImpactMaterial = IMPACT_FLESH,
}
	
AddPawn("MonHunSpiderlingEgg")

meta_Hatch1 = SelfTarget:new{ 
	Name = "Hatch",
	Description = "Hatch into a spiderling.",
	Class = "TechnoVek",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "MonHunSpiderlingEgg",
	}
}

function meta_Hatch1:GetTargetScore(p)
	return 10
end

function meta_Hatch1:GetTargetArea(p)
	ret = PointList()
	ret:push_back(p)
	return ret
end

function meta_Hatch1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	ret:AddScript(string.format([[
	modApi:conditionalHook(
	function()
		return Game:GetTeamTurn() == TEAM_PLAYER
	end,
	function()
		local unit = PAWN_FACTORY:CreatePawn(%q)
		local p1 = %s
		unit:SetActive(false)
		if Board:GetPawn(p1) then 
			unit:SetOwner(Board:GetPawn(p1):GetOwner())
			Board:GetPawn(p1):Kill(false) 
			Board:AddPawn(unit,p1) 
		end
	end)]], "meta_Spiderling", user:GetId()))	
	--dirty hack because if it spawns on enemy turn the game queues it as though it were an enemy???
	--for some reason just spawning a thing and doing SetActive(false) does not help
	return ret
end

meta_Spiderling = {
	Name = "Spiderling",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Image = "Meta_spiderling",
	SkillList = { "meta_SpiderlingAtk1" },
	SoundLocation = "/enemy/spiderling_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Portrait = "enemy/Spider1"
}
AddPawn("meta_Spiderling")  

meta_SpiderlingAtk1 = Skill:new{
	Name = "Tiny Mandibles",
	Description = "Weak 1 damage attack against a single adjacent target.",
	Class = "TechnoVek",
	Icon = "weapons/spiderling.png",
	PathSize = 1, 
	Damage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "meta_Spiderling"
	}
}

function meta_SpiderlingAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,self.Damage)
	ret:AddMelee(p1,damage)
	return ret
end

function MonsterHunter_SpiderIG:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		if not Board:IsBlocked(point + DIR_VECTORS[i]*2, PATH_MASSIVE) then ret:push_back(point + DIR_VECTORS[i]) end
		for j = 1, 8 do
			ret:push_back(point + DIR_VECTORS[i]*j)
			if Board:IsBlocked(point + DIR_VECTORS[i]*j, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function MonsterHunter_SpiderIG:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if p1:Manhattan(p2) == 1 then
		ret:AddLeap(p1, p1 + DIR_VECTORS[dir] * 2)
		local damage = SpaceDamage(p1 + DIR_VECTORS[dir], amount, DIR_FLIP)
		damage.sAnimation = "SwipeClaw2"
		ret:AddDamage(damage)
	else
		local damage = SpaceDamage(target, 0, dir)
		ret:AddProjectile(p1, damage, "effects/spiderlingegg", PROJ_DELAY)
		local spawnDamage = SpaceDamage(target - DIR_VECTORS[dir])
		spawnDamage.sPawn = "MonHunSpiderlingEgg"
		ret:AddArtillery(target, spawnDamage, "effects/shotup_spiderlingegg.png", PROJ_DELAY)
	end
	return ret
end

MonsterHunter_SpiderIG_A = MonsterHunter_SpiderIG:new{UpgradeDescription = "Deals 1 more damage.", Damage = 3,}


MonsterHunter_BouncerGS = Skill:new{
	Name = "Bouncer Greatsword",
	Class = "Brute",
	Icon = "weapons/BouncerGS.png",
	Description = "Leap to strike a melee target, pushing all adjacent tiles on landing and dealing damage equal to distance crossed.",
	MinDamage = 1,
	Damage = 3,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Range" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_BouncerGS:GetTargetArea(point)
	local ret = PointList()
	local pawn = Board:GetPawn(point)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	for i = DIR_START, DIR_END do
		if not Board:IsBlocked(point + DIR_VECTORS[i]*2, PATH_MASSIVE) then ret:push_back(point + DIR_VECTORS[i]) end
		for j = 1, amount do
			ret:push_back(point + DIR_VECTORS[i]*j)
			if Board:IsBlocked(point + DIR_VECTORS[i]*j, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function MonsterHunter_BouncerGS:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if p1:Manhattan(p2) == 1 then
		local damage = SpaceDamage(p2, self.MinDamage, dir)
		damage.sAnimation = "explosmash_"..dir
		ret:AddMelee(p1, damage)
	else
		ret:AddLeap(p1, p2 - DIR_VECTORS[dir])
		local damage = SpaceDamage(p2, math.min(amount, p1:Manhattan(p2)), dir)
		damage.sAnimation = "explosmash_"..dir
		ret:AddDamage(damage)
		for i = DIR_START, DIR_END do
			local curr = p2 - DIR_VECTORS[dir] + DIR_VECTORS[i]
			local pushDamage = SpaceDamage(curr, 0, i)
			pushDamage.sAnimation = "airpush_"..i
			if p2 ~= curr then ret:AddDamage(pushDamage) end
		end
	end
	return ret
end

MonsterHunter_BouncerGS_A = MonsterHunter_BouncerGS:new{UpgradeDescription = "Can target 1 tile further.", Damage = 4, PathSize = 4}


MonsterHunter_ScarabHH = Skill:new{
	Name = "Scarab Hunting Horn",
	Class = "Prime",
	Icon = "weapons/ScarabHH.png",
	Description = "Bash a target, pushing it sideways. Boosts allies and increases their movement speed.",
	Damage = 1,
	PathSize = 1,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList = { "+2 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_ScarabHH:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount, (dir+1)%4)
	damage.sAnimation = "explosmash_"..dir
	ret:AddMelee(p1, damage)
	if isDeadlyDamage(damage, Board:GetPawn(p2)) then
		for i = 0, 2 do
			if i ~= Board:GetPawn(p1):GetId() then 
				ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", i)) 
				ret:AddScript(string.format("Board:GetPawn(%s):AddMoveBonus(1)", i)) 
			end
		end
	end
	return ret
end

MonsterHunter_ScarabHH_A = MonsterHunter_ScarabHH:new{UpgradeDescription = "Deals 2 more damage.", Damage = 3,}


MonsterHunter_CentipedeLS = Skill:new{  
	Name = "Centipede Longsword",
	Description = "Charge through units, damaging them and applying A.C.I.D..",
	Class = "Prime",
	Icon = "weapons/CentipedeLS.png",
	Rarity = 2,
	LaunchSound = "/weapons/shield_bash",
	BladeSound = "/weapons/sword",
	Damage = 2,
	Phasing = 1,
	Range = 7,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeList = { "+1 Damage" },
	UpgradeCost = { 2 },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,0),
	}
}

MonsterHunter_CentipedeLS_A = MonsterHunter_CentipedeLS:new{UpgradeDescription = "Increases damage by 1.",Damage = 3,}

function MonsterHunter_CentipedeLS:GetTargetArea(p1)
	local ret = PointList()
	--ret = Board:GetReachable(p1, self.Range, PATH_FLYER)	
	for dir = DIR_START, DIR_END do
		local stillgood = true
		local max_i = 0
		for i = 1,self.Range do
			local point = p1 + DIR_VECTORS[dir]*i
			if stillgood and not Board:IsBlocked(point, Board:GetPawn(p1):GetPathProf()) then
				--ret:push_back(point)
				max_i = i
			end
			if self.Phasing ~= 1 and (Board:IsBuilding(point) or Board:IsTerrain(point,TERRAIN_MOUNTAIN)) then -- UPDATE!
				stillgood = false --needed?
				break
			end
		end
		if max_i > 0 then
			for i = 1,max_i do
				point = p1 + DIR_VECTORS[dir]*i
				ret:push_back(point)
			end
		end
	end
	return ret
end

function MonsterHunter_CentipedeLS:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local endcharge = p2
	local direction = GetDirection(p2 - p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	-- air graphics to emphasize speed.
	local damage0 = SpaceDamage(p1, 0)
	damage0.sAnimation = "airpush_".. ((direction+2)%4)
	ret:AddDamage(damage0)
	ret:AddDelay(0.5)
	
	-- Jump target to next open tile
	if Board:IsBlocked(p2, pawn:GetPathProf()) then
		for i = 1,6 do
			local point2 = p2 + DIR_VECTORS[direction]*i
			if not Board:IsBlocked(point2, pawn:GetPathProf()) then
				endcharge = point2
				break
			end
		end
	end
    local distance = p1:Manhattan(endcharge)
	
	-- Charge really fast
	local superspeed = 4
	worldConstants.SetSpeed(ret, superspeed+1)
	ret:AddCharge(Board:GetPath(p1, endcharge, PATH_FLYER), NO_DELAY)
	worldConstants.ResetSpeed(ret)
	ret:AddDelay(0.06)
	
	-- Add the "blade" projectile
	if distance > 1 then
		worldConstants.SetSpeed(ret, superspeed)
		local dummydamage = SpaceDamage(endcharge)
		dummydamage.bHide = true
		ret:AddProjectile(dummydamage, "effects/shot_katana",NO_DELAY)
		worldConstants.ResetSpeed(ret)
		
		-- Add another "blade" projectile if damage upgraded
		if amount > 2 then
			ret:AddDelay(0.01)
			worldConstants.SetSpeed(ret, superspeed)
			ret:AddProjectile(dummydamage, "effects/shot_katana",NO_DELAY)
			worldConstants.ResetSpeed(ret)
		end
	end
	
	ret:AddSound(self.BladeSound)
	
	for i = 1,distance-1 do
		--ret:AddDelay(0.06)
		ret:AddDelay(0.02)
		local midpoint = p1 + DIR_VECTORS[direction]*i
		
		local dodamage = true
		if Board:IsBuilding(midpoint) then
			dodamage = false
		end
		
		if dodamage == true then
			local damage = SpaceDamage(midpoint,amount)
			damage.iAcid = 1
			ret:AddDamage(damage)
		end
	end	
	
	return ret
end


MonsterHunter_CrabB = Skill:new{
	Name = "Crab Bow",
	Class = "Brute",
	Icon = "weapons/CrabB.png",
	Description = "Fire a pushing arrow. Deals 1 more damage if the target is exactly 3 tiles away.",
	MinDamage = 2,
	Damage = 3,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1/+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_CrabB:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.MinDamage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(target, amount, dir)
	if p1:Manhattan(target) == 3 then damage.iDamage = amount + self.Damage - self.MinDamage end
	ret:AddProjectile(damage, "effects/crabarrow")
	return ret
end

MonsterHunter_CrabB_A = MonsterHunter_CrabB:new{UpgradeDescription = "Increases damage and critical damage by 1 each.",MinDamage = 3,Damage =5,}



MonsterHunter_BlobberBG = Skill:new{
	Name = "Blobber Bowgun",
	Class = "Brute",
	Icon = "weapons/BlobberBG.png",
	Description = "Fire a pushing blob. The impact also pushes adjacent tiles.",
	Damage = 1,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_BlobberBG:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(target, amount, dir)
	ret:AddProjectile(damage, "effects/shot_blob")
	ret:AddDamage(SpaceDamage(target+DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4))
	ret:AddDamage(SpaceDamage(target+DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4))
	return ret
end

MonsterHunter_BlobberBG_A = MonsterHunter_BlobberBG:new{UpgradeDescription = "Increases damage by 1.",Damage = 2,}


MonsterHunter_FireflyGL = Skill:new{
	Name = "Firefly Gunlance",
	Class = "Brute",
	Icon = "weapons/FireflyGL.png",
	Description = "Push an adjacent target, then fire a pushing shell with recoil.",
	Damage = 1,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_FireflyGL:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end

function MonsterHunter_FireflyGL:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(p1 + DIR_VECTORS[i]*2)
	end
	return ret
end

function MonsterHunter_FireflyGL:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount, dir)
	
	ret:AddMelee(p1, damage)
	return ret
end

function MonsterHunter_FireflyGL:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p3)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount, dir)
	damage.sAnimation = "explospear1_"..dir
	ret:AddMelee(p1, damage)
	local projectileDamage = SpaceDamage(target, 0, dir)
	projectileDamage.sAnimation = "airpush_"..dir
	ret:AddDamage(SpaceDamage(p1, 0, (dir+2)%4))
	ret:AddProjectile(p1, projectileDamage, "effects/needle")
	return ret
end

MonsterHunter_FireflyGL_A = MonsterHunter_FireflyGL:new{UpgradeDescription = "Deals 1 more damage.", Damage = 2,}


MonsterHunter_CrusherGS = Skill:new{
	Name = "Crusher Greatsword",
	Class = "Brute",
	Icon = "weapons/CrusherGS.png",
	Description = "Strike an adjacent target. Can also charge the attack until the Vek's turn to increase damage by 1, or charge the attack until the end of the Vek's turn to increase damage by 3.",
	MinDamage = 2,
	Damage = 5,
	Self = "MonsterHunter_CrusherGS",
	PathSize = 3,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1/+1/+2 Damage" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,0),
	}
}

function MonsterHunter_CrusherGS:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 3 do
			ret:push_back(point + DIR_VECTORS[i]*j)
		end
	end
	return ret
end

function MonsterHunter_CrusherGS:GetSkillEffect(p1, p2, doItNow)
	local ret = SkillEffect()
	
	local dir = GetDirection(p2-p1)
	local target = p1 + DIR_VECTORS[dir]
	local dist = p1:Manhattan(p2)
	local pawn = Board:GetPawn(p1)
	local bonus = 0
	if pawn and pawn:GetAbility() == "MonHunSkill" then bonus = 1 end
	if doItNow then
		local damage = SpaceDamage(target, self.Damage + bonus)
		damage.sAnimation = "explosmash_"..dir
		ret:AddMelee(p1, damage)
		ret:AddBounce(target, 5)
		ret:AddScript("Board:StartShake(0.3")
	elseif dist == 1 then
		local damage = SpaceDamage(target, self.MinDamage + bonus)
		damage.sAnimation = "explosmash_"..dir
		ret:AddMelee(p1, damage)
	elseif dist == 2 then
		local damage = SpaceDamage(target, self.MinDamage + 1 + bonus)
		damage.sAnimation = "explosmash_"..dir
		ret:AddQueuedMelee(p1, damage)
		ret:AddBounce(target, 2)
	elseif dist == 3 then
		ret:AddScript(string.format("GetCurrentMission()[%q] = %s", self.Self..Board:GetPawn(p1):GetId(), dir))	--store that, resolve it through a hook later
		ret:AddQueuedDamage(SpaceDamage(target, self.Damage + bonus))				--fake a queued attack for visuals, cancel it later
	end
	return ret
end

MonsterHunter_CrusherGS_A = MonsterHunter_CrusherGS:new{UpgradeDescription = "Deals more damage.", MinDamage = 3, Damage = 7, Self = "MonsterHunter_CrusherGS",}

local function MonHunVeryQueuedAttack(mission)
	for i = 0, 2 do
		if mission["MonsterHunter_CrusherGS"..i] ~= nil and Board:GetPawn(i) and not Board:GetPawn(i):IsDead() then
			Board:AddEffect(_G["MonsterHunter_CrusherGS"]:GetSkillEffect(Board:GetPawn(i):GetSpace(), Board:GetPawn(i):GetSpace()+ DIR_VECTORS[mission["MonsterHunter_CrusherGS"..i]], true))
			mission["MonsterHunter_CrusherGS"..i] = nil
		end
		if mission["MonsterHunter_CrusherGS_A"..i] ~= nil and Board:GetPawn(i) and not Board:GetPawn(i):IsDead() then
			Board:AddEffect(_G["MonsterHunter_CrusherGS_A"]:GetSkillEffect(Board:GetPawn(i):GetSpace(), Board:GetPawn(i):GetSpace()+ DIR_VECTORS[mission["MonsterHunter_CrusherGS_A"..i]], true))
			mission["MonsterHunter_CrusherGS_A"..i] = nil
		end
	end
end

local function MonHunCancelQueuedAttack(mission)	--used for preview of very queued only
	for i = 0, 2 do
		if mission["MonsterHunter_CrusherGS_A"..i] ~= nil and Board:GetPawn(i) and not Board:GetPawn(i):IsDead() then
			Board:GetPawn(i):ClearQueued()
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addNextTurnHook(MonHunVeryQueuedAttack)
	modApi:addPreEnvironmentHook(MonHunCancelQueuedAttack)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


MonsterHunter_StarfishDB = Skill:new{
	Name = "Starfish Dual Blades",
	Class = "Prime",
	Icon = "weapons/StarfishDB.png",
	Description = "Strike two adjacent targets.",
	Damage = 1,
	PathSize = 1,
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeCost = { 1, 1 },
	UpgradeList = { "Shock", "Powder" },
	ZoneTargeting = ZONE_ALL,
}
MonsterHunter_StarfishDB_A = MonsterHunter_StarfishDB:new{UpgradeDescription = "Applies the Shocked status effect. When shocked enemies are damaged, they flip their attack direction. Being shocked again cancels their queued attacks.",Shocked = true,}
MonsterHunter_StarfishDB_B = MonsterHunter_StarfishDB:new{UpgradeDescription = "Applies the Powder status effect. When a pawn with powder is on fire, it explodes, dealing 1 damage to itself and adjacent tiles.",Powder = true,}
MonsterHunter_StarfishDB_AB = MonsterHunter_StarfishDB:new{Shocked = true, Powder = true,}


function MonsterHunter_StarfishDB:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+DIR_VECTORS[i])
	end
	return ret
end

function MonsterHunter_StarfishDB:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(p1+DIR_VECTORS[i])
	end
	return ret
end

function MonsterHunter_StarfishDB:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	ret:AddDamage(SpaceDamage(p2, amount))
	return ret
end

function MonsterHunter_StarfishDB:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage1 = SpaceDamage(p2, amount)
	if self.Shocked then damage1.iShocked = 1 end
	local damage2 = SpaceDamage(p3, amount)
	if self.Powder then damage2.iPowder = 1 end
	ret:AddMelee(p1, damage1)
	ret:AddMelee(p1, damage2)
	return ret
end


MonsterHunter_GooHH = Skill:new{
	Name = "Goo Hunting Horn",
	Class = "Prime",
	Icon = "weapons/GooHH.png",
	Description = "Strike a target. On hit, frees webbed allies and grants other allies +1 movement.",
	Damage = 1,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_GooHH:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = Board:GetPawn(p2)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local damage = SpaceDamage(p2, amount)
	damage.sAnimation = "explosmash_"..GetDirection(p2-p1)
	ret:AddMelee(p1, damage)

	if target and target:IsEnemy() then
		for i = 0, 2 do
			local ally = Board:GetPawn(i)
			if ally and i ~= pawn:GetId() then
				ret:AddScript(string.format("Board:GetPawn(%s):AddMoveBonus(1)",i))
			end
		end
	end
	for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		local removeWeb = SpaceDamage(Board:GetPawn(i), 0, DIR_FLIP)
		removeWeb.bHide = true
		ret:AddDamage(removeWeb)
		ret:AddDamage(removeWeb)
	end
	return ret
end

MonsterHunter_GooHH_A = MonsterHunter_GooHH:new{
	UpgradeDescription = "Deals 1 more damage.",
	Damage = 2,
}


--------------------------------------------------
-- MOSQUITO GUNLANCE
--------------------------------------------------

MonsterHunter_MosquitoGL = Skill:new{
	Name = "Mosquito Gunlance",
	Class = "Brute",
	Icon = "weapons/MosquitoGL.png",
	Description = "Damage and push an adjacent target. Otherwise, create smoke in a line up to 3 tiles away.",
	Damage = 1,
	PathSize = 3,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_MosquitoGL:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, self.PathSize do
			local curr = point + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
		end
	end
	return ret
end

function MonsterHunter_MosquitoGL:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if distance == 1 then
		local damage = SpaceDamage(p2, amount, dir)
		damage.sAnimation = "explospear1_"..dir
		ret:AddMelee(p1, damage)
	else
		for i = 1, distance do
			local curr = p1 + DIR_VECTORS[dir] * i
			local damage = SpaceDamage(curr)
			damage.iSmoke = 1
			ret:AddDamage(damage)
		end
	end

	return ret
end

MonsterHunter_MosquitoGL_A = MonsterHunter_MosquitoGL:new{
	UpgradeDescription = "Deals 1 more damage.",
	Damage = 2,
}


--------------------------------------------------
-- SCARAB BOWGUN
--------------------------------------------------

MonsterHunter_ScarabBG = Skill:new{
	Name = "Scarab Bowgun",
	Class = "Ranged",
	Icon = "weapons/ScarabBG.png",
	Description = "Fire a bolt. Deals 1 more damage if the user has not moved this turn.",
	Damage = 2,
	StationaryBonus = 1,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_ScarabBG:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, self.PathSize do
			local curr = point + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
		end
	end
	return ret
end

function MonsterHunter_ScarabBG:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1, p2)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	if pawn and pawn:IsActive() then amount = amount + self.StationaryBonus end

	ret:AddProjectile(p1, SpaceDamage(target, amount), "effects/needle", PROJ_DELAY)
	return ret
end

MonsterHunter_ScarabBG_A = MonsterHunter_ScarabBG:new{UpgradeDescription = "Deals 1 more damage.",Damage = 3,}


--------------------------------------------------
-- WYRM INSECTGLAIVE
--------------------------------------------------

MonsterHunter_WyrmIG = Skill:new{
	Name = "Wyrm Insectglaive",
	Class = "Brute",
	Icon = "weapons/WyrmIG.png",
	Description = "Slash an adjacent target for 3 damage, or fire a Kinsect that bounces between nearby enemies.",
	Damage = 3,
	KinsectDamage = 1,
	Bounces = 2,
	BounceRange = 2,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Bounce" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_WyrmIG:GetTargetArea(point)
	local ret = PointList()

	for dir = DIR_START, DIR_END do
		for i = 1, self.PathSize do
			local curr = point + DIR_VECTORS[dir] * i
			if not Board:IsValid(curr) then break end

			local pawn = Board:GetPawn(curr)
			if pawn and pawn:IsEnemy() then
				ret:push_back(curr)
				break
			end

			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end

	return ret
end

local function MonHunWyrmFindTarget(origin, hitTargets, range)
	local bestTarget = nil
	local bestDistance = range + 1

	for x = 0, 7 do
		for y = 0, 7 do
			local curr = Point(x, y)
			local pawn = Board:GetPawn(curr)
			local distance = origin:Manhattan(curr)

			if pawn and pawn:IsEnemy()
				and not hitTargets[curr:GetString()]
				and distance > 0
				and distance <= range
				and distance < bestDistance then

				bestTarget = curr
				bestDistance = distance
			end
		end
	end

	return bestTarget
end

function MonsterHunter_WyrmIG:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	-- Adjacent targets are hit with the glaive itself.
	if p1:Manhattan(p2) == 1 then
		local damage = SpaceDamage(p2, amount)
		damage.sAnimation = "Swipe2Claw1"
		ret:AddMelee(p1, damage)
	else
		-- Otherwise, fire the Kinsect at the selected enemy.
		local target = GetProjectileEnd(p1, p2)
		local pawn = Board:GetPawn(target)

		if pawn and pawn:IsEnemy() then
			local hitTargets = {}
			local origin = p1
			local hits = self.Bounces + 1

			for i = 1, hits do
				pawn = Board:GetPawn(target)
				if not pawn or not pawn:IsEnemy() then break end

				hitTargets[target:GetString()] = true

				ret:AddProjectile( origin, SpaceDamage(target, self.KinsectDamage + amount - self.Damage), "effects/kinsect", PROJ_DELAY)

				if i < hits then
					ret:AddDelay(0.1)

					local nextTarget = MonHunWyrmFindTarget( target, hitTargets, self.BounceRange )

					if not nextTarget then break end

					origin = target
					target = nextTarget
				end
			end
		end
	end

	return ret
end

MonsterHunter_WyrmIG_A = MonsterHunter_WyrmIG:new{
	UpgradeDescription = "The Kinsect can bounce to one additional enemy.",
	Bounces = 3,
}


MonsterHunter_PlasmodiaSA = Skill:new{
	Name = "Plasmodia Switch Axe",
	Class = "Brute",
	Icon = "weapons/PlasmodiaSA.png",
	Description = "Either toss the target or strike it multiple times.",
	Damage = 1,
	MaxDamage = 3,
	PowerCost = 0,
	Self = "MonsterHunter_PlasmodiaSA",
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
}

function MonsterHunter_PlasmodiaSA:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, self.MaxDamage do
			local curr = point + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
			if not Board:GetPawn(point + DIR_VECTORS[dir]) or Board:GetPawn(point + DIR_VECTORS[dir]):IsGuarding() then break end
		end
	end
	return ret
end

function MonsterHunter_PlasmodiaSA:GetSkillEffect(p1, p2, remainingShots)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = p1+DIR_VECTORS[dir]
	local dist = p1:Manhattan(p2)
	local damage = self.Damage
	local pawn = Board:GetPawn(p1)
	local amount = self.MaxDamage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end

	if dist > 1 then
		local move = PointList()
		move:push_back(target)
		move:push_back(p2)
		ret:AddLeap(move)
		ret:AddDamage(SpaceDamage(p2, damage))
	else
		local damage = SpaceDamage(target, self.Damage)
		if remainingShots == nil then remainingShots = amount end
		damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
		ret:AddMelee(p1, damage)
		ret:AddDelay(0.15)
		if remainingShots > 1 then
			remainingShots = remainingShots - 1
			ret:AddScript(string.format([=[
				local fx = SkillEffect();
				fx:AddScript([[
					Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
				]]);
				Board:AddEffect(fx);
			]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
		end
	end
	return ret
end

MonsterHunter_PlasmodiaSA_A = MonsterHunter_PlasmodiaSA:new{
	UpgradeDescription = "Deals 1 more damage.",
	Damage = 2,
	MaxDamage = 4,
	Self = "MonsterHunter_PlasmodiaSA_A"
}


MonsterHunter_RathalosGS = Skill:new{
	Name = "Rathalos Greatsword",
	Class = "Prime",
	Icon = "weapons/RathalosGS.png",
	Description = "Strike an adjacent target and sets it on fire. If the target is on fire, can damage several tiles in a row.",
	Damage = 2,
	PathSize = 3,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}

MonsterHunter_RathalosGS_A = MonsterHunter_RathalosGS:new{UpgradeDescription = "Deals 1 more damage.", Damage = 3,}

function MonsterHunter_RathalosGS:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, self.PathSize do
			local curr = point + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
			if i == 1 and (not Board:IsFire(curr) or (Board:GetPawn(curr) and Board:GetPawn(curr):IsFire())) then break end
		end
	end
	return ret
end

Emitter_LavaPlume = Emitter:new{
	image = "effects/lavaplume.png",
	x = 0,
	y = 10,
	max_alpha = 1,
	min_alpha = 0.75,
	angle = -70,
	angle_variance = 40,
	random_rot = false,
	rot_speed = 0,
	variance = 12,
	lifespan = 0.4,
	burst_count = 15,
	speed = 3.75,
	birth_rate = 0,
	gravity = true,
	layer = LAYER_FRONT
}	
Emitter_LavaSpark = Emitter:new{
	image = "effects/lavaspark.png",
	x = 0,
	y = 15,
	max_alpha = 1,
	min_alpha = 0.75,
	angle = -50,
	angle_variance = 60,
	rot_speed = 50,
	variance = 12,
	lifespan = 0.4,
	burst_count = 45,
	speed = 2.75,
	birth_rate = 0,
	gravity = true,
	layer = LAYER_FRONT
}	

function MonsterHunter_RathalosGS:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = p1+DIR_VECTORS[dir]
	local dist = p1:Manhattan(p2)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end

	if dist > 1 then
		for i = 1, dist do
			local damage = SpaceDamage(p1+DIR_VECTORS[dir]*i, amount)
			damage.iFire = 1
			if i == 1 then damage.sAnimation = "explosmash_"..dir end
			ret:AddDamage(damage)
			ret:AddBurst(p1+DIR_VECTORS[dir]*i, "Emitter_LavaPlume", DIR_NONE)
			ret:AddBurst(p1+DIR_VECTORS[dir]*i, "Emitter_LavaSpark", DIR_NONE)
			ret:AddDelay(0.2)
			
		end
	else
		local damage = SpaceDamage(p2, amount)
		damage.iFire = 1
		damage.sAnimation = "explosmash_"..dir
		ret:AddDamage(damage)
		ret:AddBurst(p2, "Emitter_LavaPlume", DIR_NONE)
		ret:AddBurst(p2, "Emitter_LavaSpark", DIR_NONE)
	end
	return ret
end

MonsterHunter_GastropodCB = Skill:new{
	Name = "Gastropod Charge Blade",
	Class = "Prime",
	Icon = "weapons/GastropodCB.png",
	Description = "Regular attacks push and refuel 2 charges. With at least 2 charges, can consume all charges except 1 to deal 1 damage per charge and push adjacent pawns away from the target.",
	MinDamage = 1,
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+2 Initial Charges" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,0),
	}
}

MonsterHunter_GastropodCB_A = MonsterHunter_GastropodCB:new{UpgradeDescription = "Starts each mission with +2 charges.", Limited = 3}

function MonsterHunter_GastropodCB:GetTargetArea(point)
	local ret = PointList()
	local pawn = Board:GetPawn(point)
	if pawn then
		for i = 1, pawn:GetWeaponCount() do
			if pawn:GetWeaponBaseType(i) == "MonsterHunter_GastropodCB" then maxDist = pawn:GetWeaponLimitedRemaining(i) end
		end
	end
	
	for dir = DIR_START, DIR_END do
		for i = 1, maxDist do
			local curr = point + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) then ret:push_back(curr) end
		end
	end
	return ret
end

function MonsterHunter_GastropodCB:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = p1+DIR_VECTORS[dir]
	local dist = p1:Manhattan(p2)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local charges = 1
	local weaponIndex = 0
	if pawn then
		for i = 1, pawn:GetWeaponCount() do
			if pawn:GetWeaponBaseType(i) == "MonsterHunter_GastropodCB" then charges = pawn:GetWeaponLimitedRemaining(i) weaponIndex = i end
		end
	end
	
	if dist > 1 then	
		local dummy = SpaceDamage(p1+DIR_VECTORS[dir])
		dummy.sAnimation = "explosmash_"..dir
		ret:AddMele(p1, dummy)
		for i = 1, dist-1 do
			ret:AddBounce(p1+DIR_VECTORS[dir]*i)
			ret:AddDelay(0.2)
		end
		local damage = SpaceDamage(p2, charges + amount - self.Damage)
		damage.sAnimation = "ExploArt3"
		ret:AddDamage(damage)
		for i = DIR_START, DIR_END do
			local pushDamage = SpaceDamage(p2+DIR_VECTORS[i], 0, i)
			pushDamage.sAnimation = "airpush_"..i
			ret:AddDamage(pushDamage)
		end
		
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetWeaponLimitedRemaining(%s, 1) end)", pawn:GetId(), weaponIndex))
	else
		local damage = SpaceDamage(p2, amount, dir)
		ret:AddMelee(p1, damage)
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetWeaponLimitedRemaining(%s, %s) end)", pawn:GetId(), weaponIndex, pawn:GetWeaponLimitedRemaining(i) + 2))
	end
	return ret
end

MonsterHunter_RoachSNS = Skill:new{
	Name = "Roach Sword&Shield",
	Class = "Brute",
	Icon = "weapons/RoachSNS.png",
	Projectile = "effects/shot_blob", -- placeholder art, swap for an acid shot if you have one
	Description = "Once per turn, fire a harmless A.C.I.D. projectile as a free action. If already used this turn, damage and push an adjacent tile instead.",
	Damage = 1,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 1,
	UpgradeCost = { 2 },
	UpgradeList = { "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}
 
function MonsterHunter_RoachSNS:GetTargetArea(point)
	local ret = PointList()
	local usedThisTurn = MonHunRoachUsedThisTurn(Board:GetPawn(point))
	local mission = GetCurrentMission()
	for dir = DIR_START, DIR_END do
		if not (pawn and mission and mission["ROACH_SNS_"..pawn:GetId()] == mission:GetTurnCount()) then
			-- second use: adjacent tiles only
			local curr = point + DIR_VECTORS[dir]
			if Board:IsValid(curr) then ret:push_back(curr) end
		else
			-- first use: projectile, stops at the first blocker
			for i = 1, self.PathSize do
				local curr = point + DIR_VECTORS[dir] * i
				if not Board:IsValid(curr) then break end
				ret:push_back(curr)
				if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
			end
		end
	end
	return ret
end
 
function MonsterHunter_RoachSNS:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local pawn = Board:GetPawn(p1)
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	local mission = GetCurrentMission()
	if pawn and mission and mission["ROACH_SNS_"..pawn:GetId()] == mission:GetTurnCount() then
		ret:AddMelee(p1, SpaceDamage(p2, amount, dir))
	else
		local damage = SpaceDamage(GetProjectileEnd(p1, p2), 0)
		damage.iAcid = 1
		ret:AddProjectile(p1, damage, self.Projectile, PROJ_DELAY)
 
		-- scripts only run on real execution, not on preview
		if pawn and not Board:IsTipImage() then
			if mission then
				ret:AddScript(string.format("GetCurrentMission()[%q] = %s", "ROACH_SNS_" .. pawn:GetId(), mission:GetTurnCount()))
			end
			-- runLater so the game doesn't re-deactivate the pawn after the skill resolves
			ret:AddScript(string.format([[
				modApi:runLater(function()
					local pawn = Board:GetPawn(%s)
					if pawn then pawn:SetActive(true) end
				end)
			]], pawn:GetId()))
		end
	end
	return ret
end
 
MonsterHunter_RoachSNS_A = MonsterHunter_RoachSNS:new{UpgradeDescription = "Deals 1 more damage.", Damage = 2,}
 
MonsterHunter_SwarmerDB = Skill:new{
	Name = "Swarmer Dual Blades",
	Class = "Brute",
	Icon = "weapons/SwarmerDB.png",
	Description = "Leap over tiles in a line, spreading the weapon's damage evenly across the tiles crossed. Can cross as many tiles as its damage.",
	Damage = 3,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 2, 2 },
	UpgradeList = { "+1 Damage", "+1 Damage" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Enemy2 = Point(2,2),
		Target = Point(2,1),
	}
}
 
MonsterHunter_SwarmerDB_A = MonsterHunter_SwarmerDB:new{UpgradeDescription = "Deals 1 more damage and can cross 1 more tile.", Damage = 4}
MonsterHunter_SwarmerDB_B = MonsterHunter_SwarmerDB:new{UpgradeDescription = "Deals 1 more damage and can cross 1 more tile.", Damage = 4}
MonsterHunter_SwarmerDB_AB = MonsterHunter_SwarmerDB:new{Damage = 5}

function MonsterHunter_SwarmerDB:GetTargetArea(point)
	local ret = PointList()
	local pawn = Board:GetPawn(point)
	local pathProf = pawn and pawn:GetPathProf() or PATH_GROUND
	local amount = self.Damage
	if pawn and pawn:GetAbility() == "MonHunSkill" then amount = amount + 1 end
	for dir = DIR_START, DIR_END do
		for i = 2, amount + 1 do
			local curr = point + DIR_VECTORS[dir] * i
			if not Board:IsValid(curr) then break end
			if not Board:IsBlocked(curr, pathProf) then ret:push_back(curr) end
		end
	end
	return ret
end
 
function MonsterHunter_SwarmerDB:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local tiles = p1:Manhattan(p2) - 1	
	if tiles < 1 then return ret end
 
	local leap = PointList()
	leap:push_back(p1)
	leap:push_back(p2)
	ret:AddLeap(leap, NO_DELAY)
	
	local amount = self.Damage
	if Board:GetPawn(p1) and Board:GetPawn(p1):GetAbility() == "MonHunSkill" then amount = amount + 1 end
	
	local base = math.floor(amount / tiles)
	local remainder = amount % tiles
 
	for i = 1, tiles do
		local tile = p1 + DIR_VECTORS[dir] * i
		local damageCount = base + (i <= remainder and 1 or 0)
 
		ret:AddDelay(0.1)
		for j = 1, damageCount do
			local damage = SpaceDamage(tile, 1)
			if j == damageCount then
				damage.sImageMark = MultishotLib:getImageMark(1, damageCount, p1, tile)
			end
			ret:AddDamage(damage)
			if j < damageCount then ret:AddDelay(0.05) end
		end
	end
	return ret
end
 
 
MonsterHunter_SpitterLS = Skill:new{
	Name = "Spitter Longsword",
	Class = "Prime",
	Icon = "weapons/SpitterLS.png",
	Description = "Choose an adjacent tile to slash and a different adjacent tile to push the user to.",
	Damage = 2,			-- center tile
	MinDamage = 1,
	Projectile = "effects/shot_katana",	
	PathSize = 1,
	TwoClick = true,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 1, 3 },
	UpgradeList = { "+1 Center Damage", "+1 All Damage" },
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Target = Point(2,2),
		Second_Click = Point(2,4),
	}
}

MonsterHunter_SpitterLS_A = MonsterHunter_SpitterLS:new{UpgradeDescription = "Deals 1 more damage to the center tile.", Damage = 3,}
MonsterHunter_SpitterLS_B = MonsterHunter_SpitterLS:new{UpgradeDescription = "Deals 1 more damage to all tiles.", Damage = 3, MinDamage = 2,}
MonsterHunter_SpitterLS_AB = MonsterHunter_SpitterLS:new{Damage = 4, MinDamage = 2,}

function MonsterHunter_SpitterLS:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		if Board:IsValid(curr) then ret:push_back(curr) end
	end
	return ret
end

function MonsterHunter_SpitterLS:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		if curr ~= p2 and Board:IsValid(curr) then ret:push_back(curr) end
	end
	return ret
end

function MonsterHunter_SpitterLS:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local extraAmount = 0
	if Board:GetPawn(p1) and Board:GetPawn(p1):GetAbility() == "MonHunSkill" then extraAmount = 1 end
	
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.MinDamage + extraAmount))
	ret:AddDamage(SpaceDamage(p2, self.Damage + extraAmount))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.MinDamage + extraAmount))
	return ret
end

function MonsterHunter_SpitterLS:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local extraAmount = 0
	if Board:GetPawn(p1) and Board:GetPawn(p1):GetAbility() == "MonHunSkill" then extraAmount = 1 end
	
	ret:AddDamage(SpaceDamage(p1, 0, GetDirection(p3 - p1)))
	local dummy = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4])
	dummy.bHide = true
	ret:AddProjectile(p2 + DIR_VECTORS[(dir-1)%4], dummy, self.Projectile, NO_DELAY)
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.MinDamage + extraAmount))
	ret:AddDelay(0.06)
	ret:AddDamage(SpaceDamage(p2, self.Damage + extraAmount))
	ret:AddDelay(0.06)
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.MinDamage + extraAmount))
	ret:AddDelay(0.06)

	return ret
end