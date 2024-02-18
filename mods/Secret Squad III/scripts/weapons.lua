-- Known issues:
-- o Art for the encased buildings is shit.
-- o The TipImage for the Digger's encasing upgrade doesn't encase anything.

local mod = modApi:getCurrentMod()

local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/ranged_mothweapon.png", resourcePath.."img/weapons/ranged_mothweapon.png")
modApi:appendAsset("img/weapons/geomancy.png", resourcePath.."img/weapons/geomancy.png")
modApi:appendAsset("img/effects/upshot_bombrock.png", resourcePath.."img/effects/upshot_bombrock.png")
modApi:appendAsset("img/effects/upshot_acidfirerock.png", resourcePath.."img/effects/upshot_acidfirerock.png")
modApi:appendAsset("img/effects/upshot_acidrock.png", resourcePath.."img/effects/upshot_acidrock.png")
modApi:appendAsset("img/effects/upshot_firerock.png", resourcePath.."img/effects/upshot_firerock.png")
modApi:appendAsset("img/effects/upshot_acidfirebombrock.png", resourcePath.."img/effects/upshot_acidfirebombrock.png")
modApi:appendAsset("img/effects/upshot_acidbombrock.png", resourcePath.."img/effects/upshot_acidbombrock.png")
modApi:appendAsset("img/effects/upshot_firebombrock.png", resourcePath.."img/effects/upshot_firebombrock.png")
modApi:appendAsset("img/units/player/encasedbuilding.png", resourcePath.."img/units/player/encasedbuilding.png")
modApi:appendAsset("img/units/player/encasedbuilding_d.png", resourcePath.."img/units/player/encasedbuilding_d.png")
modApi:appendAsset("img/units/player/encasedbuilding_e.png", resourcePath.."img/units/player/encasedbuilding_e.png")
modApi:appendAsset("img/effects/explo_viridian.png", resourcePath.."img/effects/explo_viridian.png")
modApi:appendAsset("img/achievements/BlownAway.png", resourcePath.."img/achievements/BlownAway.png")
modApi:appendAsset("img/achievements/GaiasCradle.png", resourcePath.."img/achievements/GaiasCradle.png")
modApi:appendAsset("img/achievements/RenfieldWho.png", resourcePath.."img/achievements/RenfieldWho.png")

for i = 1, 5 do
	modApi:appendAsset("img/effects/shrapnel"..i.."_U.png", resourcePath.."img/effects/shrapnel"..i.."_U.png")
	modApi:appendAsset("img/effects/shrapnel"..i.."_R.png", resourcePath.."img/effects/shrapnel"..i.."_R.png")
end
modApi:appendAsset("img/effects/treeshot_U.png", resourcePath.."img/effects/treeshot_U.png")
modApi:appendAsset("img/effects/treeshot_R.png", resourcePath.."img/effects/treeshot_R.png")
ANIMS.encasedbuilding = 	ANIMS.BaseUnit:new{ Image = "units/player/encasedbuilding.png", PosX = -18, PosY = -44, Loop = false, Time = 0.3, Height = 1}
ANIMS.encasedbuildinga = 	ANIMS.encasedbuilding:new{ Image = "units/player/encasedbuilding.png", PosX = -18, PosY = -44, Loop = true, Time = 0.3}
ANIMS.encasedbuildingd = 	ANIMS.encasedbuilding:new{ Image = "units/player/encasedbuilding_d.png", PosX = -34, PosY = -44, NumFrames = 13, Time = 0.09, Loop = false }
ANIMS.encasedbuildinge = 	ANIMS.encasedbuilding:new{ Image = "units/player/encasedbuilding_e.png", PosX = -18, PosY = -44, NumFrames = 5, Time = 0.07, Loop = false }
ANIMS.explo_viridian = Animation:new{
	Image = "effects/explo_viridian.png",
	NumFrames = 8,
	Time = 0.06,
	PosX = -22,
	PosY = 1
}


----------------
--Achievements--
----------------

local achievements = {
	Meta_BlownAway = modApi.achievements:add{
		id = "Meta_BlownAway",
		name = "Blown away",
		tip = "Push 5 things with a single use of Repulsive Pellets.",
		img = resourcePath.."img/achievements/BlownAway.png",
		squad = "Meta_TechnoVek3",
	},

	Meta_GaiasCradle = modApi.achievements:add{
		id = "Meta_GaiasCradle",
		name = "Gaia's Cradle",
		tip = "Have four buildings encased at the same time.",
		img = resourcePath.."img/achievements/GaiasCradle.png",
		squad = "Meta_TechnoVek3",
	},

	Meta_RenfieldWho = modApi.achievements:add{
		id = "Meta_RenfieldWho",
		name = "Renfield who?",
		tip = "Toss an unstable boulder covered in A.C.I.D. and fire.",
		img = resourcePath.."img/achievements/RenfieldWho.png",
		squad = "Meta_TechnoVek3",
	},
}

function completeBlownAway()
	if not achievements.Meta_BlownAway:isComplete() then achievements.Meta_BlownAway:addProgress{ complete = true } end
end

function completeGaiasCradle()
	if not achievements.Meta_GaiasCradle:isComplete() then achievements.Meta_GaiasCradle:addProgress{ complete = true } end
end

function completeRenfieldWho()
	if not achievements.Meta_RenfieldWho:isComplete() then achievements.Meta_RenfieldWho:addProgress{ complete = true } end
end

--------
--Moth--
--------

Meta_TechnoMothWeapon = Skill:new{
	Name = "Repulsive Pellets",
	Description = "Launch a pushing artillery attack. The Moth's wings also push everything adjacent to it.",
	Class = "TechnoVek",
	Icon = "weapons/ranged_mothweapon.png",
	Rarity = 3,
	UpShot = "effects/shotup_ant2.png",
	BuildingDamage = true,
	PowerCost = 0, --AE Change
	Damage = 1,
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "Reposition", "+2 Damage"  },
	ImpactSound = "/enemy/moth_1/attack_impact",
	LaunchSound = "/enemy/moth_1/attack_launch",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		--Fire = Point(2,2),
		Enemy2 = Point(2,4),
		--Enemy3 = Point(2,1),
		Target = Point(2,1),
		Mountain = Point(2,2),
		CustomPawn = "Meta_TechnoMoth"
	}
}

--get target area1: if twoclick, is limited to movespeed, second target area is normal artillery that starts from p2

