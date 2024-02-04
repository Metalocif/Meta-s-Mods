--Current weapons:

-- Emboldening Screech (PBAoE boost)
   -- Interesting because boosting enemy Vek can also be useful.
-- Bloody Stream (pew pew once per HP you can spare)
   -- Uses HP as a resource, gets stronger throughout the game as max HP increases, Vek pilots gaining +2 max HP at random may make you change users
-- Cannibalize (melee instakill thing with less HP; heal self; boost self)
   -- Uses max HP as something useful
-- Quickspit (spit at something as a free action; +1 range; +1 damage)
   -- free ACID but you have to be in close range, can also shoot then move then hit something else
-- Mite Swarm (apply mites on everything in laser area, all mites deal 2 damage; +1 damage; +1 move on allies)
   -- stronger the more times it is used
-- Sticky Web (sets movespeed to 0, hits more tiles with upgrades)?
   -- a way to disable some big melee alpha; I see this as very strong on those "kill 4 or fewer enemies" missions
-- Tentacle Strike (AoE)
   -- hits in a cross, A is +1 damage, B is +1 radius and buildings immune, AB is neither but cracks central tile
-- Ooze (spawn an allied medium blob that splits)
   -- attacks by slamming into things, taking damage, probably synergizes with that one passive
   -- initial blob has two HP, meaning it splits into 2/3 things on the second turn unless you hit it, which is interesting
-- Burrowing (move somewhere else; confuse on the way; hit something at the end)
   -- only non-flying units for animation reasons (see SetCustomAnim: set to water anim, pause, invis, pause, appear, pause, set to normal anim)
   -- very fancy animation
   -- it's literally just a Pokémon attack
-- Evolving Bonespear (piercing railgun that gets stronger when used)
   -- Interesting if gotten early or if a pilot has Conservative
   -- Has 15 upgrades, there are 22 battles in the game
-- Hive Sacrifice (get tentacled into lava with every adjacent tile, which kills you)
   -- Basically a replacement for Self-Destruct, which is fine if people want to play with Cyborg weapons only
   -- Also the interaction is so fun it's probably fine to have both in the pool
   -- Doesn't kill bosses and flying units, but leaves lava behind for subsequent turns (which there shouldn't be)/to push Vek in
   -- Overall weaker than self-destruct
-- Alluring/Quickening/Hypnotic/Refreshing Pheromones (pull/haste+move again/choose push direction/dance)?
   -- has a bonus effect when both upgrades are on, letting allies act again
   -- given you want to hit both allies and enemies with it, it's interesting to use
--Weakening Pheromones (cancel attacks in area + delevel enemy weapons)
   -- can delevel twice if you push a boss into it again on another turn
   -- basically smoke that doesn't stay behind
--Bloodlust (melee hit harder if damaged, upgrade to hit everything adjacent)
   -- better on flying mechs since you want to be surrounded
--Metabolize (copy an enemy's weapon)
   -- so fucking hard to code
   --but very worth it, it's fun
   --doesn't work with some weapons
--Assimilate (eat fire/acid/smoke and apply it on subsequent uses)
   --stronger if you use it several times
   --kind of underpowered damage-wise
--Reproduce (toss egg, egg spawns a clone)
   --weaker Clone Cannon, which is probably balanced
   --also I love Rock Accelerator
--Shed Tail (spawn thing, redirect attacks, force priority target)
   --can make two fireflies hit each other or something
--Adapt (reroll other cyborg weapon or this if no other cyborg weapon)
   --won't reroll into passives and only rerolls into enabled cyborg weapons
   --limited to 1 use, good with Conservative

--Passives!
  --Hunter Reflexes (bonus move)
  --Prize of the Hunt (heal on adjacent death)
  --Opportunistic Predation (damage spawns)
  --Cricket Legs (all cyborgs jump)
  --Overdrive (boost each turn but take damage)




-- Vek: Jellyfish?
   --Uses bioelectricity design. Its attack damages units normally but self-heals and leeches power on attacking Grid buildings (doesn't destroy).
   --Evolves if stuck by lightning.
   --Drains Grid every turn, increasing its max HP.
   --Kill it to restore Grid.
   --We know the right amount by comparing max HP to HP it should have.
   
----------------   
--KNOWN ISSUES--
----------------

-- Burrowing's code is not great
-- Hive Sacrifice's tipimage is weird; it does not SetCorpse to false properly for some reason

local path = mod_loader.mods[modApi.currentMod].resourcePath

local BoardEvents = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/boardEvents")

-- add assets from our mod so the game can find them.
modApi:appendAsset("img/weapons/BloodyStream.png", path .."img/weapons/BloodyStream.png")
modApi:appendAsset("img/weapons/Scream_Boost.png", path .."img/weapons/Scream_Boost.png")
modApi:appendAsset("img/weapons/Quickspit.png", path .."img/weapons/Quickspit.png")
modApi:appendAsset("img/weapons/Cannibalize.png", path .."img/weapons/Cannibalize.png")
modApi:appendAsset("img/weapons/MiteSwarm.png", path .."img/weapons/MiteSwarm.png")
--second batch
modApi:appendAsset("img/weapons/Burrowing.png", path .."img/weapons/Burrowing.png")
modApi:appendAsset("img/weapons/Ooze.png", path .."img/weapons/Ooze.png")
modApi:appendAsset("img/weapons/OozeSlam.png", path .."img/weapons/OozeSlam.png")
modApi:appendAsset("img/weapons/old/StickyWeb.png", path .."img/weapons/old/StickyWeb.png")
-- modApi:appendAsset("img/weapons/StickyWeb.png", path .."img/weapons/StickyWeb.png")
modApi:appendAsset("img/weapons/TentacleStrike.png", path .."img/weapons/TentacleStrike.png")
--third batch
modApi:appendAsset("img/weapons/Bonespear.png", path .."img/weapons/Bonespear.png")
modApi:appendAsset("img/weapons/Pheromones.png", path .."img/weapons/Pheromones.png")
modApi:appendAsset("img/weapons/WeakPheromones.png", path .."img/weapons/WeakPheromones.png")
modApi:appendAsset("img/weapons/HiveSacrifice.png", path .."img/weapons/HiveSacrifice.png")
modApi:appendAsset("img/weapons/Bloodlust.png", path .."img/weapons/Bloodlust.png")
modApi:appendAsset("img/weapons/Metabolize.png", path .."img/weapons/Metabolize.png")
modApi:appendAsset("img/weapons/Assimilate.png", path .."img/weapons/Assimilate.png")
modApi:appendAsset("img/weapons/Reproduce.png", path .."img/weapons/Reproduce.png")
modApi:appendAsset("img/weapons/ShedTail.png", path .."img/weapons/ShedTail.png")
modApi:appendAsset("img/weapons/Molt.png", path .."img/weapons/Molt.png")
modApi:appendAsset("img/weapons/AdaptiveBiology.png", path .."img/weapons/AdaptiveBiology.png")
modApi:appendAsset("img/weapons/OpportunisticHunting.png", path .."img/weapons/OpportunisticHunting.png")
modApi:appendAsset("img/weapons/HunterReflexes.png", path .."img/weapons/HunterReflexes.png")
modApi:appendAsset("img/weapons/PrizeOfTheHunt.png", path .."img/weapons/PrizeOfTheHunt.png")
modApi:appendAsset("img/weapons/CricketLegs.png", path .."img/weapons/CricketLegs.png")
modApi:appendAsset("img/weapons/Overdrive.png", path .."img/weapons/Overdrive.png")

modApi:appendAsset("img/effects/explo_bloodyStream.png", path .."img/effects/explo_bloodyStream.png")
modApi:appendAsset("img/effects/shot_bloodyStream_R.png", path .."img/effects/shot_bloodyStream_R.png")
modApi:appendAsset("img/effects/shot_bloodyStream_U.png", path .."img/effects/shot_bloodyStream_U.png")
modApi:appendAsset("img/effects/DNA_anim.png", path .."img/effects/DNA_anim.png")
modApi:appendAsset("img/effects/Goo_emerge.png", path .."img/effects/Goo_emerge.png")
modApi:appendAsset("img/effects/spiderwebitem.png", path .."img/effects/spiderwebitem.png")
modApi:appendAsset("img/effects/shotup_vekegg.png", path .."img/effects/shotup_vekegg.png")

for i = 0, 7 do
	modApi:appendAsset("img/effects/bonespear/bonespear"..i.."_R.png", path .."img/effects/bonespear/bonespear"..i.."_R.png")
	modApi:appendAsset("img/effects/bonespear/bonespear"..i.."_U.png", path .."img/effects/bonespear/bonespear"..i.."_U.png")
end
--the bonespear evolves, so does its projectile, so we have 14 different pics
modApi:appendAsset("img/effects/burrow_openclose.png", path .."img/effects/burrow_openclose.png")
modApi:appendAsset("img/effects/pheromonehypnosisanim.png", path .."img/effects/pheromonehypnosisanim.png")
modApi:appendAsset("img/effects/frighteningpheromonesanim.png", path .."img/effects/frighteningpheromonesanim.png")
modApi:appendAsset("img/effects/tauntedAnim.png", path .."img/effects/tauntedAnim.png")
ANIMS.tail = ANIMS.MechUnit:new{ Image = "units/player/tail.png", PosX = -15, PosY = 15, Height=1}
ANIMS.taila = ANIMS.MechUnit:new{ Image = "units/player/taila.png", PosX = -15, PosY = 15, NumFrames = 6, Height=1 }
ANIMS.taild = ANIMS.MechUnit:new{ Image = "units/player/tail_death.png", PosX = -15, PosY = 15, NumFrames = 6, Time = 0.14, Loop = false, Height=1 }
modApi:appendAsset("img/units/player/tail.png", path.."img/units/player/tail.png")
modApi:appendAsset("img/units/player/taila.png", path.."img/units/player/taila.png")
modApi:appendAsset("img/units/player/tail_death.png", path.."img/units/player/tail_death.png")

-----------------------
--Emboldening Screech--
-----------------------

modApi:addWeaponDrop("CyborgWeapons_Scream_Boost")

CyborgWeapons_Scream_Boost = Science_LocalShield:new{
	Name = "Emboldening Screech",
	Class = "TechnoVek",
	Icon = "weapons/Scream_Boost.png",
	Description = "Boosts the damage of every Vek and Cyborg in the area, including the user.",
	Explosion = "",
	Damage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	WideArea = 1,
	Push = 1,--TOOLTIP HELPER,
	Range = 1,--TOOLTIP HELPER
	Upgrades = 2,
	UpgradeCost = { 1,2 },
	UpgradeList = { "+1 Size",  "+1 Size"  },
	LaunchSound = "/enemy/beetle_1/hurt",
	ZoneTargeting = ZONE_ALL,
}

function CyborgWeapons_Scream_Boost:GetSkillEffect(p1, p2)
	--thanks to NamesAreHard for ridiculous amounts of help
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	for k = 1, #targets do
		local toBoost = Board:GetPawn(targets[k])
		if toBoost and (toBoost:GetClass() == "TechnoVek" or toBoost:GetTeam() == TEAM_ENEMY) then --or toBoost.GetTeam == TEAM_ENEMY_MAJOR 
			ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)",toBoost:GetId()))
		end
	end
	ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
	return ret
end

CyborgWeapons_Scream_Boost_A = CyborgWeapons_Scream_Boost:new{
	UpgradeDescription = "Increases affected radius by 1.",
	Range = 2,
	WideArea = 2,
}

CyborgWeapons_Scream_Boost_B = CyborgWeapons_Scream_Boost:new{
	UpgradeDescription = "Increases affected radius by 1.",
	Range = 2,
	WideArea = 2,
}

CyborgWeapons_Scream_Boost_AB = CyborgWeapons_Scream_Boost:new{
	Range = 3,
	WideArea = 3,
}

---------------
--Cannibalize--
---------------

modApi:addWeaponDrop("CyborgWeapons_Cannibalize")

CyborgWeapons_Cannibalize = Skill:new{  
	Name = "Cannibalize",
	Class = "TechnoVek",
	Icon = "weapons/Cannibalize.png",
	Description = "Kill another biological creature with lower current health.",
	Rarity = 3,
	LaunchSound = "/weapons/titan_fist",
	Damage = DAMAGE_DEATH,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Heal",  "Boost"  },
	UpgradeCost = { 1 , 1 },
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Leaper1",
	},
}

function CyborgWeapons_Cannibalize:GetTargetArea(point)
	local ret = PointList()
	local minHealth = Pawn:GetHealth()
	if Pawn:IsBoosted() then minHealth = minHealth + 1 end
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and (Board:GetPawn(curr):GetClass() == "TechnoVek" or (Board:GetPawn(curr):GetTeam() == TEAM_ENEMY and Board:GetPawn(curr):GetTeam() ~= TEAM_BOTS)) and Board:GetPawn(curr):GetHealth() < minHealth then
		-- can only target something if it has a pawn that is a cyborg or vek with less health
		-- apparently pawns can be on two teams at once???
			ret:push_back(curr)
		end
	end
	
	return ret
end

				
function CyborgWeapons_Cannibalize:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation="ExploBloodyStream"
	ret:AddMelee(p1, damage)
	if self.Heal then ret:AddDamage(SpaceDamage(p1,-1)) end
	if self.Boost then ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", Pawn:GetId())) end
	return ret
end	

CyborgWeapons_Cannibalize_A = CyborgWeapons_Cannibalize:new{
	UpgradeDescription = "Also heals self.",
	Heal=true,
}

CyborgWeapons_Cannibalize_B = CyborgWeapons_Cannibalize:new{	
	UpgradeDescription = "Also boosts on kill.",
	Boost=true,
}

CyborgWeapons_Cannibalize_AB = CyborgWeapons_Cannibalize:new{
	Heal=true,
	Boost=true,
}

-------------
--Quickspit--
-------------

modApi:addWeaponDrop("CyborgWeapons_Quickspit")

CyborgWeapons_Quickspit = Skill:new{  
	Name = "Quickspit",				--don't know about the name
	Class = "TechnoVek",
	Icon = "weapons/Quickspit.png",
	Description = "Spit an A.C.I.D. projectile. Can be followed up with another action once per turn.",
	Rarity = 3,
	Damage = 0,
	Range = 2, -- Tooltip?
	Projectile = true,
	ZoneTargeting = ZONE_DIR,
	ProjectileArt = "effects/shot_tankacid",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Range",  "+1 Damage"  },
	UpgradeCost = { 1 , 1 },
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
		Second_Target=Point(3,2),
	}
}

function CyborgWeapons_Quickspit:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.Range do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then
				break
			end
		end
	end
	
	return ret
end
	
function CyborgWeapons_Quickspit:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.iAcid = 1		--Wrote true instead of 1, game doesn't like that, thanks Pilot_Arrogant
	damage.sAnimation = "ExploAcid1"
	local mission = GetCurrentMission()
	if mission then
		if not mission.LastQuickspitTurn then mission.LastQuickspitTurn = -1 end
		local mission = GetCurrentMission()
		if mission.LastQuickspitTurn ~= Game:GetTurnCount() then
			damage.sScript = string.format("Board:GetPawn(%s):SetActive(true)",Board:GetPawn(p1):GetId())
		end
		ret:AddScript("GetCurrentMission().LastQuickspitTurn = Game:GetTurnCount()")
		-- mission.LastQuickspitTurn = Game:GetTurnCount()
	end        
	ret:AddProjectile(damage,self.ProjectileArt,NO_DELAY)
	return ret
end	

CyborgWeapons_Quickspit_A = CyborgWeapons_Quickspit:new{
	UpgradeDescription = "Range goes from 2 to 3.",
	Range=3,
	TipImage = {
		Unit = Point(2,4),
		Second_Origin=Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		Second_Target=Point(4,2),
	}
}

CyborgWeapons_Quickspit_B = CyborgWeapons_Quickspit:new{	
	UpgradeDescription = "Projectile now deals 1 damage.",
	Damage=1,
}

CyborgWeapons_Quickspit_AB = CyborgWeapons_Quickspit:new{
	Range=3,
	Damage=1,
}

----------------
--BloodyStream--
----------------

modApi:addWeaponDrop("CyborgWeapons_BloodyStream")

CyborgWeapons_BloodyStream = TankDefault:new{  
	Self = "CyborgWeapons_BloodyStream",    --used for recursive shooting
	Name = "Ichorous Stream",				--haha funny JoJo reference
	Class = "TechnoVek",
	Icon = "weapons/BloodyStream.png",
	Description = "Spit blood until down to 1 HP.",
	Rarity = 3,
	LaunchSound = "/weapons/titan_fist",
	Damage = 1,
	ExtraShots = 0,
	Range = RANGE_PROJECTILE, -- Tooltip?
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	--Projectile = true,
	ZoneTargeting = ZONE_DIR,
	Projectile = "effects/shot_bloodyStream",
	Explosion = "ExploBloodyStream",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Shot",  "+2 Shots"  },
	UpgradeCost = { 1 , 2 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Leaper1",
		CustomEnemy2 = "Leaper1",
	},
}

ANIMS.ExploBloodyStream = Animation:new{
	Image = "effects/explo_bloodyStream.png",
	NumFrames = 8,
	Time = 0.03,
	PosX = -22,
	PosY = 1
}

function CyborgWeapons_BloodyStream:GetSkillEffect(p1, p2, remainingShots)
	--Inspired by Lemonymous's RF1995.
	--There was a weird issue where the second shot would fire from (-1, -1), also fixed by Lemonymous.
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1,p2)
	local damage = SpaceDamage(target, self.Damage)
	damage.sAnimation="ExploBloodyStream"
	if remainingShots == nil then 
		remainingShots = Board:GetPawn(p1):GetHealth() - 1 + self.ExtraShots 
	end
	ret:AddProjectile(p1, damage, self.Projectile, NO_DELAY)
	ret:AddDelay(0.35)
	if Board:GetPawn(p1):GetHealth() > 1 then ret:AddSafeDamage(SpaceDamage(p1,1)) end
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
	return ret
end	

CyborgWeapons_BloodyStream_A = CyborgWeapons_BloodyStream:new{
	UpgradeDescription = "Adds an extra shot, independant of remaining health.",
	ExtraShots = 1,
}

CyborgWeapons_BloodyStream_B = CyborgWeapons_BloodyStream:new{	
	UpgradeDescription = "Adds two extra shots, independant of remaining health.",
	ExtraShots = 2,
}

CyborgWeapons_BloodyStream_AB = CyborgWeapons_BloodyStream:new{
	ExtraShots = 3,
}

--------------
--Mite Swarm--
--------------
modApi:addWeaponDrop("CyborgWeapons_MiteSwarm")

CyborgWeapons_MiteSwarm = LaserDefault:new{
	Class = "TechnoVek",
	Name = "Mite Swarm",
	Icon = "weapons/MiteSwarm.png",
	Description = "Send out a swarm of Vek mites, infecting everything in a line. Infected enemies then take damage.",
	Rarity = 3,
	Explosion = "",
	Sound = "",
	Damage = 2,
	PowerCost = 0, --AE Change
	HasteAlly = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
    UpgradeList = { "Haste Ally", "+1 Damage" },
	UpgradeCost = { 1,2 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0)
	}
}
			
CyborgWeapons_MiteSwarm_A = CyborgWeapons_MiteSwarm:new{
	HasteAlly = true,
	UpgradeDescription = "+1 move to allies that would take damage from this weapon.",
}
CyborgWeapons_MiteSwarm_B = CyborgWeapons_MiteSwarm:new{
	Damage = 3,
	UpgradeDescription = "Increases the damage dealt to 3.",
}
CyborgWeapons_MiteSwarm_AB = CyborgWeapons_MiteSwarm:new{
	Damage = 3,
	HasteAlly = true,
}

function CyborgWeapons_MiteSwarm:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local targets = {}
	local curr = p1 + DIR_VECTORS[direction]
	while Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and Board:IsValid(curr) and not Board:IsBuilding(curr) do
		targets[#targets+1] = curr
		curr = curr + DIR_VECTORS[direction]
	end
	-- IsInfected checks whether a pawn has mites.
	-- SetInfected adds/removes mites.
	local board_size = Board:GetSize()
	for i = 0, board_size.x - 1 do
		for j = 0, board_size.y - 1 do
			local p = Point(i,j)
			local toHit = Board:GetPawn(p)
			if toHit and toHit:IsInfected() then
				local damage = SpaceDamage(p)
				if toHit:IsEnemy() then damage.iDamage = self.Damage end
				if self.HasteAlly and not toHit:IsEnemy() then damage.sScript = string.format("Board:GetPawn(%s):AddMoveBonus(1)",toHit:GetId()) end
				ret:AddDamage(damage)
				ret:AddScript(string.format("Board:GetPawn(%s):SetInfected(true)",toHit:GetId()))
			end
		end
	end
	for k = 1, #targets do
		local toHit = Board:GetPawn(targets[k])
		if toHit then
			local damage = SpaceDamage(targets[k])
			if toHit:IsEnemy() then damage.iDamage = self.Damage end
			if self.HasteAlly and not toHit:IsEnemy() then damage.sScript = string.format("Board:GetPawn(%s):AddMoveBonus(1)",toHit:GetId()) end
			ret:AddDamage(damage)
			ret:AddScript(string.format("Board:GetPawn(%s):SetInfected(true)",toHit:GetId()))
		end
	end
	return ret
end

--------
--Ooze--
--------
modApi:addWeaponDrop("CyborgWeapons_Ooze")

ANIMS.OozeSpawn = Animation:new{
	Image = "effects/Goo_emerge.png",
	NumFrames = 5,
	Time = 0.15,
	PosX = -21, PosY = -3 
}

CyborgWeapons_Ooze = Skill:new{
	Class = "TechnoVek",
	Name = "Ooze",
	Description = "Spawn a medium-sized blob, which can slam itself into enemies and splits on death.",
	
	Icon = "weapons/Ooze.png",
	Rarity = 1,
	Deployed = "CyborgWeapons_Deployable_MediumOoze",
	--Projectile = "effects/shotup_tank.png",
	
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {1,1},
	UpgradeList = { "+1 Small Blob", "+1 Small Blob HP" },
	LaunchSound = "/enemy/goo_boss/",
	ImpactSound = "/enemy/goo_boss/",
	TipImage = {
		Unit = Point(1,2),
		Target = Point(1,1),
		Enemy = Point(3,1),
		Second_Origin = Point(1,1),
		Second_Target = Point(2,1),
	},
}

CyborgWeapons_Ooze_A = CyborgWeapons_Ooze:new{
	UpgradeDescription = "Spawns one more small blob on death.",
	Deployed = "CyborgWeapons_Deployable_MediumOozeA",
}
CyborgWeapons_Ooze_B = CyborgWeapons_Ooze:new{
	UpgradeDescription = "Small blobs have one more HP.",
	Deployed = "CyborgWeapons_Deployable_MediumOozeB",
}
CyborgWeapons_Ooze_AB = CyborgWeapons_Ooze:new{
	Deployed = "CyborgWeapons_Deployable_MediumOozeAB",
}

function CyborgWeapons_Ooze:GetTargetArea(point)
	local ret = PointList()
	
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
	end
	
	return ret
end

function CyborgWeapons_Ooze:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddAnimation(p2, "OozeSpawn", ANIM_DELAY)
	ret:AddDelay(0.75)
	local spawnDamage = SpaceDamage(p2)
	spawnDamage.sPawn = self.Deployed
	ret:AddDamage(spawnDamage)
	return ret
end

CyborgWeapons_Deployable_MediumOoze = BlobBoss:new{
	Name="Medium Goo",
	Class="",
	Health = 2,
	SpawnCount = 2,
	MoveSpeed=3,
	Image = "slimeb2",		
	DeathSpawn = "CyborgWeapons_Deployable_SmallOoze",
	Massive = true,
	DefaultTeam = TEAM_PLAYER,
	Portrait = "enemy/BlobBoss",
	SoundLocation = "/enemy/goo_boss/",
	SkillList = { "CyborgWeapons_Deployable_OozeAtk" },
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_ALPHA,	--otherwise we get a boss icon next to the blob
}

CyborgWeapons_Deployable_SmallOoze = CyborgWeapons_Deployable_MediumOoze:new{
	Name="Small Goo",
	Health = 1,
	SpawnCount = 0,
	MoveSpeed=2,
	Image = "slimeb3",		
	Massive = false,
}
CyborgWeapons_Deployable_SmallOozeB = CyborgWeapons_Deployable_SmallOoze:new{Health = 2}

CyborgWeapons_Deployable_MediumOozeA = CyborgWeapons_Deployable_MediumOoze:new{SpawnCount = 3}
CyborgWeapons_Deployable_MediumOozeB = CyborgWeapons_Deployable_MediumOoze:new{DeathSpawn = "CyborgWeapons_Deployable_SmallOozeB"}
CyborgWeapons_Deployable_MediumOozeAB = CyborgWeapons_Deployable_MediumOoze:new{SpawnCount = 3, DeathSpawn = "CyborgWeapons_Deployable_SmallOozeB"}

CyborgWeapons_Deployable_OozeAtk = Punch:new{
	Name="Slam",
	Icon = "weapons/OozeSlam.png",
	Description = "Slam a gelatinous body into a target.",	--push self into target
	Damage=0,
	PowerCost = 0,
	TipImage = {
		Unit = Point(1,2),
		Target = Point(1,1),
		Enemy = Point(1,1),
	},
}

function CyborgWeapons_Deployable_MediumOoze:GetDeathEffect(point)
	local ret = SkillEffect()
	
	if self.DeathSpawn == "" then return ret end
	
	ret:AddSound("/enemy/goo_boss/split")
	
	local vicinity = extract_table(general_DiamondTarget(point,4))
	local spawnPoints = {}
	local backup = {}
	for i,v in ipairs(vicinity) do
		if not Board:IsBlocked(v,PATH_GROUND) and
				v ~= point	then
			
			if point:Manhattan(v) > 2 then
				backup[#backup + 1] = v
			else
				spawnPoints[#spawnPoints + 1] = v
				--LOG("Valid target = "..spawnPoints[#spawnPoints]:GetString())
			end
			
		end
	end
	
	local spawn_amount = self.SpawnCount
		
	for i = 1, spawn_amount do
	
		local damage = SpaceDamage(0)
		if #spawnPoints ~= 0 then
			damage.loc = random_removal(spawnPoints)
		elseif #backup ~= 0 then
			damage.loc = random_removal(backup)
		else
			ret:AddScript("Board:AddAlert("..point:GetString()..",\"Alert_BlobSpawn\")")
			break
		end
		
		damage.sPawn = self.DeathSpawn
		damage.sSound = '/impact/generic/blob'
		ret:AddArtillery(damage,"effects/shotup_crab2.png",NO_DELAY)
		
	end
	
	return ret
end

function CyborgWeapons_Deployable_OozeAtk:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p1, 0)
	damage.iPush = GetDirection(p2 - p1)
	ret:AddDamage(damage)
	return ret
end	

-------------
--Burrowing--
-------------
--I am a Vek and I'm digging a hole
--Basically the Iron Legion's Seismic Wave

modApi:addWeaponDrop("CyborgWeapons_Burrowing")

CyborgWeapons_Burrowing = Skill:new{
	Name = "Dig",
	Class = "TechnoVek",
	Icon = "weapons/Burrowing.png",
	Description = "Non-flier only.\n\nBurrow into the ground to reappear on any empty tile there is a straight earthern path to, pushing adjacent tiles.",
	Explosion = "",
	Damage = 0,
	PathSize = 1,
	PowerCost = 0,
	WideArea = 1,
	Push = 1,--TOOLTIP HELPER,
	Range = 1,--TOOLTIP HELPER
	Upgrades = 2,
	UpgradeCost = { 1,2 },
	UpgradeList = { "Confuse",  "Burrowing Attack"  },
	LaunchSound = "/enemy/digger_1/attack_queued",
	ZoneTargeting = ZONE_ALL,
	CanAttackPawns=false,
	TipImage = {
		Unit = Point(4,2),
		Target = Point(1,2),
		Enemy = Point(3,2),
		Enemy2 = Point(2,1),
		CustomPawn="BeetleMech",
	},
}

function CyborgWeapons_Burrowing:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		--A tile can contain units, buildings, water, chasms, mountains...
		--We go all the way across the board for each direction.
		--When we meet something that is not solid ground, we can't tunnel further and exit the inner loop.
		--When we meet a tile with stuff on it, we can't emerge, unless it's a pawn and we have the second upgrade.
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if not Board:IsValid(point2) or Board:GetTerrain(point2) == TERRAIN_WATER or Board:GetTerrain(point2) == TERRAIN_HOLE then break end	--can't dig past the board/water/lava/holes
			if not Board:IsBuilding(point2) and Board:GetTerrain(point2) ~= TERRAIN_MOUNTAIN then													--can't emerge from mountains/buildings but can go past them
				if not Board:GetPawn(point2) or self.CanAttackPawns then ret:push_back(point2) end													--can only emerge from pawns with the upgrade
			end
		end
	end
	return ret
end

function CyborgWeapons_Burrowing:GetSecondTargetArea(p1, p2)
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

function CyborgWeapons_Burrowing:IsTwoClickException(p1,p2)
	if not Board:GetPawn(p2) then return true end	--we only do two click weapon stuff if there is a pawn in p2
	return false
end

function CyborgWeapons_Burrowing:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local distance = p1:Manhattan(p2)
	local direction = GetDirection(p2 - p1)
	if pawn:IsFlying() then return ret	end --because flying pawns don't have a water anim
	local damage0 = SpaceDamage(p1,0)
	damage0.bHide = true
	damage0.sAnimation = "BurrowOpenClose"
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(\"%sw\")", pawn:GetId(), _G[pawn:GetType()].Image))
	ret:AddDamage(damage0)
	ret:AddDelay(1.25)
	ret:AddScript(string.format("Board:GetPawn(%s):SetInvisible(true)", pawn:GetId()))
	-- ret:AddDelay(0.1)
	
	for i = 1, distance - 1 do
		local point = p1 + DIR_VECTORS[direction] * i
		ret:AddBounce(point,10)
		local damage = SpaceDamage(point,0)
		if self.Flip then damage.iPush = DIR_FLIP end
		ret:AddDamage(damage)
		ret:AddDelay(0.28)
	end
	ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn:GetId(), p2:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetInvisible(false)", pawn:GetId()))
	local damage0 = SpaceDamage(p2,0)
	damage0.bHide = true
	damage0.sAnimation = "BurrowOpenClose"
	ret:AddDamage(damage0)
	for dir = DIR_START, DIR_END do
		if dir ~= (direction+2)%4 then ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[dir], 0, dir)) end
	end
	ret:AddDelay(1.1)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", pawn:GetId(), _G[pawn:GetType()].Image))
	
	return ret
end

function CyborgWeapons_Burrowing:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local distance = p1:Manhattan(p2)
	local direction = GetDirection(p2 - p1)
	if pawn:IsFlying() then return ret	end
	local damage0 = SpaceDamage(p1,0)
	damage0.bHide = true
	damage0.sAnimation = "BurrowOpenClose"
	LOG(string.format("Board:GetPawn(%s):SetCustomAnim(\"%sw\")", pawn:GetId(), _G[pawn:GetType()].Image))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(\"%sw\")", pawn:GetId(), _G[pawn:GetType()].Image))
	ret:AddDamage(damage0)
	ret:AddDelay(0.70)	--0.05 per frame, 14 frames but the last four frames are the hole closing
	ret:AddScript(string.format("Board:GetPawn(%s):SetInvisible(true)", pawn:GetId()))
	ret:AddDelay(0.1)
	
	for i = 1, distance - 1 do
		local point = p1 + DIR_VECTORS[GetDirection(p2 - p1)] * i
		ret:AddBounce(point,-10)
		local damage = SpaceDamage(point,0)
		if self.Flip then damage.iPush = DIR_FLIP end
		ret:AddDamage(damage)
		ret:AddDelay(0.08)
	end
	
	
	if not Board:GetPawn(p2) then
		local damage0 = SpaceDamage(p2,0)
		damage0.bHide = true
		damage0.sAnimation = "BurrowOpenClose"
		ret:AddDamage(damage0)
		ret:AddDelay(0.70)
		ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn:GetId(), p2:GetString()))
	else
		local digDamage = SpaceDamage(p2, 3)
		ret:AddDamage(digDamage)
		ret:AddDelay(0.1)
		local damage0 = SpaceDamage(p3,0)
		damage0.bHide = true
		damage0.sAnimation = "BurrowOpenClose"
		ret:AddDamage(damage0)
		ret:AddDelay(0.70)
		ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn:GetId(), p3:GetString()))
	end

	
	ret:AddScript(string.format("Board:GetPawn(%s):SetInvisible(false)", pawn:GetId()))
	for dir = DIR_START, DIR_END do
		if dir ~= (direction+2)%4 and p2 + DIR_VECTORS[dir] ~= p3 then ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[dir], 0, dir)) end
	end
	ret:AddDelay(0.4)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", pawn:GetId(), _G[pawn:GetType()].Image))
	
	return ret
