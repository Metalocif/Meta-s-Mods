local description = "A squad of insanity-inducing mechs."

local mod = {
	id = "Meta_Eldritch",
	name = "Eldritch Mechs",
	version = "1.2",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.9.3",
	icon = "mod_icon.png",
	description = description,
	--metadata = metadata,
}

function mod:metadata()
	modApi:addGenerationOption(
		"Meta_EldritchSelfInsanity",
		"Weapons apply insanity to the user",
		"Check to make weapons that apply insanity to adjacent pilots affect the pilot as well (default: false).",
		{ enabled = false }
	)
end

function mod:init()
	require(self.scriptPath .."pilot")
	-- require(self.scriptPath .."tentacular")
	-- require(self.scriptPath .."worm")
	-- require(self.scriptPath .."octopus")
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	-- require(self.scriptPath .."dialog")
	
	require(mod_loader.mods.meta_mods.scriptPath.."libs/multishot")
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Eldritch Mechs",		-- title
			"Mech_Tentacular",	-- mech #1
			"Mech_Worm",-- mech #2
			"Mech_Octopus",	-- mech #3
			id="Meta_Eldritch"
		},
		"Eldritch Mechs",
		"Based on designs by a mad scientist in a lost timeline, these mechs grant great power to their pilots, but drive them slowly insane.",
		self.resourcePath .."img/mod_icon.png"
	)
	-- modApi:addPopEvent("InsanityBuilding", "Ïa! Ïa!")
	-- modApi:addPopEvent("InsanityBuilding", "Ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn!")
	-- modApi:addPopEvent("InsanityBuilding", "The Deep Ones demand sacrifice!")

end

return mod