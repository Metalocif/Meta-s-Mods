local mod = modApi:getCurrentMod()
local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath.."libs/weaponPreview")

--------------
--Slime Slam--
--------------

modApi:addWeaponDrop("Djinn_SlimeSlam")


Djinn_SlimeSlam = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Djinn_SlimeSlam.png",	
	Rarity = 3,
	Name = "Slime Slam",
	Description = "Dash at a target, dealing damage equal to the Slime Beast's current health. Leaves a trail of gunk.",
	Push = 1,--TOOLTIP HELPER
	MinDamage = 1,
	Damage = 9,
	SelfDamage = 1,
	PathSize = INT_MAX,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Mitosis",  "No self-damage"  },
	UpgradeCost = {1,3},
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1)
	}
}
			
function Djinn_SlimeSlam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local doDamage = true
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	local distance = p1:Manhattan(target)
	local damageAmount = Board:GetPawn(p1):GetHealth()
	local selfDamageAmount = self.SelfDamage
	if damageAmount == 1 then selfDamageAmount = 0 end
	
	if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	
	local damage = SpaceDamage(target, damageAmount)
	damage.sAnimation = "ExploAir2"
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
		ret:AddSafeDamage(SpaceDamage( target - DIR_VECTORS[direction] , selfDamageAmount))
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target do 
			ret:AddBounce(temp,-3)
			local itemDamage = SpaceDamage(temp, 0)
			itemDamage.sItem = "Meta_BlobGunk"
			ret:AddDamage(itemDamage)
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then ret:AddDelay(0.06) end
			if Board:GetTerrain(temp) ~= TERRAIN_WATER and Board:GetTerrain(temp) ~= TERRAIN_HOLE then 
				ret:AddScript(string.format("Board:AddItem(%s, %q)", temp:GetString(), "Meta_BlobGunk")) 
			end
		end
		
		if doDamage then
			ret:AddDamage(damage)
			ret:AddSafeDamage(SpaceDamage(target - DIR_VECTORS[direction] , selfDamageAmount))
		end
	
	end
	ret:AddScript(string.format("Board:AddPawn(%q, %s)", self.ToSpawn, p1:GetString()))

	return ret
end

Djinn_SlimeSlam_A = Djinn_SlimeSlam:new{
	UpgradeDescription = "Leaves a Slimelet on the starting tile.",
	ToSpawn = "Slimelet",
}

Djinn_SlimeSlam_B = Djinn_SlimeSlam:new{
	UpgradeDescription = "No longer deals self-damage.",
	SelfDamage = 0,
}

Djinn_SlimeSlam_AB = Djinn_SlimeSlam:new{
	ToSpawn = "Slimelet",
	SelfDamage = 0,
}

------------------
--Slimelet Shove--
------------------

Djinn_SlimeletShove = Skill:new{
	Class = "",
	Icon = "weapons/Djinn_SlimeletShove.png",	
	Name = "Shove",
	Description = "Weakly shove an adjacent unit.",
	Rarity = 3,
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	SelfDamage = DAMAGE_DEATH,
	PathSize = 1,	--automatically makes a target area?
	Cost = "med",
	PowerCost = 0, --AE Change
	Upgrades = 0,
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1)
	}
}
			
function Djinn_SlimeletShove:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage, direction)
	--local options = mod_loader.currentModContent[mod.id].options
	damage.sSound = self.ImpactSound
	--if Board:GetPawn(p2):GetMechName() == "Djinn_SlimeBeast" and (options.Gunk_SlimeletsCanFuse and options.Gunk_SlimeletsCanFuse.enabled) then damage.iDamage = -1 end
	ret:AddMelee(p1, damage)
	ret:AddDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end


--------------
--Gunk Spray--
--------------

modApi:addWeaponDrop("Djinn_GunkSpray")

Djinn_GunkSpray = Skill:new{ 
	Class = "Prime",
	Icon = "weapons/Djinn_GunkSpray.png",
	Name = "Gunk Spray",
	Description = "Spray gunk over targets in a line, applying Gunk and spawning a Slimelet for each killed enemy.",
	Explosion = "",
	PathSize = 2,
	Damage = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 2 , 2 },
	UpgradeList = { "+2 Range",  "+1 Damage"  },
	LaunchSound = "/weapons/flamespreader",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		CustomEnemy = "Leaper1",
	},
}

