local description = "A squad of draconic cyborgs. Their unique biology lends them versatile weapons to deal with the Vek threat."

local mod = {
	id = "Meta_Draconids",
	name = "Ancient Draconids",
	version = "1.2",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.9.3",
	icon = "img/mod_icon.png",
	description = description,
	--metadata = metadata,
}

function mod:metadata()
end

function mod:init()
	require(self.scriptPath .."hydra")
	require(self.scriptPath .."wyvern")
	require(self.scriptPath .."drake")
	require(self.scriptPath .."pawns")
	require(mod_loader.mods.meta_mods.scriptPath.."libs/multishot")
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Ancient Draconids",		-- title
			"Meta_Hydra",	-- mech #1
			"Meta_Wyvern",-- mech #2
			"Meta_Drake",	-- mech #3
			id="Meta_Draconids"
		},
		"Ancient Draconids",
		"Wrought by forgotten scientists in lost timelines, these vatgrown dragons bring a unique biology and versatile weapons to the fight.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod