local mod = modApi:getCurrentMod()

local function ModifyCount(pawn, val)
    Spawner.pawn_counts = Spawner.pawn_counts or {}
	Spawner.pawn_counts[pawn] = Spawner.pawn_counts[pawn] or 0
	Spawner.pawn_counts[pawn] = Spawner.pawn_counts[pawn] + val
	
	Spawner.pawn_counts[pawn] = math.max(0,Spawner.pawn_counts[pawn])
end


local old_Spawner_NextPawn = Spawner.NextPawn
function Spawner:NextPawn(pawn_tables)
	GAME.OmegaCount = GAME.OmegaCount or 0
	local options = mod_loader.currentModContent[mod.id].options
	merge_table(options, mod_loader.currentModContent["Meta_OmegaBotsAndBugs"].options)
	merge_table(options, mod_loader.currentModContent["Meta_OmegaVextra"].options)
	local ret = old_Spawner_NextPawn(self, pawn_tables)
	local chance = 0.5
	if _G["Omega"..ret] ~= nil then
		if options["OmegaVek"] ~= nil and options["Omega"..ret:sub(1, -2)] ~= nil then
			if options["Omega"..ret:sub(1, -2)].value ~= "Default" then 
				chance = options["Omega"..ret:sub(1, -2)].value
			else
				chance = options["OmegaVek"].value
			end
		end
		if options["OmegaVekLimit"] ~= nil and options["OmegaVekLimit"].value > 0 then
			if GAME.OmegaCount >= options["OmegaVekLimit"].value then chance = 0 end
		end
		if self.pawn_counts["OmegaDung2"] and self.pawn_counts["OmegaDung2"] > 0 and ret == "Dung2" then chance = 0 end
		if math.random() <= chance then 
			ModifyCount(ret, -1)
			ModifyCount("Omega"..ret, 1)
			GAME.OmegaCount = GAME.OmegaCount + 1
			ret = "Omega"..ret 
		end
	end
	return ret
end

local function EVENT_onModsLoaded()
	modApi:addMissionEndHook(function(mission)
		GAME.OmegaCount = 0
	end)	
	modapiext:addPawnKilledHook(function(mission, pawn)
		GAME.OmegaCount = GAME.OmegaCount or 0
		if not (mission and pawn) then return end
		if pawn:GetType():sub(1, 5) == "Omega" then GAME.OmegaCount = math.max(0, GAME.OmegaCount - 1) end
	end)
end
modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)