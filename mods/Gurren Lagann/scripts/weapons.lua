local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAssets("img/weapons/", "img/weapons/")

local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

modApi:appendAssets("img/effects/", "img/effects/")

local achievements = {
	Meta_BelieveInMe = modApi.achievements:add{
		id = "Meta_BelieveInMe",
		name = "Believe in me",
		tip = "Use Drill Breaker to kill a Leader Vek in a single hit.",
		img = path.."img/achievements/BelieveInMe.png",
		squad = "Meta_GurrenLagann",
	}, 
	Meta_CrackShot = modApi.achievements:add{
		id = "Meta_CrackShot",
		name = "Crack Shot",
		tip = "Hit at least 8 shots with Repeating Cannon in a single mission.",
		img = path.."img/achievements/CrackShot.png",
		squad = "Meta_GurrenLagann",
	},
	Meta_HandleTheRabble = modApi.achievements:add{
		id = "Meta_HandleTheRabble",
		name = "Handle the rabble",
		tip = "Kill at least 3 enemies in a single use of King Kittan Stinger.",
		img = path.."img/achievements/HandleTheRabble.png",
		squad = "Meta_GurrenLagann",
	},
	Meta_KaminaSecret = modApi.achievements:add{
		id = "Meta_KaminaSecret",
		name = "Gurren Lagann Secret Reward",
		tip = "Complete all 3 Team Dai-Gurren achievements.",
		img = path.."img/achievements/secret.png",
		squad = "Meta_GurrenLagann",
		global = "Secret Rewards",
		secret = true,
		objective = {
			aa = true,
			bb = true,
			cc = true,
			reward = "?|Secret Pilot"}
	}
}

ANIMS.Meta_SunglassesProjectile = Animation:new{
    Image = "effects/sunglassesanim.png",
    NumFrames = 4,
	Time = 0.06,
    PosX = -12,
    PosY = -12,
    Loop = true
}

function completeBelieveInMe()
	if not achievements.Meta_BelieveInMe:isComplete() then achievements.Meta_BelieveInMe:addProgress{ complete = true } achievements.Meta_KaminaSecret:addProgress{ aa = true } end
	if achievements.Meta_BelieveInMe:isComplete() and achievements.Meta_CrackShot:isComplete() and achievements.Meta_HandleTheRabble:isComplete() then	
		achievements.Meta_KaminaSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_GurrenLagann","Meta_KaminaSecret",true)
	end
end

function completeCrackShot()
	if not achievements.Meta_CrackShot:isComplete() then achievements.Meta_CrackShot:addProgress{ complete = true }  achievements.Meta_KaminaSecret:addProgress{ bb = true } end
	if achievements.Meta_BelieveInMe:isComplete() and achievements.Meta_CrackShot:isComplete() and achievements.Meta_HandleTheRabble:isComplete() then	
		achievements.Meta_KaminaSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_GurrenLagann","Meta_KaminaSecret",true)
	end
end

function completeHandleTheRabble()
	if not achievements.Meta_HandleTheRabble:isComplete() then achievements.Meta_HandleTheRabble:addProgress{ complete = true } achievements.Meta_KaminaSecret:addProgress{ cc = true }  end
	if achievements.Meta_BelieveInMe:isComplete() and achievements.Meta_CrackShot:isComplete() and achievements.Meta_HandleTheRabble:isComplete() then	
		achievements.Meta_KaminaSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_GurrenLagann","Meta_KaminaSecret",true)
	end
end

Meta_DrillStrike = Skill:new{  
	Name = "Drill Strike",
	Class = "Prime",
	Icon = "weapons/DrillStrike.png",
	Description = "Damages an adjacent enemy. Deals +1 damage to Alpha-tier Vek. Deals +2 damage to Leader-tier Vek.",	--also works against Omega
	Rarity = 3,
	Damage = 2,
	MaxDamage = 4,
	ZoneTargeting = ZONE_DIR,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "Boost on kill",  "+1 Damage"  },
	UpgradeCost = { 1 , 3 },
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Second_Target=Point(2,1),
		Second_Click=Point(2,1),
		Water = Point(2,0),
		CustomPawn = "Mech_GurrenLagann",
	}
}

