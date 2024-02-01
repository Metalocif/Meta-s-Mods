local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
local artilleryArc = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/artilleryArc")
local weaponArmed = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/weaponArmed")
local customAnim = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/customAnim")

local files = {
    "Pound.png",
	"Protect.png",
	"Twister.png",
	"Psywave.png",
	"Slam.png",
	"Confusion.png",
	"Kinesis.png",
	"DragonRage.png",
	"Psychic.png",
	"Fly.png",
	"HyperBeam.png",
	"IcyWind.png",
	"Shockwave.png",
	"HeatWave.png",
	"Blizzard.png",
	"Thunder.png",
	"FireBlast.png",
	"Psystrike.png",
	"ShadowBall.png",
	"DarkPulse.png",
	"Hypnosis.png",
	"DarkVoid.png",
	"FormChange.png",
	"CosmicPower.png",
	"PsychoBoost.png",
	"TimeTravel.png",
	"NaturePower.png",
	"Bloom.png",
	"SeedFlare.png",
	"PetalBlizzard.png",
	"Moonblast.png",
	"EternalLife.png",
	"Reflect.png",
	"Teleport.png",
	"TakeDown.png",
	"ZenHeadbutt.png",
	"MetalClaw.png",
	"MeteorMash.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/weapons/"..file, resourcePath.."img/weapons/"..file)
end

modApi:appendAsset("img/effects/confusion.png", resourcePath.."img/effects/confusion.png")
modApi:appendAsset("img/effects/psywave_R.png", resourcePath.."img/effects/psywave_R.png")
modApi:appendAsset("img/effects/psywave_U.png", resourcePath.."img/effects/psywave_U.png")
modApi:appendAsset("img/effects/shotup_dragonrage.png", resourcePath.."img/effects/shotup_dragonrage.png")
modApi:appendAsset("img/effects/shotup_psystrike.png", resourcePath.."img/effects/shotup_psystrike.png")
modApi:appendAsset("img/effects/twister.png", resourcePath.."img/effects/twister.png")
modApi:appendAsset("img/effects/chill.png", resourcePath.."img/effects/chill.png")
modApi:appendAsset("img/effects/darkpulse.png", resourcePath.."img/effects/darkpulse.png")
modApi:appendAsset("img/effects/sleepanim.png", resourcePath.."img/effects/sleepanim.png")
modApi:appendAsset("img/effects/moonblastanim.png", resourcePath.."img/effects/moonblastanim.png")
modApi:appendAsset("img/effects/petalblizzardanim.png", resourcePath.."img/effects/petalblizzardanim.png")
modApi:appendAsset("img/effects/clockanim.png", resourcePath.."img/effects/clockanim.png")

modApi:appendAsset("img/effects/alienwhip0_D.png", resourcePath.."img/effects/alienwhip0_D.png")
modApi:appendAsset("img/effects/alienwhip0_L.png", resourcePath.."img/effects/alienwhip0_L.png")
modApi:appendAsset("img/effects/alienwhip0_R.png", resourcePath.."img/effects/alienwhip0_R.png")
modApi:appendAsset("img/effects/alienwhip0_U.png", resourcePath.."img/effects/alienwhip0_U.png")
modApi:appendAsset("img/effects/alienwhip1_D.png", resourcePath.."img/effects/alienwhip1_D.png")
modApi:appendAsset("img/effects/alienwhip1_L.png", resourcePath.."img/effects/alienwhip1_L.png")
modApi:appendAsset("img/effects/alienwhip1_R.png", resourcePath.."img/effects/alienwhip1_R.png")
modApi:appendAsset("img/effects/alienwhip1_U.png", resourcePath.."img/effects/alienwhip1_U.png")
modApi:appendAsset("img/effects/alienwhip2_D.png", resourcePath.."img/effects/alienwhip2_D.png")
modApi:appendAsset("img/effects/alienwhip2_L.png", resourcePath.."img/effects/alienwhip2_L.png")
modApi:appendAsset("img/effects/alienwhip2_R.png", resourcePath.."img/effects/alienwhip2_R.png")
modApi:appendAsset("img/effects/alienwhip2_U.png", resourcePath.."img/effects/alienwhip2_U.png")
modApi:appendAsset("img/effects/alienwhip3_D.png", resourcePath.."img/effects/alienwhip3_D.png")
modApi:appendAsset("img/effects/alienwhip3_L.png", resourcePath.."img/effects/alienwhip3_L.png")
modApi:appendAsset("img/effects/alienwhip3_R.png", resourcePath.."img/effects/alienwhip3_R.png")
modApi:appendAsset("img/effects/alienwhip3_U.png", resourcePath.."img/effects/alienwhip3_U.png")


modApi:appendAsset("img/effects/icywind_R.png", resourcePath.."img/effects/icywind_R.png")
modApi:appendAsset("img/effects/icywind_U.png", resourcePath.."img/effects/icywind_U.png")
modApi:appendAsset("img/effects/heatwave_R.png", resourcePath.."img/effects/heatwave_R.png")
modApi:appendAsset("img/effects/heatwave_U.png", resourcePath.."img/effects/heatwave_U.png")
modApi:appendAsset("img/effects/shadowball_R.png", resourcePath.."img/effects/shadowball_R.png")
modApi:appendAsset("img/effects/shadowball_U.png", resourcePath.."img/effects/shadowball_U.png")
modApi:appendAsset("img/effects/naturepower_R.png", resourcePath.."img/effects/naturepower_R.png")
modApi:appendAsset("img/effects/naturepower_U.png", resourcePath.."img/effects/naturepower_U.png")
modApi:appendAsset("img/effects/petal_R.png", resourcePath.."img/effects/petal_R.png")
modApi:appendAsset("img/effects/petal_U.png", resourcePath.."img/effects/petal_U.png")
modApi:appendAsset("img/effects/shotup_seedflare.png", resourcePath.."img/effects/shotup_seedflare.png")
modApi:appendAsset("img/effects/item_seedflare.png", resourcePath.."img/effects/item_seedflare.png")
modApi:appendAsset("img/effects/item_gracidea.png", resourcePath.."img/effects/item_gracidea.png")

local effects = {
	"laser_hyperbeam_R.png",
	"laser_hyperbeam_R1.png",
	"laser_hyperbeam_R2.png",
	-- "laser_hyperbeam_start.png",
	"laser_hyperbeam_U.png",
	"laser_hyperbeam_U1.png",
	"laser_hyperbeam_U2.png",
}
for _, effect in ipairs(effects) do
	modApi:appendAsset("img/effects/".. effect, resourcePath .. "img/effects/" .. effect)
	Location["effects/"..effect] = Point(-12,3)
end
modApi:appendAsset("img/effects/evolution.png", resourcePath.."img/effects/evolution.png")

ANIMS.evolutionAnim = Animation:new{ 	
	Image = "effects/evolution.png",
	PosX = -10, PosY = -5,
	NumFrames = 4,
	Time = 0.2,
	Loop = true,
	Frames = {0, 1, 2, 3, 2, 1, 0}
}

ANIMS.confusionAnim = Animation:new{ 	
	Image = "effects/confusion.png",
	PosX = -10, PosY = -5,
	NumFrames = 8,
	Time = 0.1,
	Loop = false,
}
ANIMS.twisterAnim = Animation:new{ 	
	Image = "effects/twister.png",
	PosX = -10, PosY = -5,
	NumFrames = 5,
	Time = 0.1,
	Loop = false,
}

ANIMS.chillAnim = Animation:new{ 	
	Image = "effects/chill.png",
	PosX = -10, PosY = 5,
	NumFrames = 1,
	Time = 1,
	Loop = true
}

ANIMS.darkpulseAnim = Animation:new{
	Image = "effects/darkpulse.png",
	NumFrames = 8,
	Time = 0.1,
	PosX = -32,
	PosY = -20
}
ANIMS.moonblastAnim = Animation:new{
	Image = "effects/moonblastanim.png",
	NumFrames = 3,
	Frames = {2, 1, 0, 0, 0, 0, 1, 2},
	Time = 0.1,
	PosX = -27,
	PosY = -15
}
ANIMS.petalblizzardAnim = Animation:new{
	Image = "effects/petalblizzardanim.png",
	NumFrames = 5,
	Time = 0.1,
	PosX = -42,
	PosY = -30
}

ANIMS.sleepAnim = Animation:new{
	Image = "effects/sleepanim.png",
	NumFrames = 7,
	Time = 0.3,
	PosX = -30,
	PosY = -20
}
ANIMS.clockAnim = Animation:new{
	Image = "effects/clockanim.png",
	NumFrames = 12,
	Frames = {0,1,2,3,4,5,6,7,8,9,10,11,0,1,2,3,4,5,6,7,8,9,10,11,1,3,5,7,9,11,2,5,8,11,3,7,11,5,11},
	Time = 0.06,
	PosX = -32,
	PosY = -32
}
ANIMS.clockAnimRev = Animation:new{
	Image = "effects/clockanim.png",
	NumFrames = 12,
	-- Frames = {0,11,10,9,8,7,6,5,4,3,2,1,0,11,10,9,8,7,6,5,4,3,2,1,11,9,7,5,3,1,10,7,4,1,9,5,1,7,1},
	Frames = {0,1,2,3,4,5,6,7,8,9,10,11,0,0,1,1,2,2,3,3,4,4,4,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,6,6,6,6,5,5,5,4,4,4,3,3,2,2,1,1,0,0,11,10,9,8,7,6,5,4,3,2,1,0},
	Time = 0.06,
	PosX = -32,
	PosY = -32
}

