local description = "A squad of mechs that FIGHT THE POWER."

local mod = {
	id = "Meta_GurrenLagann",
	name = "Gurren Lagann",
	version = "1",
	requirements = {},
	dependencies = {
		modApiExt = "1.17",
	},
	modApiVersion = "2.9.6",
	icon = "mod_icon.png",
	description = description,
}

function mod:init()
	self.libs = {}

	self.libs.pilotSkill_tooltip = require(mod.scriptPath .."libs/pilotSkill_tooltip")
	self.libs.repairApi = require(self.scriptPath.. "replaceRepair/api")
	self.libs.worldConstants = require(self.scriptPath.. "libs/worldConstants")
	self.libs.tipTracker = require(self.scriptPath.. "libs/tipTracker")
	self.libs.repairApi:init(self, modapiext)
	self.libs.customProjectile = require(self.scriptPath.. "libs/customProjectile/customProjectile")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
	if modApi.achievements:isComplete(mod.id,"Meta_KaminaSecret") then require(self.scriptPath .."kamina"):init() end 
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Team Dai-Gurren",		-- title
			"Mech_GurrenLagann",	-- mech #1
			"Mech_Dayakkaiser",-- mech #2
			"Mech_Kittan",	-- mech #3
			id="Meta_GurrenLagann"
		},
		"Team Dai-Gurren",
		"A squad of mechs that can overpower any foe.",
		self.resourcePath .."mod_icon.png"
	)
end

return mod