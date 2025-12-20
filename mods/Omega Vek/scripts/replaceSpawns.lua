local mod = modApi:getCurrentMod()

local old_Spawner_NextPawn = Spawner.NextPawn
function Spawner:NextPawn(pawn_tables)
	local options = mod_loader.currentModContent[mod.id].options
	merge_table(options, mod_loader.currentModContent["Meta_OmegaVanilla"].options)
	merge_table(options, mod_loader.currentModContent["Meta_OmegaBotsAndBugs"].options)
	local ret = old_Spawner_NextPawn(self, pawn_tables)
	if _G["Omega"..ret] ~= nil then
		if options["OmegaVek"] ~= nil and options["Omega"..ret:sub(1, -2)] ~= nil then
			if options["Omega"..ret:sub(1, -2)].value ~= "Default" then 
				chance = options["Omega"..ret:sub(1, -2)].value
			else
				chance = options["OmegaVek"].value
			end
		else
			chance = 0.5
		end
		if math.random() <= chance then ret = "Omega"..ret end
	end
	return ret
end