Meta_DrillStrike_A = Meta_DrillStrike:new{UpgradeDescription = "When this attack kills a unit, boost all mechs.",Boost=true}
Meta_DrillStrike_B = Meta_DrillStrike:new{UpgradeDescription = "Deals 1 more damage.",Damage=3, MaxDamage = 5}
Meta_DrillStrike_AB = Meta_DrillStrike:new{Boost = true, Damage=3, MaxDamage = 5}

function Meta_DrillStrike:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local target = Board:GetPawn(p2)
	local damage = SpaceDamage(p2, self.Damage)
	if target and (_G[target:GetType()].Tier == TIER_ALPHA or _G[target:GetType()].Tier == TIER_OMEGA) then damage.iDamage = self.Damage + 1 end
	if target and _G[target:GetType()].Tier == TIER_BOSS then damage.iDamage = self.MaxDamage end
	ret:AddMelee(p1, damage)
	if Board:IsDeadly(damage, target) then
		if _G[target:GetType()].Tier == TIER_BOSS and not target:IsDamaged() then ret:AddScript("completeBelieveInMe()") end
		if self.Boost then
			for i = 0, 2 do
				if Board:GetPawn(i) and not Board:GetPawn(i):IsDead() then
					local booster = SpaceDamage(Board:GetPawn(i):GetSpace())
					booster.sImageMark = "combat/icons/icon_boosted_glow.png"
					booster.sScript = string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", i)
					ret:AddDamage(booster)
				end
			end
		end
	end
	return ret
end

Meta_SunglassesBoomerang = Skill:new{  
	Name = "Sunglasses Boomerang",
	Class = "Prime",
	Icon = "weapons/SunglassesBoomerang.png",
	Description = "Shoots a boomerang that rebounds between two targets before returning to the user.",
	Rarity = 3,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	LaunchSound = "/weapons/sword",
	Range = 1,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	TwoClick = true,
	Upgrades = 1,
	UpgradeList = { "+1 Damage" },
	UpgradeCost = { 2 },
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Mech_GurrenLagann",
	}
}

function Meta_SunglassesBoomerang:GetTargetArea(point)
	--get tiles adjacent to an artillery range
	local ret = PointList()
	local pawn = Board:GetPawn(point)
	if not pawn then return ret end
	for i = DIR_START, DIR_END do
		ret:push_back(point+DIR_VECTORS[i])	--basic option
		for j = 2, 4 do
			local curr = point + DIR_VECTORS[i] * j
			local side1 = (i+1)%4
			local side2 = (i-1)%4
			local canPathTo = true
			for k = 0, j-1 do
				if Board:IsBlocked(point + DIR_VECTORS[side1] + DIR_VECTORS[i] * k, PATH_PROJECTILE) then canPathTo = false end
			end
			if canPathTo then ret:push_back(point + DIR_VECTORS[i] * j  + DIR_VECTORS[side1]) end
			canPathTo = true
			for k = 0, j-1 do
				if Board:IsBlocked(point + DIR_VECTORS[side2] + DIR_VECTORS[i] * k, PATH_PROJECTILE) then canPathTo = false end
			end
			if canPathTo then ret:push_back(point + DIR_VECTORS[i] * j  + DIR_VECTORS[side2]) end
		end
	end
	return ret
end


function Meta_SunglassesBoomerang:IsTwoClickException(p1, p2)
	return p1:Manhattan(p2) == 1
end
	
function Meta_SunglassesBoomerang:GetSecondTargetArea(p1,p2)
	--get tiles on an artillery range, past p2
	local ret = PointList()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	local dist = p1:Manhattan(p2)
	if dist == 1 then return ret end
	local trueDist
	local dir, dir2
	for i = DIR_START, DIR_END do
		for j = 2, 4 do
			local curr = p1 + DIR_VECTORS[i] * j
			if curr:Manhattan(p2) <= 1 then 
				dir = i 
				dir2 = GetDirection(curr-p2) 
				trueDist = j
			end
		end
	end
	for j = trueDist, 7 do
		local curr = p1 + DIR_VECTORS[dir] * j
		local canPathTo = true
		for i = trueDist+1, j do
			if Board:IsBlocked(p1+DIR_VECTORS[dir] * i +DIR_VECTORS[dir2], PATH_PROJECTILE) then canPathTo = false end
		end
		if canPathTo then ret:push_back(curr) end
	end
	return ret
end

