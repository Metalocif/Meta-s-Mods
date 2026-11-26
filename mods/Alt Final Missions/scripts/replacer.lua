local function PickEnding(corporation, island)
	--mod options contains weights; we add N cards for each ending to a deck with N the weight
	local options = mod_loader.currentModContent["Meta_AltFinalMissions"].options
	if Game:GetSector() == 1 then 
		local possibleMissions = {}
		for i = 1, options.Meta_RegularFinalMissionWeight.value do
			possibleMissions[#possibleMissions+1] = "Normal"
		end
		for i = 1, options.Meta_FluorousFinalMissionWeight.value do
			possibleMissions[#possibleMissions+1] = "Fluorous"
		end
		for i = 1, options.Meta_NukeFinalMissionWeight.value do
			possibleMissions[#possibleMissions+1] = "Nuke"
		end
		for i = 1, options.Meta_QueenFinalMissionWeight.value do
			possibleMissions[#possibleMissions+1] = "Queen"
		end
		--just in case users messed up options
		if #possibleMissions == 0 then GAME.Meta_AltFinalMission = "Normal" return end
		--then we pick a card at random
		GAME.Meta_AltFinalMission = random_removal(possibleMissions)
		LOG("Final mission: "..GAME.Meta_AltFinalMission)
	end
end

local function PreviewEnding(island)
	local options = mod_loader.currentModContent["Meta_AltFinalMissions"].options
	if Game:GetSector() == 3 and options.Meta_LearnAboutFinalMission.enabled then
		local text = "Attention, Commander. We have chosen our method of attack on the Vek Hive.\n"
		if GAME.Meta_AltFinalMission == "Normal" then
			text = text.."We will drop a Renfield Bomb into the Hive. It will require some time to charge, and your pilots will need to protect it until it is ready."
		elseif GAME.Meta_AltFinalMission == "Fluorous" then
			text = text.."Using a Volatile Vek specimen, we have engineered a new breed capable of detonating with immense force. We will trigger its ignition sequence before the assault. Your pilots will need to protect it until detonation, though we expect it to attack them in the meantime."
		elseif GAME.Meta_AltFinalMission == "Nuke" then
			text = text.."We will drop a nuclear warhead into the Hive. It has no dedicated detonator, so your pilots will need to strike it until it explodes."
		elseif GAME.Meta_AltFinalMission == "Queen" then
			text = text.."We will use captured Psions to send a psychic signal and draw the Hive Queen out, giving your pilots an opportunity to slay it. The psionic backlash from its death should scour the Hive from this world."
		end
		sdlext.showTextDialog("Briefing", text)
	end
end

local function EVENT_onModsLoaded()
	modApi:addPostIslandSelectionHook(PickEnding)
	modApi.events.onIslandLeft:subscribe(PreviewEnding)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local writepath = "img/units/mission/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local trait = require(mod.scriptPath..'libs/trait')
local customEmitter = require(mod_loader.mods.meta_mods.scriptPath.."libs/customEmitter")
local a = ANIMS

Emitter_PsionicFieldExplosive = Emitter:new{ image = "effects/effect_tile_explosive.png", timer = 0.2, x = -27, y = 0, angle = -90, angle_variance = 0, burst_count = 1, max_particles = 1, min_alpha = 0.25, max_alpha = 0.25, layer = LAYER_FRONT, fade_in = true, gravity = false, random_rot = false,speed=1.5, lifespan = 0.5}
Emitter_PsionicFieldRetarget = Emitter:new{ image = "effects/effect_tile_retarget.png", timer = 0.2, x = -27, y = 0, angle = -90, angle_variance = 0, burst_count = 1, max_particles = 1, min_alpha = 0.25, max_alpha = 0.25, layer = LAYER_FRONT, fade_in = true, gravity = false, random_rot = false,speed=1.5, lifespan = 0.5}
Emitter_PsionicFieldBreach = Emitter:new{ image = "effects/effect_tile_breach.png", timer = 0.2, x = -27, y = 0, angle = -90, angle_variance = 0, burst_count = 1, max_particles = 1, min_alpha = 0.25, max_alpha = 0.25, layer = LAYER_FRONT, fade_in = true, gravity = false, random_rot = false,speed=1.5, lifespan = 0.5}

UnitRift_Overhead = Animation:new{ 
	Image = "combat/rift_unit.png", PosX = -33, PosY = -70,
	NumFrames = 11, Time = 0.04, Loop = false
}

a.Meta_FluorousVek = a.EnemyUnit:new{Image = imagepath .. "FluorousVek.png", PosX = -17, PosY = -10, Height = 1}
a.Meta_FluorousVekd = a.Meta_FluorousVek:new{Image = imagepath .. "FluorousVek_d.png", PosX = -20, NumFrames = 7, Loop = false}
a.Meta_FluorousVeka = a.Meta_FluorousVek:new{ Image = imagepath.."FluorousVek_a.png", NumFrames = 4 }
a.Meta_FluorousVekw = a.Meta_FluorousVek:new{ Image = imagepath.."FluorousVek_w.png", }
-- a.Meta_FluorousVeke = a.BaseEmerge:new{ Image = imagepath.."FluorousVek_e.png", PosX = -24, PosY = -1, Height = 1 }

a.HiveTentacle = a.EnemyUnit:new{Image = imagepath .. "djinn_tenta.png", PosX = -22, PosY = -10, Height = 1}
a.HiveTentacled = a.HiveTentacle:new{Image = imagepath .. "djinn_tenta_rip.png", PosX = -20, NumFrames = 8, Loop = false}
a.HiveTentaclea = a.HiveTentacle:new{ Image = imagepath.."djinn_tenta_idle.png", NumFrames = 6, Time=0.6 }
a.HiveTentaclee = a.BaseEmerge:new{ Image = imagepath.."djinn_tenta_emerge.png", PosX = -24, PosY = -1, Height = 1, NumFrames = 8 }

a.HiveTentacle_small = a.EnemyUnit:new{Image = imagepath .. "djinn_tentasmall.png", PosX = -22, PosY = -10, Height = 1}
a.HiveTentacle_smalld = a.HiveTentacle_small:new{Image = imagepath .. "djinn_tentasmall_emerge.png", PosX = -24, PosY = -1, NumFrames = 8, Loop = false, Frames={7,6,5,4,3,2,1,0}}
a.HiveTentacle_smalla = a.HiveTentacle_small:new{ Image = imagepath.."djinn_tentasmall_idle.png", NumFrames = 6 }
a.HiveTentacle_smalle = a.BaseEmerge:new{ Image = imagepath.."djinn_tentasmall_emerge.png", PosX = -22, PosY = -10, Height = 1, NumFrames = 8 }

a.Meta_Nuke = a.EnemyUnit:new{Image = imagepath .. "Nuke.png", PosX = -12, PosY = -20, Height = 1}
a.Meta_Nuked = a.Meta_Nuke:new{Image = imagepath .. "Nuke_d.png",  NumFrames = 4, Loop = true, Frames={0,1,2,3,2,1}}
a.Meta_Nukea = a.Meta_Nuke:new{ Image = imagepath.."Nuke_a.png", NumFrames = 1 }
-- a.Meta_Nukew = a.Meta_Nuke:new{ Image = imagepath.."Nuke_w.png", }

a.Meta_HiveQueen = a.EnemyUnit:new{Image = imagepath .. "queen.png", PosX = -40, PosY = 5, Height = 1}
a.Meta_HiveQueend = a.Meta_HiveQueen:new{Image = imagepath .. "queend.png",  NumFrames = 9, Loop = true, Time = 0.1, Frames={0,1,2,3,4,5,6,7,8,7,6,5,4,3,2,1}}
a.Meta_HiveQueena = a.Meta_HiveQueen:new{ Image = imagepath.."queena.png", NumFrames = 3, Time = 1 }

Location["img/combat/tiles_grass/crack_bottom.png"] = Point(-26,2)
Location["img/combat/tiles_grass/crack_left.png"] = Point(-26,2)
Location["img/combat/tiles_grass/crack_right.png"] = Point(-26,2)
  
Meta_HiveQueen = {
	GetHealth = function()
		local options = mod_loader.currentModContent["Meta_AltFinalMissions"].options
		return options.Meta_HiveQueenMaxHealth.value
	end,
	MoveSpeed = 0,	--does not move
	Pushable = false,
	Supermassive = true,	--uses a tweaked Tosx code to make it immune to holes/liquids
	Flying = true,			--here for Tosx's code
	IgnoreFlip = true,
	--IgnoreFire = true,		--there's a weird issue if you use SetFire(false) on an extra space
	IgnoreSmoke = true,	
	Image = "Meta_HiveQueen",
	Name = "Hive Queen",
	ExtraSpaces = { Point(0,1), Point(1,0), Point(1,1) },			--chonky girl
	SkillList = { "Meta_HiveQueenDeployTentacles", "Meta_HiveQueenEatStuff", "Meta_HiveQueenImprison" },
	GetWeapon = function() 
		if not Pawn then return 1 end
		if Pawn:GetWeaponCount() <= 1 then return 1 end
		local p1 = Pawn:GetSpace()
		local bestScores = {-1000, -1000, -1000}
		for i = 1, Pawn:GetWeaponCount() do
			for _, p2 in ipairs(extract_table(_G[Pawn:GetWeaponType(i)]:GetTargetArea(p1))) do
				local score = _G[Pawn:GetWeaponType(i)]:GetTargetScore(p1, p2)
				if score > bestScores[i] then bestScores[i] = score end
			end
		end
		if bestScores[1] >= bestScores[2] and bestScores[1] >= bestScores[3] then 
			return 1
		elseif bestScores[2] >= bestScores[1] and bestScores[2] >= bestScores[3] then 
			return 2
		else
			return 3
		end
	end,
	-- Massive = true,
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	Portrait = "enemy/hivequeen",
	SoundLocation = "/enemy/burrower_2/",
	Corpse = true,			--just for the visuals
	IsDeathEffect = true,	--clear psionic fields, end battle
	Tier = TIER_BOSS,
	DoNotReplace = true		--looked for in Hive War, which turns a boss into the Hive Warrior
}
AddPawn("Meta_HiveQueen") 

Meta_HiveQueenTentacle = Pawn:new{
	Name = "Tentacle",
	Health = 1,
	Image = "HiveTentacle",
	MoveSpeed = 0,
	SkillList = { },
	SoundLocation = "/support/bombrock/",
	DefaultTeam = TEAM_NONE,
	ImpactMaterial = IMPACT_FLESH,
	Neutral = true,
	Pushable = false,
	LargeShield = true,
	TempUnit = true,
	Minor = true,
	Portrait = "enemy/djinn_tenta_portrait",
}
AddPawn("Meta_HiveQueenTentacle")

Meta_HiveQueenTentacle_Attacker = Pawn:new{
	Name = "Tentacle",
	Health = 3,
	Image = "HiveTentacle_small",
	MoveSpeed = 4,
	SkillList = { "Meta_HiveQueenTentacle_Attack" },
	SoundLocation = "/support/bombrock/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_FLESH,
	Pushable = false,
	Burrows = true,
	LargeShield = true,
	Minor = true,
	Portrait = "enemy/djinn_tenta_portrait",
}

Meta_HiveQueenTentacle_Attack = Skill:new{
	Class = "Enemy",
	Name = "Tentacle Strike",
	Description = "Strikes an adjacent tile.",
	Damage = 2,
	PathSize = 1,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "Meta_HiveQueenTentacle_Attacker"
	}
}

function Meta_HiveQueenTentacle_Attack:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddQueuedMelee(p1, SpaceDamage(p2, self.Damage))
	return ret
end

AddPawn("Meta_HiveQueenTentacle_Attacker")

local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(0, -1), Point(-1, 0) }

local function GetQueen()
	for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(i) and Board:GetPawn(i):GetType() == "Meta_HiveQueen" then return i end
	end 
	return -1
end

trait:add{
	pawnType = "Meta_HiveQueen",
	icon = resourcePath.."img/combat/traits/invincible.png",
	desc_title = "Invincible",
	desc_text = "Can only take up to "..mod_loader.currentModContent["Meta_AltFinalMissions"].options.Meta_HiveQueenInvincibleThreshold.value.." damage in a single attack.",
}
trait:add{
	func = function(self, pawn) 
		local m = GetCurrentMission()
		if (not pawn) or pawn:GetTeam() ~= TEAM_ENEMY or (not m) or (not m.PsionicField_ExplosiveLocs) then return false end
		for i, tile in ipairs(m.PsionicField_ExplosiveLocs) do
			if tile == pawn:GetSpace() then return true end 
		end
		return false
	end,
	icon = "img/combat/icons/icon_explode.png",
	desc_title = "Explosive",
	desc_text = "While in the psionic field, will explode on death.",
}
trait:add{
	func = function(self, pawn) 
		local m = GetCurrentMission()
		if (not pawn) or pawn:GetTeam() ~= TEAM_ENEMY or (not m) or (not m.PsionicField_RetargetLocs) then return false end
		for i, tile in ipairs(m.PsionicField_RetargetLocs) do
			if tile == pawn:GetSpace() then return true end 
		end
		return false
	end,
	icon = "img/combat/traits/retarget.png",
	desc_title = "Retarget",
	desc_text = "Will retarget when moved inside or into the psionic field.",
}
trait:add{
	func = function(self, pawn) 
		local m = GetCurrentMission()
		if (not pawn) or pawn:GetTeam() ~= TEAM_ENEMY or (not m) or (not m.PsionicField_BreachLocs) then return false end
		for i, tile in ipairs(m.PsionicField_BreachLocs) do
			if tile == pawn:GetSpace() then return true end 
		end
		return false
	end,
	icon = "img/combat/traits/breached.png",
	desc_title = "Breached",
	desc_text = "While in the psionic field, will be teleported through time instead of dying, returning on the next turn unless its tile and all adjacent tiles are blocked.",
}

local function ClearPsionicFields()
	local mission = GetCurrentMission()
	mission.PsionicField_ExplosiveLocs = {}
	mission.PsionicField_RetargetLocs = {}
	mission.PsionicField_BreachLocs = {}
	mission.PsionicField_BreachedPawns = mission.PsionicField_BreachedPawns or {}
	for _, id in ipairs(mission.PsionicField_BreachedPawns) do
		if Board:GetPawn(id) then
			local curr = Board:GetPawn(id):GetSpace()
			local returnTo 
			for _, offset in ipairs(offsets) do
				returnTo = Point(curr.x - 10, curr.y - 10) + offset
				if not Board:IsBlocked(returnTo, Board:GetPawn(id):GetPathProf()) then
					break
				end
			end
			if not Board:IsBlocked(returnTo, Board:GetPawn(id):GetPathProf()) then
				Board:GetPawn(id):SetSpace(returnTo)
				Board:GetPawn(id):ClearQueued()
				Board:AddAnimation(returnTo, "UnitRift", ANIM_NO_DELAY)
			end
		end
	end
	mission.PsionicField_BreachedPawns = {}
	for _, p in ipairs(Board) do
		customEmitter:Rem(mission, p, "Emitter_PsionicFieldExplosive")
		customEmitter:Rem(mission, p, "Emitter_PsionicFieldRetarget")
		customEmitter:Rem(mission, p, "Emitter_PsionicFieldBreach")
		trait:update(p)
	end
end

function SkillEffect:AddPsionicField()
	if not (Game and Game:GetTeamTurn() == TEAM_ENEMY) then return self end	--if forcing to retarget or copying skill effect, don't make field
	local m = GetCurrentMission()
	m.PsionicField_ExplosiveLocs = m.PsionicField_ExplosiveLocs or {}
	m.PsionicField_RetargetLocs = m.PsionicField_RetargetLocs or {}
	m.PsionicField_BreachLocs = m.PsionicField_BreachLocs or {}

	m.baseScoreExplosive = m.baseScoreExplosive or 1
	m.baseScoreBreach = m.baseScoreBreach or 1
	m.baseScoreRetarget = m.baseScoreRetarget or 1

	local bestScore = -100
	local bestLoc, bestType

	for i = 1, 6 do
		for j = 1, 6 do
			local scoreExplosive = m.baseScoreExplosive
			local scoreRetarget = m.baseScoreRetarget
			local scoreBreach = m.baseScoreBreach
			local valid = true

			for _, offset in ipairs(offsets) do
				local tile = Point(i, j) + offset
				local pawn = Board:GetPawn(tile)

				if pawn and pawn:GetType() == "Meta_HiveQueen" then
					valid = false
					break
				end
				if pawn and pawn:GetTeam() == TEAM_ENEMY and not _G[pawn:GetType()].Explodes and not pawn:IsMinor() then
					if pawn:GetHealth() <= 2 or (pawn:GetHealth() <= 4 and pawn:IsAcid()) then
						scoreExplosive = scoreExplosive + 5
					else
						scoreExplosive = scoreExplosive + 2
					end
				end
				if pawn and pawn:GetTeam() == TEAM_ENEMY and not pawn:IsGuarding() then
					scoreRetarget = scoreRetarget + pawn:GetHealth()
				end
				if pawn and pawn:GetTeam() == TEAM_ENEMY then
					scoreBreach = scoreBreach + 6
				end
			end

			if valid then
				if scoreExplosive > bestScore then
					bestScore = scoreExplosive
					bestLoc = Point(i, j)
					bestType = "Explosive"
				end

				if scoreRetarget > bestScore then
					bestScore = scoreRetarget
					bestLoc = Point(i, j)
					bestType = "Retarget"
				end

				if scoreBreach > bestScore then
					bestScore = scoreBreach
					bestLoc = Point(i, j)
					bestType = "Breach"
				end
			end
		end
	end

	if not bestLoc then return self end

	-- Encourage variety between field types
	if bestType == "Explosive" then
		m.baseScoreBreach = m.baseScoreBreach + 5
		m.baseScoreRetarget = m.baseScoreRetarget + 5
	elseif bestType == "Retarget" then
		m.baseScoreExplosive = m.baseScoreExplosive + 5
		m.baseScoreBreach = m.baseScoreBreach + 5
	elseif bestType == "Breach" then
		m.baseScoreExplosive = m.baseScoreExplosive + 5
		m.baseScoreRetarget = m.baseScoreRetarget + 5
	end

	for i, offset in ipairs(offsets) do
		local tile = bestLoc + offset

		self:AddScript(string.format(
			"GetCurrentMission().PsionicField_%sLocs[%s] = %s",
			bestType, i, tile:GetString()
		))

		self:AddScript(string.format(
			"local customEmitter = require(%q) customEmitter:Add(nil, %s, %q)",
			mod_loader.mods.meta_mods.scriptPath .. "libs/customEmitter",
			tile:GetString(),
			"Emitter_PsionicField" .. bestType
		))

		trait:update(tile)
	end

	return self
end

function Meta_HiveQueen:GetDeathEffect(point)
	GetCurrentMission().TurnLimit = Game:GetTurnCount()
	ClearPsionicFields()
	return SkillEffect()
end

Meta_HiveQueenImprison = Skill:new{
	Name = "Tentacle Cage",
	Class = "Enemy",
	PathSize = 1,
	Description = "Creates a temporary psionic field and entraps a mech with tentacles, preparing to kill it from below.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,0),
		Water = Point(3,2),
		CustomPawn = "Meta_HiveQueen"
	}
}

function Meta_HiveQueenImprison:GetTargetArea(point)
	local ret = PointList()
	for i = 1, 6 do
		for j = 1, 6 do
			ret:push_back(Point(i, j))
		end
	end
	return ret
end

function Meta_HiveQueenImprison:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	ret:AddPsionicField()
	
	for i = DIR_START, DIR_END do
		local tile = p2 + DIR_VECTORS[i]
		if not Board:IsBlocked(tile, PATH_GROUND) then
			local spawnDamage = SpaceDamage(tile)
			spawnDamage.sPawn = "Meta_HiveQueenTentacle"
			ret:AddDamage(spawnDamage)
		end
	end
	local damage = SpaceDamage(p2, DAMAGE_DEATH)
	damage.sAnimation = "tentacles"
	damage.iTerrain = TERRAIN_LAVA
	damage.sSound = "/props/tentacle"
	ret:AddQueuedDamage(damage)
	return ret
end

function Meta_HiveQueenImprison:GetTargetScore(p1, p2)	--don't target mechs that escape easily or mechs adjacent to friend/liquid
	local score = 15
	local pawn = Board:GetPawn(p2)
	if not (pawn and pawn:IsMech()) then return -100 end
	if pawn:IsFlying() or pawn:IsBurrower() or pawn:IsDead() or pawn:IsJumper() or pawn:IsTeleporter() or 
	_G[pawn:GetType()].GhostMovement or _G[pawn:GetType()].FastTeleporter then return -100 end
	--GhostMovement/FastTeleporter is used in Pokemon
	--this deliberately ignores pilot abilities so they get a chance to shine
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		if Board:GetTerrain(curr) == TERRAIN_WATER or (Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER) then return -100 end
		if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_GROUND) then score = score + 1 end 	--encourage making more tendrils when possible
	end
	return score