function Meta_TechnoMothWeapon:GetTargetArea(point)
	local ret = PointList()	
	if self.TwoClick and Board:GetPawn(point):GetMoveSpeed() >= 2 then	--reposition if upgrade acquired and can move
		ret:push_back(point)
		for dir = DIR_START, DIR_END do
			if not (Board:GetPawn(point + DIR_VECTORS[dir]) and not Board:GetPawn(point + DIR_VECTORS[dir]):IsGuarding()) and --no pushable pawn 
			not Board:IsBlocked(point + DIR_VECTORS[dir] * 2, PATH_PROJECTILE) and --nothing blocking the tile
			Board:GetPawn(point):GetMoveSpeed() >= 2 then --not webbed
				ret:push_back(point + DIR_VECTORS[dir] * 2) 
			end
			for k = 3, Board:GetPawn(point):GetMoveSpeed() do
				local curr = point + DIR_VECTORS[dir] * k
				if not Board:IsBlocked(curr,PATH_PROJECTILE) then ret:push_back(curr) end
			end
		end
	else																--normal artillery
		for dir = DIR_START, DIR_END do
			for i = 2, 8 do
				local curr = Point(point + DIR_VECTORS[dir] * i)
				if not Board:IsValid(curr) then break end
				ret:push_back(curr)
			end
		end
	end
	return ret
end

function Meta_TechnoMothWeapon:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 2, 8 do
			local curr = Point(p2 + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then break end
			ret:push_back(curr)
		end
	end
	return ret
end

function Meta_TechnoMothWeapon:IsTwoClickException(p1,p2)
	if Board:GetPawn(p1):GetMoveSpeed() < 2 then return true end
	return false
end


function Meta_TechnoMothWeapon:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local options = mod_loader.currentModContent[mod.id].options
	local achievementCounter = 0
	ret:AddBounce(p1, 1)
	if self.TwoClick and Board:GetPawn(p1):GetMoveSpeed() >= 2 then
		for dir = DIR_START, DIR_END do
			damage = SpaceDamage(p1 + DIR_VECTORS[dir], 0, dir)
			damage.sAnimation = "airpush_"..dir
			if dir ~= direction or (options.Meta_MothNerf and not options.Meta_MothNerf.enabled) then ret:AddDamage(damage) end
		end
		local move = PointList()
		move:push_back(p1)
		move:push_back(p2)
		ret:AddBounce(p1, 1)
		ret:AddLeap(move,FULL_DELAY)
	else
		local damage = SpaceDamage(p2, self.Damage, direction)
		damage.sAnimation = "ExploArt"..self.Damage
		ret:AddArtillery(p1, damage, self.UpShot, PROJ_DELAY)
		if Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsPushable() then achievementCounter = achievementCounter + 1 end
		for dir = DIR_START, DIR_END do
			damage = SpaceDamage(p1 + DIR_VECTORS[dir], 0, dir)
			damage.sAnimation = "airpush_"..dir
			if dir ~= direction or (options.Meta_MothNerf and not options.Meta_MothNerf.enabled) then
				ret:AddDamage(damage)
				if Board:IsPawnSpace(p1 + DIR_VECTORS[dir]) and Board:GetPawn(p1 + DIR_VECTORS[dir]):IsPushable() then achievementCounter = achievementCounter + 1 end
			end
		end
		ret:AddBounce(p2, 2)
	end
	--if achievementCounter >= 5 and not achievements.Meta_BlownAway:isComplete() then achievements.Meta_BlownAway:addProgress{ complete = true } end
	if achievementCounter >= 5 then ret:AddScript("completeBlownAway()") end
	return ret
end

function Meta_TechnoMothWeapon:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	local options = mod_loader.currentModContent[mod.id].options
	local achievementCounter = 0
	local damage
	if p1 ~= p2 then
		for dir = DIR_START, DIR_END do
			damage = SpaceDamage(p1 + DIR_VECTORS[dir], 0, dir)
			damage.sAnimation = "airpush_"..dir
			if dir ~= GetDirection(p2-p1) or (options.Meta_MothNerf and not options.Meta_MothNerf.enabled) then
				ret:AddDamage(damage)
				if Board:IsPawnSpace(p1 + DIR_VECTORS[dir]) and Board:GetPawn(p1 + DIR_VECTORS[dir]):IsPushable() then achievementCounter = achievementCounter + 1 end
			end
		end
		local move = PointList()
		move:push_back(p1)
		move:push_back(p2)
		ret:AddBounce(p1, 1)
		ret:AddLeap(move,FULL_DELAY)
	end
	for dir = DIR_START, DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[dir], 0, dir)
		damage.sAnimation = "airpush_"..dir
		if dir ~= direction or (options.Meta_MothNerf and not options.Meta_MothNerf.enabled) then
			ret:AddDamage(damage)
			if Board:IsPawnSpace(p2 + DIR_VECTORS[dir]) and Board:GetPawn(p2 + DIR_VECTORS[dir]):IsPushable() then achievementCounter = achievementCounter + 1 end
		end
	end
	damage = SpaceDamage(p3, self.Damage, direction)
	damage.sAnimation = "ExploArt"..self.Damage
	ret:AddArtillery(p2, damage, self.UpShot, PROJ_DELAY)
	if Board:IsPawnSpace(p3) and Board:GetPawn(p3):IsPushable() then achievementCounter = achievementCounter + 1 end
	
	ret:AddBounce(p3, 2)
	--if achievementCounter >= 5 and not achievements.Meta_BlownAway:isComplete() then achievements.Meta_BlownAway:addProgress{ complete = true } end
	if achievementCounter >= 5 then ret:AddScript("completeBlownAway()") end
	return ret
end

Meta_TechnoMothWeapon_A = Meta_TechnoMothWeapon:new{
	TwoClick = true,
	UpgradeDescription = "Before firing, can also reposition to another tile, pushing things from both starting and landing tile.",
	TipImage = {
		Unit = Point(0,3),
		Enemy1 = Point(1,3),
		Target = Point(3,3),
		Enemy2 = Point(3,2),
		Second_Click = Point(3,1),
		-- Second_Target = Point(3,0),
		CustomPawn = "Meta_TechnoMoth",
	}
}

Meta_TechnoMothWeapon_B = Meta_TechnoMothWeapon:new{
	Damage = 3,
	UpShot = "effects/shotup_crab2.png",
	UpgradeDescription = "Increases damage by 2.",
}
			
Meta_TechnoMothWeapon_AB = Meta_TechnoMothWeapon:new{
	Damage = 3,
	UpShot = "effects/shotup_crab2.png",
	TwoClick = true,
	TipImage = {
		Unit = Point(0,3),
		Enemy1 = Point(1,3),
		Target = Point(3,3),
		Enemy2 = Point(3,2),
		Second_Click = Point(3,1),
		-- Second_Target = Point(3,0),
		CustomPawn = "Meta_TechnoMoth",
	}
}

