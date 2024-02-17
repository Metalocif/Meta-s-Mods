local mod =  {
	id = "meta_mods",
	name = "Meta's mods",
	description = "Mods by Meta.",
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
end

return mod