end

Meta_HiveQueenEatStuff = Skill:new{
	Name = "Warping Hunger",
	Class = "Enemy",
	PathSize = 1,
	Description = "Creates a temporary psionic field and prepares to warp all units in an area into the user, killing them. Heals the user for the total health of units killed that way.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,0),
		Water = Point(3,2),
		CustomPawn = "Meta_HiveQueen"
	}
}

function Meta_HiveQueenEatStuff:GetTargetArea(point)
	local ret = PointList()
	for i = 1, 6 do
		for j = 1, 6 do
			ret:push_back(Point(i, j))
		end
	end
	return ret
end

function Meta_HiveQueenEatStuff:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	ret:AddPsionicField()
	local totalHealth = 0
	for _, offset in ipairs(offsets) do
		local tile = p2 + offset
		local pawn = Board:GetPawn(tile)
		if pawn and not pawn:IsGuarding() then
			totalHealth = totalHealth + pawn:GetHealth()
			ret:AddQueuedScript(string.format("Board:AddAnimation(%s, %q, %s)", tile:GetString(), "UnitRift", ANIM_NO_DELAY))
			ret:AddQueuedDelay(0.2)
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn:GetId(), p1:GetString()))
			ret:AddQueuedScript(string.format("Board:AddAnimation(%s, %q, %s)", p1:GetString(), "UnitRift_Overhead", ANIM_NO_DELAY))
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):Fall(0)", pawn:GetId()))
			ret:AddQueuedDelay(0.2)
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCorpse(false)", pawn:GetId()))
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):Kill(false)", pawn:GetId()))
			local damage = SpaceDamage(tile, DAMAGE_ZERO)
			if Board:GetPawn(tile) then damage.iDamage = DAMAGE_DEATH end
			ret:AddQueuedDamage(damage)
		end
	end
	ret:AddQueuedDamage(SpaceDamage(p1, -totalHealth))
	return ret
