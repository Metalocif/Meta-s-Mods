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
	-- modApi:addPostLoadGameHook(function()
		-- modApi:conditionalHook(function()
			-- return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		-- end, 
		-- function()
			-- if GetCurrentMission().Meta_GooAnims ~= nil then
				-- for id, anim in pairs(GetCurrentMission().Meta_GooAnims) do
					-- if Board:GetPawn(id) then Board:GetPawn(id):SetCustomAnim(anim) end
				-- end
			-- end
			-- if GetCurrentMission().GunkTable ~= nil then
				-- for id, _ in pairs(GetCurrentMission().GunkTable) do
					-- local pawn = Board:GetPawn(id)
					-- if pawn then 
						-- CustomAnim:add(id, "gunk")
						-- pawn:SetMoveSpeed(pawn:GetMoveSpeed() - 1)
					-- end
				-- end
			-- end
		-- end)
    -- end)
end

return mod