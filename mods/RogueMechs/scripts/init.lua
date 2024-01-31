local description = "Adds rogue mechs to the game: a mission where you face a corrupted squad that act like Vek."
local mod = {
	id = "Meta_RogueMechs",
	name = "Rogue Mechs",
	version = "1.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.3",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	require(self.scriptPath .."missions/mission_roguemechs")
	require(self.scriptPath .."missions/mission_roguemechs_dialog")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
	modApi:appendAssets("img/strategy/mission/", "img/strategy/mission/", "")
	modApi:appendAssets("img/strategy/mission/small/", "img/strategy/mission/small/", "")
	local scriptPath = self.scriptPath

	self.modApiExt = require(scriptPath .."modApiExt/modApiExt")
	self.modApiExt:init()
		
	self.missions = require(scriptPath .."missions/init")
	self.missions:init(self)	

	local corpMissions = require(scriptPath .."corpMissions")
end

function mod:load( options, version)
	local scriptPath = self.scriptPath
	self.modApiExt:load(self, options, version)
	self.missions:load(self, options, version)
	require(scriptPath .."libs/menu"):load()
	require(scriptPath .."libs/selected"):load()
	require(scriptPath .."libs/highlighted"):load()
end

local function init(self)
	Meta_RogueMechs_modApiExt = require(self.scriptPath.."modApiExt/modApiExt"):init()
end

return mod