ANIMS.alienwhip0_0 = Animation:new{Image = "effects/alienwhip0_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
ANIMS.alienwhip1_0 = Animation:new{Image = "effects/alienwhip1_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
ANIMS.alienwhip2_0 = Animation:new{Image = "effects/alienwhip2_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
ANIMS.alienwhip3_0 = Animation:new{Image = "effects/alienwhip3_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}

ANIMS.alienwhip0_1 = Animation:new{Image = "effects/alienwhip0_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
ANIMS.alienwhip1_1 = Animation:new{Image = "effects/alienwhip1_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
ANIMS.alienwhip2_1 = Animation:new{Image = "effects/alienwhip2_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
ANIMS.alienwhip3_1 = Animation:new{Image = "effects/alienwhip3_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}

ANIMS.alienwhip0_2 = Animation:new{Image = "effects/alienwhip0_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
ANIMS.alienwhip1_2 = Animation:new{Image = "effects/alienwhip1_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
ANIMS.alienwhip2_2 = Animation:new{Image = "effects/alienwhip2_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
ANIMS.alienwhip3_2 = Animation:new{Image = "effects/alienwhip3_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}

ANIMS.alienwhip0_3 = Animation:new{Image = "effects/alienwhip0_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
ANIMS.alienwhip1_3 = Animation:new{Image = "effects/alienwhip1_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
ANIMS.alienwhip2_3 = Animation:new{Image = "effects/alienwhip2_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
ANIMS.alienwhip3_3 = Animation:new{Image = "effects/alienwhip3_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}

Poke_Pound = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Pound.png",	
	Rarity = 3,
	Name = "Pound",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 0,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Abra",
	}
}
			
function Poke_Pound:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, 1, direction)
	damage.sAnimation = "explopunch1_"..direction
	ret:AddMelee(p1, damage)
	return ret
end

Poke_Slam = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/Slam.png",	
	Rarity = 3,
	Name = "Slam",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 3,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}

function Poke_Slam:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Slam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	

	return ret
end

Poke_Protect = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Protect.png",	
	Rarity = 3,
	Name = "Protect",
	Description = "Shield a target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Free Action" },
	UpgradeCost = { 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Protect_A=Poke_Protect:new{ UpgradeDescription = "Can be used for free once per turn.", FreeShield = true }


function Poke_Protect:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or Board:IsBuilding(curr) then ret:push_back(curr) end
		end
	end
	return ret
end
	
function Poke_Protect:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local mission = GetCurrentMission()        
	local damage = SpaceDamage(p2)
	if not Board:GetPawn(p1) then return ret end
	damage.iShield = EFFECT_CREATE
	ret:AddDamage(damage)
	if mission and self.FreeShield and not Board:IsTipImage() then
		if not mission.LastProtectTurn then mission.LastProtectTurn = -1 end
		if mission.LastProtectTurn ~= Game:GetTurnCount() then
			ret:AddDelay(0.3)
			ret:AddScript([[modApi:runLater(function() 
				local pos = ]]..p1:GetString()..[[;
				Board:GetPawn(pos):SetActive(true);
				Game:TriggerSound("/ui/map/flyin_rewards");
				Board:Ping(pos, GL_Color(255, 255, 255));
				GetCurrentMission().LastProtectTurn = Game:GetTurnCount();
				end)
			]])
		end
		ret:AddScript("GetCurrentMission().LastProtectTurn = Game:GetTurnCount()")
	end
	
	return ret
end

Poke_Psywave = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Psywave.png",	
	Rarity = 3,
	Name = "Psywave",
	Description = "Send out a psychic projectile. It splits in two when it hits a shield.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Crush Shields" },
	UpgradeCost = { 2, 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Psywave_A=Poke_Psywave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psywave_B=Poke_Psywave:new{ UpgradeDescription = "Damages shielded enemies.", CrushShields = true }
Poke_Psywave_AB=Poke_Psywave:new{ Damage = 3, CrushShields = true }


function Poke_Psywave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Psywave:SplitOnShieldHit(ret, p1, p2, depth)
	if not depth then depth = 0 end
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage)
	local direction = GetDirection(p2-p1)
	local crushShield
	if Board:IsShield(target) then damage.iDamage = 0 end
	if Board:GetPawn(target) and Board:GetPawn(target):IsShield() then
		if self.CrushShields then crushShield = true else damage.iDamage = 0 end
	end
	local delay = NO_DELAY
	if depth == 0 then delay = PROJ_DELAY end
	if crushShield then ret:AddScript(string.format("Board:RemoveShield(%s)", target:GetString())) end
	ret:AddProjectile(p1, damage, "effects/psywave", delay)
	
	if (damage.iDamage == 0 or crushShield) and depth < 3 then 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+1)%4], depth + 1) 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+3)%4], depth + 1) 
		ret:AddDelay(-1)
	end
	return ret
end
	
function Poke_Psywave:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	if Board:GetSize() == Point(6,6) then Board:AddShield(Point(2,2)) end
	-- local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	self:SplitOnShieldHit(ret, p1, p2, 0)
	return ret
end



Poke_DragonRage = LineArtillery:new{
	Class = "TechnoVek",
	Icon = "weapons/DragonRage.png",	
	Rarity = 3,
	Name = "Dragon Rage",
	Description = "Throw a damaging projectile.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_DragonRage_A=Poke_DragonRage:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonRage_B=Poke_DragonRage:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonRage_AB=Poke_DragonRage:new{ Damage = 3 }

function Poke_DragonRage:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploArt1"
	ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", PROJ_DELAY)
	return ret
end
	
Poke_Twister = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Twister.png",	
	Rarity = 3,
	Name = "Twister",
	Description = "Cast a tornado, dealing damage to a target and pushing adjacent tiles clockwise.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Wind Mastery" },
	UpgradeCost = { 2,2 },
	LaunchSound = "/weapons/support_wind",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Twister_A=Poke_Twister:new{ UpgradeDescription = "Increases damage by 1 and damages adjacent tiles.", Damage = 2 }
Poke_Twister_B=Poke_Twister:new{ UpgradeDescription = "Lets you choose whether to push clockwise, counterclockwise, or focus the damage on the center tile and flip it.", TwoClick = true }
Poke_Twister_AB=Poke_Twister:new{ Damage = 2, TwoClick = true }

function Poke_Twister:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end

function Poke_Twister:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	ret:push_back(p2)
	if p1 ~= p2 then
		ret:push_back(p2 + DIR_VECTORS[GetDirection(p2-p1)])
		ret:push_back(p2 + DIR_VECTORS[GetDirection(p1-p2)])
	end
	return ret
end
	
function Poke_Twister:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "twisterAnim"
	damage.sSound = self.LaunchSound
	if Board:IsBuilding(p2) then damage.iDamage = 0 end
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local pushDamage = SpaceDamage(curr, math.max(self.Damage-1, 0), (i+1)%4)
		if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
		ret:AddDamage(pushDamage)
	end
	return ret
end

function Poke_Twister:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "twisterAnim"
	damage.sSound = self.LaunchSound
	if Board:IsBuilding(p2) then damage.iDamage = 0 end
	if p2 == p3 then 
		damage.iDamage = damage.iDamage + 1
		damage.iPush = DIR_FLIP
	else
		local rotation = 1
		if GetDirection(p3-p2) == GetDirection(p2-p1) then rotation = 3 end
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			local pushDamage = SpaceDamage(curr, math.max(self.Damage-1, 0), (i+rotation)%4)
			if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
			ret:AddDamage(pushDamage)
		end
	end
	ret:AddDamage(damage)
	return ret
end

Poke_Confusion = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Confusion.png",	
	Rarity = 3,
	Name = "Confusion",
	Description = "Strike a target with psychic powers, confusing it into changing its attack direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Abra",
	}
}
Poke_Confusion_A=Poke_Confusion:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Confusion_B=Poke_Confusion:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Confusion_AB=Poke_Confusion:new{ Damage = 4 }

function Poke_Confusion:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or 
			(self.HitSides and (Board:GetPawn(curr + DIR_VECTORS[(i + 1)%4]) or Board:GetPawn(curr + DIR_VECTORS[(i + 3)%4]))) then 
				ret:push_back(curr) 
			end
		end
	end
	return ret
end

function Poke_Confusion:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage, DIR_FLIP)
	damage.sAnimation = "confusionAnim"
	ret:AddSafeDamage(damage)
	if self.HitSides then
		damage.loc = p2 + DIR_VECTORS[(direction + 1)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
		damage.loc = p2 + DIR_VECTORS[(direction + 3)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
	end
	return ret
end

Poke_Psychic=Poke_Confusion:new{
	Icon = "weapons/Psychic.png",	
	Rarity = 3,
	Name = "Psychic",
	Description = "Strike several targets with psychic powers, confusing them into changing their attack directions.",
	HitSides = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
}
Poke_Psychic_A=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_B=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_AB=Poke_Psychic:new{ Damage = 4 }


Poke_Fly=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Fly.png",	
	Rarity = 3,
	Name = "Fly",
	Description = "Fly up, then swoop down on a target for massive damage.",
	Push = false,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Global", "Push" },
	UpgradeCost = { 2,2 },
	ZoneTargeting = ZONE_DIR,
	ArtilleryHeight = 50,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(1, 1),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Fly_A=Poke_Fly:new{ UpgradeDescription = "Can target any tile.", Global = true }
Poke_Fly_B=Poke_Fly:new{ UpgradeDescription = "Pushes adjacent tiles, except the target's, on landing.", Push = true }
Poke_Fly_AB=Poke_Fly:new{ Global = true, Push = true }

function Poke_Fly:GetTargetArea(p1)
	local ret = PointList()
	if self.Global then
		for _, tile in ipairs(Board) do
			local unblocked = false
			if Board:IsBlocked(tile, PATH_PROJECTILE) then
				for i = DIR_START, DIR_END do
					local curr = tile + DIR_VECTORS[i]
					if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
				end
				if unblocked then ret:push_back(tile) end
			else
				ret:push_back(tile)
			end
		end
	else
		for dir = DIR_START, DIR_END do
			for i = 1,7 do
				local tile = p1 + DIR_VECTORS[dir]*i
				if Board:IsBlocked(tile, PATH_PROJECTILE) then
					for j = DIR_START, DIR_END do
						local curr = tile + DIR_VECTORS[j]
						if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
					end
					if unblocked then ret:push_back(tile) end
				else
					ret:push_back(tile)
				end
			end
		end
	end
	return ret
end

function Poke_Fly:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	--We only do two click weapon stuff if there is a pawn to strike in the target tile.
	for i = DIR_START,DIR_END do
		--for each tile adjacent to the pawn
		local curr = p2 + DIR_VECTORS[i]
		if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then 
			--if valid and something the user can stand on, we return it
			ret:push_back(curr) 
		end
	end
	
	return ret	
end

function Poke_Fly:IsTwoClickException(p1,p2)
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then return true end	--we only do two click weapon stuff if there is a pawn in p2
	return false
end

function Poke_Fly:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local distance = p1:Manhattan(p2)
	local direction = GetDirection(p2 - p1)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p2,"Emitter_Burst_$tile",DIR_NONE)
	if self.Push and not Board:IsBlocked(p2, PATH_PROJECTILE) then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p2 + DIR_VECTORS[i], 0)
			 dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			ret:AddDamage(dam)
		end
	end
	return ret
end

function Poke_Fly:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p3)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p3,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddDamage(SpaceDamage(p2, self.Damage))
	if self.Push then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p3 + DIR_VECTORS[i], 0)
			dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			if dam.loc ~= p2 then ret:AddDamage(dam) end
		end
	end
	return ret
