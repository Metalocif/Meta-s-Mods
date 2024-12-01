local description = "Adds variants to all vanilla Alpha Vek called Omega Vek. See mod options."

local mod = {
	id = "Meta_OmegaVek",
	name = "Omega Vek",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
	},
	modApiVersion = "2.9.2",
	icon = "img/mod_icon.png",
	description = description,
	--metadata = metadata,
}


function mod:init()
	require(self.scriptPath.."pawns")
	require(self.scriptPath.."weapons")
	require(self.scriptPath.."replaceSpawns")
end

function mod:load( options, version)
end

function mod:metadata()
	modApi:addGenerationOption(
		"OmegaVek",
		"Omega Vek spawn settings",
		"Pick the overall percentage of Alpha Vek that will be replaced by Omega Vek. The options below overrule this one for specific species.",
		{ strings = { "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 }, 
		  value = 0.5 }	--defaults to 50%
	)
	modApi:addGenerationOption(
		"OmegaFirefly",
		"Omega Firefly spawn settings",
		"Pick the percentage of Alpha Fireflies that will be replaced by Omega Fireflies. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaHornet",
		"Omega Hornet spawn settings",
		"Pick the percentage of Alpha Hornets that will be replaced by Omega Hornets. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaLeaper",
		"Omega Leaper spawn settings",
		"Pick the percentage of Alpha Leapers that will be replaced by Omega Leapers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaScarab",
		"Omega Scarab spawn settings",
		"Pick the percentage of Alpha Scarabs that will be replaced by Omega Scarabs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaScorpion",
		"Omega Scorpion spawn settings",
		"Pick the percentage of Alpha Scorpions that will be replaced by Omega Scorpions. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaBeetle",
		"Omega Beetle spawn settings",
		"Pick the percentage of Alpha Beetles that will be replaced by Omega Beetles. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaBlobber",
		"Omega Blobber spawn settings",
		"Pick the percentage of Alpha Blobbers that will be replaced by Omega Blobbers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaBurrower",
		"Omega Burrower spawn settings",
		"Pick the percentage of Alpha Burrowers that will be replaced by Omega Burrowers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaCentipede",
		"Omega Centipede spawn settings",
		"Pick the percentage of Alpha Centipedes that will be replaced by Omega Centipedes. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaCrab",
		"Omega Crab spawn settings",
		"Pick the percentage of Alpha Crabs that will be replaced by Omega Crabs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDigger",
		"Omega Digger spawn settings",
		"Pick the percentage of Alpha Diggers that will be replaced by Omega Diggers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaSpider",
		"Omega Spider spawn settings",
		"Pick the percentage of Alpha Spiders that will be replaced by Omega Spiders. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaBouncer",
		"Omega Bouncer spawn settings",
		"Pick the percentage of Alpha Bouncers that will be replaced by Omega Bouncers. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaBurnbug",
		"Omega Gastropod spawn settings",
		"Pick the percentage of Alpha Gastropods that will be replaced by Omega Gastropods. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaMosquito",
		"Omega Mosquito spawn settings",
		"Pick the percentage of Alpha Mosquitos that will be replaced by Omega Mosquitos. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaMoth",
		"Omega Moth spawn settings",
		"Pick the percentage of Alpha Moths that will be replaced by Omega Moths. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaShaman",
		"Omega Plasmodia spawn settings",
		"Pick the percentage of Alpha Plasmodias that will be replaced by Omega Plasmodias. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaStarfish",
		"Omega Starfish spawn settings",
		"Pick the percentage of Alpha Starfishes that will be replaced by Omega Starfishes. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
	modApi:addGenerationOption(
		"OmegaDung",
		"Omega Tumblebug spawn settings",
		"Pick the percentage of Alpha Tumblebugs that will be replaced by Omega Tumblebugs. Can default to the overall percentage defined above.",
		{ strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	)
end

return mod