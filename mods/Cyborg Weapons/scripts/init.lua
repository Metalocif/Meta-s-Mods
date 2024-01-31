--INIT.LUA--
local description = "A few weapons for Cyborg-class mechs, meant to have a biological theming."

local mod = {
	id = "Metalocif_CyborgWeapons",
	name = "Cyborg Weapons",
	version = "1.4",
	modApiVersion = "2.9.3",
	gameVersion = "1.2.88",
	icon = "img/mod_icon.png",
	description = description,
	dependencies = {
		modApiExt = "1.18",
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
}

function mod:init()
	require(self.scriptPath.."weapons")
	
end

function mod:load(options, version)

end

return mod