local description = "A squad of spectral mechs."

local mod = {
	id = "Meta_Gravekeepers",
	name = "Gravekeepers",
	version = "1.0",
	requirements = {},
	dependencies = {
		modApiExt = "1.17",
	},
	modApiVersion = "2.9.6",
	icon = "mod_icon.png",
	description = description,
}

function mod:init()
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Gravekeepers",		-- title
			"Mech_Banshee",	-- mech #1
			"Mech_Wraith",-- mech #2
			"Mech_Reaper",	-- mech #3
			id="Meta_Gravekeepers"
		},
		"Gravekeepers",
		"A squad of spectral mechs that use advanced technology to phase through matter.",
		self.resourcePath .."mod_icon.png"
	)
end

return mod