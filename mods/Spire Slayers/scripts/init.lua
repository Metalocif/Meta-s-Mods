local description = "Adds the four playable characters from Slay the Spire as pilots."
local mod = {
	id = "Meta_SpireSlayers",
	name = "Spire Slayers",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.1",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	modApi:appendAssets("img/portraits/pilots/","img/portraits/pilots/")
    modApi:appendAssets("img/weapons/","img/weapons/")
	self.libs = {}

	self.libs.pilotSkill_tooltip = require(mod.scriptPath .."libs/pilotSkill_tooltip")

	self.libs.repairApi = require(self.scriptPath.. "replaceRepair/api")
	self.libs.repairApi:init(self, modapiext)
	
	require(self.scriptPath .."pilot_effects")
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pilot_defect"):init()
	require(self.scriptPath .."pilot_ironclad"):init()
	require(self.scriptPath .."pilot_silent"):init()
	require(self.scriptPath .."pilot_watcher"):init()
end

function mod:load( options, version)
end

function mod:metadata()
end

return mod