end

Poke_Kinesis=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Kinesis.png",	
	Rarity = 3,
	Name = "Kinesis",
	Description = "Use psychic powers to shove a target in any direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Fling" },
	UpgradeCost = { 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy = Point(2,2),
		Water = Point(2,1),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
		CustomPawn = "Poke_Abra",
	}
}
Poke_Kinesis_A=Poke_Kinesis:new{ UpgradeDescription = "Can fling targets as far as possible.", Push = 2 }


function Poke_Kinesis:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and not Board:GetPawn(point2):IsGuarding() then ret:push_back(point2) end
		end
	end
	return ret
end

function Poke_Kinesis:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	for i = DIR_START,DIR_END do
		for j = 1, self.Push do
			local curr = p2 + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	
	return ret	
end

function Poke_Kinesis:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p2, 0, direction))
	return ret
end

function Poke_Kinesis:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	local distance = p2:Manhattan(p3)
	if distance == 1 then
		ret:AddDamage(SpaceDamage(p2, 0, direction))
	else
		local target = GetProjectileEnd(p2, p3)
		local hurt = true
		if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
		ret:AddCharge(Board:GetSimplePath(p2, target), FULL_DELAY)
		if hurt then
			ret:AddSafeDamage(SpaceDamage(target, 1))
			ret:AddSafeDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
		end
	end
	return ret
end

Poke_HyperBeam = LaserDefault:new{
	Class = "TechnoVek",
	Icon = "weapons/HyperBeam.png",
	Name = "Hyper Beam",
	Description = "Cast a devastating beam of energy. Completely exhausts the user; they must spend one turn asleep to recuperate.",
	Rarity = 4,
	Explosion = "",
	LaunchSound = "/props/final_bomb_explode",
	Damage = 3,
	PowerCost = 0, --AE Change
	MinDamage = 3,
	FriendlyDamage = true,
	ZoneTargeting = ZONE_DIR,
	LaserArt = "effects/laser_hyperbeam",
	-- LaserArt = "effects/laser1",
	Upgrades = 0,
--	UpgradeList = { "Ally Immune", "+1 Damage" },
	-- UpgradeCost = { 1,3 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
		CustomPawn = "Poke_Dratini",
	}
}
function Poke_HyperBeam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	ret:AddAnimation(p1, "PulseBlast", ANIM_REVERSE)
	ret:AddScript(string.format("Game:TriggerSound(%q)", self.LaunchSound))
	ret:AddDelay(1)
	ret:AddScript("Board:StartShake(2)")
	self:AddLaser(ret, target, direction)
	ret:AddScript(string.format("Board:GetPawn(%s):SetPowered(false)", p1:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Dragonite_sleep"))
	ret:AddScript(string.format("GetCurrentMission().SleepTable[%s] = 3", Board:GetPawn(p1):GetId()))
	return ret
end

-------------------
--LEGENDARY BIRDS--
-------------------

Poke_IcyWind = Skill:new{
	Name = "Icy Wind",
	Class = "TechnoVek",
	Icon = "weapons/IcyWind.png",
	PathSize = 8,
	Damage = 1,
	Description = "Deals damage, removes fire, and chills enemies that are not on fire. Pierces through up to one target. Will freeze an already chilled target.",
	ProjectileArt = "effects/icywind",
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "Freeze Buildings", "+2 Damage"  },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Articuno"
	}
}

Poke_IcyWind_A = Poke_IcyWind:new{ UpgradeDescription = "Freezes buildings instead of damaging them.", FreezeBuildings = true, }

Poke_IcyWind_B = Poke_IcyWind:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3, }

Poke_IcyWind_AB = Poke_IcyWind:new{ FreezeBuildings = true, Damage = 3, }

-- function Poke_IcyWind:GetTargetArea(point)
	-- local ret = PointList()
	-- for i = DIR_START, DIR_END do
		-- ret:push_back(point + DIR_VECTORS[i])
	-- end
	-- return ret
-- end


function Poke_IcyWind:GetSkillEffect(p1,p2)	
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	local second_tar = GetProjectileEnd(first_tar,first_tar+DIR_VECTORS[dir],PATH_PROJECTILE)  
		
	if Board:IsValid(second_tar) and second_tar ~= first_tar then
		
		local damage = SpaceDamage(second_tar, self.Damage)
		damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(second_tar) then
			if CustomAnim:get(Board:GetPawn(second_tar):GetId(), "chillAnim") then 
				damage.iFrozen = 1 
			elseif not Board:GetPawn(second_tar):IsFire() then
				damage.sScript = string.format("CustomAnim:add(%s, %q)", Board:GetPawn(second_tar):GetId(), "chillAnim") 
			end
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", second_tar:GetString()))
		end
		if self.FreezeBuildings and Board:IsBuilding(second_tar) then
			damage.iDamage = 0
			damage.iFrozen = 1
		end
		ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
		
		local distance = first_tar:Manhattan(p1)
		-- ret:AddDelay(distance*0.1 + 0.2)
		local first_damage = SpaceDamage(first_tar, self.Damage)
		first_damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(first_tar) then
			if CustomAnim:get(Board:GetPawn(first_tar):GetId(), "chillAnim") then 
				first_damage.iFrozen = 1 
			elseif not Board:GetPawn(first_tar):IsFire() then
				first_damage.sScript = string.format("CustomAnim:add(%s, %q)", Board:GetPawn(first_tar):GetId(), "chillAnim") 
			end
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", first_tar:GetString()))
		end
		if self.FreezeBuildings and Board:IsBuilding(first_tar) then
			first_damage.iDamage = 0
			first_damage.iFrozen = 1
		end
		ret:AddDamage(first_damage)
	else
		local damage = SpaceDamage(first_tar, self.Damage)
		damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(first_tar) then
			if CustomAnim:get(Board:GetPawn(first_tar):GetId(), "chillAnim") then 
				damage.iFrozen = 1 
			elseif not Board:GetPawn(first_tar):IsFire() then
				damage.sScript = string.format("CustomAnim:add(%s, %q)", Board:GetPawn(first_tar):GetId(), "chillAnim") 
			end
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", first_tar:GetString()))
		end
		if self.FreezeBuildings and Board:IsBuilding(first_tar) then
			damage.iDamage = 0
			damage.iFrozen = 1
		end
		ret:AddProjectile(damage, self.ProjectileArt)
	end
	return ret
end



Poke_Blizzard = Skill:new{
	Name = "Blizzard",
	Class = "TechnoVek",
	Icon = "weapons/Blizzard.png",
	PathSize = 8,
	Damage = 2,
	Limited = 1,
	Description = "Deals damage and chills every enemy on the map. Will freeze an already chilled target.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Articuno"
	}
}