end

CyborgWeapons_Burrowing_A = CyborgWeapons_Burrowing:new{
	UpgradeDescription = "Confuses enemies passed through.",
	Flip = true,
}

CyborgWeapons_Burrowing_B = CyborgWeapons_Burrowing:new{
	UpgradeDescription = "Can emerge from a target, dealing 3 damage to it and reappearing on an adjacent tile.",
	CanAttackPawns = true,
	TwoClick = true,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Enemy2 = Point(2,2),
		Enemy3 = Point(2,1),
		Target = Point(2,1),
		Second_Click = Point(1,1),
		CustomPawn="BeetleMech",
	},
}

CyborgWeapons_Burrowing_AB = CyborgWeapons_Burrowing:new{
	Flip = true,
	CanAttackPawns = true,
	TwoClick = true,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Enemy2 = Point(2,2),
		Enemy3 = Point(2,1),
		Target = Point(2,1),
		Second_Click = Point(1,1),
		CustomPawn="BeetleMech",
	},
}

ANIMS.BurrowOpenClose = Animation:new{
	Image = "effects/burrow_openclose.png",
	NumFrames = 14,
	Time = 0.07,
	PosX = -27,
	PosY = 0,
	Layer = LAYER_FLOOR		--lets you create an animation visually behind pawns
}

-------------------
--Tentacle Strike--
-------------------
modApi:addWeaponDrop("CyborgWeapons_TentacleStrike")

CyborgWeapons_TentacleStrike=Grenade_Base:new{	--apparently Grenade_Base has a target area that hits everywhere
	Name="Tentacle Strike",
	Class="TechnoVek",
	Description="Strike 5 tiles anywhere on the map. Single use.",
	Icon="weapons/TentacleStrike.png",
	DamageAmount=2,
	Limited = 1,
	Radius=1,
	CrackCenter=0,
	BuildingDamage=true,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={1,1},
	UpgradeList={"+1 Damage","+1 Radius, building immune"},
	
	LaunchSound = "/weapons/arachnoid_ko",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Building = Point(2,1),
		Target = Point(2,2),
	}
}

CyborgWeapons_TentacleStrike_A = CyborgWeapons_TentacleStrike:new{DamageAmount=3,UpgradeDescription="Deals 3 damage. If both upgrades are enabled, instead cracks the target tile."}
CyborgWeapons_TentacleStrike_B = CyborgWeapons_TentacleStrike:new{Radius=2,BuildingDamage=false,UpgradeDescription="Increases radius and makes buildings immune. If both upgrades are enabled, instead cracks the target tile."}
CyborgWeapons_TentacleStrike_AB = CyborgWeapons_TentacleStrike:new{CrackCenter=1,}

function CyborgWeapons_TentacleStrike:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2, self.DamageAmount)
	damage.iCrack = self.CrackCenter -- 1 means create, 0 means don't change, -1 means remove, so using the upgrade value works
	damage.sAnimation = "PsionAttack_Back"
	local damageAnim = SpaceDamage(p2, 0)
	damageAnim.sAnimation = "PsionAttack_Front"	-- anim has two halves so we get both animations for tentacles
	if not self.BuildingDamage and Board:IsBuilding(p2) then damage.iDamage = 0 end
	ret:AddDamage(damage)
	ret:AddDamage(damageAnim)
	ret:AddDelay(0.25)
	for i = DIR_START, DIR_END do
		damage.loc = p2 + DIR_VECTORS[i]
		damageAnim.loc = p2 + DIR_VECTORS[i]
		if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[i]) then damage.iDamage = 0 else damage.iDamage = self.DamageAmount end
		ret:AddDamage(damage)
		ret:AddDamage(damageAnim)
	end 
	ret:AddDelay(0.25)
	if self.Radius == 2 then
		for i = DIR_START, DIR_END do
			damage.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
			damage.sAnimation = "PsionAttack_Back"
			damageAnim.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
			if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]) then damage.iDamage = 0 else damage.iDamage = self.DamageAmount end
			ret:AddDamage(damage)
			ret:AddDamage(damageAnim)
		end 
		ret:AddDelay(0.25)
		for i = DIR_START, DIR_END do
			damage.loc = p2 + DIR_VECTORS[i] * 2
			damage.sAnimation = "PsionAttack_Back"
			damageAnim.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[i]
			if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[i] * 2) then damage.iDamage = 0 else damage.iDamage = self.DamageAmount end
			ret:AddDamage(damage)
			ret:AddDamage(damageAnim)
		end 
		ret:AddDelay(0.25)
	end
	return ret
end


--------------
--Sticky Web--
--------------
modApi:addWeaponDrop("CyborgWeapons_StickyWeb")

CyborgWeapons_StickyWeb=LineArtillery:new{	
	Name="Sticky Web",
	Class="TechnoVek",
	Description="Launch a wad of sticky web at a target, permanently preventing it from moving. Flying targets will lose the ability to fly.",
	Icon="weapons/old/StickyWeb.png",
	PowerCost=0,
	Area=0,
	Upgrades=2,
	UpgradeCost={1,1},
	UpgradeList={"+4 Tiles","Extra Sticky"},
	MyArtillery =  "effects/shotup_webling.png",
	ImpactSound = "/enemy/spider_boss_1/attack_egg_land",
	Explosion="",
	
	LaunchSound = "/weapons/arachnoid_ko",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}

CyborgWeapons_StickyWeb_A = CyborgWeapons_StickyWeb:new{Area=1,UpgradeDescription="Also hits the tiles around the target."}
CyborgWeapons_StickyWeb_B = CyborgWeapons_StickyWeb:new{LeaveItem=true,UpgradeDescription="Leaves a sticky web on ground tiles if no pawn was hit."}
CyborgWeapons_StickyWeb_AB = CyborgWeapons_StickyWeb:new{Area=1,LeaveItem=true}

function CyborgWeapons_StickyWeb:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local targets = extract_table(general_DiamondTarget(p2, self.Area))
	local damage
	for k = 1, #targets do 
		damage = SpaceDamage(targets[k], 0)
		damage.sAnimation = "Webland1"
		if Board:GetPawn(targets[k]) then 
			damage.sScript=string.format("Board:GetPawn(%s):SetMoveSpeed(-10) Board:GetPawn(%s):SetFlying(false)",Board:GetPawn(targets[k]):GetId(),Board:GetPawn(targets[k]):GetId()) 
			if Board:GetTerrain(targets[k]) == TERRAIN_WATER and Board:GetPawn(targets[k]):IsFlying() and not Board:GetPawn(targets[k]):IsMassive() then damage.sAnimation = "" end
			if Board:GetTerrain(targets[k]) == TERRAIN_HOLE and Board:GetPawn(targets[k]):IsFlying() then damage.sAnimation = "" end
		elseif self.LeaveItem then
			if Board:GetTerrain(targets[k]) == TERRAIN_ROAD then 
				damage.sItem = "CyborgWeapons_WebItem" 
				damage.sAnimation = ""
			end
		end
		ret:AddArtillery(damage, self.MyArtillery, NO_DELAY)
	end
	return ret
end

merge_table(TILE_TOOLTIPS, { CyborgWeapons_Web_Text = {"Spider Web", "Prevents units that move onto it from moving and flying."} } )

local webdamage = SpaceDamage(0)
CyborgWeapons_WebItem = { Image = "effects/spiderwebitem.png", Damage = webdamage, Tooltip = "CyborgWeapons_Web_Text", Icon = "effects/spiderwebitem.png", UsedImage = ""}
Location["effects/spiderwebitem.png"] = Point(-20,0)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
    if removed_item == "CyborgWeapons_WebItem" then
        local pawn = Board:GetPawn(loc)
        if pawn then
			local damage = SpaceDamage(loc)
			damage.sScript=string.format("Board:GetPawn(%s):SetMoveSpeed(-10)",Board:GetPawn(loc):GetId())
			Board:DamageSpace(damage)
			damage.sScript=string.format("Board:GetPawn(%s):SetFlying(false)",Board:GetPawn(loc):GetId()) 
			Board:DamageSpace(damage)
        end
    end
end)

----------------------
--Evolving Bonespear--
----------------------
modApi:addWeaponDrop("CyborgWeapons_EvolvingBonespear0")
--Inspired by StS's Genetic Algorithm.
CyborgWeapons_EvolvingBonespear0=TankDefault:new{
	Name="Evolving Bonespear",
	Class="TechnoVek",
	Description="Throw a projectile dealing 2 total damage and up to 1 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use.",
	Icon="weapons/Bonespear.png",
	Damage=2,
	MaxDamagePerTarget=1,
	Limited = 1,
	BuildingDamage=true,
	PowerCost=0,
	Upgrades=0,
	BonespearLevel=0, 
	
	LaunchSound = "/enemy/hornet_1/attack",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
	}
}
CyborgWeapons_EvolvingBonespear1=CyborgWeapons_EvolvingBonespear0:new{BonespearLevel=1, MaxDamagePerTarget=2, Description="Throw a projectile dealing 2 damage. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear2=CyborgWeapons_EvolvingBonespear1:new{BonespearLevel=2, Damage=3, Description="Throw a projectile dealing 3 total damage and up to 2 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear3=CyborgWeapons_EvolvingBonespear2:new{BonespearLevel=3, Damage=4, Description="Throw a projectile dealing 4 total damage and up to 2 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear4=CyborgWeapons_EvolvingBonespear3:new{BonespearLevel=4, Damage=5, Description="Throw a projectile dealing 5 total damage and up to 2 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear5=CyborgWeapons_EvolvingBonespear4:new{BonespearLevel=5, MaxDamagePerTarget=3, Description="Throw a projectile dealing 5 total damage and up to 3 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear6=CyborgWeapons_EvolvingBonespear5:new{BonespearLevel=6, Damage=6, Description="Throw a projectile dealing 6 total damage and up to 3 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear7=CyborgWeapons_EvolvingBonespear6:new{BonespearLevel=7, Damage=7, Description="Throw a projectile dealing 7 total damage and up to 3 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear8=CyborgWeapons_EvolvingBonespear7:new{BonespearLevel=8, MaxDamagePerTarget=4, Description="Throw a projectile dealing 7 total damage and up to 4 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear9=CyborgWeapons_EvolvingBonespear8:new{BonespearLevel=9, Damage=8, Description="Throw a projectile dealing 8 total damage and up to 4 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear10=CyborgWeapons_EvolvingBonespear9:new{BonespearLevel=10, Damage=9, Description="Throw a projectile dealing 9 total damage and up to 4 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear11=CyborgWeapons_EvolvingBonespear10:new{BonespearLevel=11, MaxDamagePerTarget=5, Description="Throw a projectile dealing 9 total damage and up to 5 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear12=CyborgWeapons_EvolvingBonespear11:new{BonespearLevel=12, Damage=10, Description="Throw a projectile dealing 10 total damage and up to 5 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear13=CyborgWeapons_EvolvingBonespear12:new{BonespearLevel=13, Damage=11, Description="Throw a projectile dealing 11 total damage and up to 5 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear14=CyborgWeapons_EvolvingBonespear13:new{BonespearLevel=14, Damage=12, Description="Throw a projectile dealing 12 total damage and up to 5 damage per target. If it kills, it pierces with the remaining damage. Evolves into a stronger weapon on use."}
CyborgWeapons_EvolvingBonespear15=CyborgWeapons_EvolvingBonespear14:new{Name="Perfected Bonespear", BonespearLevel=15, MaxDamagePerTarget=6, Description="Throw a projectile dealing 12 total damage and up to 6 damage per target. If it kills, it pierces with the remaining damage."}

function CyborgWeapons_EvolvingBonespear0:GetTargetArea(point)
	--exactly the same as TankDefault except for the bit at the end
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, 8 do
			local curr = Point(point + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then break end
			
			ret:push_back(curr)
			
			if Board:IsBlocked(curr,PATH_PHASING) then break end
		end
	end
	--if not Board:GetPawn(point):IsActive() then ret:push_back(point) end
	--if the pawn can't attack, the skill can self-target, which we use to self-shoot after adding a weapon to spend its uses
	--dumb hack, but it should also work with Conservative
	--not necessary after all, there was a memedit function for it
	return ret
end

function CyborgWeapons_EvolvingBonespear0:GetSkillEffect(p1,p2)
	--most of this is borrowed from the piercing railgun weapon
	--to evolve a weapon, we remove it and add the version N+1
	local ret = SkillEffect()
	-- if p1:GetString() == p2:GetString() then 
	--dumb hack to self-shoot and spend the weapon's uses when upgraded, using FireWeapon at self, doing nothing
		-- ret:AddBounce(p1, -1)
		--if you return the empty SkillEffect, FireWeapon will not deduct an use.
		-- return ret 
	-- end
	local direction = GetDirection(p2 - p1)
	local remainingDamage = self.Damage
	local maxDamage = self.MaxDamagePerTarget
	--if Board:GetPawn(p1):IsBoosted() then maxDamage = maxDamage + 1 end
	local last_origin = p1
	local targetHealth
	local willKill
	local curr = p1 + DIR_VECTORS[direction]
	
	
	while true do
		local target = curr
		if not Board:IsBlocked(curr,PATH_PROJECTILE) and Board:IsValid(curr + DIR_VECTORS[direction]) then
			target = GetProjectileEnd(curr,curr + DIR_VECTORS[direction],PATH_PROJECTILE)
		end
		if Board:GetPawn(target) then 
			targetHealth = Board:GetPawn(target):GetHealth() 
			if Board:GetPawn(target):IsArmor() then targetHealth = targetHealth + 1 end	--lets us correctly use 3 damage on 2 HP armored targets
		end
		if not targetHealth then targetHealth = 1 end
		--may want to divide by 2 if ACIDified?
		local damageToDeal = math.min(maxDamage, remainingDamage, targetHealth)
		remainingDamage = remainingDamage - damageToDeal
		local damage = SpaceDamage(target, damageToDeal)
		
		willKill = false
		if Board:GetPawn(target) and Board:IsDeadly(damage,Board:GetPawn(target)) then willKill = true end
		
		--local animation = damage.bKO_Effect and self.ExploKO or self.Exploart..direction
		local GraphicLevel = math.floor(self.BonespearLevel / 2)
		--turns 0 and 1 into 0, 2 and 3 into 1, 4 and 5 into 2, and so on
		local projectileArt="effects/bonespear/bonespear"..GraphicLevel
		ret:AddProjectile(last_origin, damage, projectileArt, FULL_DELAY)
		--ret:AddAnimation(damage.loc,animation,ANIM_NO_DELAY)
		
		--bail out if this isn't a pawn or it won't kill the pawn
		if not willKill then break end
		
		ret:AddSound(self.LaunchSound)
		last_origin = target
		curr = target + DIR_VECTORS[direction]
	end
	--Note that this doesn't work if not equipped to a pawn and ran by a tooltip, so we check whether we are in a tooltip
	if not Board:IsTipImage() and self.BonespearLevel < 15 then
		if string.sub(Board:GetPawn(p1):GetWeaponType(1), 31) == "CyborgWeapons_EvolvingBonespear" then IdToRemove = 1 else IdToRemove = 2 end
		local remainingUses = Board:GetPawn(p1):GetWeaponLimitedRemaining(IdToRemove)
		ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)",Board:GetPawn(p1):GetId(), IdToRemove))
		ret:AddScript(string.format("Board:GetPawn(%s):AddWeapon(\"CyborgWeapons_EvolvingBonespear%s\")",Board:GetPawn(p1):GetId(), string.match(self.__Id, "%d+") + 1))
		--ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, %s)", Board:GetPawn(p1):GetId(), p1:GetString(), 2))
		--I formerly used FireWeapon to shoot the newly acquired weapon to spend its use, otherwise the weapon would reset its limited uses on upgrade
		--This worked because I had the pawn fire at itself, so the weapon would fire but do nothing.
		--It was not actually necessary; there was an undocumented memedit function for it after all. Leaving it as a comment because neat hack.
		ret:AddScript(string.format("Board:GetPawn(%s):SetWeaponLimitedRemaining(%s, %s)", Board:GetPawn(p1):GetId(), 2, remainingUses-1))
	end
	return ret	
end

------------------
--Hive Sacrifice--
------------------
modApi:addWeaponDrop("CyborgWeapons_HiveSacrifice")
CyborgWeapons_HiveSacrifice = Skill:new{  
	Name="Hive Sacrifice",
	Description="Sacrifice this to the Hive to turn the surrounding tiles into lava.",
	Class = "TechnoVek",
	Icon = "weapons/HiveSacrifice.png",
	Range = 1, 
	ZoneTargeting = ZONE_ALL,
	PathSize = 1,
	Damage = DAMAGE_DEATH,
	PowerCost = 0,
	Upgrades = 0,
	Limited = 1,
	TipImage = StandardTips.Surrounded
}


function CyborgWeapons_HiveSacrifice:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end
				
function CyborgWeapons_HiveSacrifice:GetSkillEffect(p1, p2)
	--caster visually falls and is teleported outside the game board so you can't heal it?
	--not sure whether that would work for Repair Drop
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p1, self.Damage)
	damage.sAnimation = "tentacles"
	damage.iTerrain = TERRAIN_LAVA
	damage.sSound = "/props/tentacle"
	--ret:AddScript(string.format("Board:GetPawn(%s):Fall(4)",Board:GetPawn(p1):GetId()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCorpse(false)",Board:GetPawn(p1):GetId()))
	--that way the user doesn't leave a corpse, since it's supposed to be swallowed into lava
	--doesn't work for some reason???
	ret:AddDamage(damage)
	ret:AddBounce(p1, 3)
	damage.sAnimation = "tentacles"
	damage.iTerrain = TERRAIN_LAVA
	damage.sSound = "/props/tentacle"
	--ret:AddScript("Board:Crack(CRACK_TENTACLE)")
	--ret:AddScript("Board:Crack(CRACK_LAVA)")
	
	if not Board:IsTipImage() then ret:AddBoardShake(2) end
	--AFAICT something messes up the tip image preview; foes are on fire and lava doesn't appear properly
	ret:AddDelay(0.25)
	damage.iDamage = 2	--because they get hit by tentacles/to hit psions
	for i = DIR_START,DIR_END do
		if Board:GetTerrain(p1 + DIR_VECTORS[i]) ~= TERRAIN_WATER and Board:GetTerrain(p1 + DIR_VECTORS[i]) ~= TERRAIN_LAVA and Board:GetTerrain(p1 + DIR_VECTORS[i]) ~= TERRAIN_ACID and Board:GetTerrain(p1 + DIR_VECTORS[i]) ~= TERRAIN_HOLE then
			damage.loc = p1 + DIR_VECTORS[i]
			--local direction = GetDirection(p1, p1 - DIR_VECTORS[i])
			ret:AddDamage(damage)
			if not Board:IsTipImage() then ret:AddBounce(p1 + DIR_VECTORS[i], 2) end
		end
	end
	if Board:IsTipImage() then ret:AddDelay(2) end
	return ret
end	

--------------
--Pheromones--
--------------
modApi:addWeaponDrop("CyborgWeapons_Pheromones")
CyborgWeapons_Pheromones = Skill:new{

	Name="Alluring Pheromones",
	Description="Pull all Vek and Cyborgs in range towards the user.",
	Class = "TechnoVek",
	Icon = "weapons/Pheromones.png",
	LaunchSound = "/weapons/wind",
	Range = 1, 
	ZoneTargeting = ZONE_ALL,
	PathSize = 1,
	Damage = 0,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost={2,2},	--core sink, but it gives you one extra action; also applies to Blobs from the Ooze weapon
	UpgradeList={"Quickening","Hypnotic"},--frenzying? confusing?
	--Limited = 1,
	TipImage = StandardTips.Surrounded,	--should be a custom to show bots and mechs are not affected
	--Pull=true,
	Haste=false,
	TwoClick=false,
	Dance=false, --named after Fire Emblem dancers

}

CyborgWeapons_Pheromones_A = CyborgWeapons_Pheromones:new{Name="Quickening Pheromones",Haste=true,UpgradeDescription="Also increases movement range and allows affected units to move again. If both upgrades are enabled, lets affected Cyborg units act again."}
CyborgWeapons_Pheromones_B = CyborgWeapons_Pheromones:new{Name="Hypnotic Pheromones",TwoClick=true,UpgradeDescription="Instead of pulling, push in any direction. If both upgrades are enabled, lets affected Cyborg units act again."}
CyborgWeapons_Pheromones_AB = CyborgWeapons_Pheromones:new{Name="Invigorating Pheromones",Haste=true,TwoClick=true,Dance=true}

function CyborgWeapons_Pheromones:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		while Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and Board:IsValid(curr) do
			ret:push_back(curr)
			curr = curr + DIR_VECTORS[dir]
		end
		
		if Board:IsValid(curr) then ret:push_back(curr) end
	end
	
	return ret
end

function CyborgWeapons_Pheromones:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for i = DIR_START,DIR_END do
		--we are just using this as a way to determine direction in which to move things
		--could do it the fancy Wind Generator way like Paradoxica did but I can't be bothered
		local curr = p2 + DIR_VECTORS[i]
		if Board:IsValid(curr) then ret:push_back(curr) end
	end
	
	return ret	
end

function CyborgWeapons_Pheromones:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	for i = 1, 8 do
		local curr = p1 + DIR_VECTORS[dir] * i
		if not Board:IsValid(curr) or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:IsBuilding(curr) then break end
		local damage = SpaceDamage(curr, 0)
		local toAffect = Board:GetPawn(curr)
		if toAffect and (toAffect:GetClass() == "TechnoVek" or toAffect:GetTeam() == TEAM_ENEMY) then
			if not self.TwoClick then damage.iPush = (dir+2)%4 end
			if self.Haste then
				damage.sScript = string.format("Board:GetPawn(%s):AddMoveBonus(1)", Board:GetPawn(curr):GetId())
				ret:AddScript(string.format("Board:GetPawn(%s):SetMovementSpent(false)", Board:GetPawn(curr):GetId()))
			end
			-- if self.TwoClick then 
			-- end
			if self.Dance then ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", Board:GetPawn(curr):GetId())) end
		end
		damage.sAnimation = "HypnoticPheromone"
		ret:AddDamage(damage)
	end
	return ret
end

function CyborgWeapons_Pheromones:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local pushDirection = GetDirection(p3 - p2)
	--depending on twoclick direction, the things can be slammed into each otherwise
	--therefore we want to iterate in a different order depending on direction
	local i = 1
	local step = 1
	if dir == pushDirection then 
		i = 7
		step = -1  
	end
	while step == -1 and not Board:IsValid(Point(p1 + DIR_VECTORS[dir] * i)) do
		i=i-1
	end
	ret:AddSound(self.LaunchSound)
	while true do
		local curr = Point(p1 + DIR_VECTORS[dir] * i)
		if not Board:IsValid(curr) or 
		   ((Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:IsBuilding(curr)) and step == 1) or 	--we need to check step == 1; if it's -1, we would stop when going backwards and meeting terrain before pushing stuff that should be
		   curr == p1 then --this stops us when step == -1
			break 
		end
		local damage = SpaceDamage(curr, 0)
		local toAffect = Board:GetPawn(curr)
		if toAffect and (toAffect:GetClass() == "TechnoVek" or toAffect:GetTeam() == TEAM_ENEMY) then
			if not self.TwoClick then damage.iPush = (dir+2)%4 else damage.iPush = pushDirection end	--shouldn't happen?
			if self.Haste then
				damage.sScript = string.format("Board:GetPawn(%s):AddMoveBonus(1)", Board:GetPawn(curr):GetId())
				ret:AddScript(string.format("Board:GetPawn(%s):SetMovementSpent(false)", Board:GetPawn(curr):GetId()))
			end
			if self.Dance then ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", Board:GetPawn(curr):GetId())) end
		end
		damage.sAnimation = "HypnoticPheromone"
		ret:AddDamage(damage)
		--ret:AddBurst(curr, "Emitter_Pheromones", dir)
		if toAffect then ret:AddDelay(0.15) end
		i=i+step
	end
	return ret
end

ANIMS.HypnoticPheromone = Animation:new{ 	
	Image = "effects/pheromonehypnosisanim.png",
	--PosX = -8, PosY = -3,
	NumFrames = 6,
	Time = 0.1,
	Loop = false
}

-------------------
--Weak Pheromones--
-------------------
modApi:addWeaponDrop("CyborgWeapons_WeakPheromones")

CyborgWeapons_WeakPheromones=Skill:new{
	Name="Weakening Pheromones",
	Class="TechnoVek",
	Description="Cancels and permanently weakens Vek attacks in a 5 tile area. Leaves lingering smokes that weakens Vek.",
	Icon = "weapons/WeakPheromones.png",
	Limited = 2,
	Radius=1,
	PowerCost=0,
	Upgrades=0,
	Damage=0,
	LaunchSound = "/weapons/wind",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Building = Point(2,1),
		Target = Point(2,2),
	}
}

local customAnim = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/customAnim")

function CyborgWeapons_WeakPheromones:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local targets = {}
	if Board:IsTipImage() then return ret end
	local mission = GetCurrentMission()
	if mission and not mission.frightenedTiles then mission.frightenedTiles = {} end
	if mission and not mission.deleveledVeks then mission.deleveledVeks = {} end
	ret:AddSound(self.LaunchSound)
	--we create an empty list of affected tiles if not yet made
	local targets = extract_table(general_DiamondTarget(p2, 1))
	for k = 1, #targets do
		local emptyDamage = SpaceDamage(0)
		emptyDamage.iPush = 5	--does no push, just a yellow outline
		ret:AddDamage(emptyDamage)
		ret:AddScript(string.format("CustomAnim:add(%s, \"frighteningPheromoneAnim\")", Point(targets[k]):GetString()))
		-- if mission then mission.frightenedTiles[#mission.frightenedTiles+1] = targets[k] end
		-- if mission then ret:AddScript(string.format("mission.frightenedTiles[%s] = %s", #mission.frightenedTiles+1, Point(targets[k]):GetString())) end
		if mission then ret:AddScript(string.format("mission.frightenedTiles[%s] = %s", #mission.frightenedTiles+k, Point(targets[k]):GetString())) end
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:IsEnemy() and pawn:GetWeaponCount() > 0 then
			-- local weaponName = pawn:GetQueuedWeapon()
			local weaponName = pawn:GetWeaponType(1)
			-- LOG(weaponName)
			-- LOG(weaponName:sub(1, -2))
			local weaponID = 1
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn:GetId()))
			if weaponName:sub(-1, -1) == "2" and _G[weaponName:sub(1, -2).."1"] then
			--if it's an alpha's weapon and the devolved version exists, remove it and add normal version
				ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", pawn:GetId(), weaponID))
				ret:AddScript(string.format("Board:GetPawn(%s):AddWeaponVanilla(%q)", pawn:GetId(), weaponName:sub(1, -2).."1"))
				ret:AddScript(string.format("mission.deleveledVeks[%s] = %s", #mission.deleveledVeks+1, pawn:GetId()))
			elseif weaponName:sub(-1, -1) == "B" and _G[weaponName:sub(1, -2).."2"] then
			--if it's a boss' weapon and the devolved version exists, remove it and add alpha version
				ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", pawn:GetId(), weaponID))
				ret:AddScript(string.format("Board:GetPawn(%s):AddWeaponVanilla(%q)", pawn:GetId(), weaponName:sub(1, -2).."2"))
				ret:AddScript(string.format("mission.deleveledVeks[%s] = %s", #mission.deleveledVeks+1, pawn:GetId()))
			end
		end
	end 
	return ret
end

local function EVENT_onModsLoaded()
	modApi:addPreEnvironmentHook(function(mission)
		if mission.frightenedTiles then
			for k = 1, #mission.frightenedTiles do
				Board:Ping(mission.frightenedTiles[k], COLOR_BLACK)
				Board:SetDangerous(mission.frightenedTiles[k])	--pretty sure it's not working
				local pawn = Board:GetPawn(mission.frightenedTiles[k])
				local wasJustDeleveled = false
				for _, value in ipairs(mission.deleveledVeks) do
					if pawn and value == pawn:GetId() then wasJustDeleveled = true end
				end
				if pawn and pawn:IsEnemy() and pawn:GetWeaponCount() > 0 and not wasJustDeleveled then
					local weaponName = pawn:GetWeaponType(1)
					local weaponID = 1
					if weaponName:sub(-1, -1) == "2" and _G[weaponName:sub(1, -2).."1"] then
						pawn:RemoveWeapon(1)
						pawn:AddWeapon(weaponName:sub(1, -2).."1")
					elseif weaponName:sub(-1, -1) == "B" and _G[weaponName:sub(1, -2).."2"] then
						pawn:RemoveWeapon(1)
						pawn:AddWeapon(weaponName:sub(1, -2).."2")
					else
						LOG("there was no weapon to delevel to for "..weaponName)
					end
				end
			end 
		end
		mission.deleveledVeks = {}
	end)
	--we could also look for the custom anim, but this should run faster
	--the deleveledVeks table is to make sure we don't delevel a boss twice in one skill (on hit + on start of turn)
	--we reset the table at the end of the hook so that they can lose a second level eventually
	modApi:addNextTurnHook(function(mission)
		if mission.overdrive and Game:GetTeamTurn() == TEAM_PLAYER then
			for i = 0, 2 do
				local pawn = Board:GetPawn(i)
				if pawn then
					local threshold = 1
					if pawn:IsAcid() then threshold = 2 end
					if pawn:GetHealth() > threshold and not pawn:IsBoosted() then
						pawn:SetBoosted(true)
						local amount = 1
						if pawn:IsArmor() and not pawn:IsAcid() then amount = 2 end
						pawn:ApplyDamage(SpaceDamage(pawn:GetSpace(), amount))
					end
				end
			end
		end
	end)
	modApi:addMissionStartHook(function(mission)
		for i = 0, 2 do
			if Board:GetPawn(i) then
				local weapons = Board:GetPawn(i):GetPoweredWeaponTypes()
				if weapons[1] == "CyborgWeapons_HunterReflexes" or weapons[2] == "CyborgWeapons_HunterReflexes" then mission.giveBonusMove = true end
				if weapons[1] == "CyborgWeapons_CricketLegs" or weapons[2] == "CyborgWeapons_CricketLegs" then mission.giveJumping = true end
				if weapons[1] == "CyborgWeapons_PrizeOfTheHunt" or weapons[2] == "CyborgWeapons_PrizeOfTheHunt" then mission.healOnKill = true end
				if weapons[1] == "CyborgWeapons_OpportunisticHunting" or weapons[2] == "CyborgWeapons_OpportunisticHunting" then mission.opportunity = true end
				if weapons[1] == "CyborgWeapons_Overdrive" or weapons[2] == "CyborgWeapons_Overdrive" then mission.overdrive = true end
			end
		end
		if mission.giveJumping then
			for i = 0, 2 do
				if Board:GetPawn(i) and Board:GetPawn(i):GetClass() == "TechnoVek" and Board:GetPawn(i):GetPathProf() == 18 then Board:GetPawn(i):SetJumper(true) end
			end
		end
	end)
	modapiext:addSkillEndHook(function(mission, pawn, weaponId, p1, p2)
		if not mission or not mission.giveBonusMove then return end
		if pawn:IsDead() or tostring(weaponId) == "Move" or not pawn:GetClass() == "TechnoVek" then return end
		modApi:runLater(function() 
			modApi:runLater(function() 
				if not pawn:IsActive() then
					pawn:SetBonusMove(pawn:GetBonusMove() + 1)
					pawn:SetActive(true) 
				end
			end)
		end)
		--we run this two frames later because some weapons are free actions and make the pawn active again one frame later
		--if the pawn is given bonus move, it cannot act again, overwriting the free action
	end)
	modapiext:addPawnKilledHook(function(mission, pawn)
		if not mission or not mission.healOnKill then return end
		if (pawn:GetTeam() == TEAM_ENEMY) and (pawn:GetTeam() ~= TEAM_BOTS) and not (_G[pawn:GetType()].Minor) then
			local point = pawn:GetSpace()
			for i = DIR_START, DIR_END do
				local curr = point + DIR_VECTORS[i]
				if Board:GetPawn(curr) and Board:GetPawn(curr):GetClass() == "TechnoVek" then Board:DamageSpace(SpaceDamage(curr, -1)) end
			end
		end
	end)

	modapiext:addPawnTrackedHook(function(mission, pawn)
		if not mission or not mission.opportunity or not pawn then return end
		--stolen from Tosx's Stranger pilot
		local p0 = pawn:GetSpace()
		for dir = DIR_START, DIR_END do
			local point = p0 + DIR_VECTORS[dir]
			if Board:IsValid(point) and Board:IsPawnSpace(point) then
				local pawn2 = Board:GetPawn(point)
				if not pawn2:IsDead() and pawn2:GetClass() == "TechnoVek" then	
					local reg = GetCurrentRegion(RegionData)
					if reg ~= nil then
						for _, a in ipairs(reg.player.map_data.spawn_ids) do 
							if a == pawn:GetId() then			
								local delayed = false
								for i = DIR_START, DIR_END do
									local curr = p0 + DIR_VECTORS[i]
									if Board:GetPawn(curr) and Board:GetPawn(curr):GetClass() == "TechnoVek" then
										local fx = SkillEffect()
										local amount = 1
										if Board:GetPawn(curr):IsBoosted() then amount = 2 end
										local damage = SpaceDamage(p0, amount)
										damage.sAnimation="ExploBloodyStream"
										if not delayed then fx:AddDelay(0.4) delayed = true end
										fx:AddMelee(curr, damage)
										Board:AddEffect(fx)
										if amount == 2 then Board:GetPawn(curr):SetBoosted(false) end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

ANIMS.frighteningPheromoneAnim = Animation:new{ 	
	Image = "effects/frighteningpheromonesanim.png",
	PosX = -30, PosY = -20,
	NumFrames = 15,
	Frames = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	Time = 0.2,
	Loop = true
}

-------------
--Bloodlust--
-------------
--Hit damaged targets harder; can upgrade to hit even harder and hit all damaged targets
modApi:addWeaponDrop("CyborgWeapons_Bloodlust")

CyborgWeapons_Bloodlust = Skill:new{  
	Name = "Bloodlust",
	Class = "TechnoVek",
	Icon = "weapons/Bloodlust.png",
	Description = "Strike a biological target harder if it is damaged.",
	Rarity = 3,
	ImpactSound = "/enemy/scorpion_soldier_1/attack",
	MinDamage = 2,
	Damage = 3,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1/+1 Damage",  "Multistrike"  },
	UpgradeCost = { 2 , 3 },
	TipImage = {
		Unit = Point(2,2),
		Enemy_Damaged = Point(2,1),
		Enemy2 = Point(2,3),
		Enemy3 = Point(1,2),
		Enemy4 = Point(3,2),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Centipede2",
	},
}

CyborgWeapons_Bloodlust_A = CyborgWeapons_Bloodlust:new{
	UpgradeDescription = "Increases base damage by 1. Damage on damaged targets is increased by 1 more.",
	MinDamage = 3,
	Damage = 5,
}

CyborgWeapons_Bloodlust_B = CyborgWeapons_Bloodlust:new{	
	UpgradeDescription = "Attacks every adjacent biological unit.",
	Multistrike = true,
}

CyborgWeapons_Bloodlust_AB = CyborgWeapons_Bloodlust:new{
	MinDamage = 3,
	Damage = 5,
	Multistrike = true,
}

function CyborgWeapons_Bloodlust:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and (Board:GetPawn(curr):GetClass() == "TechnoVek" or (Board:GetPawn(curr):GetTeam() == TEAM_ENEMY and Board:GetPawn(curr):GetTeam() ~= TEAM_BOTS)) then
			ret:push_back(curr)
		end
	end
	return ret
end
				
function CyborgWeapons_Bloodlust:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = Board:GetPawn(p2)
	local damage = SpaceDamage(p2)
	
	damage.sAnimation="SwipeClaw"..self.MinDamage-1	--makes the animation bigger when upgraded
	damage.sSound = self.ImpactSound
	if self.Multistrike then
		for i = DIR_START, DIR_END do
			target = Board:GetPawn(p1 + DIR_VECTORS[i])
			if target then
				damage.loc = p1 + DIR_VECTORS[i]
				if (target:GetClass() == "TechnoVek" or (target:GetTeam() == TEAM_ENEMY and target:GetTeam() ~= TEAM_BOTS)) and target:IsDamaged() then
					damage.iDamage = self.Damage
					ret:AddAnimation(p1 + DIR_VECTORS[i], "ExploBloodyStream")	--when hitting for extra damage, we add a burst of blood
				else
					damage.iDamage = self.MinDamage
				end
				if (target:GetClass() == "TechnoVek" or (target:GetTeam() == TEAM_ENEMY and target:GetTeam() ~= TEAM_BOTS)) or p1 + DIR_VECTORS[i] == p2 then ret:AddMelee(p1, damage) end
				--with the Multistrike upgrade, we hit everything biological and adjacent, and we always hit the target regardless
			end
		end
	else
		target = Board:GetPawn(p2)
		if target then
			if (target:GetClass() == "TechnoVek" or (target:GetTeam() == TEAM_ENEMY and target:GetTeam() ~= TEAM_BOTS)) and target:IsDamaged() then
				damage.iDamage = self.Damage
				ret:AddAnimation(p2, "ExploBloodyStream")
			else
				damage.iDamage = self.MinDamage
			end
			ret:AddMelee(p1, damage)
		end
	end
	return ret
end	

--------------
--Metabolize--
--------------
--Munch an enemy to gain its weapon. Very cool, promotes meta-decision making outside of battle, ie. "oh I should go on this island because the boss weapon is great"
--This was very interesting to code but it would have been impossible without galaxy-brained Lemonymous's help.
--Still buggy for some vanilla enemies and a lot of modded enemies for various reasons.

modApi:addWeaponDrop("CyborgWeapons_Metabolize")

CyborgWeapons_Metabolize = Skill:new{  
	Name = "Metabolize",
	Class = "TechnoVek",
	Icon = "weapons/Metabolize.png",
	Description = "Strike an adjacent biological target to gain its weapon, attacking with it on subsequent uses. With a stolen weapon, self-target to lose it.",
	Rarity = 3,
	ImpactSound = "/enemy/scorpion_soldier_1/attack",
	Damage = 2,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0,	--for testing, should cost 1
	DamageUp = 0,
	Upgrades = 2,
	UpgradeList = { "Digest",  "+1 Damage"  },
	UpgradeCost = { 1 , 3 },
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Centipede2",
	},
}

CyborgWeapons_Metabolize_A = CyborgWeapons_Metabolize:new{
	UpgradeDescription = "Heal 1 damage and become boosted when discarding a weapon.",
	Digest = true,
}

CyborgWeapons_Metabolize_B = CyborgWeapons_Metabolize:new{	
	UpgradeDescription = "Increases damage dealt by 1.",
	DamageUp = 1,
	Damage = 3,
}

CyborgWeapons_Metabolize_AB = CyborgWeapons_Metabolize:new{
	Digest = true,
	DamageUp = 1,
	Damage = 3,
}

ANIMS.DNATwirl = Animation:new{
	Image = "effects/DNA_anim.png",
	NumFrames = 26,
	Time = 0.03,
	PosX = -11,
	PosY = 1
}

function CyborgWeapons_Metabolize:GetTargetArea(point)
	local ret = PointList()
	if Board:IsTipImage() then ret:push_back(Point(2, 1)) return ret end
	if not GAME.Metabolized or IsTestMechScenario() then	--if we have no weapon stored, this is a melee attack; we don't metabolize in test scenario
		for i = DIR_START, DIR_END do
			local curr = point + DIR_VECTORS[i]
			if Board:GetPawn(curr) and 
			   Board:GetPawn(curr):GetTeam() == TEAM_ENEMY and not 
			   Board:GetPawn(curr):GetMechName():find("Psion") and 
			   Board:GetPawn(curr):GetTeam() ~= TEAM_BOTS then 
				ret:push_back(curr) 
			end
		end
	else
		ret = _G[GAME.Metabolized]:GetTargetArea(point)				--if we do, it has the target area of the stored skill
		--check whether it has a charge/projectile in a skilleffect, if so extend range
		local foundCharge = false
		for k = 1, 4 do
			local skillEffect = _G[GAME.Metabolized]:GetSkillEffect(point, ret[k])
			for _, spaceDamage in ipairs(extract_table(skillEffect.q_effect)) do
				if (spaceDamage:IsMovement() and spaceDamage:GetMoveType() == 2) or spaceDamage:GetType() == 2 then
					foundCharge = true
					for i = DIR_START, DIR_END do
						for j = 1, 7 do
							local curr = Point(point + DIR_VECTORS[i] * j)
							if Board:IsBlocked(curr, PATH_PROJECTILE) and spaceDamage:GetType() ~= 2 then break end	
							--not sure whether to put this before or after, works better here for the Beetle
							--if it's blocked and we are charging, don't add to target area
							if Board:IsValid(curr) then ret:push_back(curr) else break end
							if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
							
						end
					end
					break
				end
			end
			if foundCharge then break end
		end
		ret:push_back(point)	--we add the option to self-target, which removes the stored weapon
	end
	return ret
end

function CyborgWeapons_Metabolize:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	if IsTestMechScenario() then	--just melee
		ret:AddMelee(p1, SpaceDamage(p2, self.Damage))
		ret:AddScript(string.format("Board:AddAlert(%s, %q)",p1:GetString(),"Cannot metabolize in simulation."))
	elseif Board:IsTipImage() then  --melee, then shoot a fake centipede shot
		local damage = SpaceDamage(p2, self.Damage)
		ret:AddMelee(p1, damage)
		ret:AddDelay(2)
		local damage1 = SpaceDamage(Point(2, 1), 2 + self.DamageUp)
		local damage2 = SpaceDamage(Point(1, 1), 2 + self.DamageUp)
		local damage3 = SpaceDamage(Point(3, 1), 2 + self.DamageUp)
		damage1.iAcid = 1
		damage2.iAcid = 1
		damage3.iAcid = 1
		damage1.bHide = true
		damage2.bHide = true
		damage3.bHide = true
		ret:AddProjectile(damage1,"effects/shot_firefly2")
		ret:AddDamage(damage2)
		ret:AddDamage(damage3)
		ret:AddDelay(2)
	elseif p1 == p2 then --remove weapon as a free action, boost&heal with the upgrade
		ret:AddScript("GAME.Metabolized = nil")
		local animDamage = SpaceDamage(p1, 0)
		if self.Digest then animDamage.iDamage = -1 end
		animDamage.sAnimation = "DNATwirl"
		ret:AddDamage(animDamage)
		ret:AddDelay(0.2)
		ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)",Board:GetPawn(p1):GetId()))
		ret:AddDelay(0.2)
		if self.Digest then ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", Board:GetPawn(p1):GetId())) end
	elseif not GAME.Metabolized then						--munch something to gain its weapon
		local copied = ""
		if Board:GetPawn(p2):GetWeaponCount() == 0 then		--handles Spider boss who has no weapon for some reason
			local pawnType = Board:GetPawn(p2):GetType()
			if string.sub(pawnType, -4) == "Boss" then 
				local pawnType = string.sub(pawnType, 1, -5).."2"
				copied = _G[pawnType].SkillList[1]
			end
		else
			copied = Board:GetPawn(p2):GetWeaponType(1)
		end
		ret:AddScript(string.format("GAME.Metabolized = %q", copied))
		ret:AddMelee(p1, SpaceDamage(p2, self.Damage))
	else													--use weapon
		local skillEffect = _G[GAME.Metabolized]:GetSkillEffect(p1,p2)
		local target = GetProjectileEnd(p1,p2)
		local addedMelee = false
		for _, spaceDamage in ipairs(extract_table(skillEffect.effect)) do	--we add nonqueued stuff first, not sure it matters but it makes more sense
			local convert = false
			if spaceDamage.sPawn and _G[spaceDamage.sPawn] ~= nil then
				local playerVersionId = spaceDamage.sPawn.."_playerVersion"
				if _G[playerVersionId] == nil then 
					_G[playerVersionId] = _G[spaceDamage.sPawn]:new{
						DefaultTeam = TEAM_PLAYER,
						-- Image = _G[spaceDamage.sPawn].Image,
						-- Portrait = _G[spaceDamage.sPawn].Portrait,
						-- SkillList = _G[spaceDamage.sPawn].SkillList,
					}
				end
				LOG(_G[playerVersionId].SkillList[1])
				spaceDamage.sPawn = playerVersionId
				convert = true
			end
			if spaceDamage.iDamage > 0 and spaceDamage.iDamage ~= DAMAGE_DEATH then spaceDamage.iDamage = spaceDamage.iDamage + self.DamageUp end
			if spaceDamage:GetType() == 1 then ret:AddArtillery(p1, spaceDamage, spaceDamage:GetProjectileArt(), NO_DELAY) end
			if spaceDamage:GetType() == 2 then ret:AddProjectile(p1, spaceDamage, spaceDamage:GetProjectileArt(), NO_DELAY) end
			if spaceDamage:GetType() == 0 then ret:AddDamage(spaceDamage) end	--this should really be AddMelee, but if it's unqueued it means something else is coming, you don't want to AddMelee twice because it looks stupid, think Mosquito meleeing for smoke and then for damage
			
			if convert then ret:AddDelay(1) local convertD = SpaceDamage(spaceDamage.loc, 0) convertD.iPawnTeam = TEAM_PLAYER ret:AddDamage(convertD) end
		end
		ret:AddDelay(0.2)	--we add a delay between instant and queued stuff, may help stuff like dragonfly boss
		for _, spaceDamage in ipairs(extract_table(skillEffect.q_effect)) do
			local convert = false
			if spaceDamage.sPawn and _G[spaceDamage.sPawn] ~= nil then
				local playerVersionId = spaceDamage.sPawn.."_playerVersion"
				if _G[playerVersionId] == nil then 
					_G[playerVersionId] = _G[spaceDamage.sPawn]:new{
						DefaultTeam = TEAM_PLAYER,
						--IsDeathEffect = true,
						--GetDeathEffect = function(pawn, point) ret = SkillEffect() ret:AddDelay(1) ret:AddScript(Board:GetPawn(point):SetTeam(TEAM_PLAYER)) LOG("will convert at "..point:GetString()) return ret end,
						--it's cool that I can programatically make a copy of a pawn and give it a custom death effect, but it won't help here
						-- Image = _G[spaceDamage.sPawn].Image,
						-- Portrait = _G[spaceDamage.sPawn].Portrait,
						-- SkillList = _G[spaceDamage.sPawn].SkillList,
					}
				end
				spaceDamage.sPawn = playerVersionId
				convert = true
			end
			if spaceDamage:IsMovement() then
				if spaceDamage:GetMoveType() == 1 then --leap	
					LOG("found leap from "..p1:GetString().." to "..p2:GetString())
					ret:AddLeap(Board:GetSimplePath(p1, p2), NO_DELAY)
					p1 = p2
					p2 = p2 + DIR_VECTORS[direction]
				elseif spaceDamage:GetMoveType() == 2 then --charge
					LOG("found charge from "..p1:GetString().." to "..p2:GetString())
					ret:AddCharge(Board:GetSimplePath(p1, p2), NO_DELAY)
					p1 = p2
					p2 = p2 + DIR_VECTORS[direction]
				else
					LOG("found weird move type from "..GAME.Metabolized..", tell Metalocif on the Discord.")
				end
			else
				if spaceDamage.iDamage > 0 and spaceDamage.iDamage ~= DAMAGE_DEATH then spaceDamage.iDamage = spaceDamage.iDamage + self.DamageUp end
				--if spaceDamage:GetMoveType() == 3 then ret:AddMelee(spaceDamage, p2) else ret:AddDamage(spaceDamage, p2) end
				if spaceDamage:GetType() == 1 then ret:AddArtillery(spaceDamage, spaceDamage:GetProjectileArt(), NO_DELAY) end
				if spaceDamage:GetType() == 2 then ret:AddProjectile(p1, spaceDamage, spaceDamage:GetProjectileArt(), NO_DELAY) end
				if spaceDamage:GetType() == 0 then 
					if spaceDamage.iDamage > 0 and not addedMelee then ret:AddMelee(p1, spaceDamage) addedMelee = true else ret:AddDamage(spaceDamage) end
				end
				if convert then ret:AddDelay(1) local convertD = SpaceDamage(spaceDamage.loc, 0) convertD.iPawnTeam = TEAM_PLAYER ret:AddDamage(convertD) end
			end
		end
	end
	return ret	
end

function SpawnPlayerTeam(pawn, point)
	ret = SkillEffect()
	local damage = SpaceDamage(point, 0)
	damage.iPawnTeam = TEAM_PLAYER
	ret:AddDamage(damage)
	return ret
end



--------------
--Assimilate--
--------------
--Munch an enemy to gain extra effects on the weapon if there was acid/fire/smoke on it.
--Also swallow items on tiles to spit them.
--Surprisingly easy to code.

modApi:addWeaponDrop("CyborgWeapons_Assimilate")

CyborgWeapons_Assimilate = Skill:new{  
	Name = "Assimilate",
	Class = "TechnoVek",
	Icon = "weapons/Assimilate.png",
	Description = "Strike an adjacent target and remove fire, A.C.I.D., and smoke from it. Subsequent uses of this weapon apply previously removed effects.",
	Rarity = 3,
	ImpactSound = "/enemy/scorpion_soldier_1/attack",
	Damage = 2,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0,	--for testing, should cost 1
	DamageUp = 0,
	Upgrades = 2,
	UpgradeList = { "Lick Wounds",  "Swallow Items"  },
	UpgradeCost = { 1 , 1 },
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Centipede2",
	},
}

CyborgWeapons_Assimilate_A = CyborgWeapons_Assimilate:new{
	UpgradeDescription = "Before attacking, heal the user and remove fire, A.C.I.D., and smoke from it.",
	HealSelf = true,
}

CyborgWeapons_Assimilate_B = CyborgWeapons_Assimilate:new{	
	UpgradeDescription = "Can absorb items from tiles, spitting them as a ranged attack on next use.",
	EatItems = true,
}

CyborgWeapons_Assimilate_AB = CyborgWeapons_Assimilate:new{
	HealSelf = true,
	EatItems = true,
}


function CyborgWeapons_Assimilate:GetTargetArea(point)
	local ret = PointList()
	local mission = GetCurrentMission()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	if mission then
		if not mission.AssimilateDamage then mission.AssimilateDamage = SpaceDamage(point) end
		if mission.AssimilateDamage.sItem ~= "" then	--if we stored an item, we spit it as artillery, so we need a bigger target area
			for i = DIR_START, DIR_END do
				for j = 2, 8 do
					ret:push_back(point + DIR_VECTORS[i] * j)
				end
			end
		end
	end        
	return ret
end

function CyborgWeapons_Assimilate:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local distance = p1:Manhattan(p2)
	local mission = GetCurrentMission()
	if mission then
		if not mission.AssimilateDamage then mission.AssimilateDamage = SpaceDamage(point) end
		if self.HealSelf then
			if Board:GetPawn(p1):IsFire() or Board:IsFire(p1) then ret:AddScript("GetCurrentMission().AssimilateDamage.iFire = EFFECT_CREATE") end	
			--second check if on a fire space and with Thick Skin
			if Board:GetPawn(p1):IsAcid() or (Board:IsAcid(p1) and not Board:GetTerrain(p1) == TERRAIN_WATER) then ret:AddScript("GetCurrentMission().AssimilateDamage.iAcid = EFFECT_CREATE") end
			--second check is because the pawn might be flying above acid water, in which case it wouldn't make sense to purify it
			if Board:IsSmoke(p1) then ret:AddScript("GetCurrentMission().AssimilateDamage.iSmoke = EFFECT_CREATE") end 
			--only relevant with Camilla?
			local healDamage = SpaceDamage(p1, -1)
			healDamage.iFire = EFFECT_REMOVE
			healDamage.iAcid = EFFECT_REMOVE
			healDamage.iSmoke = EFFECT_REMOVE
			ret:AddDamage(healDamage)
		end
		
		if mission.AssimilateDamage.sItem ~= "" and distance > 1 then		--distance > 1 implies we have an item, but other mods may extend target area
			local damage = SpaceDamage(p2, 2)
			damage.sItem = mission.AssimilateDamage.sItem
			ret:AddScript("GetCurrentMission().AssimilateDamage.sItem = \"\"")
			ret:AddArtillery(p1, damage, _G[damage.sItem].Image, FULL_DELAY)
		end 
		if distance == 1 then
			local damage = mission.AssimilateDamage
			if mission.AssimilateDamage.iAcid == EFFECT_CREATE then ret:AddScript(string.format("Board:GetPawn(%s):SetAcid(true)", p2:GetString())) end
			--we apply acid before damage because otherwise the weapon deals fairly low damage, ACID+fire is a 5 damage melee attack which is okay
			damage.loc = p2
			damage.iDamage = 2
			local addFire, addAcid, addSmoke
			if (Board:GetPawn(p2) and Board:GetPawn(p2):IsFire()) or Board:IsFire(p2) then addFire = true end	--we look before applying damage because this might remove the status if we break a tile/kill a dude
			if (Board:GetPawn(p2) and Board:GetPawn(p2):IsAcid()) or (Board:IsAcid(p2) and not Board:GetTerrain(p2) == TERRAIN_WATER) then addAcid = true end
			if Board:IsSmoke(p2) then addSmoke = true end 
			if Board:GetItem(p2) ~= "" and self.EatItems then
				ret:AddScript(string.format("GetCurrentMission().AssimilateDamage.sItem = %q", Board:GetItem(p2)))
				ret:AddScript(string.format("Board:RemoveItem(%s)", p2:GetString()))
			end
			ret:AddMelee(p1, damage)
			if addFire then ret:AddScript("GetCurrentMission().AssimilateDamage.iFire = EFFECT_CREATE") end
			if addAcid then ret:AddScript("GetCurrentMission().AssimilateDamage.iAcid = EFFECT_CREATE") end
			if addSmoke then ret:AddScript("GetCurrentMission().AssimilateDamage.iSmoke = EFFECT_CREATE") end
		end
	end        
	return ret	
end

-------------
--Reproduce--
-------------
--Throw an egg; if it hatches, it spawns a clone of the user, if it's killed before, it boosts the team.
--Sort of a Rock Artillery with an extra benefit you can use as a delayed spawner.

modApi:addWeaponDrop("CyborgWeapons_Reproduce")

CyborgWeapons_Reproduce = Skill:new{  
	Name = "Reproduce",
	Class = "TechnoVek",
	Icon = "weapons/Reproduce.png",
	Description = "Throw an egg at a location, pushing adjacent tiles. At the end of the enemy turn, the egg hatches into a newborn clone of the user. If it dies before hatching, it enrages allied mechs instead.",
	Rarity = 3,
	ImpactSound = "/enemy/scorpion_soldier_1/attack",
	Damage = 1,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Limited = 1,
	Push = 0, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0,	--for testing, should cost 1
	Health = 1,
	Upgrades = 2,
	UpgradeList = { "Unlimited uses", "Health Up"  },
	UpgradeCost = { 2, 2 },
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Target = Point(2,0),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Centipede2",
	},
}

CyborgWeapons_Reproduce_A = CyborgWeapons_Reproduce:new{
	UpgradeDescription = "Can be used unlimited times.",
	Limited = 0,
}
CyborgWeapons_Reproduce_B = CyborgWeapons_Reproduce:new{
	UpgradeDescription = "The egg has 3 HP; the clone has as much HP as the base version of its user.",
	Health = 3,
}
CyborgWeapons_Reproduce_AB = CyborgWeapons_Reproduce:new{
	Limited = 0,
	Health = 3,
}

BoostingEgg = 
{
	Name = "Cyborg Egg",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	IsPortrait = false,
	Image = "debris1",
	SoundLocation = "/support/vek_egg/",
	SkillList = {"BoostingEggHatch"},
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,
	IsDeathEffect = true,
}
AddPawn("BoostingEgg") 

BoostingEggHatch = SelfTarget:new{ 
	Class = "Enemy",
	Name = "Hatch",
	Description = "Hatch into a weaker, baseline copy of the spawning pawn.",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "BoostingEgg",
	}
}

function BoostingEggHatch:GetTargetScore(p)
	return 10
end

function BoostingEggHatch:GetSkillEffect(p1,p2)
	local ret = SkillEffect()	
	local selfId = Board:GetPawn(p1):GetId()
	-- ret:AddScript(string.format([[
	-- local spawn
	-- local parentId
	-- for i = 0, 2 do
		-- if Board:GetPawn(i):GetWeaponBaseType(1) == "CyborgWeapons_Reproduce" or Board:GetPawn(i):GetWeaponBaseType(2) == "CyborgWeapons_Reproduce" then
			-- spawn = Board:GetPawn(i):GetType()
			-- parentId = Board:GetPawn(i):GetId()
			-- LOG(spawn)
			-- break
		-- end
	-- end
	-- local unit = PAWN_FACTORY:CreatePawn(spawn)
	-- unit:SetMech(false)
	-- unit:SetOwner(parentId)
	-- Board:AddPawn(unit,%s)]], p1:GetString()))
	ret:AddScript(string.format([[
	local parentId = GetCurrentMission().ReproduceUser
	local unit = PAWN_FACTORY:CreatePawn(Board:GetPawn(parentId):GetType())
	unit:SetMech(false)
	unit:SetOwner(parentId)
	Board:AddPawn(unit,%s)]], p1:GetString()))
	--if we kill it, it triggers the boosting death effect, so we fake its death
	ret:AddScript(string.format("Board:RemovePawn(Board:GetPawn(%s))", selfId))
	ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(%s)", p1:GetString(), GetCurrentMission().ReproduceUpgrade))
	ret:AddScript(string.format("Board:GetPawn(%s):SetActive(false)", p1:GetString()))
	ret:AddAnimation(p1, "debris1d")
	return ret
end

function BoostingEgg:GetDeathEffect(point)
	local ret = SkillEffect()
	if Pawn:GetTurnCount() == 0 then
		for i = 0, 2 do
			ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", tostring(i)))
		end
	end
	return ret
end

function CyborgWeapons_Reproduce:GetTargetArea(point)
	ret=PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point + DIR_VECTORS[i] * j)
		end
	end
	return ret
end

function CyborgWeapons_Reproduce:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage)
	local killedEgg = false
	if Board:IsValid(p2) and not Board:IsBlocked(p2,PATH_GROUND) then
		damage.sPawn = "BoostingEgg"
		damage.sAnimation = ""
		damage.iDamage = 0
	else 
		damage.sAnimation = "debris1d" 
		killedEgg = true
	end
	
	ret:AddBounce(p1, 1)
	ret:AddArtillery(p1, damage, "effects/shotup_vekegg.png", PROJ_DELAY)
	ret:AddBounce(p2, 3)
	
	local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
	damagepush.sAnimation = "airpush_"..((dir+1)%4)
	ret:AddDamage(damagepush) 
	damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
	damagepush.sAnimation = "airpush_"..((dir-1)%4)
	ret:AddDamage(damagepush)
	
	if killedEgg then
		for i = 0, 2 do
			ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", i))
		end
	else
		if self.HealthUp then 
			ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(3)", p2:GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(3)", p2:GetString()))
		end
		if not Board:IsTipImage() then 
			ret:AddScript("GetCurrentMission().ReproduceUser = "..Board:GetPawn(p1):GetId()) 
			ret:AddScript("GetCurrentMission().ReproduceUpgrade = "..self.Health)
		end
	end
	return ret
end

-------------
--Shed Tail--
-------------
--Shed your tail, losing HP to lure enemies.
--Uses SetPriorityTarget, but the fact it's a pawn means it can have a DeathEffect to remove it (as otherwise Vek would target an empty tile forever).
--Literally a Pokemon move.

modApi:addWeaponDrop("CyborgWeapons_ShedTail")

CyborgWeapons_ShedTail = Skill:new{  
	Name = "Shed Tail",
	Class = "TechnoVek",
	Icon = "weapons/ShedTail.png",
	Description = "Sheds the user's tail to bait all adjacent Vek into attacking the tail until it dies, then repositions to a location, swapping positions with any ally there.",
	Rarity = 0,
	LaunchSound = "/weapons/titan_fist",
	Anim = "tauntedAnim",
	SelfDamage = 1,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1,
	PowerCost = 1,
	Upgrades = 2,
	Health = 1,
	UpgradeList = { "+2 HP", "+4 HP"  },
	UpgradeCost = { 1, 2 },
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,3),
		Enemy2 = Point(1,2),
		Enemy3 = Point(3,2),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
		CustomEnemy = "Firefly1",
	},
}

CyborgWeapons_ShedTail_A = CyborgWeapons_ShedTail:new{
	UpgradeDescription = "The tail gains 2 HP.",
	Health = 3,
}
CyborgWeapons_ShedTail_B = CyborgWeapons_ShedTail:new{
	UpgradeDescription = "The tail gains 4 HP.",
	Health = 5,
}
CyborgWeapons_ShedTail_AB = CyborgWeapons_ShedTail:new{
	Health = 7,
}

ANIMS.tauntedAnim = Animation:new{ 	
	Image = "effects/tauntedAnim.png",
	PosX = -10, PosY = -5,
	NumFrames = 1,
	Time = 1,
	Loop = true
}


SheddedTail = Pawn:new{
	Name = "Tail",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	IsPortrait = false,
	Image = "tail",
	ImageOffset = 1,
	SoundLocation = "/support/vek_egg/",
	SkillList = { "Tail_Taunt" },
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,
	IsDeathEffect = true,
	Corpse = true,		--game won't find the pawn's ID in the DeathEffect otherwise, we turn it off in DeathEffect
}
AddPawn("SheddedTail") 

Tail_Taunt = SelfTarget:new{  
	Name = "Taunt",
	Class = "TechnoVek",
	Icon = "weapons/Provoke.png",
	Description = "Taunts adjacent Vek to attack this unit.",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,3),
		Enemy2 = Point(1,2),
		Enemy3 = Point(3,2),
		Target = Point(2,1),
		CustomPawn = "SheddedTail",
		CustomEnemy = "Firefly1",
	},
}

function Tail_Taunt:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:IsEnemy() then
			local removeWeb = SpaceDamage(curr, 0, DIR_FLIP)
			removeWeb.bHide = true
			ret:AddDamage(removeWeb)
			ret:AddDamage(removeWeb)	--this flips the pawn twice, deleting webs
			ret:AddScript(string.format("Board:GetPawn(%s):SetPriorityTarget(%s)", pawn:GetId(), p1:GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", pawn:GetId(), p1:GetString()))
			ret:AddScript(string.format("CustomAnim:add(%s, %q, %q)", pawn:GetId(), "tauntedAnim", tostring(Board:GetPawn(p1):GetId())))
		end
	end
	return ret
end

function SheddedTail:GetDeathEffect(point)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(point) --:GetId()
	local selfId = pawn:GetId()
	local mission = GetCurrentMission()
	if not mission then return end
	for _, tile in ipairs(Board) do
		if Board:GetPawn(tile) and CustomAnim:get(Board:GetPawn(tile):GetId(), "tauntedAnim", tostring(selfId)) then
			CustomAnim:rem(Board:GetPawn(tile):GetId(), "tauntedAnim", tostring(selfId))
			Board:GetPawn(tile):SetPriorityTarget(Point(-1, -1))	--untaunts all Vek on death
		end
	end
	pawn:SetCorpse(false)
	return ret
end



function CyborgWeapons_ShedTail:GetTargetArea(point)
	ret = PointList()
	if Board:GetTerrain(point) == TERRAIN_WATER or Board:GetTerrain(point) == TERRAIN_HOLE then return ret end
	--we'll create a pawn on this tile so it has to be standable, only matters for flying mechs
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if not Board:IsBlocked(curr, PATH_PROJECTILE) and not Board:IsBlocked(curr, Pawn:GetPathProf()) then
		--we can stand there
			ret:push_back(curr)
		end
	end
	return ret
end

function CyborgWeapons_ShedTail:GetSkillEffect(p1, p2)
	ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local distance = p1:Manhattan(p2)
	local moveDamage = SpaceDamage(p1, 1, direction) --push ourselves to move one tile
	local userId = Board:GetPawn(p1):GetId()	
	moveDamage.fDelay = -1
	ret:AddSafeDamage(moveDamage)
	local spawnDamage = SpaceDamage(p1, 0)
	spawnDamage.sPawn = "SheddedTail"
	ret:AddSafeDamage(spawnDamage)
	ret:AddScript(string.format([[
    local palette = Board:GetPawn(%s):GetImageOffset()
    unit:SetOwner(%s)
    unit:SetMaxHealth(%s)
    unit:SetHealth(%s)
    unit:SetImageOffset(palette))]], userId, userId, self.Health, self.Health))
	ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", p1:GetString(), p1:GetString()))
	return ret
end


--------
--Molt--
--------
--Spawn a dead clone, randomize skin color for fun; not sure how to make it go back to normal.
modApi:addWeaponDrop("CyborgWeapons_Molt")

CyborgWeapons_Molt = Skill:new{  
	Name = "Molt",
	Class = "TechnoVek",
	Icon = "weapons/Molt.png",
	Description = "Molt, repairing, spawning dead skin, increasing movement speed, and boosting.",
	Rarity = 3,
	ImpactSound = "/enemy/scorpion_soldier_1/attack",
	Damage = 0,
	Range = 1, -- Tooltip?
	PathSize = 1,
	Limited = 1,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,1),
		CustomPawn = "BeetleMech",
	},
}

MoltedSkin = Pawn:new{
	Name = "Molting",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	IsPortrait = false,
	Image = "tail",			--we set its image to the corpse of its spawner
	ImageOffset = 1,
	Limited = 1,
	SoundLocation = "/support/vek_egg/",
	SkillList = {},
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}
AddPawn("MoltedSkin") 



function CyborgWeapons_Molt:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
	end
	return ret
end
				
function CyborgWeapons_Molt:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = Board:GetPawn(p2)
	local damage = SpaceDamage(p2)
	damage.bHide = true
	damage.sPawn = "MoltedSkin"
	ret:AddMelee(p1, damage)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p2:GetString(), _G[Board:GetPawn(p1):GetType()].Image.."_broken"))
	ret:AddScript(string.format("Board:GetPawn(%s):SetImageOffset(%s)", p1:GetString(), math.random(14))) --(Board:GetPawn(p1):GetImageOffset() + 1) % 10))
	ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", p1:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p1:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):AddMoveBonus(1)", p1:GetString()))
	local healDamage = SpaceDamage(p1, -1)
	healDamage.iFire = EFFECT_REMOVE
	healDamage.iAcid = EFFECT_REMOVE
	ret:AddDamage(healDamage)
	return ret
end	

--------------------
--Adaptive Biology--
--------------------