----------
--Digger--
----------

Meta_TechnoDiggerWeapon = Skill:new{
	Name = "Digging Tusks",
	Description = "Dig up rocks on all adjacent empty tiles. Strike nonempty tiles for 1 damage. Buildings are safe.",
	Class = "TechnoVek",
	Icon = "weapons/enemy_rocker1.png",
	Rarity = 3,
	PowerCost = 0, --AE Change
	Damage = 1,
	Range  = 1,
	Upgrades = 2,
	UpgradeCost = {2,1},
	UpgradeList = { "Hard Rocks", "Encase Building"  },
	ToSpawn = "Wall",
	Shrapnel = false,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		--Enemy2 = Point(2,3),
		Enemy3 = Point(1,1),
		Enemy4 = Point(1,0),
		Target = Point(2,1),
		Water = Point(3,2),
		Building = Point(1,2),
		Building2 = Point(3,1),
		CustomEnemy = "Wall",
		CustomPawn = "Meta_TechnoDigger"
	}
}

function Meta_TechnoDiggerWeapon:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		ret:push_back(DIR_VECTORS[i] + point)
	end
	return ret
end

function Meta_TechnoDiggerWeapon:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		local damage = SpaceDamage(curr)
		if not Board:IsBlocked(curr,PATH_PROJECTILE) and Board:GetTerrain(curr) ~= TERRAIN_WATER and not Board:IsPod(curr) then
			damage.sPawn = self.ToSpawn
			damage.sSound = "/enemy/digger_2/attack_queued"
			ret:AddDamage(damage)
		elseif Board:GetTerrain(curr) ~= TERRAIN_BUILDING then 
			damage.iDamage = self.Damage
			damage.sAnimation = "explorocker_"..dir
			damage.sSound = "/enemy/digger_2/attack"
			ret:AddDamage(damage)
		elseif self.EncaseBuildings and curr == p2 then
			local mission = GetCurrentMission()
			if mission then
				if not mission.EncasedBuildings then mission.EncasedBuildings = {} end
				if Board:IsUniqueBuilding(curr) then 
					mission.EncasedBuildings[curr:GetString()] = tostring(Board:GetUniqueBuilding(curr)) 
					damage.sScript = string.format("Board:SetUniqueBuilding(%s, \"\")", curr:GetString())	--probably unneeded
				else 
					mission.EncasedBuildings[curr:GetString()] = Board:GetHealth(curr) .. Board:GetMaxHealth(curr) 
					--we store both current and max HP so we can remake a half-destroyed building later
				end
				local encasedCount = 0
				for n in pairs(mission.EncasedBuildings) do 
					encasedCount = encasedCount + 1 
				end
				if encasedCount >= 4 then ret:AddScript("completeGaiasCradle()") end
				local freezeRock = false
				if Board:IsFrozen(curr) then freezeRock = true end
				damage.iFrozen = EFFECT_REMOVE
				damage.iTerrain = 0
				if mission.BossMission and Board:IsUniqueBuilding(curr) then damage.sPawn = "EncasedBuilding" else damage.sPawn = "EncasedBuildingStout" end
				if self.ToSpawn == "Wall2" then damage.sPawn = damage.sPawn.."2" end
				ret:AddDamage(damage)
				
				damage = SpaceDamage(curr)
				if freezeRock then damage.iFrozen = EFFECT_CREATE end
				ret:AddDamage(damage)
				
			end        
		end
	end	
	
	if not self.Shrapnel then return ret end
	--check for rocks and do shrapnel
	ret:AddDelay(0.35)
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		if Board:GetPawn(curr) and _G[Board:GetPawn(curr):GetType()].ImpactMaterial == IMPACT_ROCK and (curr == p2 or p1 == p2) then
		--we only fire shrapnel if the rock is targeted or the Digger is targeted
			for dir2 = DIR_START, DIR_END do
				if curr + DIR_VECTORS[dir2] ~= p1 and not Board:IsBuilding(curr + DIR_VECTORS[dir2]) then ret:AddProjectile(curr, SpaceDamage(curr + DIR_VECTORS[dir2], 2), "effects/shrapnel"..math.random(1, 5), NO_DELAY) end
				--we fire from rocks towards tiles that are neither the Digger nor buildings
				--random projectiles graphics because so many are fired at once, although they are barely visible
			end
		end
	end
	return ret
end

Meta_TechnoDiggerWeapon_A = Meta_TechnoDiggerWeapon:new{
	ToSpawn = "Wall2",
	Shrapnel = true,
	UpgradeDescription = "Digs harder rocks. They have one more HP and deal 2 more damage when tossed by the Tumblebug. Hitting rocks now damages adjacent things.",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		--Enemy2 = Point(2,3),
		Enemy3 = Point(1,1),
		Enemy4 = Point(1,0),
		Target = Point(2,1),
		Water = Point(3,2),
		Building = Point(1,2),
		Building2 = Point(3,1),
		CustomEnemy = "Wall2",
		CustomPawn = "Meta_TechnoDigger",
	}
}

Meta_TechnoDiggerWeapon_B = Meta_TechnoDiggerWeapon:new{
	EncaseBuildings = true,
	UpgradeDescription = "Can now encase buildings in stone to protect them.",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		--Enemy2 = Point(2,3),
		Enemy3 = Point(1,1),
		Enemy4 = Point(1,0),
		Target = Point(1,2),
		Water = Point(3,2),
		Building = Point(1,2),
		Building2 = Point(3,1),
		CustomEnemy = "Wall",
		CustomPawn = "Meta_TechnoDigger",
	}
}
			
Meta_TechnoDiggerWeapon_AB = Meta_TechnoDiggerWeapon:new{
	ToSpawn = "Wall2",
	Shrapnel = true,
	EncaseBuildings = true,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Enemy2 = Point(2,3),
		Enemy3 = Point(1,1),
		Enemy4 = Point(1,0),
		Target = Point(2,1),
		Second_Origin = Point(2,2),
		Second_Target = Point(1,2),
		Water = Point(3,2),
		Building = Point(1,2),
		Building2 = Point(3,1),
		CustomEnemy = "Wall2",
		CustomPawn = "Meta_TechnoDigger",
	}
}

Wall2 = 
	{
		Name = "Rock",
		Health = 2,
		Neutral = true,
		MoveSpeed = 0,
		IsPortrait = false,
		Image = "rock1",
		SoundLocation = "/support/rock/",
		DefaultTeam = TEAM_NONE,
		ImpactMaterial = IMPACT_ROCK
	}