function Poke_Blizzard:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end


function Poke_Blizzard:GetSkillEffect(p1,p2)		--do chill
	local ret = SkillEffect()
	ret:AddScript("Board:SetWeather(3,"..RAIN_SNOW..",Point(0, 0),Point(8, 8),2)")
	ret:AddDelay(1)
	for _, tile in ipairs(Board) do
		if Board:GetPawn(tile) and Board:GetPawn(tile):GetTeam() == TEAM_ENEMY then
			local damage = SpaceDamage(tile, self.Damage)
			if Board:GetPawn(tile) then
				if CustomAnim:get(Board:GetPawn(tile):GetId(), "chillAnim") then 
					damage.iFrozen = 1 
				else
					damage.sScript = string.format("CustomAnim:add(%s, %q)", Board:GetPawn(tile):GetId(), "chillAnim")
				end
			end
			ret:AddDamage(damage)
		end
	end
	
	return ret
end



Poke_Shockwave = Skill:new{
	Name = "Shockwave",
	Class = "TechnoVek",
	Icon = "weapons/Shockwave.png",
	PathSize = 8,
	Damage = 1,
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "+1 Damage", "+1 Damage"  },
	Description = "Fires a projectile in all four directions. Can be focused in a single direction for more damage. Can also steal power from the Grid to boost as a free action.",
	ProjectileArt = "effects/laser_elec",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Zapdos"
	}
}

Poke_Shockwave_A = Poke_Shockwave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2, }

Poke_Shockwave_B = Poke_Shockwave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2, }

Poke_Shockwave_AB = Poke_Shockwave:new{ Damage = 3, }

function Poke_Shockwave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(point + DIR_VECTORS[i] * j)
			if Board:IsBlocked(point + DIR_VECTORS[i] * j, PATH_PROJECTILE) then break end
		end
	end
	ret:push_back(point)
	return ret
end


function Poke_Shockwave:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	if Board:IsBuilding(p2) then
		ret:AddDelay(0.3)
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
		ret:AddScript("Game:ModifyPowerGrid(-1)")
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 255, 200))", p1:GetString()))
		ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p1:GetString()))
		
	elseif p1 ~= p2 then
		local target = GetProjectileEnd(p1, p2)
		local damage = SpaceDamage(target, self.Damage + 1)
		damage.sAnimation = "LightningBolt0"
		ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
	
	else
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local target = GetProjectileEnd(p1, curr)
			local damage = SpaceDamage(target, self.Damage)
			damage.sAnimation = "LightningBolt0"
			ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
		
		end
	end
	return ret
end



Poke_Thunder = Skill:new{
	Name = "Thunder",
	Class = "TechnoVek",
	Icon = "weapons/Thunder.png",
	PathSize = 8,
	Damage = 4,
	Limited = 1,
	Description = "Calls down lightning on a single target. Electricity then chains through adjacent units.",
	ProjectileArt = "effects/laser_elec",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Zapdos"
	}
}

function Poke_Thunder:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point+ DIR_VECTORS[i] * j)
		end
	end
	return ret
end


function Poke_Thunder:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	-- local damage = SpaceDamage(p2, 4)
	-- damage.sAnimation = "LightningBoltBig"
	ret:AddAnimation(p2, "LightningBoltBig")
	local damage = SpaceDamage(p2,self.Damage)
	local hash = function(point) return point.x + point.y*10 end
	local explored = {[hash(p1)] = true}
	local todo = {p2}
	-- for i = DIR_START, DIR_END do
		-- todo[#todo+1] = p2 + DIR_VECTORS[i]
	-- end
	local origin = { [hash(p2)] = p1 }
	
	if Board:IsPawnSpace(p2) or (self.Buildings and Board:IsBuilding(p2)) then
		ret:AddAnimation(p1,"Lightning_Hit")
	end
	
	while #todo ~= 0 do
		local current = pop_back(todo)
		
		if not explored[hash(current)] then
			explored[hash(current)] = true
			
			if Board:IsPawnSpace(current) or Board:IsBuilding(current) then
			
				local direction = GetDirection(current - origin[hash(current)])
				damage.sAnimation = "Lightning_Attack_"..direction
				damage.loc = current
				damage.iDamage = Board:IsBuilding(current) and DAMAGE_ZERO or 2
				if current == p2 then damage.iDamage = 4 end		--hacky but I couldn't figure out how to change this properly
				ret:AddDamage(damage)
				
				if not Board:IsBuilding(current) then
					ret:AddAnimation(current,"Lightning_Hit")
				end
				
				for i = DIR_START, DIR_END do
					local neighbor = current + DIR_VECTORS[i]
					if not explored[hash(neighbor)] then
						todo[#todo + 1] = neighbor
						origin[hash(neighbor)] = current
					end
				end
			end		
		end
	end
	return ret
end




Poke_HeatWave = Skill:new{
	Name = "Heat Wave",
	Class = "TechnoVek",
	Icon = "weapons/HeatWave.png",
	PathSize = 1,
	Damage = 0,
	Description = "Sends forth three projectiles that push and burn.",
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "Fan the Flames", "Roaring Fires"  },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,2),
		Building2 = Point(3,3),
		CustomPawn = "Poke_Moltres"
	}
}

Poke_HeatWave_A = Poke_HeatWave:new{ UpgradeDescription = "Damages targets that are already on fire.", Damage = 2, }

Poke_HeatWave_B = Poke_HeatWave:new{ UpgradeDescription = "Damages all units that are on fire.", TriggerFires = true, }

Poke_HeatWave_AB = Poke_HeatWave:new{ Damage = 2, TriggerFires = true, }

function Poke_HeatWave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+ DIR_VECTORS[i])
	end
	return ret
end


function Poke_HeatWave:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local offset = DIR_VECTORS[(dir+1)%4]
	for i = -1, 1 do
		local curr = p1 + offset * i
		local target = GetProjectileEnd(curr, p2 + offset * i)
		local damage = SpaceDamage(target, 0, dir)
		damage.iFire = 1
		if Board:IsFire(target) or (Board:GetPawn(target) and Board:GetPawn(target):IsFire()) then damage.iDamage = self.Damage end
		ret:AddProjectile(curr, damage, "effects/heatwave", NO_DELAY)
	end
	if self.TriggerFires then
		for _, tile in ipairs(Board) do	--this should iterate on GetPawns() but I couldn't remember the syntax
			if Board:GetPawn(tile) and Board:GetPawn(tile):IsFire() and not Board:GetPawn(tile):IsIgnoreFire() then ret:AddSafeDamage(SpaceDamage(tile, 1)) end
		end
	end
	return ret
end

Poke_FireBlast = Skill:new{
	Name = "Fire Blast",
	Class = "TechnoVek",
	Icon = "weapons/FireBlast.png",
	PathSize = 8,
	Damage = 3,
	Limited = 1,
	Description = "Fire a devastating fire explosion, pushing and burning adjacent tiles.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,2),
		Building2 = Point(3,3),
		CustomPawn = "Poke_MoltresBoss"
	}
}

function Poke_FireBlast:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point+ DIR_VECTORS[i] * j)
		end
	end
	return ret
end

function Poke_FireBlast:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage)
	damage.iFire = 1
	ret:AddArtillery(damage, "effects/shotup_fireball.png", PROJ_DELAY)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, 0, i)
		damage.iFire = 1
		ret:AddDamage(damage)
	end
	return ret
end




Poke_ShadowBall=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ShadowBall.png",	
	Rarity = 3,
	Name = "Shadow Ball",
	Self = "Poke_ShadowBall",
	Description = "Use psychic powers to shove a target in any direction, then fire two shadow projectiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	Shots = 2,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+2 shots", "Fling" },
	UpgradeCost = { 2, 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2,2),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		-- Second_Target = Point(2,1),
		CustomPawn = "Poke_Mewtwo",
	}
}
Poke_ShadowBall_A=Poke_ShadowBall:new{ Description = "Use psychic powers to shove a target in any direction, then fire four shadow projectiles.", UpgradeDescription = "Fires two extra projectiles.", Shots = 4 }
Poke_ShadowBall_B=Poke_ShadowBall:new{ UpgradeDescription = "Can fling targets as far as possible.", Push = 2 }
Poke_ShadowBall_AB=Poke_ShadowBall:new{ Shots = 4, Push = 2 }

function Poke_ShadowBall:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and not Board:GetPawn(point2):IsGuarding() then ret:push_back(point2) end
		end
	end
	return ret
end

function Poke_ShadowBall:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	for i = DIR_START,DIR_END do
		for j = 1, self.Push do
			local curr = p2 + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	
	return ret	
end

function Poke_ShadowBall:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p2, 0, direction))
	return ret
end