modApi:addWeaponDrop("CyborgWeapons_Adapt")

CyborgWeapons_Adapt = Skill:new{  
	Name = "Adaptive Biology",
	Class = "TechnoVek",
	Icon = "weapons/AdaptiveBiology.png",
	Description = "With another Cyborg-class weapon equipped, permanently rerolls it into another, random Cyborg-class weapon. Otherwise, permanently rerolls this weapon. Will only generate weapons enabled in the weapon deck.",
	Rarity = 3,
	Damage = 0,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	Limited = 1,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
	}
}

function CyborgWeapons_Adapt:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function CyborgWeapons_Adapt:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if IsTestMechScenario() or Board:IsTipImage() then return ret end
	local cyborgWeapons = {}
	for id, enabled in pairs(modApi.weaponDeck) do
		local weapon = _G[id]
		if weapon.Class == "TechnoVek" and enabled and weapon.Passive == "" then cyborgWeapons[#cyborgWeapons + 1] = id end
	end
	if #cyborgWeapons == 0 then return ret end
	local roll = random_removal(cyborgWeapons)
	local thisID = 0
	local cyborgID = 0
	local user = Board:GetPawn(p1)
	for i = 1, 2 do
		if user:GetWeaponType(i) == "CyborgWeapons_Adapt" then thisID = i
		elseif user:GetWeaponClass(i) == "TechnoVek" then cyborgID = i end
	end
	if cyborgID == 0 then cyborgID = thisID end
	ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), cyborgID))
	ret:AddScript(string.format("Board:GetPawn(%s):AddWeapon(%q, true)", user:GetId(), roll))
	ret:AddDelay(0.2)
	ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)",user:GetId()))
	return ret
