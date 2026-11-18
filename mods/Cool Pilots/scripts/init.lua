local description = "Adds three pilots with intricate effects."
local mod = {
	id = "Meta_CoolPilots",
	name = "Cool Pilots",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.7",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	modApi:appendAssets("img/portraits/pilots/","img/portraits/pilots/")
	modApi:appendAssets("img/portraits/enemy/","img/portraits/enemy/")
    modApi:appendAssets("img/weapons/","img/weapons/")
    modApi:appendAssets("img/effects/","img/effects/")
    modApi:appendAssets("img/units/aliens/","img/units/aliens/")

	require(self.scriptPath .."pilots/monsterhunter"):init()
	require(self.scriptPath .."pilots/monsterhunter_effects")
	require(self.scriptPath .."weapons")
	
	require(self.scriptPath.."pilots/weaponmaster"):init()
	require(self.scriptPath.."pilots/weaponmaster_personality")
	
	require(self.scriptPath.."pilots/galatea"):init()
	require(self.scriptPath.."pilots/galatea_personality")
	
	require(self.scriptPath.."boss")
end

function mod:load( options, version)
end

function mod:metadata()
end

return mod