function Poke_ShadowBall:GetFinalEffect(p1, p2, p3, remainingShots)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	local distance = p2:Manhattan(p3)
	if not remainingShots then 
		remainingShots = self.Shots
		if distance == 1 then
			
			local pushDamage = SpaceDamage(p2, 0, direction)
			pushDamage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, p2)
			ret:AddDamage(pushDamage)
		else
			local target = GetProjectileEnd(p2, p3)
			local hurt = true
			if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
			ret:AddCharge(Board:GetSimplePath(p2, target), FULL_DELAY)
			if hurt then
				local pushDamage = SpaceDamage(target, 1)
				pushDamage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
				ret:AddSafeDamage(pushDamage)
				ret:AddSafeDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
			end
		end
		-- ret:AddDelay(1)
	else
		local target = GetProjectileEnd(p1,p2)
		local damage = SpaceDamage(target, 1)
		-- damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
		ret:AddProjectile(p1, damage, "effects/shadowball", NO_DELAY)
		ret:AddDelay(0.1 + remainingShots * 0.05)
		remainingShots = remainingShots - 1
	end
	if remainingShots >= 1 then
		
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetFinalEffect(%s, %s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], self.Self, p1:GetString(), p2:GetString(), p3:GetString(), remainingShots))
	end
	return ret
end

Poke_Psystrike=Poke_Confusion:new{		--temp
	Icon = "weapons/Psystrike.png",	
	Rarity = 3,
	Name = "Psystrike",
	Description = "Strike several targets with psychic powers, confusing them into changing their attack directions. Strikes several times and ignores armor.",
	HitSides = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	Damage = 3,
}
Poke_Psystrike_A=Poke_Psystrike:new{ UpgradeDescription = "Increases damage by 1.", Damage = 4 }
Poke_Psystrike_B=Poke_Psystrike:new{ UpgradeDescription = "Increases damage by 1.", Damage = 4 }
Poke_Psystrike_AB=Poke_Psystrike:new{ Damage = 5 }

function Poke_Psystrike:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damageAmount = 1
	local direction = GetDirection(p2-p1)
	for i = -1, 1 do
		local curr = p2 + DIR_VECTORS[(direction+1)%4] * i
		if Board:GetPawn(curr) then
			local damageAmount = 1
			if Board:GetPawn(curr):IsArmor() and not Board:GetPawn(curr):IsAcid() then damageAmount = 2 end
			local damage = SpaceDamage(curr, damageAmount)
			damage.sImageMark = MultishotLib:getImageMark(damageAmount, self.Damage, p1, curr)
			for j = 1, self.Damage do
				ret:AddArtillery(curr + DIR_VECTORS[math.random(0, 3)], damage, "effects/shotup_psystrike.png", NO_DELAY)
				ret:AddDelay(0.05)
			end
			local damage = SpaceDamage(curr, 0, DIR_FLIP)
			-- damage.sAnimation = "confusionAnim"
			ret:AddDamage(damage)
		end
		
	end
	return ret
end


Poke_DarkPulse = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/DarkPulse.png",	
	Rarity = 3,
	Name = "Dark Pulse",
	Description = "Damage all surrounding enemies.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Extend Sleep" },
	UpgradeCost = { 2, 2 },
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,3),
		Target = Point(2,3),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Darkrai",
	}
}
Poke_DarkPulse_A=Poke_DarkPulse:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_DarkPulse_B=Poke_DarkPulse:new{ UpgradeDescription = "Sleeping targets will stay asleep for another turn.", ExtendSleep = true }
Poke_DarkPulse_AB=Poke_DarkPulse:new{ Damage = 3, ExtendSleep = true }


function Poke_DarkPulse:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Poke_DarkPulse:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddAnimation(p1, "darkpulseAnim")
	ret:AddDelay(0.2)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if Board:GetPawn(curr) then 
			ret:AddDamage(SpaceDamage(curr, self.Damage)) 
			-- if GetCurrentMission().SleepTable[Board:GetPawn(curr):GetId()] > -1 then 
			if CustomAnim:get(Board:GetPawn(curr):GetId(), "sleepAnim") then
				ret:AddScript(string.format("GetCurrentMission().SleepTable[%s] = GetCurrentMission().SleepTable[%s] + 1", Board:GetPawn(curr):GetId(), Board:GetPawn(curr):GetId()))
			end
		end
	end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		if Board:GetPawn(curr) then 
			ret:AddDamage(SpaceDamage(curr, self.Damage))
			if CustomAnim:get(Board:GetPawn(curr):GetId(), "sleepAnim") then
				ret:AddScript(string.format("GetCurrentMission().SleepTable[%s] = GetCurrentMission().SleepTable[%s] + 1", Board:GetPawn(curr):GetId(), Board:GetPawn(curr):GetId()))
			end
		end
	end
	return ret
end


Poke_FormChange = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FormChange.png",	
	Rarity = 3,
	Name = "Form Change",
	Description = "Change forms and perform a different attack based on the target. \nSelf: taunt adjacent enemies and gain a shield. \nAdjacent: Strike front tiles several times. \nRanged: pull the target and strike it. \Otherwise: phase to the location, pushing adjacent tiles.",
	Push = 1,--TOOLTIP HELPER
	MinDamage = 1,
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2, 2 },
	TipImage = {
		Unit = Point(2,1),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Water1 = Point(0,2),
		Water2 = Point(4,2),
		Second_Origin = Point(2,1),
		Second_Target = Point(2,4),
		Second_Click = Point(2,4),
		CustomPawn = "Poke_Deoxys",
	}
}
Poke_FormChange_A=Poke_FormChange:new{ UpgradeDescription = "Increases damage by 1.", MinDamage = 2, Damage = 3 }
Poke_FormChange_B=Poke_FormChange:new{ UpgradeDescription = "Increases damage by 1.", MinDamage = 2, Damage = 3 }
Poke_FormChange_AB=Poke_FormChange:new{ MinDamage = 3, Damage = 4 }

function Poke_FormChange:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	
	for i = DIR_START, DIR_END do
		local wasBlocked = false
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if not wasBlocked then ret:push_back(curr) end
			if wasBlocked and not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
			--we want to stop if it's at or past a blocking thing
			if Board:IsBlocked(curr, PATH_PROJECTILE) then wasBlocked = true end
		end
	end
	return ret
end

function Poke_FormChange:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local distance = p1:Manhattan(p2)
	if p1 == p2 then 			--defense form
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysD"))
		local shield = SpaceDamage(p1)
		shield.iShield = 1
		ret:AddDamage(shield)
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:GetTeam() == TEAM_ENEMY then
				local removeWeb = SpaceDamage(curr, 0, DIR_FLIP)
				removeWeb.bHide = true
				ret:AddDamage(removeWeb)
				ret:AddDamage(removeWeb)	--this flips the pawn twice, deleting webs
				ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", pawn:GetId(), p1:GetString()))
			end
		end
	elseif distance == 1 then 	--attack form
		local direction = GetDirection(p2-p1)
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysA"))
		local damage = SpaceDamage(p2, 1)
		for i = 1, self.Damage do
			damage.loc = p2 + DIR_VECTORS[(direction+1)%4]
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2 + DIR_VECTORS[(direction+1)%4])
			ret:AddDamage(damage)
			damage.loc = p2 + DIR_VECTORS[(direction-1)%4]
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2 + DIR_VECTORS[(direction-1)%4])
			ret:AddDamage(damage)
			damage.loc = p2
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2)
			ret:AddAnimation(p2, "alienwhip"..math.random(0, 3).."_"..direction, 1 + math.random(0, 1) + 4)	--either 1 or 5, normal or reverse
			ret:AddMelee(p1, damage)
			ret:AddSound("/enemy/starfish_1/attack")
			ret:AddDelay(0.35 - self.Damage * 0.05)			--makes it go faster when we hit more times
		end
	elseif GetProjectileEnd(p1, p2) == p2 and Board:IsBlocked(p2, PATH_PROJECTILE) then	--normal Form
		local direction = GetDirection(p2-p1)
		local target = GetProjectileEnd(p1, p2)
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Deoxys"))
		
		local damage = SpaceDamage(target)
		damage.bHidePath = true
		ret:AddProjectile(damage,"effects/shot_grapple")
		
		if Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() then	-- If it's a pawn
			ret:AddCharge(Board:GetSimplePath(target, p1 + DIR_VECTORS[direction]), FULL_DELAY)
			if Board:IsPawnTeam(target, TEAM_ENEMY) then
				ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[direction], self.MinDamage))
			end
		elseif Board:IsBlocked(target, PATH_PROJECTILE) then     --If it's an obstruction
			ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)	
			if Board:IsPawnTeam(target, TEAM_ENEMY) then
				ret:AddDamage(SpaceDamage(target, self.MinDamage))
			end
		end
	
	
	else	--speed Form
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysS"))
		local dir = GetDirection(p2-p1)
		ret:AddCharge(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
		for i = 0, distance do
			ret:AddDelay(0.06)
			ret:AddBounce(p1 + DIR_VECTORS[dir]*i, -3)
			if i < distance and i > 0 then ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[dir]*i, 0)) end
			local damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
			damage.sAnimation = "exploout0_"..(dir+1)%4
			ret:AddDamage(damage)
			damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
			damage.sAnimation = "exploout0_"..(dir-1)%4
			ret:AddDamage(damage)
		end
	end
	return ret
end

Poke_Hypnosis=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Hypnosis.png",	
	Rarity = 3,
	Name = "Hypnosis",
	Description = "Use psychic powers to put a target to sleep.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 7,	
	PowerCost = 0, 
	SleepTurns = 1,
	LargeArea = false,
	Upgrades = 1,
	UpgradeList = { "+1 Turn" },
	UpgradeCost = { 1 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Darkrai",
	}
}
Poke_Hypnosis_A=Poke_Hypnosis:new{ UpgradeDescription = "Puts targets to sleep for an extra turn.", SleepTurns = 2 }