AddPawn("Wall2") 

EncasedBuilding = 
	{
		Name = "Encased Building",
		Health = 1,
		Neutral = true,
		MoveSpeed = 0,
		IsPortrait = false,
		LargeShield = true,
		Pushable = false,				--both logical and necessary so we can find the encased building back on death
		IsDeathEffect = true,			--finds the encased buildings back to respawn them
		Image = "encasedbuilding",
		SoundLocation = "/support/rock/",
		DefaultTeam = TEAM_NONE,		--I'm not sure Vek AI cares about these, in which case they should be TEAM_PLAYER?
		ImpactMaterial = IMPACT_ROCK,	--can throw shrapnel
	}
AddPawn("EncasedBuilding") 

function EncasedBuilding:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	--check string is number, if yes spawn normal building & set health
	if tonumber(mission.EncasedBuildings[point:GetString()]) then 
		--means it's a number, ie. we saved the building's health earlier so it's not unique
		local currHealth = mission.EncasedBuildings[point:GetString()]:sub(1, 1)
		local maxHealth = mission.EncasedBuildings[point:GetString()]:sub(2, 2)
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
		ret:AddScript(string.format("Board:SetHealth(%s, %s, %s)", point:GetString(), currHealth, maxHealth))
	else
		ret:AddScript(string.format("Board:SetUniqueBuilding(%s, %q)", point:GetString(), mission.EncasedBuildings[point:GetString()]))
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
	end
	return ret
end

EncasedBuildingStout = EncasedBuilding:new	--what is inherited and what is not is a complete mystery to me
	{
		Name = "Encased Building",
		Image = "rock1",
		Health = 1,
		LargeShield = false,
		Pushable = false,
		IsPortrait = false,
	}
AddPawn("EncasedBuildingStout") 

EncasedBuilding2 = EncasedBuilding:new
	{
		Name = "Encased Building",
		Image = "encasedbuilding",
		Health = 2,
		Pushable = false,
		LargeShield = true,
		IsPortrait = false,
	}
AddPawn("EncasedBuilding2") 

EncasedBuildingStout2 = EncasedBuildingStout:new
	{
		Name = "Encased Building",
		Image = "rock1",
		Health = 2,
		Pushable = false,
		IsPortrait = false,
	}
AddPawn("EncasedBuildingStout2") 

function EncasedBuildingStout:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if tonumber(mission.EncasedBuildings[point:GetString()]) then 
		local currHealth = mission.EncasedBuildings[point:GetString()]:sub(1, 1)
		local maxHealth = mission.EncasedBuildings[point:GetString()]:sub(2, 2)
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
		ret:AddScript(string.format("Board:SetHealth(%s, %s, %s)", point:GetString(), currHealth, maxHealth))
	else
		ret:AddScript(string.format("Board:SetUniqueBuilding(%s, %q)", point:GetString(), mission.EncasedBuildings[point:GetString()]))
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
	end
	return ret
end

function EncasedBuilding2:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if tonumber(mission.EncasedBuildings[point:GetString()]) then 
		local currHealth = mission.EncasedBuildings[point:GetString()]:sub(1, 1)
		local maxHealth = mission.EncasedBuildings[point:GetString()]:sub(2, 2)
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
		ret:AddScript(string.format("Board:SetHealth(%s, %s, %s)", point:GetString(), currHealth, maxHealth))
	else
		ret:AddScript(string.format("Board:SetUniqueBuilding(%s, %q)", point:GetString(), mission.EncasedBuildings[point:GetString()]))
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
	end
	return ret
end

function EncasedBuildingStout2:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if tonumber(mission.EncasedBuildings[point:GetString()]) then 
		local currHealth = mission.EncasedBuildings[point:GetString()]:sub(1, 1)
		local maxHealth = mission.EncasedBuildings[point:GetString()]:sub(2, 2)
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
		ret:AddScript(string.format("Board:SetHealth(%s, %s, %s)", point:GetString(), currHealth, maxHealth))
	else
		ret:AddScript(string.format("Board:SetUniqueBuilding(%s, %q)", point:GetString(), mission.EncasedBuildings[point:GetString()]))
		ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_BUILDING)", point:GetString()))
	end
	return ret
end

--Tumblebug artillery: 
--You can target things beyond something so it's not a two-click and it instead auto-selects the first thing in the line, so to speak
--This deals one damage to the rock, it acts like the rock artillery, pushing sides
--Wall1 deals 2, Wall2 deals 4, BombRock deals 3

-------------
--Tumblebug--
-------------

Meta_TechnoTumblebugWeapon = Skill:new{
	Name = "Mineral Prize",
	Description = "Dig up a rock, then toss an adjacent target.",
	Class = "TechnoVek",
	Icon = "weapons/prime_rock.png",	--unused sprite afaict
	Rarity = 3,
	PowerCost = 0,
	Damage = 1,
	TwoClick = true,
	Upgrades = 2,
	UpgradeCost = {1,2},
	UpgradeList = { "Explosive Rocks", "Free Throw"  },
	ToSpawn = "Wall",
	LaunchSound = "/weapons/boulder_throw",
	ImpactSound = "/impact/dynamic/rock",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(3,3),
		Second_Click = Point(2,0),
		Mountain = Point(2,1),
		CustomPawn = "Meta_TechnoTumblebug",
	}
}

BombRockNoBoom = {
	Name = "Unstable Boulder",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Image = "rock2",
	SoundLocation = "/support/bombrock/",
	IsPortrait = false,
	DefaultTeam = TEAM_NONE,
	ImpactMaterial = IMPACT_ROCK,
	Explodes = false,
}
AddPawn("BombRockNoBoom")

function Meta_TechnoTumblebugWeapon:GetTargetArea(point)
	local ret = PointList()
	local options = mod_loader.currentModContent[mod.id].options
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if not Board:IsBlocked(curr, PATH_GROUND) then ret:push_back(curr) end	
		if not Board:IsBlocked(curr, PATH_GROUND) or (Board:GetPawn(curr) and not Board:GetPawn(curr):IsGuarding()) then
			local maxTossRange = 7
			-- if (options and options.Meta_TumblebugNerf.enabled) then maxTossRange = 2 end
			-- if self.FreeThrow then maxTossRange = maxTossRange + 1 end
			-- if self.ToSpawn == "BombRockNoBoom" then maxTossRange = maxTossRange + 1 end
			for j = 2, maxTossRange do
				local curr2 = point + DIR_VECTORS[i] * j
				if not Board:IsValid(curr2) then break end
				if Board:GetPawn(curr) or not Board:IsBlocked(curr, PATH_GROUND) then
					if not Board:IsBlocked(curr, PATH_GROUND) or _G[Board:GetPawn(curr):GetType()].ImpactMaterial == IMPACT_ROCK then
						ret:push_back(curr2)
						--we can toss rocks on things as well, damaging them
						--second condition is because we'd spawn a rock on a ground tile, then toss it
					else
						if not Board:IsBlocked(curr2, PATH_PROJECTILE) then ret:push_back(curr2) end
						--we can toss pawns on empty tiles only
					end
				end
			end
		end
	end
	--can target adjacent spaces if empty&passable or pawn
	--can target spaces in a line 3+ tiles away if first thing is a pawn or empty
	
	return ret