end	

-------------------
--Hunter Reflexes--
-------------------

modApi:addWeaponDrop("CyborgWeapons_HunterReflexes")

CyborgWeapons_HunterReflexes=PassiveSkill:new{
	Name="Hunter Reflexes",
	Class="TechnoVek",
	Passive="HunterReflexes",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="Grants one tile of bonus movement after firing a weapon to all Cyborgs.",
	Icon = "weapons/HunterReflexes.png",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		CustomEnemy = "Hornet2",
		CustomPawn = "BeetleMech",
	}
}

function CyborgWeapons_HunterReflexes:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:IsTipImage() then return ret end
	Board:GetPawn(Point(2, 1)):FireWeapon(Point(2, 2), 1)
	ret:AddMelee(Point(2, 2), SpaceDamage(Point(2, 1), 1, DIR_UP))
	ret:AddCharge(Board:GetSimplePath(Point(2, 2), Point(2, 3)), FULL_DELAY)
	return ret
end

-------------------------
--Opportunistic Hunting--
-------------------------

modApi:addWeaponDrop("CyborgWeapons_OpportunisticHunting")

CyborgWeapons_OpportunisticHunting=PassiveSkill:new{
	Name="Opportunistic Hunting",
	Class="TechnoVek",
	Passive="OpportunisticHunting",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="Vek spawning adjacent to Cyborg mechs take 1 damage upon emerging from each adjacent Cyborg.",
	Icon = "weapons/OpportunisticHunting.png",
	TipImage = {
		Unit = Point(2,2),
	}
}

