local description = "A squad of cyborgs that protect the Earth by raising and moving massive rocks."

local mod = {
	id = "Meta_TechnoVek3",
	name = "Secret Squad III",
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

function mod:metadata()
	modApi:addGenerationOption(
		"Meta_BurrowersCanIntoWater",
		"Burrowers can move into water",
		"Check to allow the Techno-Digger and Techno-Tumblebug to end movement in water tiles (default: false).",
		{ enabled = false }
	)
	modApi:addGenerationOption(
		"Meta_BombRockAffectBuildings",
		"Thrown unstable boulders explosions affect buildings",
		"Check to allow the explosions of rocks thrown by the Techno-Tumblebug's upgrade to damage buildings (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Meta_MothNerf",
		"Repelling Pellets cannot push in the same direction it fires",
		"Check to prevent the Techno-Moth from pushing an adjacent unit in the same direction it fires (default: false).",
		{ enabled = false }
	)
	-- modApi:addGenerationOption(
		-- "Meta_TumblebugNerf",
		-- "Mineral Prize unit toss range limit",
		-- "Check to prevent Mineral Prize from tossing units further than two tiles, plus one per upgrade (default: false).",
		-- { enabled = false }
	-- )
end

function mod:init()
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	local options = mod_loader.currentModContent[mod.id].options
	if modApi.achievements:isComplete(mod.id,"Meta_BlownAway") then modApi:addWeaponDrop("Meta_TechnoMothWeapon") end
	if modApi.achievements:isComplete(mod.id,"Meta_GaiasCradle") then modApi:addWeaponDrop("Meta_TechnoDiggerWeapon") end
	if modApi.achievements:isComplete(mod.id,"Meta_RenfieldWho") then modApi:addWeaponDrop("Meta_TechnoTumblebugWeapon") end
	if modApi.achievements:isComplete(mod.id,"Meta_BlownAway") and modApi.achievements:isComplete(mod.id,"Meta_GaiasCradle") and modApi.achievements:isComplete(mod.id,"Meta_RenfieldWho") then	
		require(mod_loader.mods.meta_mods.Meta_Pokemon.scriptPath.."weathers")
		modApi:addWeaponDrop("Meta_Geomancy") 
	end
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Secret Squad III",		-- title
			"Meta_TechnoDigger",	-- mech #1
			"Meta_TechnoTumblebug",-- mech #2
			"Meta_TechnoMoth",	-- mech #3
			id="Meta_TechnoVek3"
		},
		"Secret Squad III",
		"The third known attempt to combine Vek and machines. In a desperate bid to protect civilians, these cyborgs raise the earth itself as a makeshift shield.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod