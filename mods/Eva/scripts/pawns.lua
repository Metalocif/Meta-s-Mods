-- add color palette
local pathScripts = mod_loader.mods[modApi.currentMod].scriptPath
modApi:addPalette({
		ID = "EVA_Unit_00_palette",
		Name = "Unit 00 Paintjob",
		PlateHighlight = {168, 119, 200},	--lights
		PlateLight     = {245, 158, 5},		--main highlight
		PlateMid       = {221, 75, 6},	--main light
		PlateDark      = {150, 75, 0},		--main mid  {130, 93, 39}
		PlateOutline   = {10, 10, 10},		--main dark
		PlateShadow    = {0, 0, 0},		--metal dark
		BodyColor      = {177, 185, 217},		--metal mid
		BodyHighlight  = {250, 250, 250},	--metal light
})
local palette0 = modApi:getPaletteImageOffset("EVA_Unit_00_palette")
modApi:addPalette({
		ID = "EVA_Unit_01_palette",
		Name = "Unit 01 Paintjob",
		PlateHighlight = {168, 119, 200},	--lights
		PlateLight     = {97, 46, 105},		--main highlight
		PlateMid       = {133, 55, 152},	--main light
		PlateDark      = {56, 34, 78},		--main mid
		PlateOutline   = {9, 22, 27},		--main dark
		PlateShadow    = {0, 0, 0},		--metal dark
		BodyColor      = {107, 127, 173},		--metal mid
		BodyHighlight  = {162, 218, 90},	--metal light
})
local palette1 = modApi:getPaletteImageOffset("EVA_Unit_01_palette")
modApi:addPalette({
		ID = "EVA_Unit_02_palette",
		Name = "Unit 02 Paintjob",
		PlateHighlight = {10, 150, 200},	--lights
		PlateLight     = {252, 56, 40},		--main highlight
		PlateMid       = {252, 56, 40},	--main light
		PlateDark      = {120, 30, 30},		--main mid
		PlateOutline   = {9, 22, 27},		--main dark
		PlateShadow    = {0, 0, 0},		--metal dark
		BodyColor      = {240, 135, 20},		--metal mid
		BodyHighlight  = {168, 119, 200},	--metal light
})
local palette2 = modApi:getPaletteImageOffset("EVA_Unit_02_palette")

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-------------------
-- Cyborg Pilots --
-------------------