function CyborgWeapons_OpportunisticHunting:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:IsTipImage() then return ret end
	Board:SpawnPawn("Leaper1", Point(2, 1))
	ret:AddDelay(2)
	ret:AddMelee(Point(2, 2), SpaceDamage(Point(2, 1), 1))
	ret:AddDelay(1)
	return ret
end

---------------------
--Prize of the Hunt--
---------------------

modApi:addWeaponDrop("CyborgWeapons_PrizeOfTheHunt")

CyborgWeapons_PrizeOfTheHunt=PassiveSkill:new{
	Name="Prize of the Hunt",
	Class="TechnoVek",
	Passive="PrizeOfTheHunt",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="When a Vek dies adjacent to a Cyborg mech, that Cyborg heals 1 HP.",
	Icon = "weapons/PrizeOfTheHunt.png",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
	}
}

function CyborgWeapons_PrizeOfTheHunt:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:IsTipImage() then return ret end
	ret:AddDelay(0.5)
	ret:AddDamage(SpaceDamage(Point(2, 2), DAMAGE_DEATH))
	ret:AddDelay(0.2)
	ret:AddDamage(SpaceDamage(Point(2, 3), -1))
	ret:AddDelay(1)
	return ret
end

----------------
--Cricket Legs--
----------------

modApi:addWeaponDrop("CyborgWeapons_CricketLegs")

CyborgWeapons_CricketLegs=PassiveSkill:new{
	Name="Cricket Legs",
	Class="TechnoVek",
	Passive="CricketLegs",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="All Cyborg mechs move by leaping.",
	Icon = "weapons/CricketLegs.png",
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
	}
}

function CyborgWeapons_CricketLegs:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:IsTipImage() then return ret end
	local move = PointList()
	move:push_back(Point(2, 4))
	move:push_back(Point(2, 3))
	ret:AddLeap(move, FULL_DELAY)
	ret:AddDelay(1)
	return ret
end

-------------
--Overdrive--
-------------

modApi:addWeaponDrop("CyborgWeapons_Overdrive")

CyborgWeapons_Overdrive=PassiveSkill:new{
	Name="Overdrive",
	Class="TechnoVek",
	Passive="Overdrive",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="All Cyborg mechs are boosted at the cost of 1 HP at the start of their turns. Will not trigger if it would kill the mech.",
	Icon = "weapons/Overdrive.png",
	TipImage = {
		Unit = Point(2,3),
	}
}

function CyborgWeapons_Overdrive:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:IsTipImage() then return ret end
	Board:AddDamage(SpaceDamage(Point(2, 3), 1))
	Board:GetPawn(Point(2, 3)):SetBoosted(true)
	ret:AddDelay(1)
	return ret
end

--------------------
--Confusing Flight--
--------------------
--Queued mech movement is super buggy, this is AFAICT an engine issue.
--Not touching this again.

-- modApi:addWeaponDrop("CyborgWeapons_ConfusingFlight")

-- CyborgWeapons_ConfusingFlight = Skill:new{  
	-- Name = "Confusing Flight",
	-- Class = "TechnoVek",
	-- Icon = "weapons/ConfusingFlight.png",
	-- Description = "Flier only.\n\nFly at an empty tile, confusing all Vek around both starting and target tile. At the start of the Vek's turn, do the same in reverse.",
	-- Rarity = 3,
	-- ImpactSound = "/enemy/scorpion_soldier_1/attack",
	-- Damage = 0,
	-- Range = 1, 
	-- PathSize = 8,
	-- PushBack = false,
	-- Flip = false,
	-- Dash = false,
	-- Shield = false,
	-- Projectile = false,
	-- Push = 0, 
	-- PowerCost = 0,	
	-- Upgrades = 0,
	-- TipImage = {
		-- Unit = Point(2,2),
		-- Enemy1 = Point(2,1),
		-- Target = Point(2,0),
		-- CustomPawn = "BeetleMech",
		-- CustomEnemy = "Centipede2",
	-- },
-- }

-- function CyborgWeapons_ConfusingFlight:GetTargetArea(point)
	-- ret=PointList()
	-- if not Board:GetPawn(point) then return ret end
	-- if not Board:GetPawn(point):IsFlying() then return ret end
	-- for i = DIR_START, DIR_END do
		-- for j = 3, 8 do
			-- if not Board:IsBlocked(point + DIR_VECTORS[i] * j, PATH_PROJECTILE) then ret:push_back(point + DIR_VECTORS[i] * j) end
		-- end
	-- end
	-- return ret
-- end

-- function CyborgWeapons_ConfusingFlight:GetSkillEffect(p1,p2)
	-- local ret = SkillEffect()
	-- local dir = GetDirection(p2 - p1)
	-- local distance = p1:Manhattan(p2)
	-- local damage = SpaceDamage(p1, 0, DIR_FLIP)
	-- local start = p1
	-- local target = p2
	-- for i = DIR_START, DIR_END do
		-- damage.loc = start + DIR_VECTORS[i]
		-- ret:AddDamage(damage)
	-- end
	-- local move = PointList()
	-- move:push_back(start)
	-- move:push_back(target)
	-- ret:AddLeap(move, FULL_DELAY)
	-- for i = DIR_START, DIR_END do
		-- damage.loc = target + DIR_VECTORS[i]
		-- ret:AddDamage(damage)
	-- end
	-- for i = DIR_START, DIR_END do
		-- damage.loc = target + DIR_VECTORS[i]
		-- ret:AddQueuedDamage(damage)
	-- end
	-- move = PointList()
	-- start = start - DIR_VECTORS[dir] * distance
	-- move:push_back(Pawn:GetSpace())
	-- move:push_back(start)
	-- ret:AddQueuedLeap(move, FULL_DELAY)
	-- for i = DIR_START, DIR_END do
		-- damage.loc = start + DIR_VECTORS[i] - DIR_VECTORS[dir] * distance
		-- ret:AddQueuedDamage(damage)
	-- end
	-- return ret
-- end



--this is apparently something Pilot_Arrogant already made for Unfair Tweaks -_-
--The script doesn't quite work anyway
-- modApi:addWeaponDrop("CyborgWeapons_Provoke")

-- CyborgWeapons_Provoke = Skill:new{  
	-- Name = "Provoke",
	-- Class = "TechnoVek",
	-- Icon = "weapons/Provoke.png",
	-- Description = "Force a target to attack in a chosen direction.",
	-- TwoClick = true,
	-- Rarity = 0,
	-- LaunchSound = "/weapons/titan_fist",
	-- UpShot = "effects/shotup_provoke.png",
	-- Damage = 3,
	-- Range = 1, -- Tooltip?
	-- PathSize = 1,
	-- PushBack = false,
	-- Flip = false,
	-- Dash = false,
	-- Shield = false,
	-- Projectile = false,
	-- Push = 1,
	-- PowerCost = 1,
	-- Upgrades = 0,
	-- TipImage = {
		-- Unit = Point(2,2),
		-- Enemy_Damaged = Point(2,1),
		-- Enemy2 = Point(2,3),
		-- Enemy3 = Point(1,2),
		-- Enemy4 = Point(3,2),
		-- Target = Point(2,1),
		-- CustomPawn = "BeetleMech",
		-- CustomEnemy = "Centipede2",
	-- },
-- }

-- function CyborgWeapons_Provoke:GetTargetArea(point)
	-- local ret = PointList()
	-- for dir = DIR_START, DIR_END do
		-- for i = 2, 8 do
			-- local curr = Point(point + DIR_VECTORS[dir] * i)
			-- if not Board:IsValid(curr) then break end
			-- if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY and not Board:GetPawn(curr):GetMechName():find("Psion") then ret:push_back(curr) end
		-- end
	-- end
	-- return ret
-- end

-- function CyborgWeapons_Provoke:GetSecondTargetArea(p1, p2)
	-- local ret = PointList()
	-- for dir = DIR_START, DIR_END do
		-- if Board:IsValid(p2 + DIR_VECTORS[dir]) then ret:push_back(p2 + DIR_VECTORS[dir]) end
	-- end
	-- return ret
-- end

-- function CyborgWeapons_Provoke:GetSkillEffect(p1, p2)
	-- local ret = SkillEffect()
	-- ret:AddArtillery(p1, SpaceDamage(p2), self.UpShot, PROJ_DELAY)
	-- return ret
-- end	
				
-- function CyborgWeapons_Provoke:GetFinalEffect(p1, p2, p3)
	-- local ret = SkillEffect()
	-- local direction = GetDirection(p3 - p2)
	-- local target = Board:GetPawn(p2)
	-- ret:AddArtillery(p1, SpaceDamage(p2), self.UpShot, PROJ_DELAY)
	-- ret:AddScript([[
	-- j = 1
	-- while not target:FireWeapon(]]..(p2 + DIR_VECTORS[direction] * j):GetString()..[[, 1) and Board:IsValid(]]..(p2 + DIR_VECTORS[direction] * j):GetString()..[[) do
		-- j=j+1
	-- end]])
	-- return ret
-- end	