function Djinn_GunkSpray:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then break end
		end
	end
	
	return ret
end
				
function Djinn_GunkSpray:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	
	
	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[direction]*i
		local damage = SpaceDamage(curr,self.Damage)
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetType() == "Djinn_SlimeBeast" then damage.iDamage = 0 end
		local spawnDamage = SpaceDamage(curr, 0)
		spawnDamage.sPawn = "Slimelet"
		
		if i == distance then damage.sAnimation = "flamethrower"..distance.."_"..direction end
		if pawn then damage.sScript = string.format("Status.ApplyGunk(%s)", pawn:GetId()) end
		ret:AddDamage(damage)
		if pawn and pawn:GetType() == "Djinn_SlimeBeast" then weaponPreview:AddDamage(SpaceDamage(curr, -1)) end
		if Board:GetPawn(curr) and Board:IsDeadly(damage, Board:GetPawn(curr)) then
			ret:AddArtillery(curr, spawnDamage, "units/player/Slimelet.png", NO_DELAY)
		end
	end

	return ret
end	

Djinn_GunkSpray_A = Djinn_GunkSpray:new{
	PathSize = 4,
	UpgradeDescription="Increases range by 2.",
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy = Point(1,0),
		Enemy2 = Point(3,1),
		Enemy3 = Point(2,2),
	},
}
Djinn_GunkSpray_B = Djinn_GunkSpray:new{
	Damage = 2,
	UpgradeDescription="Increases damage by 1.",
}
Djinn_GunkSpray_AB = Djinn_GunkSpray:new{
	PathSize = 4,
	Damage = 2,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy = Point(1,0),
		Enemy2 = Point(3,1),
		Enemy3 = Point(2,2),
	},
}

-------------
--Resonance--
-------------

modApi:addWeaponDrop("Djinn_ Resonance")

Djinn_Resonance = Skill:new{ 
	Class = "Science",
	Icon = "weapons/Djinn_Resonance.png",
	Name = "Resonance",
	Description = "Kill a target unit with 1 HP, damaging its surroundings.",
	Explosion = "",
	Damage = DAMAGE_DEATH,
	PowerCost = 0,
	HealthToTarget = 1,
	Push = false,
	Upgrades = 2,
	UpgradeCost = { 2 , 2 },
	UpgradeList = { "+1 HP Targets",  "Push"  },
	LaunchSound = "/weapons/science_repulse",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(1,1),
		CustomEnemy = "Leaper1",
	},
}

function Djinn_Resonance:GetTargetArea(point)
	local ret = PointList()
	local maxHealth = self.HealthToTarget
	if Board:GetPawn(point):IsBoosted() then maxHealth = maxHealth + 1 end
	for i = DIR_START, DIR_END do
		for k = 2, 8 do
			local curr = DIR_VECTORS[i]*k + point
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetHealth() <= maxHealth then ret:push_back(curr) end
			if not Board:IsValid(curr) then break end
		end
	end
	
	return ret
end
				
function Djinn_Resonance:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploRepulse1"
	damage.sSound = self.LaunchSound
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local burstDamage = SpaceDamage(curr, 1)
		if self.Push then burstDamage.iPush = i end
		ret:AddDamage(burstDamage)
	end

	return ret
end	

Djinn_Resonance_A = Djinn_Resonance:new{
	HealthToTarget = 2,
	UpgradeDescription="Can target units with up to 2 HP.",
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy = Point(1,0),
		Enemy2 = Point(3,1),
		Enemy3 = Point(2,2),
	},
}
Djinn_Resonance_B = Djinn_Resonance:new{
	Push = true,
	UpgradeDescription="Explosion pushes.",
}
Djinn_Resonance_AB = Djinn_Resonance:new{
	HealthToTarget = 2,
	Push = true,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy = Point(1,0),
		Enemy2 = Point(3,1),
		Enemy3 = Point(2,2),
	},
}