end

function Meta_TechnoTumblebugWeapon:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local options = mod_loader.currentModContent[mod.id].options
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if not Board:IsBlocked(curr, PATH_GROUND) and curr ~= p2 then ret:push_back(curr) end
		if Board:GetPawn(curr) and not Board:GetPawn(curr):IsGuarding() then --and _G[Board:GetPawn(curr):GetType()].ImpactMaterial == IMPACT_ROCK then
			local maxTossRange = 7
			-- if (options and options.Meta_TumblebugNerf.enabled) then maxTossRange = 2 end
			-- if self.FreeThrow then maxTossRange = maxTossRange + 1 end
			-- if self.ToSpawn == "BombRockNoBoom" then maxTossRange = maxTossRange + 1 end
			for j = 2, maxTossRange do
				local curr2 = p1 + DIR_VECTORS[i] * j
				if _G[Board:GetPawn(curr):GetType()].ImpactMaterial == IMPACT_ROCK or not Board:IsBlocked(curr2, PATH_PROJECTILE) then ret:push_back(curr2) end
			end
		end
	end
	return ret
end

function Meta_TechnoTumblebugWeapon:IsTwoClickException(p1,p2)
	-- if p1:Manhattan(p2) > 1 then return true end	--if first click is a toss, we can't do anything else
	local direction = GetDirection(p2-p1)
	local blockedTiles = 0
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		
		if Board:GetPawn(curr) then	
			if Board:GetPawn(curr):IsGuarding() then 
				blockedTiles = blockedTiles + 1 
			else
				local foundUnblocked = false
				for i = 1, 6 do
					if not Board:IsValid(curr + DIR_VECTORS[dir] * i) then break end
					if not Board:IsBlocked(curr + DIR_VECTORS[dir] * i, PATH_PROJECTILE) then foundUnblocked = true break end
				end
				if not foundUnblocked then blockedTiles = blockedTiles + 1 end
			end
		elseif Board:GetTerrain(curr) == TERRAIN_WATER or Board:IsBuilding(curr) or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then 
			blockedTiles = blockedTiles + 1
		end
	end
	--I may be missing a possibility, but this covers pawns there is nowhere to throw to, stable pawns, and blocking terrain
	if blockedTiles >= 3 then return true end
	if self.FreeThrow and Board:GetPawn(p1 + DIR_VECTORS[direction]) and _G[Board:GetPawn(p1 + DIR_VECTORS[direction]):GetType()].ImpactMaterial == IMPACT_ROCK then return false end
	-- if not Board:IsBlocked(p2, PATH_PROJECTILE) then return false end	--we only do two click weapon stuff if there is a pawn in p2
	if p1:Manhattan(p2) > 1 then return true end
	return false
end

