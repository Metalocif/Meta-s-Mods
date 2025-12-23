local description = "Adds Omega versions of all Vek in vanilla Into the Breach."

local mod = {
	id = "Meta_OmegaVanilla",
	name = "Omega Vanilla",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
		Meta_OmegaVek = "1.0.0",
	},
	modApiVersion = "2.9.2",
	icon = "mod_icon.png",
	description = description,
}


function mod:init()
	require(self.scriptPath.."pawns")
	require(self.scriptPath.."weapons")
end

function mod:load(options, version)
end

function mod:metadata()
	-- modApi:addGenerationOption(
		-- "OmegaFirefly",
		-- "Omega Firefly spawn settings",
		-- "Pick the percentage of Alpha Fireflies that will be replaced by Omega Fireflies. Can default to the overall percentage defined above.",
		-- { strings = { "Default", "0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%" }, 
		  -- values = { "Default", 0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1 } }
	-- )
end

return mod