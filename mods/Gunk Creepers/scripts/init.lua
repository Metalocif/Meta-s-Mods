local description = "A squad of mechs that spread shapeless goo to contain the Vek."

local mod = {
	id = "Djinn_GunkCreepers",
	name = "Gunk Creepers",
	version = "1.0.0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/mod_icon.png",
	description = description,
	--metadata = metadata,
}

-- function mod:metadata()
	-- modApi:addGenerationOption(
		-- "Gunk_SlimeletsCanFuse",
		-- "Slimelets can fuse with the Slime Beast",
		-- "Check to make the Slimelet's attack heal the Slime Beast instead of pushing it (default: false).",
		-- { enabled = false }
	-- )
-- end

function mod:init()
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."replaceRepair")
	require(self.scriptPath .."devour")
	replaceRepair = require(self.scriptPath.. "replaceRepair/replaceRepair")
	replaceRepair:init(self)
	Devour = require(self.scriptPath.."Devour")
	Devour.init(self, replaceRepair)
	--local options = mod_loader.currentModContent[mod.id].options
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Gunk Creepers",		-- title
			"SlimeBeast",	-- mech #1
			"GrungeMech",-- mech #2
			"HarmonicMech",	-- mech #3
			id="Djinn_GunkCreepers"
		},
		"Gunk Creepers",
		"A squad of mechs that spread shapeless goo to contain the Vek.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod