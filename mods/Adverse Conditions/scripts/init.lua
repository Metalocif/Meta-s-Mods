local mod = {
	id = "Meta_AdverseConditions",
	name = "Adverse Conditions",
	version = "1.0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.18",
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.3",
	icon = "mod_icon.png",
	description = "Add negative conditions to your run at the start of each island.",
	metadata = metadata,
}

function mod:metadata()
	modApi:addGenerationOption(
		"SectorsToAddConditions",
		"When to add conditions?",
		"Choose which islands will add a permanent condition to your run.",
		{ 
			values = {{false, true, true, true}, {true, false, false, false}, {true, true, true, true}},
			strings = {"All islands after first", "First island only", "All islands"}
		}
	)
end

function mod:init()
	require(self.scriptPath.."conditions")
end

function mod:load( options, version)
end

return mod