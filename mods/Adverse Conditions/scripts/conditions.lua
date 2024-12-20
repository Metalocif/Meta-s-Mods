local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

modifiers = modifiers or {
	"ForestFire", 
	"IceIsLava", 
	"CrackHalfTile", 
	"Tyrant",
	"WaterIsChasms",
	"AcidHurts",
	"HealthyPsions",
	"VekLeaveCorpses",
	"LongerMissions",
	"ShorterMissions",
	"BigBuildings",
	"Mech1LowHP",
	"Mech2LowHP",
	"Mech3LowHP",
	"NoShields",
}
modifiersText = modifiersText or {
	"All forests are on fire.", 
	"All ice is lava.", 
	"50% of tiles are cracked.", 
	"Every second turn, mechs take 1 damage.",
	"All water is chasms.",
	"Applying A.C.I.D. damages your pawns.",
	"All Psions have +1 HP.",
	"Vek leave a corpse when they die.",
	"All missions are 1 turn longer.",
	"All missions are 1 turn shorter.",
	"All buildings have 4 health.",
	"Your first mech starts battle with 1 HP.",
	"Your second mech starts battle with 1 HP.",
	"Your third mech starts battle with 1 HP.",
	"Mechs cannot be shielded.",
}
modifiersValidation = modifiersValidation or {
	function() return true end,		--could check whether Archive and Pinnacle were done? But Meridia/Nautilus... Look at tilesets?
	function() return true end,		--could check whether Pinnacle was done?
	function() return true end,
	function() return true end,
	function() return true end,
	function() return true end,
	function() return true end,
	function() return true end,
	function() return not GAME.MetaModifiers.ShorterMissions end,
	function() return not GAME.MetaModifiers.LongerMissions end,
	function() return true end,		--does that work with pylons?
	function() return true end,
	function() return true end,
	function() return true end,
	function() return true end,
}

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


local function ChooseCondition(corporation, island)
	LOG(Game:GetSector(), tostring(options.SectorsToAddConditions.value[Game:GetSector()]))
	if options.SectorsToAddConditions and options.SectorsToAddConditions.value[Game:GetSector()] then 
		GAME.MetaModifiers = GAME.MetaModifiers or {}
		chosenModifiers = {}
		chosenModifiersText = {}
		for count = 1, 3 do
		 local i
		 repeat			
			i = math.random(1, tablelength(modifiers))
		 until modifiersValidation[i]
		 chosenModifiers[tablelength(chosenModifiers)+1] = modifiers[i]
		 chosenModifiersText[tablelength(chosenModifiersText)+1] = modifiersText[i]
		 LOG(modifiers[i], modifiersText[i])
		 modifiers[i] = nil
		 modifiersText[i] = nil
		 modifiersValidation[i] = nil
		end
			
		sdlext.showAlertDialog(
			"Choose your next modifier.",
			"Choose which of the following modifiers will apply to the rest of the run.",
			function(buttonIndex) GAME.MetaModifiers[chosenModifiers[buttonIndex]] = true end, 1200, 400, chosenModifiersText[1],chosenModifiersText[2],chosenModifiersText[3])
	end
end



local function ConditionNoShields(mission, pawn, isShield)
	if not GAME.MetaModifiers.NoShields then return end
	if isShield and pawn:IsMech() then pawn:SetShield(false, true) end
end

local function ConditionTyrant(mission)
	if not GAME.MetaModifiers.Tyrant then return end
	if not Game:GetTurnCount() % 2 == 0 then return end
	local ret = SkillEffect()
	for i = 0, 2 do
		local damage = SpaceDamage(p1, 1)
		damage.sSound = "/props/tentacle"
		damage.sAnimation = "PsionAttack_Back"
		ret:AddDamage(damage)
		local damageAnim = SpaceDamage(p2, 0)
		damageAnim.sAnimation = "PsionAttack_Front"	-- anim has two halves so we get both animations for tentacles
		ret:AddDamage(damageAnim)
		ret:AddDelay(0.2)
	end
	Board:AddEffect(ret)
end

local function ConditionLongerMissionsShorterMissions(mission)
	if GAME.MetaModifiers.LongerMissions then mission.TurnLimit = mission.TurnLimit + 1 end
	if GAME.MetaModifiers.ShorterMissions then mission.TurnLimit = mission.TurnLimit - 1 end
end

local function ConditionIceIsLava(mission)
	if not GAME.MetaModifiers.IceIsLava then return end
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_ICE then Board:SetTerrain(Point(i, j), TERRAIN_LAVA) end
		end
	end
end

local function ConditionForestFire(mission)
	if not GAME.MetaModifiers.ForestIsFire then return end
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_FOREST then Board:DamageSpace(SpaceDamage(Point(i, j), 1)) end
		end
	end
end

local function ConditionWaterIsChasms(mission)
	if not GAME.MetaModifiers.WaterIsChasms then return end
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_WATER and not Board:GetTerrain(Point(i, j)) == TERRAIN_LAVA then Board:SetTerrain(Point(i, j), TERRAIN_HOLE) end
		end
	end
end

local function ConditionCrackHalfTile(mission)
	if not GAME.MetaModifiers.CrackHalfTile then return end
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_ROAD and math.random() > 0.5 then Board:Crack(Point(i, j)) end
		end
	end
end

local function ConditionBigBuildings(mission)
	if not GAME.MetaModifiers.BigBuildings then return end
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_BUILDING then Board:SetHealth(Point(i, j), 4, 4) end
		end
	end
end

local function ConditionMech1LowHP(mission)
	if not GAME.MetaModifiers.Mech1LowHP then return end
	if Board:GetPawn(0) then Board:GetPawn(0):SetHealth(1) end
end

local function ConditionMech2LowHP(mission)
	if not GAME.MetaModifiers.Mech2LowHP then return end
	if Board:GetPawn(1) then Board:GetPawn(1):SetHealth(1) end
end

local function ConditionMech3LowHP(mission)
	if not GAME.MetaModifiers.Mech3LowHP then return end
	if Board:GetPawn(2) then Board:GetPawn(2):SetHealth(1) end
end

local function ConditionHealthyPsions(mission, pawn)
	--maybe this doesn't work on mission start?	
	if not GAME.MetaModifiers.HealthyPsions then return end
	if string.match(pawn:GetType(), "Jelly") then 
		pawn:SetMaxHealth(pawn:GetMaxHealth() + 1)
		pawn:SetHealth(pawn:GetMaxHealth())
	end
end

local function EVENT_onModsLoaded()
	modApi:addPostIslandSelectionHook(ChooseCondition)
	
	modapiext:addPawnIsShieldedHook(ConditionNoShields)
	modApi:addPreEnvironmentHook(ConditionTyrant)
	modApi:addMissionStartHook(ConditionLongerMissionsShorterMissions)
	modApi:addMissionStartHook(ConditionIceIsLava)
	modApi:addMissionStartHook(ConditionForestFire)
	modApi:addMissionStartHook(ConditionWaterIsChasms)
	modApi:addMissionStartHook(ConditionCrackHalfTile)
	modApi:addMissionStartHook(ConditionBigBuildings)
	modApi:addMissionStartHook(ConditionMech1LowHP)
	modApi:addMissionStartHook(ConditionMech2LowHP)
	modApi:addMissionStartHook(ConditionMech3LowHP)
	modapiext:addPawnTrackedHook(ConditionHealthyPsions)
	-- modapiext:addPawnTrackedHook(ConditionVekLeaveCorpses)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


