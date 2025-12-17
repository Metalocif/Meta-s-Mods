local mod =  {
	id = "meta_mods",
	name = "Meta's mods",
	description = "Mods by Meta. Hold SHIFT and click an enemy with custom status effects for tooltips.",
	icon = "scripts/icon.png",
	submodFolders = {"mods/"},
	version = "1.0",
	dependencies = {
		modApiExt = "1.2",
		memedit = "0.1.0",
		easyEdit = "2.0.0",
	},
	load = function() end
}

function mod:init(options)
	require(self.scriptPath.."libs/artilleryArc")
	require(self.scriptPath.."libs/astar")
	require(self.scriptPath .."libs/boardEvents")
	require(self.scriptPath .."libs/clip")
	require(self.scriptPath.."libs/customAnim")
	require(self.scriptPath.."libs/customEmitter")
	require(self.scriptPath.."libs/multishot")
	require(self.scriptPath.."libs/saveData")
	require(self.scriptPath.."libs/spaceDamageObjects")
	require(self.scriptPath.."libs/status")
	require(self.scriptPath.."libs/weaponArmed")
	require(self.scriptPath.."libs/weaponPreview")
	require(self.scriptPath .."libs/worldConstants")
end

return mod