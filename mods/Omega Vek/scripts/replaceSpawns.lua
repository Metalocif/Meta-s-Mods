local mod = modApi:getCurrentMod()

-- local function HOOK_MissionStart()
	-- LOG("replacing Omega Vek")
	-- if GetCurrentMission() == nil then LOG("no mission") end
	-- if GetCurrentMission():GetSpawner() == nil then LOG("no spawner") end
	-- if GetCurrentMission():GetSpawner().max_pawns == nil then LOG("no pawns") end
	-- for name, maxCount in ipairs(GetCurrentMission():GetSpawner().max_pawns) do
		-- LOG(name, maxCount)
		-- if _G["Omega"..name] ~= nil then --and math.random() > 0.5
			-- self.GetSpawner().max_pawns["Omega"..name] = self.GetSpawner().max_pawns.name 
			-- self.GetSpawner().max_pawns.name = 0 
			-- LOG("replaced "..name.." with Omega version")
		-- end
	-- end
-- end

local function HOOK_MissionStart(mission)
	local options = mod_loader.currentModContent[mod.id].options
	for _, tile in ipairs(Board) do
		local pawn = Board:GetPawn(tile)
		if pawn and pawn:GetTeam() == TEAM_ENEMY and _G["Omega"..pawn:GetType()] ~= nil then
			if options["OmegaVek"] ~= nil then
				if options["Omega"..pawn:GetType():sub(1, -2)].value ~= "Default" then 
					chance = options["Omega"..pawn:GetType():sub(1, -2)].value
				else
					chance = options["OmegaVek"].value
				end
			else
				chance = 0.5
			end
			if math.random() <= chance then
				Board:RemovePawn(tile)
				Board:AddPawn("Omega"..pawn:GetType(), tile)
				Board:GetPawn(tile):SpawnAnimation()
			end
		end
	end
end

local function HOOK_VekSpawnAdded(mission, spawnData)
	local options = mod_loader.currentModContent[mod.id].options
	local vekType = spawnData.type
	if _G["Omega"..vekType] ~= nil then
		if options["OmegaVek"] then
			if options["Omega"..vekType:sub(1, -2)].value ~= "Default" then 
				chance = options["Omega"..vekType:sub(1, -2)].value
			else
				chance = options["OmegaVek"].value
			end
		else
			chance = 0.5
		end
		if math.random() <= chance then
			mission:RemoveSpawnPoint(spawnData.location)
			
			modApi:runLater(function()
				GetCurrentMission():SpawnPawn(spawnData.location, "Omega"..vekType)
			end)
			local fx = SkillEffect()
			fx:AddDelay(0.1)
			Board:AddEffect(fx)
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addMissionStartHook(HOOK_MissionStart)			--add Omega Vek at start of battle
	modApi:addVekSpawnAddedHook(HOOK_VekSpawnAdded)			--replace spawns with Omega Vek	
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)