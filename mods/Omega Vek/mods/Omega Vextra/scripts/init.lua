local description = "Adds Omega versions of all Vek in Vextra. See mod options."

local mod = {
	id = "Meta_OmegaVextra",
	name = "Omega Vextra",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
		Djinn_NAH_Tatu_Vextra = "1.1.0",
		Meta_OmegaVek = "1.0.0",
	},
	modApiVersion = "2.9.2",
	icon = "mod_icon.png",
	description = description,
}


function mod:init()
	require(self.scriptPath.."pawns")
	require(self.scriptPath.."anthill")
	require(self.scriptPath.."antlion")
	require(self.scriptPath.."cockroach")
	require(self.scriptPath.."dragonfly")
	require(self.scriptPath.."fly")
	require(self.scriptPath.."icecrawler")
	require(self.scriptPath.."mantis")
	require(self.scriptPath.."pillbug")
	require(self.scriptPath.."silkworm")
	require(self.scriptPath.."stinkbug")
	require(self.scriptPath.."termites")
	require(self.scriptPath.."thunderbug")
end

function mod:load(options, version)
end

function mod:metadata()
	modApi:addGenerationOption(
		"OmegaDNT_Anthill",
		"Omega Anthill spawn settings",
		"Pick the percentage of Alpha Anthills that will be replaced by Omega Anthills. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Antlion",
		"Omega Antlion spawn settings",
		"Pick the percentage of Alpha Antlions that will be replaced by Omega Antlions. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Cockroach",
		"Omega Cockroach spawn settings",
		"Pick the percentage of Alpha Cockroaches that will be replaced by Omega Cockroaches. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Dragonfly",
		"Omega Dragonfly spawn settings",
		"Pick the percentage of Alpha Dragonflies that will be replaced by Omega Dragonflies. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Fly",
		"Omega Fly spawn settings",
		"Pick the percentage of Alpha Flies that will be replaced by Omega Flies. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_IceCrawler",
		"Omega Ice Crawler spawn settings",
		"Pick the percentage of Alpha Ice Crawlers that will be replaced by Omega Ice Crawlers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Mantis",
		"Omega Mantis spawn settings",
		"Pick the percentage of Alpha Mantis that will be replaced by Omega Mantis. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Pillbug",
		"Omega Pillbug spawn settings",
		"Pick the percentage of Alpha Pillbugs that will be replaced by Omega Pillbugs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Silkworm",
		"Omega Silkworm spawn settings",
		"Pick the percentage of Alpha Silkworms that will be replaced by Omega Silkworms. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Stinkbug",
		"Omega Stinkbug spawn settings",
		"Pick the percentage of Alpha Stinkbugs that will be replaced by Omega Stinkbugs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Termites",
		"Omega Termites spawn settings",
		"Pick the percentage of Alpha Termites that will be replaced by Omega Termites. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDNT_Thunderbug",
		"Omega Thunderbug spawn settings",
		"Pick the percentage of Alpha Thunderbugs that will be replaced by Omega Thunderbugs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
end

return mod