end

function Meta_HiveQueenEatStuff:GetTargetScore(p1, p2)
	local score = 1
	local missingHealth = 0
	local totalHealth = 0
	if Board:GetPawn(p1) and Board:GetPawn(p1):IsDamaged() then missingHealth = Board:GetPawn(p1):GetMaxHealth() - Board:GetPawn(p1):GetHealth() end
	for _, offset in ipairs(offsets) do
		local tile = p2 + offset
		local pawn = Board:GetPawn(tile)
		if pawn and pawn:GetType() == "Meta_HiveQueen" then return -100 end
		if pawn and not pawn:IsGuarding() then totalHealth = totalHealth + pawn:GetHealth() score = score + 1 end
	end
	score = score + math.min(missingHealth, totalHealth)
	return score
end


Meta_HiveQueenDeployTentacles = Skill:new{
	Class = "Enemy",
	Name = "Tentacle Ambush",
	Description = "Summons up to two tentacle attackers near player units or buildings.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,3),
		Water = Point(3,2),
		CustomPawn = "Meta_HiveQueen"
	}
}

function Meta_HiveQueenDeployTentacles:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	return ret
end

function Meta_HiveQueenDeployTentacles:GetTargetScore(p1, p2)
	return 35 - Board:GetPawnCount(TEAM_ENEMY) * 5