function Poke_Hypnosis:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,self.PathSize do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and Board:GetPawn(point2):GetTeam() == TEAM_ENEMY then ret:push_back(point2) end		-- and Board:GetPawn(point2):IsPowered()
		end
	end
	return ret
end


function Poke_Hypnosis:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	--if GetCurrentMission().SleepTable == nil then GetCurrentMission().SleepTable = {} end
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_ENEMY then
		ret:AddScript(string.format([[local pawn = Board:GetPawn(%s);
		pawn:SetPowered(false);
		pawn:ClearQueued();
		CustomAnim:add(pawn:GetId(), "sleepAnim");
		GetCurrentMission().SleepTable[pawn:GetId()] = %s]], p2:GetString(), self.SleepTurns))
	end
	if self.LargeArea then
		ret:AddAnimation(p2, "darkpulseAnim", ANIM_REVERSE)
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then
				ret:AddScript(string.format([[local pawn = Board:GetPawn(%s)
				pawn:SetPowered(false)
				pawn:ClearQueued()
				CustomAnim:add(pawn:GetId(), "sleepAnim")
				GetCurrentMission().SleepTable[pawn:GetId()] = %s]], curr:GetString(), self.SleepTurns))			
			end
		end
	end
	return ret
end

Poke_DarkVoid=Poke_Hypnosis:new{
	Icon = "weapons/DarkVoid.png",	
	Rarity = 3,
	Name = "Dark Void",
	Description = "Drag all targets in an area into the realm of nightmares.",
	LargeArea = true,
	SleepTurns = 2,
	Upgrades = 1,
	UpgradeList = { "+1 Turn" },
	UpgradeCost = { 2 },
	Damage = 0,
}
Poke_DarkVoid_A=Poke_DarkVoid:new{ UpgradeDescription = "Targets stay asleep for one more turn.", SleepTurns = 3 }

function Poke_DarkVoid:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,self.PathSize do
			local point = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point) and Board:GetPawn(point):GetTeam() == TEAM_ENEMY then 
				ret:push_back(point)
			else
				for j = DIR_START, DIR_END do
					local point2 = p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[j]
					if Board:GetPawn(point2) and Board:GetPawn(point2):GetTeam() == TEAM_ENEMY then ret:push_back(point) break end		-- and Board:GetPawn(point2):IsPowered()
				end
			end
		end
	end
	return ret
end

Poke_CosmicPower=SelfTarget:new{
	Class = "TechnoVek",
	Icon = "weapons/CosmicPower.png",	
	Rarity = 3,
	Name = "Cosmic Power",
	Description = "Gains a buff as a free action based on the user's current form.",
	Damage = 0,
	Limited = 1,
}

function Poke_CosmicPower:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	ret:AddDelay(0.3)
	if pawn:GetCustomAnim() == "Poke_DeoxysA" then		--attack form: boost
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysS" then		--speed form: +MS
		ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(%s)", p1:GetString(), pawn:GetMoveSpeed() + 2))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysD" then		--defense form: +max HP
		ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(%s)", p1:GetString(), pawn:GetMaxHealth() + 2))
		ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), pawn:GetHealth() + 2))
	else											--normal form: heal
		ret:AddDamage(SpaceDamage(p1, -2))
	end
	ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p1:GetString()))
	return ret
end

Poke_PsychoBoost=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PsychoBoost.png",	
	Rarity = 3,
	Name = "Psycho Boost",
	Description = "Fire the user's other weapon as a free action, then gains a buff based on the user's current form.",
	Damage = 0,
	Limited = 1,
}

function Poke_PsychoBoost:GetTargetArea(point)
	local pawn = Board:GetPawn(point)
	local index
	if pawn:GetWeaponBaseType(1) == "Poke_PsychoBoost" then index = 2 else index = 1 end
	return _G[pawn:GetWeaponBaseType(index)]:GetTargetArea(point)
end

function Poke_PsychoBoost:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local index
	if pawn:GetWeaponBaseType(1) == "Poke_PsychoBoost" then index = 2 else index = 1 end
	ret.effect:AppendAll(_G[pawn:GetWeaponType(index)]:GetSkillEffect(p1,p2).effect)
	ret:AddDelay(0.3)
	if pawn:GetCustomAnim() == "Poke_DeoxysA" then			--attack form: boost
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", pawn:GetId()))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysS" then		--speed form: +MS
		ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(%s)", pawn:GetId(), pawn:GetMoveSpeed() + 2))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysD" then		--defense form: +max HP
		ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(%s)", pawn:GetId(), pawn:GetMaxHealth() + 2))
		ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(%s)", pawn:GetId(), pawn:GetHealth() + 2))
	else													--normal form: heal
		ret:AddDamage(SpaceDamage(p1, -2))
	end
	ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", pawn:GetId()))
	return ret
end







Poke_TimeTravel=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/TimeTravel.png",	
	Rarity = 3,
	Name = "Time Travel",
	Description = "Manipulate the flow of time to bring the end of the current mission closer or farther away.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	SelfDamage = 1,
	PathSize = 1,	
	PowerCost = 0,
	Limited = 1,
	Upgrades = 1,
	UpgradeList = { "+1 Use" },
	UpgradeCost = { 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		CustomPawn = "Poke_Celebi",
	}
}
Poke_TimeTravel_A=Poke_TimeTravel:new{ UpgradeDescription = "Can be used one more time.", Limited = 2 }

function Poke_TimeTravel:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		ret:push_back(p1+DIR_VECTORS[dir])
	end
	return ret
end

function Poke_TimeTravel:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if Board:GetSize() == Point(6,6) then
		ret:AddAnimation(p1, "clockAnim")
	elseif GetCurrentMission() then
		if p1==p2 then
			ret:AddScript("GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit + 1")
			ret:AddAnimation(p1, "clockAnimRev")
		else
			ret:AddScript("GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit - 1")
			ret:AddAnimation(p1, "clockAnim")
		end
		ret:AddSafeDamage(SpaceDamage(p1, self.SelfDamage))
	end
	return ret
end

Poke_NaturePower=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/NaturePower.png",	
	Rarity = 3,
	Name = "Nature Power",
	Description = "Fire a projectile with limited range that increases in power for each forest in its path.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 3,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+2 Range" },
	UpgradeCost = { 1,2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Forest1 = Point(2,3),
		Forest2 = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2, 1),
		CustomPawn = "Poke_Celebi",
	}
}
Poke_NaturePower_A=Poke_NaturePower:new{ UpgradeDescription = "Can be fired at targets up to 4 tiles away.", PathSize = 4 }
Poke_NaturePower_B=Poke_NaturePower:new{ UpgradeDescription = "Can be fired at targets up to 6 tiles away.", PathSize = 6 }
Poke_NaturePower_AB=Poke_NaturePower:new{ PathSize = 7 }

-- function Poke_NaturePower:GetTargetArea(p1)
	-- local ret = PointList()
	-- ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	-- end
	-- return ret
-- end

function Poke_NaturePower:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	-- local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local curr = p1
	local amount = 1
	repeat
		if Board:GetTerrain(curr) == TERRAIN_FOREST then amount = amount + 1 end
		if not Board:IsValid(curr + DIR_VECTORS[dir]) then break end
		curr = curr + DIR_VECTORS[dir]
	until Board:IsBlocked(curr, PATH_PROJECTILE) or p1:Manhattan(curr) >= self.PathSize
	ret:AddProjectile(SpaceDamage(curr, amount), "effects/naturepower")
	return ret
end



Poke_Bloom=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Bloom.png",	
	Rarity = 3,
	Name = "Bloom",
	Description = "Creates forests in an area, pushing pawns on the edge. Forests already present bloom with Gracidea, which empower Grass-type allied Pokemon.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	Healing = 0,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "Forest's Mercy", "Forest's Wrath" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Forest1 = Point(2,3),
		Target = Point(2, 2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		Forest2 = Point(2, 1),
		CustomPawn = "Poke_Shaymin",
	}
}
Poke_Bloom_A=Poke_Bloom:new{ UpgradeDescription = "Heals allies on forests.", Healing = -1 }
Poke_Bloom_B=Poke_Bloom:new{ UpgradeDescription = "Damages enemies on forests.", Damage = 2 }
Poke_Bloom_AB=Poke_Bloom:new{ Healing = -1, Damage = 2 }

function Poke_Bloom:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_Bloom:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	if Board:GetTerrain(p2) == TERRAIN_FOREST then 
		if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_ENEMY and self.Damage > 0 then
			ret:AddSafeDamage(SpaceDamage(p2, self.Damage))
		elseif Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER and self.Healing < 0 then
			ret:AddDamage(SpaceDamage(p2, self.Healing))
		elseif not Board:GetPawn(p2) and Board:GetItem(p2) == "" then
			damage.sItem = "Poke_Gracidea" 
		end
	elseif Board:GetTerrain(p2) == TERRAIN_HOLE or Board:GetTerrain(p2) == TERRAIN_WATER or Board:GetTerrain(p2) == TERRAIN_MOUNTAIN or Board:GetTerrain(p2) == TERRAIN_BUILDING then
	else
		damage.iTerrain = TERRAIN_FOREST
	end
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		damage = SpaceDamage(curr, 0, i)
		if Board:GetTerrain(curr) == TERRAIN_FOREST then 
			damage.sItem = "Poke_Gracidea" 
		elseif Board:GetTerrain(curr) == TERRAIN_HOLE or Board:GetTerrain(curr) == TERRAIN_WATER or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:GetTerrain(curr) == TERRAIN_BUILDING then
		else
			damage.iTerrain = TERRAIN_FOREST
		end
		ret:AddDamage(damage)
	end
	return ret