function Meta_TechnoTumblebugWeapon:TossStuff(ret, p1, p2)
	local direction = GetDirection(p2-p1)
	local options = mod_loader.currentModContent[mod.id].options
	local didSidePush
	if p1:Manhattan(p2) == 1 and not Board:GetPawn(p2) then	
	--just spawning a rock
		local damage = SpaceDamage(p2, 0)
		damage.sPawn = self.ToSpawn
		if self.ToSpawn == "BombRockNoBoom" then damage.sPawn = "BombRock" end
		ret:AddMelee(p1,damage)
		ret:AddDelay(0.5)
	elseif Board:GetPawn(p1 + DIR_VECTORS[direction]) and _G[Board:GetPawn(p1 + DIR_VECTORS[direction]):GetType()].ImpactMaterial ~= IMPACT_ROCK then
	--yeeting a non-rock pawn
		local fake_punch = SpaceDamage(p1 + DIR_VECTORS[direction],0)
		fake_punch.sSound = self.LaunchSound
		ret:AddMelee(p1,fake_punch)
		local move = PointList()
		move:push_back(p1+DIR_VECTORS[direction])
		move:push_back(p2)
		ret:AddLeap(move, FULL_DELAY)
		ret:AddDamage(SpaceDamage(p2, 1))
	elseif Board:GetPawn(p1 + DIR_VECTORS[direction]) then
	--yeeting an existing rock
		local fake_punch = SpaceDamage(p1 + DIR_VECTORS[direction],0)
		fake_punch.sSound = self.LaunchSound
		ret:AddMelee(p1,fake_punch)
		
		if not Board:IsBlocked(p2, PATH_PROJECTILE) then
			local move = PointList()
			local fireBoom
			local acidBoom
			if _G[Board:GetPawn(p1+DIR_VECTORS[direction]):GetType()].Explodes and Board:GetPawn(p1+DIR_VECTORS[direction]):IsFire() then fireBoom = true end
			if _G[Board:GetPawn(p1+DIR_VECTORS[direction]):GetType()].Explodes and Board:GetPawn(p1+DIR_VECTORS[direction]):IsAcid() then acidBoom = true end
			move:push_back(p1+DIR_VECTORS[direction])
			move:push_back(p2)
			ret:AddLeap(move, FULL_DELAY)
			ret:AddSound(self.ImpactSound)
			if fireBoom or acidBoom then
				for i = DIR_START, DIR_END do
					local damage = SpaceDamage(p2 + DIR_VECTORS[i])
					if fireBoom then damage.iFire = 1 else damage.iAcid = 1 end
					ret:AddDamage(damage)
				end
			end
			if _G[Board:GetPawn(p1+DIR_VECTORS[direction]):GetType()].Explodes then ret:AddDamage(SpaceDamage(p2, 1)) end
			if _G[Board:GetPawn(p1+DIR_VECTORS[direction]):GetType()].Explodes and Board:GetPawn(p1+DIR_VECTORS[direction]):IsAcid() and Board:GetPawn(p1+DIR_VECTORS[direction]):IsFire() then ret:AddScript("completeRenfieldWho()") end
		else
			local rockID = Board:GetPawn(p1 + DIR_VECTORS[direction]):GetId()
			local damage = SpaceDamage(p2, Board:GetPawn(rockID):GetMaxHealth() * 2)
			damage.fDelay = -1
			damage.sSound = self.ImpactSound
			local visual
			if Board:GetPawn(rockID):IsAcid() and Board:GetPawn(rockID):IsFire() then 
				damage.iAcid = EFFECT_CREATE 
				damage.iFire = EFFECT_CREATE 
				visual = "effects/upshot_acidfirerock.png"
				ret:AddScript("completeRenfieldWho()")
			elseif Board:GetPawn(rockID):IsAcid() then 
				damage.iAcid = EFFECT_CREATE 
				visual = "effects/upshot_acidrock.png"
			elseif Board:GetPawn(rockID):IsFire() then 
				damage.iFire = EFFECT_CREATE 
				visual = "effects/upshot_firerock.png"
			else
				visual = "effects/shotdown_rock.png"
			end
			if self.ToSpawn == "BombRockNoBoom" then visual = "effects/upshot_bombrock.png" end
			if (Board:IsAcid(p1 + DIR_VECTORS[direction]) or Board:IsFire(p1 + DIR_VECTORS[direction])) and self.ToSpawn == "BombRockNoBoom" then visual = visual.sub(1, -9).."bomb"..visual.sub(-8) end
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(Point(-1, -1))", Point(p1 + DIR_VECTORS[direction]):GetString()))
			if _G[Board:GetPawn(rockID):GetType()].Explodes then
				damage.iDamage = damage.iDamage + 1 
				damage.sAnimation = "rock2d" 
				ret:AddArtillery(p1 + DIR_VECTORS[direction],damage,visual, PROJ_DELAY)
				ret:AddDelay(0.1)
				
				local explosionAnim 
				explosionAnim = "ExploArt2"
				LOG(visual)
				if visual == "effects/upshot_firebombrock.png" then explosionAnim = "explo_fire1" end
				if visual == "effects/upshot_acidbombrock.png" then explosionAnim = "ExploArtCrab2" end
				if visual == "effects/upshot_acidfirebombrock.png" then explosionAnim = "ExploArt3" ret:AddScript("completeRenfieldWho()") end
				ret:AddAnimation(p2, explosionAnim)
				didSidePush = true
				for dir = DIR_START, DIR_END do
					local exploDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 1)
					exploDamage.sAnimation = "exploout2_"..dir
					exploDamage.iFire = damage.iFire
					exploDamage.iAcid = damage.iAcid
					if dir == (direction+1)%4 or dir == (direction+3)%4 then exploDamage.iPush = dir end
					if not Board:IsBuilding(p2 + DIR_VECTORS[dir])  or (options.Meta_BombRockAffectBuildings and options.Meta_BombRockAffectBuildings.enabled) then ret:AddDamage(exploDamage) end
				end
			else
				damage.sAnimation = "rock1d" 
				ret:AddArtillery(p1 + DIR_VECTORS[direction],damage, visual, PROJ_DELAY)
			end
		end
		ret:AddBounce(p2,3)
		if not didSidePush then
			ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction + 1)%4], 0, (direction + 1)%4))
			ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction + 3)%4], 0, (direction + 3)%4))
		end
	else
	--spawning and yeeting a rock
		local fake_punch = SpaceDamage(p1 + DIR_VECTORS[direction],0)
		fake_punch.sPawn = self.ToSpawn 
		ret:AddMelee(p1,fake_punch)
		ret:AddDelay(0.5)
		if not Board:IsBlocked(p2, PATH_PROJECTILE) then
			local move = PointList()
			local explosionAnim  = "ExploArt2"
			if Board:IsFire(p1+DIR_VECTORS[direction]) then explosionAnim = "explo_fire1" end
			if Board:IsAcid(p1+DIR_VECTORS[direction]) then explosionAnim = "ExploArtCrab2" end
			move:push_back(p1+DIR_VECTORS[direction])
			move:push_back(p2)
			ret:AddLeap(move, FULL_DELAY)
			ret:AddSound(self.ImpactSound)
			if self.ToSpawn == "BombRockNoBoom" then 
				ret:AddDamage(SpaceDamage(p2, 1))	--this kills the bomb rock we throw
				ret:AddDelay(0.1)
				didSidePush = true
				ret:AddAnimation(p2, explosionAnim)
				didSidePush = true
				for dir = DIR_START, DIR_END do
					local exploDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 1)
					exploDamage.sAnimation = "exploout2_"..dir
					if explosionAnim == "explo_fire1" then exploDamage.iFire = 1 end
					if explosionAnim == "ExploArtCrab2" then exploDamage.iAcid = 1 end
					if dir == (direction+1)%4 or dir == (direction+3)%4 then exploDamage.iPush = dir end
					if not Board:IsBuilding(p2 + DIR_VECTORS[dir]) or (options.Meta_BombRockAffectBuildings and options.Meta_BombRockAffectBuildings.enabled) then ret:AddDamage(exploDamage) end
				end
			end
		else
			local damage = SpaceDamage(p2, 2)
			damage.fDelay = -1
			damage.sSound = self.ImpactSound
			local visual
			if Board:IsAcid(p1 + DIR_VECTORS[direction]) and Board:IsFire(p1 + DIR_VECTORS[direction]) then 
				visual = "effects/upshot_acidfirerock.png"
				damage.iAcid = EFFECT_CREATE 
				damage.iFire = EFFECT_CREATE 
				ret:AddScript("completeRenfieldWho()")
			elseif Board:IsAcid(p1 + DIR_VECTORS[direction]) then 
				damage.iAcid = EFFECT_CREATE 
				visual = "effects/upshot_acidrock.png"
			elseif Board:IsFire(p1 + DIR_VECTORS[direction]) then 
				damage.iFire = EFFECT_CREATE 
				visual = "effects/upshot_firerock.png"
			else
				visual = "effects/shotdown_rock.png"
			end
			if (Board:IsAcid(p1 + DIR_VECTORS[direction]) or Board:IsFire(p1 + DIR_VECTORS[direction])) then
				if self.ToSpawn == "BombRockNoBoom" then visual = visual:sub(1, -9).."bomb"..visual:sub(-8) end
			else
				if self.ToSpawn == "BombRockNoBoom" then visual = "effects/upshot_bombrock.png" end
			end
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(Point(-1, -1))", Point(p1 + DIR_VECTORS[direction]):GetString()))
			if self.ToSpawn == "BombRockNoBoom" then
				damage.iDamage = damage.iDamage + 1 
				damage.sAnimation = "rock2d" 
				ret:AddArtillery(p1 + DIR_VECTORS[direction],damage,visual, PROJ_DELAY)
				ret:AddDelay(0.1)
				
				local explosionAnim 
				explosionAnim = "ExploArt2"
				if visual == "effect/upshot_firebombrock.png" then explosionAnim = "explo_fire1" end
				if visual == "effect/upshot_acidbombrock.png" then explosionAnim = "ExploArtCrab2" end
				if visual == "effect/upshot_acidfirebombrock.png" then explosionAnim = "ExploArt3" end
				ret:AddAnimation(p2, explosionAnim)
				didSidePush = true
				for dir = DIR_START, DIR_END do
					local exploDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 1)
					exploDamage.sAnimation = "exploout2_"..dir
					if explosionAnim == "explo_fire1" then exploDamage.iFire = 1 end
					if explosionAnim == "ExploArtCrab2" then exploDamage.iAcid = 1 end
					if dir == (direction+1)%4 or dir == (direction+3)%4 then exploDamage.iPush = dir end
					if not Board:IsBuilding(p2 + DIR_VECTORS[dir]) or (options.Meta_BombRockAffectBuildings and options.Meta_BombRockAffectBuildings.enabled) then ret:AddDamage(exploDamage) end
				end
			else
				damage.sAnimation = "rock1d" 
				ret:AddArtillery(p1 + DIR_VECTORS[direction], damage, visual, PROJ_DELAY)
			end
		end
		ret:AddBounce(p2,3)
		if not didSidePush then
			ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction + 1)%4], 0, (direction + 1)%4))
			ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction + 3)%4], 0, (direction + 3)%4))
		end
	end
	return ret