end

function Meta_HiveQueenDeployTentacles:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddPsionicField()
	--four 3x3 quadrants, excluding board edges
	local quadrants = { {1, 3, 1, 3},
						{4, 6, 1, 3},
						{1, 3, 4, 6},
						{4, 6, 4, 6} }

	local spawned = 0

	while #quadrants > 0 do
		local quadrant = random_removal(quadrants)
		local candidates = {}

		for x = quadrant[1], quadrant[2] do
			for y = quadrant[3], quadrant[4] do
				local tile = Point(x, y)
				if not (Board:IsBlocked(tile, PATH_GROUND) or Board:IsDangerous(tile) or Board:GetPawn(tile)) then
					for dir = DIR_START, DIR_END do
						local near = tile + DIR_VECTORS[dir]
						if (Board:GetPawn(near) and Board:GetPawn(near):GetTeam() == TEAM_PLAYER) or Board:IsBuilding(near) then
							candidates[#candidates + 1] = tile
							break
						end
					end
				end
			end
		end

		if #candidates > 0 then
			local tile = candidates[math.random(#candidates)]
			local damage = SpaceDamage(tile)
			-- damage.sPawn = "Meta_HiveQueenTentacle_Attacker"
			damage.sScript = string.format([[
					local unit = PAWN_FACTORY:CreatePawn(%q)
					local p = %s
					unit:SetMovementSpent(true)
					Board:AddPawn(unit, p)
					local flag
					for dir = DIR_START, DIR_END do
						if Board:IsBuilding(p + DIR_VECTORS[dir]) then
							unit:FireWeapon(p + DIR_VECTORS[dir], 1)
							flag = true
							break
						end
					end
					if not flag then
						for dir = DIR_START, DIR_END do
							if Board:GetPawn(p + DIR_VECTORS[dir]) and Board:GetPawn(p + DIR_VECTORS[dir]):IsMech() then
								unit:FireWeapon(p + DIR_VECTORS[dir], 1)
								break
							end
						end
					end]], "Meta_HiveQueenTentacle_Attacker", tile:GetString())
			ret:AddDamage(damage)
			--may need to add a script here to get the tentacle to fire weapon
			--either runLater or use a giant PAWN_FACTORY script
			spawned = spawned + 1
			if spawned >= 2 then break end
		end
	end
	return ret
end

local function tileToTooltipId(point)
	if not point or not Board:IsValid(point) then return nil end

	local terrain = Board:GetTerrain(point)

	-- Explicit tile identifiers (useful for scripted environmental effects)
	local icon = Board:GetTerrainIcon(point)
	if TILE_TOOLTIPS[icon] then return icon end

	-- Emerging Vek
	if Board:IsSpawning(point) then
		return "spawning"
	end

	-- Fire
	local fireType = Board:GetFireType(point)
	if terrain == TERRAIN_FIRE or fireType ~= FIRE_TYPE_NONE then
		if fireType == FIRE_TYPE_FOREST_FIRE then
			return "forest_fire"
		end
		return "fire"
	end

	-- Forest
	if Board:IsForest(point) then
		return "forest"
	end

	-- Smoke
	if Board:IsSmoke(point) then
		if Board:IsDangerous(point) then
			return "electric_smoke"
		end
		return "smoke"
	end

	-- Time Pods
	if Board:IsPod(point) then
		return "pod"
	end

	-- Buildings
	if terrain == TERRAIN_BUILDING then
		if Board:IsFrozen(point) then
			return "frozen_powered"
		end

		if Board:GetPeopleEvacuated(point) > 0 then
			return "evacuated"
		end

		if Board:GetPeoplePopulated(point) == 0 then
			return "pylon"
		end

		return nil
	end

	-- Rubble
	if terrain == TERRAIN_RUBBLE then
		if Board:GetRubbleType(point) == RUBBLE_MOUNTAIN then
			return "mnt_rubble"
		end
		return "building_rubble"
	end

	-- Mountains
	if terrain == TERRAIN_MOUNTAIN then
		return Board:IsDamaged(point) and "damaged_mountain" or "mountain"
	end

	-- Ice
	if terrain == TERRAIN_ICE then
		if Board:IsAcid(point) then
			return "acid_ice"
		end
		return Board:IsDamaged(point) and "damaged_ice" or "ice"
	end

	-- Acid
	if terrain == TERRAIN_ACID then
		return Board:IsFrozen(point) and "frozen_acid" or "acid"
	end

	-- Lava
	if terrain == TERRAIN_WATER and (Board:IsFire(point) or Board:IsTerrain(point, TERRAIN_LAVA)) then
		return Board:IsFrozen(point) and "lava_ice" or "lava"
	end

	-- Water
	if terrain == TERRAIN_WATER then
		return Board:IsAcid(point) and "acid_water" or "water"
	end

	-- Other basic terrain
	if terrain == TERRAIN_HOLE then return "chasm" end
	if terrain == TERRAIN_SAND then return "sand" end
	if terrain == TERRAIN_ROAD then return "ground" end

	return nil
end

local function EVENT_onModsLoaded()
	modapiext:addPawnPositionChangedHook(function(mission, pawn, oldPosition)	--Make enemies retarget
		if mission == nil or mission.PsionicField_RetargetLocs == nil or mission.PsionicField_RetargetLocs[1] == nil then return end
		if Game:GetTeamTurn() == TEAM_PLAYER and pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsQueued() and (not pawn:IsDead()) and list_contains(mission.PsionicField_RetargetLocs, pawn:GetSpace()) then
			local weaponId = pawn:GetQueuedWeaponId()
			local weapon = _G[pawn:GetQueuedWeapon()]
			if not weapon then return end
			local targetArea = extract_table(weapon:GetTargetArea(pawn:GetSpace()))
			local bestTarget 
			local bestScore = -100
			for i, loc in ipairs(targetArea) do
				local score = weapon:GetTargetScore(pawn:GetSpace(), loc)
				if score > bestScore then
					bestScore = score
					bestTarget = loc
				end
			end
			--maybe do pings here so it's clear that the Queen is commanding this
			if bestTarget then pawn:FireWeapon(bestTarget, weaponId) end
		end
	end)
	local function CapDamage(skillEffect, key)	--implement Invincible, also block fire
		local damageLeft = mod_loader.currentModContent["Meta_AltFinalMissions"].options.Meta_HiveQueenInvincibleThreshold.value
		local foundFire = false
		for _, fx in ipairs(extract_table(skillEffect[key])) do
			local target = Board:GetPawn(fx.loc)
			
			if (target and target:GetType() == "Meta_HiveQueen" and not target:IsDead()) then
				if fx.iFire == EFFECT_CREATE then
					fx.iFire = 0
					fx.sImageMark = "combat/icons/icon_fire_glow.png"
					foundFire = true
				end
				if fx.iDamage > 0 and fx.iDamage ~= DAMAGE_ZERO then 
					if damageLeft <= 0 then
						fx.iDamage = DAMAGE_ZERO
					else
						local factor = target:IsAcid() and 2 or 1
						local allowed = math.floor(damageLeft / factor)

						if fx.iDamage == DAMAGE_DEATH or fx.iDamage * factor > damageLeft then
							fx.iDamage = allowed
							damageLeft = damageLeft - allowed * factor
						else
							damageLeft = damageLeft - fx.iDamage * factor
						end
					end
				end
			end
		end
		if foundFire then
			if key == "effect" then
				skillEffect:AddScript(string.format("Board:GetPawn(%s):SetFire(true)", GetQueen()))
			else
				skillEffect:AddQueuedScript(string.format("Board:GetPawn(%s):SetFire(true)", GetQueen()))
			end
		end
	end
	
	local function BreachPawns(skillEffect, user, key)
		local mission = GetCurrentMission()
		if not mission then return end
		mission.PsionicField_BreachLocs = mission.PsionicField_BreachLocs or {}
		mission.PsionicField_BreachedPawns = mission.PsionicField_BreachedPawns or {}
		local originalEffect = skillEffect[key]
		local dodgeEffect = SkillEffect()
		for _, fx in ipairs(extract_table(skillEffect[key])) do
			local target = Board:GetPawn(fx.loc)
			if list_contains(mission.PsionicField_BreachLocs, fx.loc) and 
			(target and target:GetTeam() == TEAM_ENEMY and not target:IsDead()) and 
			fx.iDamage > 0 and fx.iDamage ~= DAMAGE_ZERO 
			and Board:IsDeadly(fx, user) then
				fx.iDamage = DAMAGE_ZERO
				fx.sImageMark = "advanced/combat/icons/icon_teleport_glow.png"
				dodgeEffect:AddScript(string.format([[
				local target = Board:GetPawn(%s)
				if target then 
					local pos = target:GetSpace()
					Board:AddAnimation(pos, %q, 1)
					target:SetSpace(Point(pos.x + 10, pos.y + 10)) 
					table.insert(GetCurrentMission().PsionicField_BreachedPawns, target:GetId())
				end]],
				target:GetId(), "UnitRift"))
			end
		end
		if dodgeEffect[key]:size() > 0 then
			local combinedEffect = SkillEffect()
			combinedEffect[key]:AppendAll(dodgeEffect[key])
			combinedEffect[key]:AppendAll(originalEffect)
			skillEffect[key] = combinedEffect[key]
		end
	end
	modapiext:addSkillBuildHook(function(mission, pawn, weaponId, p1, p2, skillEffect)
		if not (mission and mission.HiveQueen) then return end
		CapDamage(skillEffect, "effect")
		CapDamage(skillEffect, "q_effect")
		--handle Breached
		BreachPawns(skillEffect, pawn, "effect")
	end)
	modapiext:addFinalEffectBuildHook(function(mission, pawn, weaponId, p1, p2, p3, skillEffect)
		if not (mission and mission.HiveQueen) then return end
		CapDamage(skillEffect, "effect")
		CapDamage(skillEffect, "q_effect")
		--handle Breached
		BreachPawns(skillEffect, pawn, "effect")
	end)
	--no shield or ice; annoying for Invincible, players shouldn't use it on her anyway, and it looks weird on multitile pawns
	modapiext:addPawnIsFrozenHook(function(mission, pawn, isFrozen)
		if pawn and pawn:GetType() == "Meta_HiveQueen" and isFrozen then pawn:SetFrozen(false, true) end
	end)
	modapiext:addPawnIsShieldedHook(function(mission, pawn, isShielded)
		if pawn and pawn:GetType() == "Meta_HiveQueen" and isShielded then pawn:SetShield(false, true) end
	end)
	modapiext:addPawnKilledHook(function(mission, pawn)		--explode
		if not mission then return end
		if not pawn then return end
		if _G[pawn:GetType()].Explodes or pawn:GetTeam() ~= TEAM_ENEMY then return end
		mission.PsionicField_ExplosiveLocs = mission.PsionicField_ExplosiveLocs or {}
		for _, loc in pairs(mission.PsionicField_ExplosiveLocs) do
			if loc == pawn:GetSpace() then
				local bomb = PAWN_FACTORY:CreatePawn("BombRock")
				Board:AddPawn(bomb, loc)
				bomb:SetInvisible(true)
				bomb:Kill(true)	--invisible but still deals 1 true damage
			end
		end
	end)
	modApi:addPreEnvironmentHook(function(mission)	--clear fields before falling rocks and such
		ClearPsionicFields()
	end)
	modApi:addNextTurnHook(function(mission)	--force Hive Queen to act last
		local queen = Board:GetPawn(GetQueen())
		if queen then
			if Game:GetTeamTurn() == TEAM_ENEMY then
				modApi:conditionalHook(
					function()						--wait until Vek have spawned, so queen is added after them
						for _, p in ipairs(Board) do
							if Board:IsSpawning(p) then return false end
						end
						return true
					end,
					function()						--add queen to the board
						local tile = queen:GetSpace()
						Board:RemovePawn(queen)
						Board:AddPawn(queen, tile)
					end
				)
			end
			if mission.Environment == "Env_Final" then
				local ret = {}
				for _, p in ipairs(mission.LiveEnvironment.Locations) do
					if not (Board:GetPawn(p) and Board:GetPawn(p):GetId() == GetQueen()) then ret[#ret+1] = p end
				end
				mission.LiveEnvironment.Locations = ret
			end
		end
	end)
	local oldDesc = ""
	local oldTitle = ""
	local tooltipId = ""
	modapiext:addTileHighlightedHook(function(mission, point)
		local m = GetCurrentMission()
		if m ~= nil and Board:IsPawnAlive(GetQueen()) then
			if m.PsionicField_ExplosiveLocs == nil and m.PsionicField_BreachLocs == nil and m.PsionicField_RetargetLocs == nil then return end
			local desc = "Until the end of the turn, Vek that die on this tile explode.\n"
			local title = "Psionic field (explosive)"
			local iterateOn = ""
			if m.PsionicField_ExplosiveLocs ~= nil and m.PsionicField_ExplosiveLocs[1] then iterateOn = "PsionicField_ExplosiveLocs" end
			if m.PsionicField_BreachLocs ~= nil and m.PsionicField_BreachLocs[1] then 
				iterateOn = "PsionicField_BreachLocs"
				desc = "Until the end of the turn, Vek that die on this tile will be warped through time, returning on the following turn.\n"
				title = "Psionic field (breached)"
			end
			if m.PsionicField_RetargetLocs ~= nil and m.PsionicField_RetargetLocs[1] then 
				iterateOn = "PsionicField_RetargetLocs"
				desc = "Until the end of the turn, Vek on this tile retarget their attack when moved.\n"
				title = "Psionic field (retarget)"
			end
			if iterateOn ~= "" then
				for i, loc in ipairs(m[iterateOn]) do
					if loc == point then
						tooltipId = tileToTooltipId(loc)
						if not tooltipId then return end
						oldTitle = modApi.modLoaderDictionary["Tile_"..tooltipId.."_Title"]
						oldDesc = modApi.modLoaderDictionary["Tile_"..tooltipId.."_Text"]
						modApi.modLoaderDictionary["Tile_"..tooltipId.."_Title"] = title
						modApi.modLoaderDictionary["Tile_"..tooltipId.."_Text"] = desc
					end
				end
			end
		end
	end)
	modapiext:addTileUnhighlightedHook(function(mission, point)
		local m = GetCurrentMission()
		if m ~= nil then
			if m.PsionicField_ExplosiveLocs == nil and m.PsionicField_BreachLocs == nil and m.PsionicField_RetargetLocs == nil then return end
			if oldTitle ~= "" then
				modApi.modLoaderDictionary["Tile_"..tooltipId.."_Title"] = oldTitle
				modApi.modLoaderDictionary["Tile_"..tooltipId.."_Text"] = oldDesc
				tooltipId = ""
				oldTitle = ""
				oldDesc = ""
			end
		end
	end)
	modApi:addVoiceEventHook(function(eventInfo, customOdds, suppress)	--don't say lines related to Renfield bomb when doing something else
		if GAME.Meta_AltFinalMission ~= "Normal" and eventInfo.id == "MissionFinal_BombResponse" then
			suppress = true
			return true
		end
		return false
	end)
end
modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

Meta_FluorousVek = Pawn:new{
	Name = "Fluorous Vek",
	Health = 7,
	Image = "Meta_FluorousVek",
	MoveSpeed = 3,
	SkillList = { "ScorpionAtk2", "ScorpionAtkB" },
	GetWeapon = function()
		local options = mod_loader.currentModContent["Meta_AltFinalMissions"].options
		return options.Meta_FluorousVekHasBossAttack.enabled and 2 or 1
	end,
	SoundLocation = "/enemy/scorpion_soldier_2/",
	DefaultTeam = TEAM_ENEMY,
	Explodes = true,
	Massive = true,
	Portrait = "enemy/GlowingScorpion",
}
AddPawn("Meta_FluorousVek")

Meta_Nuke = Pawn:new{
	Name = "Nuke",
	Health = 12,
	Armor = true,
	Image = "Meta_Nuke",
	MoveSpeed = 0,
	SkillList = { },
	SoundLocation = "/support/bombrock/",
	DefaultTeam = TEAM_NONE,
	Explodes = true,
	ImpactMaterial = IMPACT_METAL,
	IsDeathEffect = true,
	Corpse = true,
	Neutral = true,
	Pushable = false,
	LargeShield = true,
	IsPortrait = false,
}
function Meta_Nuke:GetDeathEffect(point)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(point)
	local mission = GetCurrentMission()
	if pawn and not (Board:IsTerrain(point, TERRAIN_HOLE)) then
		--do voice line?
		GetCurrentMission().TurnLimit = Game:GetTurnCount()
	elseif pawn then 
		pawn:SetCorpse(false)
	end
	return ret
end
AddPawn("Meta_Nuke")

function Mission_Final_Cave:NextTurn()
	--time does not run out if facing the nuke/queen; killing it makes the mission end
	if (GAME.Meta_AltFinalMission == "Nuke" or GAME.Meta_AltFinalMission == "Queen") and Game:GetTeamTurn() == TEAM_PLAYER then GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit + 1 end 
end

function Mission_Final_Cave:MissionEnd()
	local effect = SkillEffect()
	local pawn = PAWN_FACTORY:CreatePawn("BigBomb")
	pawn:SetInvisible(true)
	--game softlocks if there is no bomb on the board
	for index, point in ipairs(Board) do
		if IsBomb(point) then Board:AddPawn(pawn, point) break end
	end
	
	if GAME.Meta_AltFinalMission == "Fluorous" then 
		effect:AddVoice("MissionFinal_MetaFluorousVekReady",PAWN_ID_CEO)
	elseif GAME.Meta_AltFinalMission == "Nuke" then
		effect:AddVoice("MissionFinal_MetaNukeArmed",PAWN_ID_CEO)
	elseif GAME.Meta_AltFinalMission == "Queen" then
		effect:AddVoice("MissionFinal_MetaQueenDying",PAWN_ID_CEO)
	else
		effect:AddVoice("MissionFinal_BombArmed",PAWN_ID_CEO)
	end
	
	Board:LockBomb()
	effect:AddDelay(5.5)
	effect:AddScript("Board:StartMechTravel()")
	
	Board:AddEffect(effect)
	pawn:SetInvisible(true)
	Board:LockBomb()
end

local function SpawnMechs(effect,zone)
	for i = 0,2 do
		local choice = random_removal(zone)
		effect:AddScript("Board:GetPawn("..(i).."):SetSpace("..choice:GetString()..") Board:GetPawn("..(i).."):SpawnAnimation()")
		effect:AddDelay(0.5)
	end
end

function Mission_Final_Cave:UpdateMission() 
	local pawn = Board:GetPawn(GetQueen())
	if pawn then
		local p1 = pawn:GetSpace()
		pawn:SetFlying(true)			--for weapons that remove flying; I made one
		pawn:SetCorpse(true)			--just in case
		for _, offset in ipairs(offsets) do
			local tile = p1 + offset
			-- Board:SetFire(tile, false)
			if Board:GetTerrain(tile) == TERRAIN_WATER or Board:GetTerrain(tile) == TERRAIN_HOLE then
				Board:SetTerrain(tile, TERRAIN_ROAD)
			end
		end
		--graphics
		Board:SetCustomTile(p1 + Point(1, 1), "crack_bottom.png")
		Board:SetCustomTile(p1 + Point(0, 1), "crack_right.png")
		Board:SetCustomTile(p1 + Point(1, 0), "crack_left.png")
	end
end

function Mission_Final_Cave:StartMission()
	local effect = SkillEffect()
	self:GetSpawner():SetSpawnIsland(5)
	LOG("Final mission type: "..GAME.Meta_AltFinalMission)
	if GAME.Meta_AltFinalMission == "Fluorous" then
	--fluorous vek webs already
		self:GetSpawner():ModifyCount("Scorpion",0)
		self:GetSpawner():ModifyCount("Leaper",0)
		self.GlobalSpawnMod = self.GlobalSpawnMod - 1
		self.SpawnStartMod = self.SpawnStartMod - 1
	elseif GAME.Meta_AltFinalMission == "Queen" then
		self.GlobalSpawnMod = self.GlobalSpawnMod - 1
		self.SpawnStartMod = self.SpawnStartMod - 1
	else
		self:GetSpawner():ModifyCount("Scorpion",2)
		self:GetSpawner():ModifyCount("Leaper",2)
	end
	
	local pylons = extract_table(Board:GetZone("pylons"))
	local drop_zone = extract_table(Board:GetZone("deployment"))
	local bomb_loc = random_removal(drop_zone)
	
	if random_int(2) == 0 and GAME.Meta_AltFinalMission ~= "Queen" and GAME.Meta_AltFinalMission ~= "Fluorous" then
		Board:SpawnPawn(self:NextPawn(),bomb_loc)
	end
	
	effect:AddDelay(2)
	effect:AddBoardShake(3)
	
	if GAME.Meta_AltFinalMission ~= "Queen" then	--they can kill the queen otherwise
		local mounts = extract_table(Board:GetZone("mountain"))
		local rock = SpaceDamage(Point(0,0),DAMAGE_DEATH)
		while #mounts > 0 do
			rock.loc = random_removal(mounts)
			rock.iDamage = DAMAGE_DEATH
			Board:BlockSpawn(rock.loc,BLOCKED_TEMP)
			effect:AddDropper(rock,"effects/shotdown_rock.png")
			effect:AddDelay(0.2)
		end
		effect:AddDelay(1)
	end
	
	SpawnMechs(effect,drop_zone)
	
	effect:AddDelay(1)
	
	if not FAST_VERSION then
		effect:AddVoice("MissionFinal_Pylons",PAWN_ID_CEO)
		effect:AddDelay(3)
	end
	
	local building = SpaceDamage(Point(0,0),0)
	building.iTerrain = TERRAIN_BUILDING
	while #pylons > 0 do
		building.loc = random_removal(pylons)
		Board:BlockSpawn(building.loc,BLOCKED_PERM)
		if Board:IsPawnSpace(building.loc) then
			building.iDamage = DAMAGE_DEATH
		end
		effect:AddDropper(building,"combat/tiles_grass/building_fall.png")
		effect:AddDropper(building,"combat/tiles_grass/building_fall.png")
		if not FAST_VERSION then effect:AddDelay(0.5) end
	end
	
	if not FAST_VERSION then
		effect:AddVoice("MissionFinal_Bomb",PAWN_ID_MECH)
		if GAME.Meta_AltFinalMission == "Fluorous" then 
			effect:AddVoice("MissionFinal_MetaFluorousVekResponse",PAWN_ID_CEO) 
			Global_Texts["TipText_BattleVictory_Final"] = "The Fluorous Vek will explode in $1 turns"
			Global_Texts["TipText_BattleVictory_One_Final"] = "The Fluorous Vek will explode in 1 turn"
		elseif GAME.Meta_AltFinalMission == "Nuke" then 
			effect:AddVoice("MissionFinal_MetaNukeResponse",PAWN_ID_CEO)
			Global_Texts["TipText_BattleVictory_Final"] = "The Nuke will explode once it runs out of HP"
			Global_Texts["TipText_BattleVictory_One_Final"] = "The Nuke is about to explode"
		elseif GAME.Meta_AltFinalMission == "Queen" then 
			effect:AddVoice("MissionFinal_MetaQueenResponse",PAWN_ID_CEO)
			Global_Texts["TipText_BattleVictory_Final"] = "The Hive Queen will explode once it runs out of HP"
			Global_Texts["TipText_BattleVictory_One_Final"] = "The Hive Queen is about to explode"
		else
			effect:AddVoice("MissionFinal_BombResponse",PAWN_ID_CEO)
			Global_Texts["TipText_BattleVictory_Final"] = "The bomb will explode in $1 turns"
			Global_Texts["TipText_BattleVictory_One_Final"] = "The bomb will explode in 1 turn"
		end
		effect:AddDelay(7)
	end
	
	effect:AddDelay(2)
	self:AddBomb(effect, bomb_loc)
	
	Board:AddEffect(effect)
	
	Board:SpawnPawn(random_element(self.BossList))
end

function Mission_Final_Cave:UpdateObjectives()
	if GAME.Meta_AltFinalMission == "Fluorous" then 
		Game:AddObjective("Mission_Final_Two_Obj_MetaFluorous",OBJ_STANDARD,REWARD_REP,0)
	elseif GAME.Meta_AltFinalMission == "Nuke" then 
		Game:AddObjective("Mission_Final_Two_Obj_MetaNuke",OBJ_STANDARD,REWARD_REP,0)
	elseif GAME.Meta_AltFinalMission == "Queen" then 
		Game:AddObjective("Mission_Final_Two_Obj_MetaQueen",OBJ_STANDARD,REWARD_REP,0)
	else
		Game:AddObjective("Mission_Final_Two_Obj",OBJ_STANDARD,REWARD_REP,0)
	end
end

function Mission_Final_Cave:AddBomb(effect, bomb_loc)
	if bomb_loc == nil then
		local choices = {}
		
		for i = 0,7 do
			for j = 0,7 do
				local curr = Point(i,j)
				if Board:GetPawnTeam(curr) ~= TEAM_PLAYER and 
					not Board:IsBuilding(curr) and 
					not Board:IsEnvironmentDanger(curr) then
					choices[#choices+1] = curr
				end
			end
		end
		
		if #choices == 0 then
			LOG("This can't happen. There aren't enough player units or buildings")
			bomb_loc = Point(4,4)
		else
			local choice = random_removal(choices)
			
			while #choices > 0 and (choice.x <= 1 or choice.x >= 6 or choice.y <= 1 or choice.y >= 6) do
				choice = random_removal(choices)
			end
			
			bomb_loc = choice
		end
	end
	
	local add_bomb = SpaceDamage(bomb_loc,0)
	add_bomb.sSound = "/props/bomb_impact"
	add_bomb.iTerrain = TERRAIN_ROAD
	if GAME.Meta_AltFinalMission == "Fluorous" then 
		add_bomb.sPawn = "Meta_FluorousVek" 
		effect:AddDropper(add_bomb,"units/mission/FluorousVek.png")
	elseif GAME.Meta_AltFinalMission == "Nuke" then 
		add_bomb.sPawn = "Meta_Nuke" 
		effect:AddDropper(add_bomb,"units/mission/Nuke.png")
	elseif GAME.Meta_AltFinalMission == "Queen" then 
		local queen = PAWN_FACTORY:CreatePawn("Meta_HiveQueen")
		self.HiveQueen = queen:GetId()
		GetCurrentMission().HiveQueen = queen:GetId()
		local flag
		local loc
		local pylons = extract_table(Board:GetZone("pylons"))
		local drop_zone = extract_table(Board:GetZone("deployment"))
		repeat
			loc = Point(math.random(1, 5), math.random(1, 5))
			flag = true
			for i = 1, #pylons do
				if pylons[i] == loc or pylons[i] == loc + Point(0, 1) or pylons[i] == loc + Point(1, 0) or pylons[i] == loc + Point(1, 1) then flag = false end
			end 
			for i = 1, #drop_zone do
				if drop_zone[i] == loc or drop_zone[i] == loc + Point(0, 1) or drop_zone[i] == loc + Point(1, 0) or drop_zone[i] == loc + Point(1, 1) then flag = false end
			end 
		until flag
		Board:AddPawn(queen, loc)
		Board:SetTerrain(loc, TERRAIN_ROAD)
		Board:SetTerrain(loc+Point(0, 1), TERRAIN_ROAD)
		Board:SetTerrain(loc+Point(1, 0), TERRAIN_ROAD)
		Board:SetTerrain(loc+Point(1, 1), TERRAIN_ROAD)
	else
		add_bomb.sPawn = "BigBomb" 
		effect:AddDropper(add_bomb,"units/mission/bomb.png")
	end
end

function IsBomb(point)
	local pawnType
	if GAME.Meta_AltFinalMission == "Fluorous" then 
		pawnType = "Meta_FluorousVek"
	elseif GAME.Meta_AltFinalMission == "Nuke" then 
		pawnType = "Meta_Nuke"
	elseif GAME.Meta_AltFinalMission == "Queen" then 
		pawnType = "Meta_HiveQueen"
	else
		pawnType = "BigBomb"
	end
	if point ~= nil then
		return Board:IsPawnSpace(point) and Board:GetPawn(point):GetType() == pawnType
	else
		local pawns = extract_table(Board:GetPawns(TEAM_ANY))
		for i, v in ipairs(pawns) do
			if Board:GetPawn(v):GetType() == pawnType then return true end
		end
		return false
	end
end