local names = {
	"EVA_Unit_00",
	"EVA_Unit_01",
	"EVA_Unit_02",
}
local oldGetSkillInfo = GetSkillInfo
function GetSkillInfo(skill)
	if IsEva then
		IsEva = nil
		if skill == "Survive_Death" then
			return PilotSkill("Evangelion Pilot", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
		end
	end
	return oldGetSkillInfo(skill)
end

	modApi:appendAsset("img/portraits/pilots/Pilot_EVA_Unit_00.png",path.."img/portraits/pilots/Pilot_EVA_Unit_00.png")
	CreatePilot{
		Id = "Pilot_EVA_Unit_00",
		Name = "Rei",
		Personality = "EvaRei",
		Sex = SEX_FEMALE,
		Rarity = 0,
		-- GetSkill = function() IsEvaZero = true; return "Survive_Death" end,
		GetSkill = function() IsEva = true; return "Survive_Death" end,
		Blacklist = {"Invulnerable", "Popular"},
	}
	modApi:appendAsset("img/portraits/pilots/Pilot_EVA_Unit_01.png",path.."img/portraits/pilots/Pilot_EVA_Unit_01.png")
	CreatePilot{
		Id = "Pilot_EVA_Unit_01",
		Name = "Shinji",
		Personality = "EvaShinji",	--"""personality"""
		Sex = SEX_MALE,				--I think this prevents them from uselessly time travelling? interesting behavior though
		Rarity = 0,
		GetSkill = function() IsEva = true; return "Survive_Death" end,
		Blacklist = {"Invulnerable", "Popular"},	--ahahah baka Shinji is not popular
	}
	modApi:appendAsset("img/portraits/pilots/Pilot_EVA_Unit_02.png",path.."img/portraits/pilots/Pilot_EVA_Unit_02.png")
	CreatePilot{
		Id = "Pilot_EVA_Unit_02",
		Name = "Asuka",
		Personality = "EvaAsuka",
		Sex = SEX_FEMALE,
		Rarity = 0,
		-- GetSkill = function() IsEvaTwo = true; return "Survive_Death" end,
		GetSkill = function() IsEva = true; return "Survive_Death" end,
		Blacklist = {"Invulnerable", "Popular"},
	}
--------------
-- Unit 01 ---
--------------

-- locate our mech assets.

-- make a list of our files.
local files = {
	"eva00.png",
	"eva00_a.png",
	"eva00_w.png",
	"eva00_broken.png",
	"eva00_w_broken.png",
	"eva00_ns.png",
	"eva00_h.png",
	"eva01.png",
	"eva01_a.png",
	"eva01_w.png",
	"eva01_broken.png",
	"eva01_w_broken.png",
	"eva01_ns.png",
	"eva01_h.png",
	"eva02.png",
	"eva02_a.png",
	"eva02_w.png",
	"eva02_broken.png",
	"eva02_w_broken.png",
	"eva02_ns.png",
	"eva02_h.png",
}
local mechFilesEnd = {
	".png",
	"_a.png",
	"_w.png",
	"_broken.png",
	"_w_broken.png",
	"_ns.png",
	"_h.png"
}

-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(mechFilesEnd) do
	--modApi:appendAsset("img/units/player/".. file, path .."img/units/player/" .. file)
	for i = 0,2 do
		modApi:appendAsset("img/units/player/eva0"..i.. file, path .."img/units/player/eva0"..i .. file)
	
	
	end
end

modApi:appendAsset("img/units/player/atfield.png", path .."img/units/player/atfield.png")
modApi:appendAsset("img/units/player/atfieldside.png", path .."img/units/player/atfieldside.png")

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.EVA_Unit_00 =				a.MechUnit:new{Image = "units/player/eva00.png", PosX = -33, PosY = -26 }
a.EVA_Unit_00a =			a.MechUnit:new{Image = "units/player/eva00_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_00w =			a.MechUnit:new{Image = "units/player/eva00_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_00_broken =		a.MechUnit:new{Image = "units/player/eva00_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_00w_broken =		a.MechUnit:new{Image = "units/player/eva00_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_00_ns =			a.MechIcon:new{Image = "units/player/eva00_ns.png"}

a.EVA_Unit_01 =				a.MechUnit:new{Image = "units/player/eva01.png"}
a.EVA_Unit_01a =			a.MechUnit:new{Image = "units/player/eva01_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_01w =			a.MechUnit:new{Image = "units/player/eva01_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_01_broken =		a.MechUnit:new{Image = "units/player/eva01_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_01w_broken =		a.MechUnit:new{Image = "units/player/eva01_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_01_ns =			a.MechIcon:new{Image = "units/player/eva01_ns.png"}

a.EVA_Unit_02 =				a.MechUnit:new{Image = "units/player/eva02.png", PosX = -33, PosY = -26 }
a.EVA_Unit_02a =			a.MechUnit:new{Image = "units/player/eva02_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_02w =			a.MechUnit:new{Image = "units/player/eva02_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_02_broken =		a.MechUnit:new{Image = "units/player/eva02_a.png", PosX = -33, PosY = -26, NumFrames = 4 }
a.EVA_Unit_02w_broken =		a.MechUnit:new{Image = "units/player/eva02_w.png", PosX = -31, PosY = -15 }
a.EVA_Unit_02_ns =			a.MechIcon:new{Image = "units/player/eva02_ns.png"}

a.EVA_ATField = 			a.BaseUnit:new{Image = "units/player/atfield.png", PosX = -18, PosY = -1, Height = 1}
a.EVA_ATFielda = 			a.EVA_ATField:new{Image = "units/player/atfield.png", PosX = -18, PosY = -1, NumFrames = 1, Time = 0.09, Height = 1	}
a.EVA_ATFieldd = 			a.EVA_ATField:new{Image = "units/player/atfield.png", PosX = -18, PosY = -1, NumFrames = 1, Time = 0.09, Loop = false}
-- a.EVA_ATFielde = 			a.EVA_ATField:new{Image = "units/atfield.png", PosX = -18, PosY = -1, Height = 1, NumFrames = 1, Time = 0.09, Loop = false}
a.EVA_ATFieldSide = 			a.BaseUnit:new{Image = "units/player/atfieldside.png", PosX = -18, PosY = -1, Height = 1}
a.EVA_ATFieldSidea = 			a.EVA_ATField:new{Image = "units/player/atfieldside.png", PosX = -18, PosY = -1, NumFrames = 1, Time = 0.09, Height = 1	}
a.EVA_ATFieldSided = 			a.EVA_ATField:new{Image = "units/player/atfieldside.png", PosX = -18, PosY = -1, NumFrames = 1, Time = 0.09, Loop = false}

EVA_Unit_00 = Pawn:new {
	Name = "Unit 00",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Image = "EVA_Unit_00",
	ImageOffset = palette0,
	SkillList = { "EVA_SniperRifle" },
	SoundLocation = "/enemy/burnbug_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Massive = true,
	CanBerserk = true,
}
AddPawnName("EVA_Unit_00")
EVA_Unit_01 = Pawn:new {
	Name = "Unit 01",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Image = "EVA_Unit_01",
	ImageOffset = palette1,
	SkillList = { "EVA_ProgKnife" },
	SoundLocation = "/enemy/burnbug_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Massive = true,
	CanBerserk = true,
}
AddPawnName("EVA_Unit_01")
EVA_Unit_02 = Pawn:new {
	Name = "Unit 02",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Image = "EVA_Unit_02",
	ImageOffset = palette2,
	SkillList = { "EVA_SonicGlaive", "EVA_NeedleRacks" },
	SoundLocation = "/enemy/burnbug_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Massive = true,
	CanBerserk = true,
}
AddPawnName("EVA_Unit_02")

local function EVENT_onModsLoaded()
	modApi:addNextTurnHook(function(mission)
		local mission = GetCurrentMission()
		if mission and not mission.deadEvaList then mission.deadEvaList = {} end
		for i = 0, 2 do
			local Eva = Board:GetPawn(i)
			if (Eva and Eva:IsDead() and _G[Eva:GetType()].CanBerserk) or mission.deadEvaList[i] then
				mission.deadEvaList[i] = true
				--if Eva:IsDead() then Eva:SetHealth(10) end
				--we no longer do that because we just animate a corpse now, Djinn's brilliant idea
				local point = Eva:GetSpace()
				local pawnList = extract_table(Board:GetPawns(TEAM_ENEMY))
				local closestSpace = Point(1000, 1000)
				LOG("there are "..#pawnList.." enemies on the board")
				if #pawnList == 0 then break end
				local someId
				for i = 1, #pawnList do
					--local closestUnit = Board:GetPawn(someId)
					local unit = Board:GetPawn(pawnList[i])
					for dir = DIR_START, DIR_END do
						local space = unit:GetSpace() + DIR_VECTORS[dir]
						if Board:IsValid(space) and not Board:IsBlocked(space, PATH_GROUND) and not Board:GetPawn(space) and space:Manhattan(point) < closestSpace:Manhattan(point) then
						--if on the board, can stand on, empty, and closer than the previous best result
							closestSpace = space
							someId = pawnList[i]
						end
					end
				end
				LOG(closestSpace:GetString())
				LOG(closestSpace:Manhattan(point))
				if closestSpace:Manhattan(point) <= 5 then
					local has_value
					for index, value in ipairs(extract_table(Board:GetReachable(point, 3, Eva:GetPathProf()))) do
						if value == closestSpace then has_value = true end
					end
					local ret = SkillEffect()
					if not has_value then 
						Eva:SetJumper(true) 	
						ret:AddSound("/weapons/boosters")
						Board:AddEffect(ret)
					end
					Eva:SetHealth(1)
					Eva:SetActive(true)
					Eva:Move(closestSpace)
					if not has_value then 
						ret = SkillEffect()
						ret:AddBurst(landing,"Emitter_Burst_$tile",DIR_NONE)
						ret:AddBounce(landing,3)
						ret:AddSound("/impact/generic/mech")
						Board:AddEffect(ret)
					end
					local damage = 2 + Game:GetSector()
					Board:DamageSpace(SpaceDamage(Board:GetPawn(someId):GetSpace(), damage))
					--damage proportional to island
					Eva:SetHealth(0)
					Eva:SetJumper(false)
				end
				--we check the target is within X tiles, as even berserk Evas don't have infinite movement
				--if we can't reach it, jump instead of running, this also guarantees we don't jump for a single tile
				--briefly become alive as otherwise Move() doesn't work
			end
		end
	end)

	modapiext:addSkillBuildHook(function(mission, pawn, weaponId, p1, p2, skillEffect)
		if pawn and string.sub(pawn:GetType(), 1, -2) == "EVA_Unit_0" and tostring(weaponId) == "Skill_Repair" and p1 ~= p2 then
		--If an EVA is trying to repair and it's not self-targeted, make an AT Field
			local spawner = SpaceDamage(p2, 0)
			local direction = GetDirection(p2 - p1)
			local mission = GetCurrentMission()
			local EvaNumber = string.sub(pawn:GetType(), -1, -1)	--the last character, either 0, 1 or 2, serves as the index in that list
			if mission and not mission.lastTurnATFieldList then mission.lastTurnATFieldList = {-1, -1, -1} end
			-- this initializes a list of last turn AT Field was used; since it was used on turn -1, it's fine even on the first move
			--if initialized to 0, this doesn't work on the first action (move/skill) for some reason
			if direction == DIR_UP or direction == DIR_DOWN then
				spawner.sPawn = "EVA_ATField"
			else
				spawner.sPawn = "EVA_ATFieldSide"
			end
			--they're the same pawn, this is just to have different graphics, essentially _U and _R
			skillEffect:AddDamage(spawner)
			skillEffect:AddDamage(SoundEffect(p2, "weapons/localized_burst"))
			if mission.lastTurnATFieldList[EvaNumber] < Game:GetTurn() then 
				skillEffect:AddScript(pawn:SetActive(true)) 
				mission.lastTurnATFieldList[EvaNumber] = Game:GetTurn()
			end
			--update last turn this was used so we can't blanket the map in AT Fields
		end
	end)
	
	modapiext:addTargetAreaBuildHook(function(mission, pawn, weaponId, p1, targetArea)
	--this should say 'if it is any eva', using string.sub or something
		if pawn and string.sub(pawn:GetType(), 1, -2) == "EVA_Unit_0" and tostring(weaponId) == "Skill_Repair" then
		--If an EVA is trying to repair, let it target adjacent empty tiles, which would make an AT Field, see hook above
			for dir = DIR_START, DIR_END do
				local point = Point(p1 + DIR_VECTORS[dir])
				if Board:IsValid(point) and not Board:IsBlocked(point, PATH_PROJECTILE) then targetArea:push_back(point) end
			end
			
		end
	end)
	
	modapiext:addPawnPositionChangedHook(function(mission, pawn, oldPosition)
		if mission.ID == "Mission_LelielBoss" then --triggers often so we want to get out ASAP if not relevant
			local pawnList = extract_table(Board:GetPawns(TEAM_ENEMY))
			local lelielPos
			for i = 1, #pawnList do
				if Board:GetPawn(pawnList[i]):GetType() == "EVA_LelielBoss" then lelielPos = Board:GetPawn(pawnList[i]):GetSpace() break end
			end
			if lelielPos and lelielPos:Manhattan(oldPosition) == 1 then
				pawn:SetCustomAnim(_G[pawn:GetType()].Image)
				pawn:SetMoveSpeed(2)
			end
		end
	end)
end

EVA_ATField = {
	Name = "AT Field",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Image = "EVA_ATField",
	IsPortrait = false,
	DefaultTeam = TEAM_PLAYER,
	Flying = true,
	Pushable = false,
	IgnoreFire = true,
	ImpactMaterial = IMPACT_SHIELD,
	TempUnit = true,
}
AddPawn("EVA_ATField")
EVA_ATFieldSide = {
	Name = "AT Field",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Image = "EVA_ATFieldSide",
	IsPortrait = false,
	DefaultTeam = TEAM_PLAYER,
	Flying = true,
	Pushable = false,
	IgnoreFire = true,
	ImpactMaterial = IMPACT_SHIELD,
	TempUnit = true,
}
AddPawn("EVA_ATFieldSide")

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