end


function Meta_TechnoTumblebugWeapon:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	self:TossStuff(ret, p1, p2)
	return ret
end

function Meta_TechnoTumblebugWeapon:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	self:TossStuff(ret, p1, p2)
	self:TossStuff(ret, p1, p3)
	return ret
end

Meta_TechnoTumblebugWeapon_A = Meta_TechnoTumblebugWeapon:new{
	ToSpawn = "BombRockNoBoom",
	UpgradeDescription = "Digs up explosive rocks. They deal extra damage if thrown on top of units.",
}

Meta_TechnoTumblebugWeapon_B = Meta_TechnoTumblebugWeapon:new{
	FreeThrow = true,
	UpgradeDescription = "If the target is an existing rock, a secondary target can be selected.",
}
			
Meta_TechnoTumblebugWeapon_AB = Meta_TechnoTumblebugWeapon:new{
	ToSpawn = "BombRockNoBoom",
	FreeThrow = true,
}

------------
--Geomancy--
------------

--An overly complicated weapon that is given to you for unlocking all achievements.

Meta_Geomancy = Skill:new{
	Name = "Geomancy",
	Description = "Unleash an effect anywhere on the map depending on the terrain there.",
	Class = "TechnoVek",
	Icon = "weapons/geomancy.png",
	Rarity = 3,
	BuildingDamage = false,
	PowerCost = 0, --AE Change
	Damage = 0,
	PathSize = 1,
	Upgrades = 1,
	UpgradeCost = {2},
	UpgradeList = { "Double cast" },
	ImpactSound = "",
	LaunchSound = "",
	ZoneTargeting = ZONE_ALL,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(1,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(2,2),
		Target = Point(2,1),
		Second_Click = Point(2,3),
		Mountain = Point(2,1),
		CustomPawn = "Meta_TechnoMoth"
	}
}

Meta_Geomancy_A = Meta_Geomancy:new{
	UpgradeDescription = "Select a second tile, applying both effects.",
	TwoClick = true,
}

function Meta_Geomancy:GetTargetArea(point)
	ret = PointList()
	for _, tile in ipairs(Board) do
		ret:push_back(tile)
	end
	return ret
end

function Meta_Geomancy:GetSecondTargetArea(p1, p2)
	ret = PointList()
	for _, tile in ipairs(Board) do
		if tile ~= p2 then ret:push_back(tile) end
	end
	return ret
end

function Meta_Geomancy:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	self:DoStuff(ret, p1, p2)
	return ret
end