function Meta_SunglassesBoomerang:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	local dir = -1
	local dir2 = -1
	if p1:Manhattan(p2) == 1 then	--basic weak attack
		if user:GetType() == "Mech_GurrenLagann" and not Board:IsTipImage() then
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_gurrenlagann_noglasses"))
		end
		ffrg_CustomProjectile.AddCustomProjectile(p1,p2,"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p2, self.Damage, GetDirection(p2-p1)), path = true, directional = false, speed = 10})
		local giveMeMyGlassesBack = SpaceDamage(p1)
		if user:GetType() == "Mech_GurrenLagann" and not Board:IsTipImage() then
			giveMeMyGlassesBack.sScript = string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_gurrenlagann")
		end
		ffrg_CustomProjectile.AddCustomProjectile(p2,p1,"Meta_SunglassesProjectile",{ret = ret, damage=giveMeMyGlassesBack, path = true, directional = false, speed = 10})
		return ret
	end
	
	for i = DIR_START, DIR_END do
		for j = 2, 4 do
			if p2 == p1 + DIR_VECTORS[i] * j + DIR_VECTORS[(i+1)%4] then 
				dir = i 
				dir2 = (i+1)%4
				break
			end
			if p2 == p1 + DIR_VECTORS[i] * j + DIR_VECTORS[(i+3)%4] then 
				dir = i 
				dir2 = (i+3)%4
				break
			end
		end
		if dir ~= -1 then break end
	end
	ffrg_CustomProjectile.AddCustomProjectile(p1,p1+DIR_VECTORS[dir2],"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p1+DIR_VECTORS[dir2]), path = true, directional = false, speed = 10})
	ffrg_CustomProjectile.AddCustomProjectile(p1+DIR_VECTORS[dir2],p2,"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p2, self.Damage, dir), path = true, directional = false, speed = 10})
	ret:AddDamage(SpaceDamage(p1))
	return ret
end	

function Meta_SunglassesBoomerang:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	local dir = -1
	local dir2 = -1
	if user:GetType() == "Mech_GurrenLagann" and not Board:IsTipImage() then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_gurrenlagann_noglasses"))
	end
	if p1:Manhattan(p2) == 1 then	--basic weak attack
		ret:AddDamage(SpaceDamage(p2, self.Damage, GetDirection(p2-p1)))
		return ret
	end
	
	for i = DIR_START, DIR_END do
		for j = 2, 4 do
			if p2 == p1 + DIR_VECTORS[i] * j + DIR_VECTORS[(i+1)%4] then 
				dir = i 
				dir2 = (i+1)%4
				break
			end
			if p2 == p1 + DIR_VECTORS[i] * j + DIR_VECTORS[(i+3)%4] then 
				dir = i 
				dir2 = (i+3)%4
				break
			end
		end
		if dir ~= -1 then break end
	end
	--we add delays equal to 1/speed * distance to travel
	ffrg_CustomProjectile.AddCustomProjectile(p1,p1+DIR_VECTORS[dir2],"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p1+DIR_VECTORS[dir2]), path = true, directional = false, speed = 10})
	ret:AddDelay(0.1)
	ffrg_CustomProjectile.AddCustomProjectile(p1+DIR_VECTORS[dir2],p2,"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p2, self.Damage, dir), path = true, directional = false, speed = 10})
	ret:AddDelay(0.1 * p2:Manhattan(p1+DIR_VECTORS[dir2]))
	ffrg_CustomProjectile.AddCustomProjectile(p2,p3+DIR_VECTORS[dir2],"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p3+DIR_VECTORS[dir2]), path = true, directional = false, speed = 10})
	ret:AddDelay(0.1 * p2:Manhattan(p3+DIR_VECTORS[dir2]))
	ffrg_CustomProjectile.AddCustomProjectile(p3+DIR_VECTORS[dir2],p3,"Meta_SunglassesProjectile",{ret = ret, damage=SpaceDamage(p3, self.Damage, (dir2+2)%4), path = true, directional = false, speed = 10})
	ret:AddDelay(0.1 * p3:Manhattan(p3+DIR_VECTORS[dir2]))
	local giveMeMyGlassesBack = SpaceDamage(p1)
	if user:GetType() == "Mech_GurrenLagann" and not Board:IsTipImage() then
		giveMeMyGlassesBack.sScript = string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_gurrenlagann")
	end
	ffrg_CustomProjectile.AddCustomArtillery(p3,p1,"Meta_SunglassesProjectile",{duration = 0.2 * p3:Manhattan(p1), ret = ret, damage=giveMeMyGlassesBack, path = false, directional = false})
	return ret
end	

Meta_SunglassesBoomerang_A = Meta_SunglassesBoomerang:new{UpgradeDescription = "Deals 1 more damage.", Damage=2}

Meta_RepeatingCannon = Skill:new{  
	Name = "Repeating Cannon",
	Class = "Ranged",
	Icon = "weapons/RepeatingCannon.png",
	Description = "Can fire up to three pushing artillery shots at adjacent tiles. Each shot consumes a weapon use.",
	Rarity = 3,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Range = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	TwoClick = true,
	Limited = 6,
	Upgrades = 2,
	UpgradeList = { "+2 Uses",  "+4 Uses"  },
	UpgradeCost = { 1 , 2 },
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Mech_Dayakkaiser",
	}
}

function Meta_RepeatingCannon:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 7 do
			ret:push_back(point + DIR_VECTORS[i] * j)
		end
	end
	return ret
end


function Meta_RepeatingCannon:IsTwoClickException(p1, p2)
	--no need to 2-click if you can only shoot once
	local pawn = Board:GetPawn(p1)
	if not pawn then return true end
	for i = 1, pawn:GetWeaponCount() do
		if pawn:GetWeaponBaseType(i) == "Meta_RepeatingCannon" and pawn:GetWeaponLimitedRemaining(i) == 1 then return true end
	end
	return false
end
	

function Meta_RepeatingCannon:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	local maxDist = 0
	ret:push_back(p2)
	for i = 1, pawn:GetWeaponCount() do
		if pawn:GetWeaponBaseType(i) == "Meta_RepeatingCannon" then maxDist = math.min(pawn:GetWeaponLimitedRemaining(i) - 1, 2) end
	end
	for dir = DIR_START, DIR_END do
		for j = 1, maxDist do
			ret:push_back(p2 + DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Meta_RepeatingCannon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	local dir = GetDirection(p2-p1)
	if GetCurrentMission() then GetCurrentMission().CrackShotCounter = GetCurrentMission().CrackShotCounter or 0 end
	if Board:GetPawn(p2) and GetCurrentMission() then ret:AddScript("GetCurrentMission().CrackShotCounter = GetCurrentMission().CrackShotCounter + 1") end
	ret:AddArtillery(p1, SpaceDamage(p2, self.Damage, dir), "effects/shotup_tricrack.png", PROJ_DELAY)
	if GetCurrentMission() then ret:AddScript("if GetCurrentMission().CrackShotCounter >= 8 then completeCrackShot() end") end
	return ret
end	

function Meta_RepeatingCannon:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local dir = GetDirection(p2-p1)
	local dir2 = GetDirection(p3-p2)
	local dist = p2:Manhattan(p3)
	if GetCurrentMission() then GetCurrentMission().CrackShotCounter = GetCurrentMission().CrackShotCounter or 0 end
	for i = 0, dist do
		local curr = p2
		if p3~=p2 then curr = p2 + DIR_VECTORS[GetDirection(p3-p2)] * i end
		ret:AddArtillery(p1, SpaceDamage(curr, self.Damage, dir), "effects/shotup_tricrack.png", dir == dir2 and PROJ_DELAY or 0.15)
		if GetCurrentMission() and Board:GetPawn(p2) then ret:AddScript("GetCurrentMission().CrackShotCounter = GetCurrentMission().CrackShotCounter + 1") end
	end
	if GetCurrentMission() then ret:AddScript("if GetCurrentMission().CrackShotCounter >= 8 then completeCrackShot() end") end
	if dist > 0 then
		for i = 1, pawn:GetWeaponCount() do
			if pawn:GetWeaponBaseType(i) == "Meta_RepeatingCannon" then
				ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetWeaponLimitedRemaining(%s, %s) end)", pawn:GetId(), i, pawn:GetWeaponLimitedRemaining(i) - (dist + 1)))
			end
		end
	end
	return ret
end	

Meta_RepeatingCannon_A = Meta_RepeatingCannon:new{UpgradeDescription = "Can fire 2 more projectiles per mission.",Limited=8}
Meta_RepeatingCannon_B = Meta_RepeatingCannon:new{UpgradeDescription = "Can fire 4 more projectiles per mission.",Limited=10}
Meta_RepeatingCannon_AB = Meta_RepeatingCannon:new{Limited=12}


Meta_Stinger = Skill:new{  
	Name = "Stinger",
	Class = "Brute",
	Icon = "weapons/KittanStinger.png",
	Description = "Charges through enemies that can be killed. Toss the first target hit that cannot.",
	Rarity = 3,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Damage",  "+1 Damage"  },
	UpgradeCost = { 2 , 3 },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Water = Point(2,0),
		CustomPawn = "Mech_Kittan",
	}
}

Meta_Stinger_A = Meta_Stinger:new{UpgradeDescription = "Deals 1 more damage.", Damage=2}
Meta_Stinger_B = Meta_Stinger:new{UpgradeDescription = "Deals 1 more damage.", Damage=2}
Meta_Stinger_AB = Meta_Stinger:new{Damage=3}

local function Meta_Stinger_CanKill(pawn, loc, damage)
	if not pawn or pawn:IsShield() or pawn:IsFrozen() or Board:GetCustomTile(loc) == "tosx_rocks_0.png" then
		return false
	end
	if not pawn:IsFlying() and Board:IsCracked(loc) and damage > 0 then return true end
	return pawn:IsDeadly(SpaceDamage(loc, damage))
end

function Meta_Stinger:GetTargetArea(p1)
	local ret = PointList()
	local user = Board:GetPawn(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = p1 + DIR_VECTORS[dir] * j

			if not Board:IsValid(curr) then break end

			local terrain = Board:GetTerrain(curr)

			if terrain == TERRAIN_HOLE then break end
			if terrain == TERRAIN_MOUNTAIN or terrain == TERRAIN_BUILDING or Board:IsBuilding(curr) then break end

			local pawn = Board:GetPawn(curr)

			if (user:IsFlying() or (terrain ~= TERRAIN_WATER or terrain ~= TERRAIN_LAVA)) or (pawn and not Meta_Stinger_CanKill(pawn, curr, self.Damage)) then
				ret:push_back(curr)
			end

			if pawn and not Meta_Stinger_CanKill(pawn, curr, self.Damage) then break end
		end
	end

	return ret
end

function Meta_Stinger:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local achievementCounter = 0
	local curr = p1
	local targetPawn = Board:GetPawn(p2)
	local destination = p2
	if targetPawn then destination = p2 - DIR_VECTORS[dir] end
	local blockingPawn = Board:GetPawn(destination) 
	local dist = p1:Manhattan(destination)
	ret:AddCharge(Board:GetPath(p1, destination, PATH_FLYER), NO_DELAY)
	for i = 0, dist do
		ret:AddSound("/support/earthmover/attack_first")
		ret:AddEmitter(curr, "Emitter_Dust")
		local damage = SpaceDamage(curr, self.Damage)
		if i > 0 and i < dist then ret:AddDamage(damage) end
		if i == dist and dist > 0 and targetPawn and blockingPawn then ret:AddScript(string.format("Board:GetPawn(%s):Kill(false)", blockingPawn:GetId())) end
		ret:AddDelay(0.1)
		ret:AddBounce(curr, 2)
		curr = curr + DIR_VECTORS[dir]
		if Board:GetPawn(curr) and Board:GetPawn(curr):IsEnemy() and i < dist then achievementCounter = achievementCounter + 1 end	--we're presumably killing that pawn
	end
	if targetPawn then 
		if targetPawn:IsGuarding() or not Board:IsValid(p2 - DIR_VECTORS[dir] * 2) then
			if Meta_Stinger_CanKill(targetPawn, p2, self.Damage) and targetPawn:IsEnemy() then achievementCounter = achievementCounter + 1 end
			ret:AddDamage(SpaceDamage(p2, self.Damage))
		else
			local move = PointList()
			move:push_back(p2)
			move:push_back(p2 - DIR_VECTORS[dir] * 2)
			ret:AddLeap(move, FULL_DELAY)
			if Meta_Stinger_CanKill(targetPawn, p2 - DIR_VECTORS[dir] * 2, self.Damage) and targetPawn:IsEnemy() then achievementCounter = achievementCounter + 1 end
			ret:AddDamage(SpaceDamage(p2 - DIR_VECTORS[dir] * 2, self.Damage))
			ret:AddBounce(p2 - DIR_VECTORS[dir] * 2, self.Damage * 2)
		end
	end
	if GetCurrentMission() and achievementCounter >= 1 then ret:AddScript("completeHandleTheRabble()") end
	return ret
end



