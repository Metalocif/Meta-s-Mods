local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

-- final mission phase 2 is longer?
-- don't make healthy psions if Permanent Psions is enabled
-- don't make Vek leave corpses if Permanent Psions is using the necro psions

local function hasModifier(id)
	return GAME ~= nil and GAME.MetaModifiers ~= nil and GAME.MetaModifiers[id] == true
end

local modifiers = {
	{
		id = "ForestFire",
		text = "All forests are on fire.",
		valid = function() return not hasModifier("ForestFire") end,
	},
	{
		id = "IceIsLava",
		text = "All ice is lava.",
		valid = function() return not hasModifier("IceIsLava") end,
	},
	{
		id = "CrackHalfTile",
		text = "50% of tiles are cracked.",
		valid = function() return not hasModifier("CrackHalfTile") end,
	},
	{
		id = "Tyrant",
		text = "Every second turn, mechs take 1 damage.",
		valid = function() return not hasModifier("Tyrant") end,
	},
	{
		id = "WaterIsChasms",
		text = "All water is chasms.",
		valid = function() return not hasModifier("WaterIsChasms") end,
	},
	{
		id = "AcidHurts",
		text = "Applying A.C.I.D. damages your pawns.",
		valid = function() return not hasModifier("AcidHurts") end,
	},
	{
		id = "HealthyPsions",
		text = "Psions are shielded.",
		valid = function()
			return not (hasModifier("HealthyPsions")
				or mod_loader.currentModContent["Meta_PermanentPsions"] ~= nil)
		end,
	},
	{
		id = "VekLeaveCorpses",
		text = "Vek leave a corpse when they die.",
		valid = function() return not hasModifier("VekLeaveCorpses") end,
	},
	{
		id = "LongerMissions",
		text = "All missions are 1 turn longer.",
		valid = function()
			return not (hasModifier("LongerMissions") or hasModifier("ShorterMissions"))
		end,
	},
	{
		id = "ShorterMissions",
		text = "All missions are 1 turn shorter.",
		valid = function()
			return not (hasModifier("LongerMissions") or hasModifier("ShorterMissions"))
		end,
	},
	{
		id = "BigBuildings",
		text = "All buildings have 4 health.",
		valid = function() return not hasModifier("BigBuildings") end,	-- does that work with pylons?
	},
	{
		id = "Mech1LowHP",
		text = "Your first mech starts with 1 HP.",
		valid = function() return not (hasModifier("NoRepairs") or hasModifier("Mech1LowHP")) end,
	},
	{
		id = "Mech2LowHP",
		text = "Your second mech starts with 1 HP.",
		valid = function() return not (hasModifier("NoRepairs") or hasModifier("Mech2LowHP")) end,
	},
	{
		id = "Mech3LowHP",
		text = "Your third mech starts with 1 HP.",
		valid = function() return not (hasModifier("NoRepairs") or hasModifier("Mech3LowHP")) end,
	},
	{
		id = "NoShields",
		text = "Mechs cannot be shielded.",
		valid = function() return not hasModifier("NoShields") end,
	},
	{
		id = "NoRepairs",
		text = "Mechs do not repair between missions.",
		valid = function()
			return not (hasModifier("Mech1LowHP") or hasModifier("Mech2LowHP")
				or hasModifier("Mech3LowHP") or hasModifier("NoRepairs"))
		end,
	},
	{
		id = "ExplosiveBuildings",
		text = "Destroyed buildings explode.",
		valid = function() return not hasModifier("ExplosiveBuildings") end,
	},
	{
		id = "LongerFinalPhase",
		text = "The final battle is 1 turn longer.",
		valid = function() return not hasModifier("LongerFinalPhase") end,
	},
}

local function ChooseCondition(corporation, island)
	GAME.MetaModifiers = GAME.MetaModifiers or {}
	if not (options.SectorsToAddConditions and options.SectorsToAddConditions.value[Game:GetSector()]) then return end

	local pool = {}
	for _, modifier in ipairs(modifiers) do
		if modifier.valid() then pool[#pool + 1] = modifier end
	end

	local offerCount = math.min(3, #pool)
	if offerCount == 0 then return end

	for n = 1, offerCount do
		local j = math.random(n, #pool)
		pool[n], pool[j] = pool[j], pool[n]
	end

	local ids, texts = {}, {}
	for n = 1, offerCount do
		ids[n] = pool[n].id
		texts[n] = pool[n].text
	end

	sdlext.showAlertDialog(
		"Choose your next modifier.",
		"Choose which of the following modifiers will apply to the rest of the run.",
		function(buttonIndex)
			local id = ids[buttonIndex]
			if id then GAME.MetaModifiers[id] = true end
		end,
		1200, 400, unpack(texts))
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
		if mech and not mech:IsDead() then GAME.MetaModifiers.NoRepairsTable[i] = mech:GetHealth() else GAME.MetaModifiers.NoRepairsTable[i] = 1 end
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
	-- maybe this doesn't work on mission start?	
	if not GAME.MetaModifiers.HealthyPsions then return end
	if string.match(pawn:GetType(), "Jelly") then 
		pawn:SetShield(true)
	end
end

local function ConditionExplosiveBuildings(mission, buildingData)
	if not GAME.MetaModifiers.ExplosiveBuildings then return end
	if not (Game:GetTurnCount() > 0) then return end
	-- some missions "destroy" a building to spawn unique buildings
	Board:AddAnimation(buildingData.loc, "explo_fire1", ANIM_NO_DELAY)
	for dir = DIR_START, DIR_END do
		local exploDamage = SpaceDamage(buildingData.loc + DIR_VECTORS[dir], 1)
		exploDamage.sAnimation = "exploout2_"..dir
		if Board:IsValid(buildingData.loc + DIR_VECTORS[dir]) then Board:DamageSpace(exploDamage) end
	end
end

local function ConditionLongerFinalPhase(prevMission, nextMission)
	if not GAME.MetaModifiers.LongerFinalPhase then return end
	modApi:conditionalHook(function()
		return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() == nextMission
	end, 
	function()
		GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit + 1
	end)
end

local function ConditionVekLeaveCorpses(mission, pawn)
	if not GAME.MetaModifiers.VekLeaveCorpses then return end
	pawn:SetCorpse(true)
end

local function ConditionAcidHurts(mission, pawn, isAcid)
	if not GAME.MetaModifiers.AcidHurts then return end
	if pawn:IsMech() and isAcid then pawn:SetHealth(pawn:GetHealth() - 1) end
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
	modapiext:addBuildingDestroyedHook(ConditionExplosiveBuildings)
	modapiext:addPawnTrackedHook(ConditionVekLeaveCorpses)
	modapiext:addPawnIsAcidHook(ConditionAcidHurts)
	modApi:addMissionNextPhaseCreatedHook(ConditionLongerFinalPhase)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