function Meta_Geomancy:DoStuff(ret, p1, p2)
	local direction = GetDirection(p2-p1)
	local terrain = Board:GetTerrain(p2)
	local target = Board:GetPawn(p2)
	--there is no switch case in Lua, it should be a table where keys are TERRAIN constants and values are corresponding functions but fuck that noise
	if Board:GetCustomTile(Point(1,1)) == "supervolcano_M.png" and (p2 == Point(0, 0) or p2 == Point(0, 1) or p2 == Point(1, 0) or p2 == Point(1, 1)) then	--big badaboom, can hit pylons :/
		for i = 3, 4 do
			for j = 3, 4 do
				local damage = SpaceDamage(Point(i, j), DAMAGE_DEATH)
				damage.iFire = 1
				damage.sAnimation = "explo_fire1"
				ret:AddArtillery(Point(1, 1), damage, "effects/shotup_fireball.png", NO_DELAY)
			end
		end
	elseif Board:IsTerrain(p2, TERRAIN_LAVA) then	 --Fireballs from lava
		for i = DIR_START, DIR_END do
			local damage = SpaceDamage(p2+DIR_VECTORS[i], 1)
			ret:AddAnimation(p2, "Splash_lava")
			damage.iFire = 1
			damage.sAnimation = "explo_fire1"
			ret:AddArtillery(p2, damage, "effects/shotup_fireball.png", NO_DELAY)
		end
	elseif Board:GetCustomTile(p2) == "tosx_whirlpool_0.png" then		--clockwise push; must be above water
		for i = DIR_START, DIR_END do
			local tile = p2 + DIR_VECTORS[i]
			local damage = SpaceDamage(tile, 0, (i+1)%4)
			ret:AddDamage(damage)
		end
	elseif Board:GetCustomTile(p2) == "tosx_rocks_0.png" then			--projectiles
		for i = DIR_START, DIR_END do
			local target = GetProjectileEnd(p2, p2 + DIR_VECTORS[i], PATH_PROJECTILE)
			local damage = SpaceDamage(target, 1)
			ret:AddProjectile(p2, damage, shrapnel..math.random(1,5), NO_DELAY)
		end
	elseif terrain == TERRAIN_WATER then							   --rain/acid rain: put out fires, replacing with smoke
		if Board:IsAcid(p2) then
			ret:AddAnimation(p2, "SplashAcid")
			ret:AddScript("Board:SetWeather(3,"..RAIN_ACID..",Point(0, 0),Point(8, 8),2)")
		else
			ret:AddAnimation(p2, "Splash")
			ret:AddScript("Board:SetWeather(3,"..RAIN_NORMAL..",Point(0, 0),Point(8, 8),2)")
		end
		ret:AddDelay(2)
		for _, tile in ipairs(Board) do
			local pawn = Board:GetPawn(tile)
			local smokeDamage = SpaceDamage(tile)
			smokeDamage.iSmoke = 1
			if Board:IsFire(tile) then
				ret:AddDamage(smokeDamage)
			elseif pawn then
				if pawn:IsFire() then
					if not pawn:IsIgnoreFire() then ret:AddSafeDamage(SpaceDamage(tile, 1)) end
				else
					smokeDamage.iSmoke = 0
				end
				if Board:IsAcid(p2) then smokeDamage.iAcid = 1 end
				ret:AddDamage(smokeDamage)
			end
		end	
	elseif terrain == TERRAIN_SAND then													--quicksands: buried & smoked	
		ret:AddBounce(p2, 5)
		local damage = SpaceDamage(p2, 0)
		if target and not target:IsFlying() then 
			if target:IsMassive() then		--we can't set a pawn to water anim if it can't go in water, otherwise it takes the color of the boss to use their anim
				ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(\"%sw\")", target:GetId(), _G[target:GetType()].Image))
			else							--so we make nonmassive pawns invisible instead, which is kind of like being buried in sand anyway
				ret:AddScript(string.format("Board:GetPawn(%s):SetInvisible(true)", target:GetId()))
			end
			damage.sScript=string.format("Board:GetPawn(%s):SetMoveSpeed(-10)",Board:GetPawn(p2):GetId())
			ret:AddScript(string.format("Board:GetPawn(%s):SetPushable(false)", target:GetId()))
		end
		damage.iSmoke = 1
		ret:AddDamage(damage)
		
	elseif terrain == TERRAIN_ICE then													--freeze thing on tile
		local damage = SpaceDamage(p2, 0)
		damage.iFrozen = 1
		ret:AddDamage(damage)	
	elseif terrain == TERRAIN_FOREST or Board:IsForestFire(p2) then													--yeet the trees
		for _, tile in ipairs(Board) do
			if (Board:GetTerrain(tile) == TERRAIN_FOREST or Board:IsForestFire(p2)) and Board:GetPawn(tile) then 
				ret:AddAnimation(tile, "explo_viridian", NO_DELAY)
				ret:AddSafeDamage(SpaceDamage(tile, 0, DIR_FLIP)) 
			end
		end
		for i = DIR_START, DIR_END do	
			local curr = p2 + DIR_VECTORS[i]
			if Board:GetTerrain(curr) == TERRAIN_ROAD or Board:GetTerrain(curr) == TERRAIN_RUBBLE then 
				ret:AddScript(string.format("Board:SetTerrain(%s, TERRAIN_FOREST)", curr:GetString()))
			end
		end
	elseif terrain == TERRAIN_ROAD then													--earthquake: 1 damage to grounded stuff, break cracks		
		ret:AddScript("Board:StartShake(1)")
		for _, tile in ipairs(Board) do
			local pawn = Board:GetPawn(tile)
			local crack = SpaceDamage(tile, 0)
			crack.iTerrain = TERRAIN_HOLE
			if pawn and not pawn:IsFlying() then ret:AddSafeDamage(SpaceDamage(tile, 1)) end
			if Board:IsCracked(tile) then ret:AddDamage(crack) end
		end
	elseif terrain == TERRAIN_MOUNTAIN then													--cracks adjacents
		ret:AddBounce(p2, 1)
		for i = DIR_START, DIR_END do
			ret:AddBounce(p2 + DIR_VECTORS[i], 1)
			local crack = SpaceDamage(p2 + DIR_VECTORS[i], 0)
			crack.iCrack = 1
			ret:AddDamage(crack)
		end
	elseif terrain == TERRAIN_BUILDING then													--encase
		local mission = GetCurrentMission()
		if mission then
			local damage = SpaceDamage(p2)
			if not mission.EncasedBuildings then mission.EncasedBuildings = {} end
			if Board:IsUniqueBuilding(p2) then 
				mission.EncasedBuildings[p2:GetString()] = tostring(Board:GetUniqueBuilding(p2)) 
				damage.sScript = string.format("Board:SetUniqueBuilding(%s, \"\")", p2:GetString())	
			else 
				mission.EncasedBuildings[p2:GetString()] = Board:GetHealth(p2) .. Board:GetMaxHealth(p2) 
			end
			local freezeRock = false
			if Board:IsFrozen(p2) then freezeRock = true end
			damage.iFrozen = EFFECT_REMOVE
			damage.iTerrain = 0
			if mission.BossMission and Board:IsUniqueBuilding(p2) then damage.sPawn = "EncasedBuilding" else damage.sPawn = "EncasedBuildingStout" end
			if self.ToSpawn == "Wall2" then damage.sPawn = damage.sPawn.."2" end
			ret:AddDamage(damage)
			damage = SpaceDamage(p2)
			if freezeRock then damage.iFrozen = EFFECT_CREATE end
			ret:AddDamage(damage)
		end        
	elseif terrain == TERRAIN_RUBBLE then													--smoke on and around it; could check whether it's mountain/building rubble
		ret:AddBounce(p2, -3)
		local smokeDamage = SpaceDamage(p2)
		smokeDamage.iSmoke = 1
		ret:AddDamage(smokeDamage)
		for i = DIR_START, DIR_END do
			smokeDamage.loc = p2 + DIR_VECTORS[i]
			ret:AddDamage(smokeDamage)
		end
	elseif terrain == TERRAIN_HOLE then															
		--nothing
	elseif terrain == TERRAIN_FIRE then														--extend fire
		for i = DIR_START, DIR_END do
			local tile = p2 + DIR_VECTORS[i]
			local damage = SpaceDamage(tile, 0)
			damage.iFire = 1
			ret:AddDamage(damage)
		end
	elseif terrain == TERRAIN_ACID then														--extend acid
		for i = DIR_START, DIR_END do
			local tile = p2 + DIR_VECTORS[i]
			local damage = SpaceDamage(tile, 0)
			damage.iAcid = 1
			ret:AddDamage(damage)
		end
	else
		LOG("found weird terrain: "..tostring(terrain))
	end
	return ret
end

function Meta_Geomancy:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	
	self:DoStuff(ret, p1, p2)
	self:DoStuff(ret, p1, p3)
	return ret
end