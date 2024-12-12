local description = "Lets you edit possible pod rewards separately for the first and second pods of an island. Defaults to vanilla behavior."
local mod = {
	id = "Meta_PodsPlus",
	name = "Pods+",
	version = "1.0.0",
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
	require(self.scriptPath .."pods")
end

function mod:load( options, version)
end

function mod:metadata()
	modApi:addGenerationOption(
		"Meta_FirstPodOneCore",
		"First Pod: odds for 1 core.",
		"Choose the odds for the first pod of an island to contain a core and nothing else (default: 3).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 3
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodTwoCores",
		"First Pod: odds for 2 cores.",
		"Choose the odds for the first pod of an island to contain two cores (default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodWeaponCore",
		"First Pod: odds for weapon + core.",
		"Choose the odds for the first pod of an island to contain a weapon and a core (default: 4).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 4
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodPilotCore",
		"First Pod: odds for pilot + core.",
		"Choose the odds for the first pod of an island to contain a pilot and a core (default: 3).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 3
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodWeapon",
		"First Pod: odds for weapon.",
		"Choose the odds for the first pod of an island to contain a weapon and nothing else (default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodPilot",
		"First Pod: odds for pilot.",
		"Choose the odds for the first pod of an island to contain a pilot and nothing else(default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodWeaponPilot",
		"First Pod: odds for weapon + pilot (messy graphics).",
		"Choose the odds for the first pod of an island to contain a weapon and a pilot (default: 0). The game UI doesn't like that but it works fine.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodOneCoreTwoRep",
		"First Pod: odds for core + 2 reputation (invisible graphics).",
		"Choose the odds for the first pod of an island to contain a core and 2 reputation (default: 0). The reputation is invisible when opening the pod.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_FirstPodFiveRep",
		"First Pod: odds for 5 reputation (invisible graphics).",
		"Choose the odds for the first pod of an island to contain 5 reputation (default: 0). The reputation looks invisible but works fine.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)

	modApi:addGenerationOption(
		"Meta_SecondPodOneCore",
		"Second Pod: odds for 1 core.",
		"Choose the odds for the second pod of an island to contain a core and nothing else (default: 3).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 3
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodTwoCores",
		"Second Pod: odds for 2 cores.",
		"Choose the odds for the second pod of an island to contain two cores (default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodWeaponCore",
		"Second Pod: odds for weapon + core.",
		"Choose the odds for the second pod of an island to contain a weapon and a core (default: 4).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 4
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodPilotCore",
		"Second Pod: odds for pilot + core.",
		"Choose the odds for the second pod of an island to contain a pilot and a core (default: 3).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 3
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodWeapon",
		"Second Pod: odds for weapon.",
		"Choose the odds for the second pod of an island to contain a weapon and nothing else (default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodPilot",
		"Second Pod: odds for pilot.",
		"Choose the odds for the second pod of an island to contain a pilot and nothing else(default: 0).",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodWeaponPilot",
		"Second Pod: odds for weapon + pilot (messy graphics).",
		"Choose the odds for the second pod of an island to contain a weapon and a pilot (default: 0). The game UI doesn't like that but it works fine.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodOneCoreTwoRep",
		"Second Pod: odds for core + 2 reputation (invisible graphics).",
		"Choose the odds for the second pod of an island to contain a core and 2 reputation (default: 0). The reputation is invisible when opening the pod.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
	modApi:addGenerationOption(
		"Meta_SecondPodFiveRep",
		"Second Pod: odds for 5 reputation (invisible graphics).",
		"Choose the odds for the second pod of an island to contain 5 reputation (default: 0). The reputation looks invisible but works fine.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 0
		}
	)
end

return mod
