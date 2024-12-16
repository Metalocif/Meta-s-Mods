local description = "Adds another cyborg squad."

local mod = {
	id = "Meta_SecretSquad4",
	name = "Secret Squad 4",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
	},
	modApiVersion = "2.9.2",
	icon = "mod_icon.png",
	description = description,
	--metadata = metadata,
}


function mod:init()
	require(self.scriptPath .."firefly")
	require(self.scriptPath .."spider")
	require(self.scriptPath .."blobberFMW")
	require(self.scriptPath .."pawns")

end

function doFlyingGraphics()
	if GetCurrentMission() ~= nil then DoSaveGame() end
	for id = 0, 2 do
		local pawn = Game:GetPawn(id)
		if pawn and _G[pawn:GetType()].MaxLevelFlyingGraphics ~= nil and GameData ~= nil and GameData.current["pilot"..id] ~= nil and GameData.current["pilot"..id].level == 2 then 
			pawn:SetFlying(true) 
			pawn:SetCustomAnim(_G[pawn:GetType()].MaxLevelFlyingGraphics)
		end
	end
end

function mod:load(options, version)
	modApi:addSquad(
		{
			"Secret Squad IV",		-- title
			"Meta_TechnoSpider",	-- mech #1
			"Meta_TechnoBlobber",-- mech #2
			"Meta_TechnoFirefly",	-- mech #3
			id="Meta_SecretSquad4"
		},
		"Secret Squad IV",
		"One of many known attempts to combine mech technology and Vek bodies.",
		self.resourcePath .."mod_icon.png"
	)
	modApi:addMissionStartHook(function(mission)	--need to reassign graphics at mission start since the game forgets otherwise
		doFlyingGraphics()
    end)
	modApi:addPostLoadGameHook(function()
		--We are not immediately in a mission after resetting turn, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		doFlyingGraphics)
    end)
	modApi:addMissionNextPhaseCreatedHook(function()
		--We are not immediately in a mission after falling into the Volcanic Cave, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		doFlyingGraphics)
    end)
end

return mod