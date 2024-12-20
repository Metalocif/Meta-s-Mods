local description = "Adds Omega versions of all Vek in Bots and Bugs. See mod options."

local mod = {
	id = "Meta_OmegaBotsAndBugs",
	name = "Omega Bots and Bugs",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
		lmn_bots_and_bugs = "2.4.0",
		Meta_OmegaVek = "1.0.0",
	},
	modApiVersion = "2.9.2",
	icon = "mod_icon.png",
	description = description,
	--metadata = metadata,
}


function mod:init()
	require(self.scriptPath.."botsAndBugsPawns")
	require(self.scriptPath.."botsAndBugsWeapons")
	require(self.scriptPath.."doubleSpawn")
end

function mod:load(options, version)
	require(self.scriptPath .. "doubleSpawn"):load()
end

function mod:metadata()
	modApi:addGenerationOption(
		"Omegalmn_Wyrm",
		"Omega Wyrm spawn settings",
		"Pick the percentage of Alpha Wyrms that will be replaced by Omega Wyrms. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Crusher",
		"Omega Crusher spawn settings",
		"Pick the percentage of Alpha Crushers that will be replaced by Omega Crushers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Floater",
		"Omega Floater spawn settings",
		"Pick the percentage of Alpha Floaters that will be replaced by Omega Floaters. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Roach",
		"Omega Roach spawn settings",
		"Pick the percentage of Alpha Roachs that will be replaced by Omega Roachs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Spitter",
		"Omega Spitter spawn settings",
		"Pick the percentage of Alpha Spitters that will be replaced by Omega Spitters. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Swarmer",
		"Omega Swarmer spawn settings",
		"Pick the percentage of Alpha Swarmers that will be replaced by Omega Swarmers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"Omegalmn_Wyrm",
		"Omega Wyrm spawn settings",
		"Pick the percentage of Alpha Wyrms that will be replaced by Omega Wyrms. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
end

return mod