end

merge_table(TILE_TOOLTIPS, { Poke_SeedFlare_Text = {"Seed Flare", "Deals 3 Damage to units that move onto it."},
						     Poke_Gracidea_Text = {"Gracidea", "Boosts units that move onto it."} } )	

local seedflare_damage = SpaceDamage(3)
seedflare_damage.iTerrain = TERRAIN_FOREST
seedflare_damage.sSound = "Science_KO_Crack_OnKill"
local gracidea_damage = SpaceDamage(0)


Poke_SeedFlareItem = { Image = "effects/item_seedflare.png", Damage = seedflare_damage, Tooltip = "Poke_SeedFlare_Text", Icon = "effects/item_seedflare.png", UsedImage = ""}
Location["effects/item_seedflare.png"] = Point(-10,10)
Poke_Gracidea = { Image = "effects/item_gracidea.png", Damage = gracidea_damage, Tooltip = "Poke_Gracidea_Text", Icon = "effects/item_gracidea.png", UsedImage = ""}
Location["effects/item_gracidea.png"] = Point(-10,10)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
    if removed_item == "Poke_Gracidea" then
        local pawn = Board:GetPawn(loc)
        if pawn then
			local gracidea_damage = SpaceDamage(loc)
			gracidea_damage.sScript = "Board:GetPawn("..loc:GetString().."):SetBoosted(true)"
			Board:DamageSpace(gracidea_damage)
        end
    end
end)


Poke_SeedFlare=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SeedFlare.png",	
	Rarity = 3,
	Name = "Seed Flare",
	Description = "Fires a powerful explosive seed at a location. If nothing is there, it will remain on that tile until set off.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 1,
	UpgradeList = { "Burst of Gratitude" },
	UpgradeCost = { 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2, 2),
		Second_Origin = Point(2, 4),
		Second_Target = Point(2, 1),
		CustomPawn = "Poke_Shaymin",
	}
}
Poke_SeedFlare_A=Poke_SeedFlare:new{ UpgradeDescription = "When fired at a Gracidea, will damage all adjacent enemies.", Burst = true }

function Poke_SeedFlare:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_SeedFlare:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	local revDir = GetDirection(p1-p2)
	local doBurst
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then 
		if Board:GetItem(p2) == "Poke_Gracidea" and self.Burst then
			doBurst = true
		else
			damage.sItem = "Poke_SeedFlareItem"
		end
	else 
		damage.iDamage = 3 
		damage.iTerrain = TERRAIN_FOREST
		seedflare_damage.sSound = "Science_KO_Crack_OnKill"
	end
	ret:AddDamage(SpaceDamage(p1, 0, revDir))		--this is here for opportunities to self-damage to enable Eternal Life
	ret:AddArtillery(p1, damage, "effects/shotup_seedflare.png", PROJ_DELAY)
	if doBurst then 
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then ret:AddDamage(SpaceDamage(curr, 3)) end
		end
	end
	return ret
end

Poke_PetalBlizzard=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PetalBlizzard.png",	
	Rarity = 3,
	Name = "Petal Blizzard",
	Description = "Strikes and pushes all pawns in a two tiles radius in the chosen direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	Range = 2,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+1 Damage" },
	UpgradeCost = { 2, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_Xerneas",
	}
}
Poke_PetalBlizzard_A=Poke_PetalBlizzard:new{ UpgradeDescription = "Affects targets in a three tile radius.", Range = 3 }
Poke_PetalBlizzard_B=Poke_PetalBlizzard:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2 }
Poke_PetalBlizzard_AB=Poke_PetalBlizzard:new{ Range = 3, Damage = 2 }

-- function Poke_PetalBlizzard:GetTargetArea(p1)
	-- local ret = PointList()
	-- ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	-- end
	-- return ret
-- end

function Poke_PetalBlizzard:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	local dir = GetDirection(p2-p1)
	ret:AddAnimation(p1, "petalblizzardAnim")
	for i = self.Range, 1, -1 do
		for k = 1, #targets do
			if p1:Manhattan(targets[k]) == i then
			--we have to hit the furthest tiles first, so we just iterate on the entire area self.Range times
				if math.random(1, self.Range) == 1 then 
					local visual = SpaceDamage(targets[k] + DIR_VECTORS[dir] * math.random(2, 3))
					visual.bHide = true
					ret:AddProjectile(targets[k], visual, "effects/petal", NO_DELAY) 
				end
				if Board:GetPawn(targets[k]) and targets[k] ~= p1 then ret:AddSafeDamage(SpaceDamage(targets[k], self.Damage, dir)) end
			end
		end
		ret:AddDelay(-1)
	end
	return ret
end



Poke_Moonblast=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Moonblast.png",	
	Rarity = 3,
	Name = "Moonblast",
	Description = "Deal damage in an X-shaped zone.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2, 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(3,3),
		Target = Point(1,1),
		Enemy1 = Point(1, 1),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(0, 0),
		Enemy3 = Point(2, 0),
		Enemy3 = Point(0, 2),
		CustomPawn = "Poke_Xerneas",
	}
}
Poke_Moonblast_A=Poke_Moonblast:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3 }
Poke_Moonblast_B=Poke_Moonblast:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3 }
Poke_Moonblast_AB=Poke_Moonblast:new{ Damage = 4 }

function Poke_Moonblast:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir]*j+DIR_VECTORS[(dir+1)%4]*j)
		end
	end
	return ret
end

function Poke_Moonblast:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "moonblastAnim"
	ret:AddDamage(damage)
	for dir = DIR_START, DIR_END do 
		damage.loc = p2+DIR_VECTORS[dir]+DIR_VECTORS[(dir+1)%4]
		ret:AddDamage(damage)
	end
	return ret
end



Poke_EternalLife=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/EternalLife.png",	
	Rarity = 3,
	Name = "Eternal Life",
	Description = "Heals all allies to full life by draining enemies. The effort puts the user to sleep for one turn.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	Range = 2,
	PathSize = 1,
	PowerCost = 0,
	-- Upgrades = 2,
	-- UpgradeList = { "+1 Range", "+1 Damage" },
	-- UpgradeCost = { 2, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_Xerneas",
	}
}

function Poke_EternalLife:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	-- end
	return ret
end

function Poke_EternalLife:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local enemies = Board:GetPawns(TEAM_ENEMY)
	local allies = Board:GetPawns(TEAM_PLAYER)
	local enemyList = {}
	local allyList = {}
	for _, i in ipairs(extract_table(enemies)) do
		enemyList[#enemyList + 1] = {id = i, hp = Board:GetPawn(i):GetHealth()}
	end
	for _, i in ipairs(extract_table(allies)) do
		if Board:GetPawn(i):IsDamaged() then allyList[#allyList + 1] = {id = i, hp = Board:GetPawn(i):GetMaxHealth() - Board:GetPawn(i):GetHealth()} end
	end
	LOG(#enemyList, #allyList)
	if #enemyList == 0 or #allyList == 0 then return ret end
	while #enemyList > 0 and #allyList > 0 do
		local randAlly = 1 --math.random(#allyList)
		local randEnemy = 1 --math.random(#enemyList)
		local randAllyId = allyList[randAlly].id
		local randEnemyId = enemyList[randEnemy].id
		ret:AddArtillery(Board:GetPawn(randEnemyId):GetSpace(), SpaceDamage(Board:GetPawn(randAllyId):GetSpace(), -1), "effects/shotup_grid.png", NO_DELAY)
		ret:AddSafeDamage(SpaceDamage(Board:GetPawn(randEnemyId):GetSpace(), 1))
		allyList[randAlly].hp = allyList[randAlly].hp - 1
		if allyList[randAlly].hp == 0 then table.remove(allyList, randAlly) end
		enemyList[randEnemy].hp = enemyList[randEnemy].hp - 1
		if Board:GetPawn(randEnemyId):IsAcid() then enemyList[randEnemy].hp = enemyList[randEnemy].hp - 1 end
		if enemyList[randEnemy].hp == 0 then table.remove(enemyList, randEnemy) end
		ret:AddDelay(0.1)
	end
	ret:AddDelay(1)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Xerneas_tree_sleep"))
	ret:AddScript(string.format("Board:GetPawn(%s):SetPowered(false)", p1:GetString()))
	ret:AddScript(string.format("GetCurrentMission().SleepTable[%s] = 1", Board:GetPawn(p1):GetId()))
	return ret
end



Poke_Reflect=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Reflect.png",	
	Rarity = 3,
	Name = "Reflect",
	Description = "Reflects all queued attacks currently targeting the user.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	Range = 0,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+2 Range", "+4 Range" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_ArmoredMewtwo",
	}
}
Poke_Reflect_A=Poke_Reflect:new{ UpgradeDescription = "Can reflect from tiles within a 2 tile radius.", Range = 2 }
Poke_Reflect_B=Poke_Reflect:new{ UpgradeDescription = "Can reflect from tiles within a 4 tile radius.", Range = 4 }
Poke_Reflect_AB=Poke_Reflect:new{ Range = 6 }

function Poke_Reflect:GetTargetArea(p1)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	if self.Range == 0 then
		ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	else	
		for _, tile in ipairs(targets) do
			ret:push_back(tile)
		end
	end
	return ret
end

function Poke_Reflect:GetSkillEffect(p1, p2)
	--for each enemy, look at their queued skill, generate a skill effect targeting the same tile, loop on it, if it targets the Reflect tile, reflect
	local ret = SkillEffect()
	ret:AddAnimation(p2, "ExploRepulse1")
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		local pawn = Board:GetPawn(id)		
		if pawn:IsQueued() then
			local fx = _G[pawn:GetQueuedWeapon()]:GetSkillEffect(pawn:GetSpace(), pawn:GetQueuedTarget())
			for _, spaceDamage in ipairs(extract_table(fx.q_effect)) do
				if spaceDamage.loc == p2 then 
					local reflectDamage = SpaceDamage(pawn:GetSpace(), spaceDamage.iDamage)
					if spaceDamage:GetType() == 2 then			--projectile
						ret:AddProjectile(p2, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetType() == 1 then		--artillery
						ret:AddArtillery(p2, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetMoveType() == 3 then	--melee
						ret:AddDamage(reflectDamage)
					else
						ret:AddDamage(reflectDamage)
					end
					ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", id))
				end
			end
		end
	end
	return ret
end



Poke_Teleport=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Teleport.png",	
	Rarity = 3,
	Name = "Teleport",
	Description = "Teleports a target to another location.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	Range = 3,
	PathSize = 1,
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "+2 Range", "Shunt" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy = Point(2, 2),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,0),
		Second_Click = Point(1, 0),
		Water = Point(1,0),
		CustomPawn = "Poke_ArmoredMewtwo",
	}
}
Poke_Teleport_A=Poke_Teleport:new{ UpgradeDescription = "Can teleport targets two tiles further.", Range = 5 }
Poke_Teleport_B=Poke_Teleport:new{ UpgradeDescription = "Can teleport targets into mountains, killing them, or into pawns, dealing damage to both equal to the lowest health of the two.", Shunt = true }
--inspired by an ability from Fell Seal, great game
Poke_Teleport_AB=Poke_Teleport:new{ Range = 5, Shunt = true }

function Poke_Teleport:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if Board:GetPawn(curr) and not Board:GetPawn(curr):IsGuarding() then ret:push_back(curr) end
	end
	return ret
end

function Poke_Teleport:IsTwoClickException(p1,p2)
	return false
end

function Poke_Teleport:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	for k = 1, #targets do
		local tile = targets[k]
		if not Board:IsBlocked(tile, PATH_PROJECTILE) or self.Shunt and (Board:GetTerrain(tile) == TERRAIN_MOUNTAIN or Board:GetTerrain(tile) == TERRAIN_BUILDING or Board:GetPawn(tile)) then ret:push_back(tile) end
	end
	return ret
end

function Poke_Teleport:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p2))
	return ret
end

function Poke_Teleport:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local moverHp = Board:GetPawn(p2):GetHealth()
	local targetHp = 100
	if Board:GetPawn(p3) then targetHp = Board:GetPawn(p3):GetHealth() end
	if (Board:GetTerrain(p3) == TERRAIN_MOUNTAIN and Board:GetHealth(p3) == 2) or (Board:GetTerrain(p3) == TERRAIN_BUILDING and Board:GetHealth(p3) > moverHp) then
		--we don't want corpses on the same tile as a mountain/building that will be standing 
		ret:AddScript(string.format("Board:GetPawn(%s):SetCorpse(false)", p2:GetString()))
	end
	ret:AddTeleport(p2, p3, FULL_DELAY)
	if Board:IsBlocked(p3, PATH_PROJECTILE) then ret:AddDamage(SpaceDamage(p3, math.min(moverHp, targetHp))) end
	return ret
end



Poke_TakeDown = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/TakeDown.png",	
	Rarity = 3,
	Name = "Take Down",
	Description = "Strike a target and push it back, taking damage equal to half the damage dealt, rounded down.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 1,
	PathSize = 4,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_TakeDown:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_TakeDown:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	local amountDealt = self.Damage
	local pawnHit = Board:GetPawn(target)
	if Board:GetPawn(p1):IsBoosted() then amountDealt = amountDealt + 1 end
	if pawnHit:IsAcid() then
		amountDealt = amountDealt * 2
	elseif pawnHit:IsArmor() then
		amountDealt = amountDealt - 1
	end
	amountDealt = math.min(amountDealt, pawnHit:GetHealth())
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	if doDamage then ret:AddDamage(SpaceDamage(target - DIR_VECTORS[direction], math.floor(amountDealt / 2))) end
	
	return ret
end

Poke_TakeDown_A=Poke_TakeDown:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_TakeDown_B=Poke_TakeDown:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_TakeDown_AB=Poke_TakeDown:new{ Damage = 4 }


Poke_ZenHeadbutt = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/ZenHeadbutt.png",	
	Rarity = 3,
	Name = "Zen Headbutt",
	Description = "Strike a target and push it back, confusing adjacent enemies on both sides of the target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 0,
	PathSize = 7,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,1),
		Enemy3 = Point(3,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_ZenHeadbutt:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_ZenHeadbutt:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	ret:AddAnimation(p1, "ExploRepulseSmall", ANIM_REVERSE)
	ret:AddDelay(0.5)
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	if doDamage then
		local damage = SpaceDamage(target + DIR_VECTORS[(dir+1)%4], 0, DIR_FLIP)
		damage.sAnimation = "confusionAnim"
		ret:AddDamage(damage)
		damage.loc = target + DIR_VECTORS[(dir-1)%4]
		ret:AddDamage(damage)
	end
	return ret
end

Poke_ZenHeadbutt_A=Poke_ZenHeadbutt:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_ZenHeadbutt_B=Poke_ZenHeadbutt:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_ZenHeadbutt_AB=Poke_ZenHeadbutt:new{ Damage = 4 }


Poke_MetalClaw = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MetalClaw.png",	
	Rarity = 3,
	Name = "Metal Claw",
	Description = "Strike a target three times with sharp claws. Each time this is used, it will strike one more time for the rest of the mission.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Strikes = 3,
	Upgrades = 2,
	UpgradeList = {"+1 Strike", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_MetalClaw:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local strikes = self.Strikes
	if GetCurrentMission() then strikes = self.Strikes + GetCurrentMission().MetalClawUses or 0 end
	local anim = Board:GetPawn(p1):GetCustomAnim()
	Board:GetPawn(p1):SetCustomAnim("Metang_swipe")
	for i = 1, strikes do
		local damage = SpaceDamage(p2, self.Damage)
		damage.sAnimation = "metalClawAnim_"..dir%2
		ret:AddMelee(p1, damage)
	end
	if GetCurrentMission() then ret:AddScript("GetCurrentMission().MetalClawUses = "..(GetCurrentMission().MetalClawUses or 0) + 1) end
	Board:GetPawn(p1):SetCustomAnim(anim)
	return ret
end

Poke_MetalClaw_A=Poke_MetalClaw:new{ UpgradeDescription = "Adds one more strike.", Strikes = 4 }
Poke_MetalClaw_B=Poke_MetalClaw:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_MetalClaw_AB=Poke_MetalClaw:new{ Strikes = 4, Damage = 2 }


Poke_MeteorMash = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MeteorMash.png",	
	Rarity = 3,
	Name = "Meteor Mash",
	Description = "Strike a target four times with metal fists. Each time this is used, it will strike one more time for the rest of the mission. Pushes on the final hit. Can also self-target to hit all adjacent tiles once.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Strikes = 4,
	Upgrades = 2,
	UpgradeList = {"+1 Strike", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_MeteorMash:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	local strikes = self.Strikes
	if GetCurrentMission() then strikes = self.Strikes + GetCurrentMission().MeteorMashUses or 0 end
	local anim = Board:GetPawn(p1):GetCustomAnim()
	if p1 ~= p2 then
		local direction = GetDirection(p2 - p1)
		for i = 1, strikes do
			local damage = SpaceDamage(p2, self.Damage)
			if i == strikes then damage.iPush = direction end
			damage.sAnimation = "metalpunch"..((i%2)+1).."_"..direction
			damage.sImageMark = MultishotLib:getImageMark(self.Damage, strikes, p1, p2)
			ret:AddMelee(p1, damage)
		end
	else
		for dir = DIR_START, DIR_END do
			local damage = SpaceDamage(p1 + DIR_VECTORS[dir], self.Damage, dir)
			damage.sAnimation = "metalpunch1_"..direction
			ret:AddDamage(damage)
		end
	end
	if GetCurrentMission() then ret:AddScript("GetCurrentMission().MeteorMashUses = "..(GetCurrentMission().MeteorMashUses or 0) + 1) end
	return ret
end

Poke_MeteorMash_A=Poke_MeteorMash:new{ UpgradeDescription = "Adds one more strike.", Strikes = 5 }
Poke_MeteorMash_B=Poke_MeteorMash:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_MeteorMash_AB=Poke_MeteorMash:new{ Strikes = 4, Damage = 2 }