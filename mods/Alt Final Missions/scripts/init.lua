local mod = {
	id = "Meta_AltFinalMissions",
	name = "Alt Final Missions",
	version = "1.0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.18",
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.3",
	icon = "img/mod_icon.png",
	description = "Adds different versions of the second phase of the final mission. Set weights in mod options.",
}

function mod:metadata()
	modApi:addGenerationOption(
		"Meta_RegularFinalMissionWeight",
		"Odds to play the standard final mission (Renfield Bomb).",
		"Choose the odds for the final mission to have you protect a Renfield Bomb.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 1
		}
	)
	modApi:addGenerationOption(
		"Meta_FluorousFinalMissionWeight",
		"Odds to play an alternate final mission (Fluorous Vek).",
		"Choose the odds for the final mission to have you keep a stronger Volatile Vek alive.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 1
		}
	)
	modApi:addGenerationOption(
		"Meta_NukeFinalMissionWeight",
		"Odds to play an alternate final mission (Nuke).",
		"Choose the odds for the final mission to have you destroy a nuke.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 1
		}
	)
	modApi:addGenerationOption(
		"Meta_QueenFinalMissionWeight",
		"Odds to play an alternate final mission (Hive Queen).",
		"Choose the odds for the final mission to have you slay the Hive Queen.",
		{
			values = { 0, 1, 2, 3, 4, 5, 6}, value = 1
		}
	)
	modApi:addGenerationOption(
		"Meta_LearnAboutFinalMission",
		"Receive a briefing about the final mission",
		"If this is enabled, once the final mission becomes available, you will be told which mission will happen.",
		{ enabled = false }
	)
	modApi:addGenerationOption(
		"Meta_FluorousVekHasBossAttack",
		"Should the Fluorous Vek use the Scorpion Leader attack?",
		"If this is enabled, the Fluorous Vek will use the Scorpion Leader's attack. Otherwise, it will use an Alpha Scorpion's attack. Disabled by default.",
		{ enabled = false }
	)
	modApi:addGenerationOption(
		"Meta_HiveQueenMaxHealth",
		"Max health for the Hive Queen final boss",
		"Choose the Hive Queen's health. 7 is max in vanilla. 12 is max the engine tolerates without greatly stretching the HP bar. 79 is max the engine will render HP markers for. Default is 20.",
		{
			values = { 7, 12, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 79}, value = 20
		}
	)
	modApi:addGenerationOption(
		"Meta_HiveQueenInvincibleThreshold",
		"Hive Queen invincibility value",
		"Choose the maximum amount of damage the Hive Queen can take from a single attack. Default is 4.",
		{
			values = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100}, value = 4
		}
	)
end

function mod:init()
	require(self.scriptPath.."replacer")
	require(self.scriptPath.."libs/swimmingIcon")
	modApi:appendAssets("img/units/mission/", "img/units/mission/")
	modApi:appendAssets("img/effects/", "img/effects/")
	modApi:appendAssets("img/combat/tiles_grass/", "img/combat/tiles_grass/")
	modApi:appendAssets("img/combat/traits/", "img/combat/traits/")
	modApi:appendAssets("img/portraits/enemy/", "img/portraits/enemy/")
end

function mod:load( options, version)
	local extraDialog = require(mod.scriptPath.."extra_dialog")
	for personalityId, dialogTable in pairs(extraDialog) do
		Personality[personalityId]:AddDialogTable(dialogTable)
	end
	Mission_Texts["Mission_Final_Two_Obj_MetaFluorous"] = "Keep the Fluorous Vek alive until it explodes"
	Mission_Texts["Mission_Final_Two_Obj_MetaNuke"] = "Attack the Nuke until it explodes"
	Mission_Texts["Mission_Final_Two_Obj_MetaQueen"] = "Slay the Hive Queen"
end

return mod