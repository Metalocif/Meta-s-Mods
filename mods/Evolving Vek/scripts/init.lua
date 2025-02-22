local description = "Adds prefixes to enemies. Each enemy can have a random suitable buff. Prefixes are generated based on enemies you left alive at the end of previous missions. Check mod options to disable individual prefixes and learn what each prefix does."
local mod = {
	id = "Meta_EvolvingVek",
	name = "Evolving Vek",
	version = "1.4.3",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.1",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	require(self.scriptPath .."effects")
	require(self.scriptPath .."evolutions")
	require(self.scriptPath .."tips")
	require(self.scriptPath .."libs/tutorialTips")
	self.libs = {}
	self.libs.modApiExt = modapiext
	EvolvingVek_ModApiExt = self.libs.modApiExt --I'm assuming this is safe
end

function mod:load( options, version)
	require(self.scriptPath .. "tips"):load(self.libs.modApiExt)
	mod.icon = self.resourcePath .."img/mod_icon.png"
	if options.resetTutorials and options.resetTutorials.enabled then
		require(self.scriptPath .."libs/tutorialTips"):ResetAll()
		options.resetTutorials.enabled = false
	end
end

function mod:metadata()
	modApi:addGenerationOption(
		"PrefixSpawns",
		"Modify spawns during mission",
		"Check to modify spawns during missions instead of solely before deployment (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"PrefixStartCount",
		"Max prefixes at start of mission",
		"Choose how many Vek can have a prefix on the first turn (default: 1).",
		{
			values = { 1, 2, 3, 4, 5, 6}
		}
	)
	modApi:addGenerationOption(
		"PrefixDeterministic",
		"Prefix deterministically",
		"Check to add a given prefix to Vek that escape in some situations deterministically. For instance, a Vek that survives the mission on fire will always become Fireproof. With this off, the prefix would be random, but suitable for the Vek type (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Stable",
		"Enable the Stable prefix",
		"Check to allow Vek to be given the Stable prefix, making them immune to pushes (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Fireproof",
		"Enable the Fireproof prefix",
		"Check to allow Vek to be given the Fireproof prefix, making them immune to fire (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Smokeproof",
		"Enable the Smokeproof prefix",
		"Check to allow Vek to be given the Smokeproof prefix, making them immune to smoke (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Leaping",
		"Enable the Leaping prefix",
		"Check to allow Vek to be given the Leaping prefix, making them move by leaping (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Armored",
		"Enable the Armored prefix",
		"Check to allow Vek to be given the Armored prefix, granting them armor (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Heavy",
		"Enable the Heavy prefix",
		"Check to allow Vek to be given the Heavy prefix, granting them +2 HP at the cost of 2 movement (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Light",
		"Enable the Light prefix",
		"Check to allow Vek to be given the Light prefix, granting them +2 movement at the cost of 1 HP (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Swarming",
		"Enable the Swarming prefix",
		"Check to allow Vek to be given the Swarming prefix, making them not count towards the spawn limit (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Volatile",
		"Enable the Volatile prefix",
		"Check to allow Vek to be given the Volatile prefix, making them explode when killed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Massive",
		"Enable the Massive prefix",
		"Check to allow Vek to be given the Massive prefix, making them immune to death by drowning (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Undying",
		"Enable the Undying prefix",
		"Check to allow Vek to be given the Undying prefix, making them leave a corpse when killed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Burrowing",
		"Enable the Burrowing prefix",
		"Check to allow Vek to be given the Burrowing prefix, making them move by burrowing and burrow when they take damage (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Ruinous",
		"Enable the Ruinous prefix",
		"Check to allow Vek to be given the Ruinous prefix, making them crack their tile when killed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Purifying",
		"Enable the Purifying prefix",
		"Check to allow Vek to be given the Purifying prefix, making them remove A.C.I.D. from adjacent tiles when killed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Healing",
		"Enable the Healing prefix",
		"Check to allow Vek to be given the Healing prefix, making them heal adjacent Veks when killed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Spiteful",
		"Enable the Spiteful prefix",
		"Check to allow Vek to be given the Spiteful prefix, making them fire at all mechs on the same row/column; the projectiles deal damage equal to the Vek's tier (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Brood",
		"Enable the Brood prefix",
		"Check to allow Vek to be given the Brood prefix, making them spawn a spiderling egg on death (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Splitting",
		"Enable the Splitting prefix",
		"Check to allow Vek to be given the Splitting prefix, making them leave a blob at the start of movement after their first turn alive (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Oozing",
		"Enable the Oozing prefix",
		"Check to allow Vek to be given the Oozing prefix, making them leave a small goo at the start of movement after their first turn alive (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Infectious",
		"Enable the Infectious prefix",
		"Check to allow Vek to be given the Infectious prefix, making them spread Vek mites on allied units at the start of movement and damaging infected units (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Regenerating",
		"Enable the Regenerating prefix",
		"Check to allow Vek to be given the Regenerating prefix, making them heal 1 HP at the start of movement (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Wrathful",
		"Enable the Wrathful prefix",
		"Check to allow Vek to be given the Wrathful prefix, making them deal 1 more damage (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Cannibalistic",
		"Enable the Cannibalistic prefix",
		"Check to allow Vek to be given the Cannibalistic prefix, making them damage adjacent Vek and Cyborgs at the start of movement to gain health and movement speed (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_CopyingMelee",
		"Enable the Copying prefix for melee Vek",
		"Check to allow melee Vek to be given the Copying prefix, making them use the best melee Vek weapon on the board instead of their own (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_CopyingRanged",
		"Enable the Copying prefix for ranged Vek",
		"Check to allow ranged Vek to be given the Copying prefix, making them use the best ranged Vek weapon on the board instead of their own (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Webbing",
		"Enable the Webbing prefix",
		"Check to allow Vek to be given the Webbing prefix, making them web adjacent allied units at the end of movement (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Tyrannical",
		"Enable the Tyrannical prefix",
		"Check to allow Psions to be given the Tyrannical prefix, granting them a weak artillery attack (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Mirroring",
		"Enable the Mirroring prefix",
		"Check to allow Vek to be given the Mirroring prefix, making them fire their weapon forward and backwards at the same time (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Pushing",
		"Enable the Pushing prefix",
		"Check to allow Vek to be given the Pushing prefix, making their weapon push everything it hits (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Groundbreaking",
		"Enable the Groundbreaking prefix",
		"Check to allow Vek to be given the Groundbreaking prefix, making their weapon crack tiles it hits (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Venomous",
		"Enable the Venomous prefix",
		"Check to allow Vek to be given the Venomous prefix, making their weapon fire an instant A.C.I.D. shot before queuing their attack (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Frenzied",
		"Enable the Frenzied prefix",
		"Check to allow Vek to be given the Frenzied prefix, making their weapon deal an extra 2 damage at the cost of 1 max HP (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Freezing",
		"Enable the Freezing prefix",
		"Check to allow Vek to be given the Freezing prefix, making their weapon freeze anything it damages (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Excavating",
		"Enable the Excavating prefix",
		"Check to allow Vek to be given the Excavating prefix, making their weapon dig up rocks around it before its attack (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Nursing",
		"Enable the Nursing prefix",
		"Check to allow Vek to be given the Nursing prefix, making their weapon heal hit allies instead of dealing damage to them (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Electrified",
		"Enable the Electrified prefix",
		"Check to allow Vek to be given the Electrified prefix, making their weapon cause lightning to chain through hit tiles, but spawning Shocked. (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Flammable",
		"Enable the Flammable prefix",
		"Check to allow Vek to be given the Flammable prefix, making them take 1 damage and deal 1 damage to their surroundings when set on fire (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Wet",
		"Enable the Wet prefix",
		"Check to allow Vek to be given the Wet prefix, making them spawn wet and unable to catch fire (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Blessed",
		"Enable the Blessed prefix",
		"Check to allow Vek to be given the Blessed prefix, making their weapon the boss version (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_Reactive",
		"Enable the Reactive prefix",
		"Check to allow Vek to be given the Reactive prefix, making them turn A.C.I.D. into smoke on adjacent tiles (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"resetTutorials",
		"Reset Tutorial Tooltips",
		"Check to reset all tutorial tooltips for this profile.",
		{ enabled = false }
	)
end

return mod
