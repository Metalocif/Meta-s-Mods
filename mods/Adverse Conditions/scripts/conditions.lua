local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

baseModifiers = {
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
	"NoRepairs",
}
baseModifiersText = {
	"All forests are on fire.", 
	"All ice is lava.", 
	"50% of tiles are cracked.", 
	"Every second turn, mechs take 1 damage.",
	"All water is chasms.",
	"Applying A.C.I.D. damages your pawns.",
	"Psions are shielded.",
	"Vek leave a corpse when they die.",
	"All missions are 1 turn longer.",
	"All missions are 1 turn shorter.",
	"All buildings have 4 health.",
	"Your first mech starts with 1 HP.",
	"Your second mech starts with 1 HP.",
	"Your third mech starts with 1 HP.",
	"Mechs cannot be shielded.",
	"Mechs do not repair between missions.",
}
baseModifiersValidation = {
	function() return not GAME.MetaModifiers.ForestFire end,		--could check whether Archive and Pinnacle were done? But Meridia/Nautilus... Look at tilesets?
	function() return not GAME.MetaModifiers.IceIsLava end,		--could check whether Pinnacle was done?
	function() return not GAME.MetaModifiers.CrackHalfTile end,
	function() return not GAME.MetaModifiers.Tyrant end,
	function() return not GAME.MetaModifiers.WaterIsChasms end,
	function() return not GAME.MetaModifiers.AcidHurts end,
	function() return not GAME.MetaModifiers.HealthyPsions end,
	function() return not GAME.MetaModifiers.VekLeaveCorpses end,
	function() return not (GAME.MetaModifiers.ShorterMissions or GAME.MetaModifiers.LongerMissions) end,
	function() return not (GAME.MetaModifiers.ShorterMissions or GAME.MetaModifiers.LongerMissions) end,
	function() return not GAME.MetaModifiers.BigBuildings end,		--does that work with pylons?
	function() return not (GAME.MetaModifiers.NoRepairs or GAME.MetaModifiers.Mech1LowHP) end,
	function() return not (GAME.MetaModifiers.NoRepairs or GAME.MetaModifiers.Mech2LowHP) end,
	function() return not (GAME.MetaModifiers.NoRepairs or GAME.MetaModifiers.Mech3LowHP) end,
	function() return not GAME.MetaModifiers.NoShields end,
	function() return not (GAME.MetaModifiers.Mech1LowHP or GAME.MetaModifiers.Mech2LowHP or GAME.MetaModifiers.Mech3LowHP or GAME.MetaModifiers.NoRepairs) end,
}

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


local function ChooseCondition(corporation, island)
	GAME.MetaModifiers = GAME.MetaModifiers or {}
	modifiers = modifiers or baseModifiers
	modifiersText = modifiersText or baseModifiersText
	modifiersValidation = modifiersValidation or baseModifiersValidation
	LOG(Game:GetSector(), tostring(options.SectorsToAddConditions.value[Game:GetSector()]))
	if options.SectorsToAddConditions and options.SectorsToAddConditions.value[Game:GetSector()] then 
		chosenModifiers = {}
		chosenModifiersText = {}
		for count = 1, 3 do
		 local i
		 local OK = false
		 repeat			
			i = math.random(1, tablelength(modifiers))
			if modifiersValidation[i] then 
				OK = true 
			else 
				modifiers[i] = nil
				modifiersText[i] = nil
				modifiersValidation[i] = nil
			end
			if tablelength(modifiers) == 0 then 
				modifiers = baseModifiers
				modifiersText = baseModifiersText
				modifiersValidation = baseModifiersValidation
			end
		 until OK
		 chosenModifiers[tablelength(chosenModifiers)+1] = modifiers[i]
		 chosenModifiersText[tablelength(chosenModifiersText)+1] = modifiersText[i]
		 LOG(modifiers[i], modifiersText[i])
		 
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
	if not (Game:GetTurnCount() % 2 == 0) then return end
	local ret = SkillEffect()
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and Board:IsValid(pawn:GetSpace()) then
			local damage = SpaceDamage(pawn:GetSpace(), 1)
			damage.sSound = "/props/tentacle"
			damage.sAnimation = "PsionAttack_Back"
			ret:AddDamage(damage)
			local damageAnim = SpaceDamage(pawn:GetSpace(), 0)
			damageAnim.sAnimation = "PsionAttack_Front"	-- anim has two halves so we get both animations for tentacles
			ret:AddDamage(damageAnim)
		end
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
	if not GAME.MetaModifiers.ForestFire then return end
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
			if Board:GetTerrain(Point(i, j)) == TERRAIN_WATER then Board:SetTerrain(Point(i, j), TERRAIN_HOLE) end
		end
	end
end

local function ConditionCrackHalfTile(mission)
	if not GAME.MetaModifiers.CrackHalfTile then return end
	local ret = SkillEffect()
	for i = 0, 7 do
		for j = 0, 7 do
			if Board:GetTerrain(Point(i, j)) == TERRAIN_ROAD and math.random() > 0.5 then 
				local damage = SpaceDamage(Point(i, j))
				damage.iCrack = EFFECT_CREATE  
				ret:AddDamage(damage)
				ret:AddBurst(Point(i, j),"Emitter_Crack_Start",DIR_NONE)
				ret:AddBounce(Point(i, j),-2)
			end
		end
	end
	ret:AddSound("/weapons/crack_ko")
	Board:AddEffect(ret)
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

local function ConditionNoRepairsStoreHP(mission)
	if not GAME.MetaModifiers.NoRepairs then return end
	GAME.MetaModifiers.NoRepairsTable = GAME.MetaModifiers.NoRepairsTable or {}
	for i = 0, 2 do
		local mech = Board:GetPawn(i)
		if mech then GAME.MetaModifiers.NoRepairsTable[i] = mech:GetHealth() else GAME.MetaModifiers.NoRepairsTable[i] = 1 end
	end
	LOG("stored no repairs HP")
end

local function ConditionNoRepairsRetrieveHP(mission)
	if not GAME.MetaModifiers.NoRepairs then return end
	if GAME.MetaModifiers.NoRepairsTable == nil then return end
	for i = 0, 2 do
		local mech = Board:GetPawn(i)
		if mech then mech:SetHealth(GAME.MetaModifiers.NoRepairsTable[i]) end
	end
end

local function ConditionHealthyPsions(mission, pawn)
	--maybe this doesn't work on mission start?	
	if not GAME.MetaModifiers.HealthyPsions then return end
	if string.match(pawn:GetType(), "Jelly") then 
		pawn:SetShield(true)
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
	modApi:addMissionStartHook(ConditionNoRepairsRetrieveHP)
	modApi:addMissionEndHook(ConditionNoRepairsStoreHP)
	modapiext:addPawnTrackedHook(ConditionHealthyPsions)
	-- modapiext:addPawnTrackedHook(ConditionVekLeaveCorpses)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


