local description = "Psions don't appear. Their effects are permanently applied to all Vek. Choose the Psion effect you want in this mod's options."
local mod = {
	id = "Meta_PermanentPsions",
	name = "Permanent Psion Effects",
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
	require(self.scriptPath .."spawner")
end

function mod:load( options, version)
end

function mod:metadata()
	modApi:addGenerationOption(
		"PermanentPsion",
		"Permanent Psion",
		"Pick the Psion effect to apply to all Vek.",
		{
			-- Internal values of the options
			values = { "Jelly_Health1", "Jelly_Armor1", "Jelly_Regen1", "Jelly_Explode1", "Jelly_Lava1", "Jelly_Boss", "Jelly_Fire1", "Jelly_Spider1", "Jelly_Boost1", "Jelly_Necro1" },

			-- Names of the options that will be shown to the player.
			strings = { "Invigorating Spores", "Hardened Carapace", "Regeneration", "Explosive Decay", "Hive Targeting", "Overpowered", "Burning Carapace", "Arachnid Host", "Raging Hormones", "Undying Biology" },

			-- Tooltips for the options that will be shown to the player.
			tooltips = {"All Vek receive +1 HP.", 
						"All Vek have incoming weapon damage reduced by 1.", 
						"All Vek heal 1 at the start of their turn.", 
						"All Vek will explode on death, dealing 1 damage to adjacent tiles.",
						"All player units take 1 damage at the end of every turn.",
						"All Vek gain +1 HP, Regeneration, and explode on death.",
						"All Vek are protected from Fire and leave Fire on death.",
						"All Vek will spawn a Spiderling Egg on death.",
						"All Vek are Boosted, providing +1 damage to attacks.",
						"All Vek will resurrect on death. This is a scrapped vanilla feature and it is somewhat buggy."},
		}
	)
end

return mod
