-- Adds a personality without the use of a csv file.
-- Table of responses to various triggers.
return {
	-- Game States
	Gamestart = {"There is much to be done if we are to save this world from both the Vek and greater horrors.","This world is doomed, but we may as well fight for its surcease.","According to my... readings..., there is little time."},
	FTL_Found = {"The harbinger from beyond the stars..."},
	--FTL_Start = {},
	Gamestart_PostVictory = {"...back in time.","I bring you a true tale of the future - not a prophecy, but first-hand knowledge."},
	Death_Revived = {"...and with strange eons even death may die."},
	Death_Main = {"That is not dead which can eternal lie..."},
	Death_Response = {"One death matters not, faced with annihilation."},
	Death_Response_AI = {"That machine was useful. It will stand again."},
	TimeTravel_Win = {"It is time to go..."},
	Gameover_Start = {"Are these bugs to claim us? Here? Now?", "And here, poor fool, with all my lore, I stand no stronger than before."},
	Gameover_Response = {"Let us go back and try again.","The beasts will not defeat me."},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"A stronger knife, for yet more worthy sacrifices.",},
	Upgrade_NoWeapon = {"I know death will eventually spit me out. Still, I do not relish the experience."},
	Upgrade_PowerGeneric = {"Your machine's engine is quite powerful.",},
	
	-- Mid-Battle
	MissionStart = {"Remind yourselves that overconfidence is a slow and insidious killer.","I fear not bug nor beast nor man."},
	Mission_ResetTurn = {"The power to turn back time... It may save humanity from the horrors to come."},
	MissionEnd_Dead = {"We are safe, for now.", "The bigger the beast... the greater the glory."},
	MissionEnd_Retreat = {"The bugs are driven back - to mend their wounds, to breed. This is no victory.", "The only victory in this war is annihilation."},

	MissionFinal_Start = {"The beginning of the end, perhaps.","I believe machines usually need power supply."},
	MissionFinal_StartResponse = {"Good, we can work now."},
	--MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"The earth breaks from their ceaseless gnawing."},
	--MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"My arts are not so great they can shatter the earth.","A shoggoth. Our fates are sealed.", "Shunned by the sane world, it lurked in this cyclopean hive!"},
	--MissionFinal_BombResponse = {},
	MissionFinal_CaveStart = {"I remain unsure this bomb can harm the shoggoth."},
	--MissionFinal_BombDestroyed = {},
	MissionFinal_BombArmed = {"Let us leave, and let us pray."},

	PodIncoming = {"A gift from beyond space and time."},
	PodResponse = {"Let us secure this gift."},
	PodCollected_Self = {"The pod is secure. Focus on elimination.", "I safeguarded the box. Fight the creatures with abandon."},
	PodDestroyed_Obs = {"Rejecting Their gifts... how foolish."},
	Secret_DeviceSeen_Mountain = {"There is something... calling to me there."},
	Secret_DeviceSeen_Ice = {"The ice beckons... what manner of creature would live there?"},
	Secret_DeviceUsed = {"An old device. It is surely of no import."},
	Secret_Arriving = {"Something from outer space. Could it be...?"},
	Emerge_Detected = {"More arrive, seeking death.", "They come, flowing from below ground like so much mud."},
	Emerge_Success = {"I learnt of the Vek's coming far before your science. A few more will not shock me.", "Things have learnt to walk that ought to crawl."},
	Emerge_FailedMech = {"Know your place - underground.", "Return to your cthonian haunt."},
	Emerge_FailedVek = {"Too many beasts in too small a burrow.", "Their effluence stops, for a time."},

	-- Mech State
	Mech_LowHealth = {"Death comes. I fear it not.", "Not again."},
	Mech_Webbed = {"Disgusting.", "They are catching me."},
	Mech_Shielded = {"Good, no harm should come my way now."},
	Mech_Repaired = {"My armor is mended. My spirit remains desecrated."},
	Pilot_Level_Self = {"I understand the creatures better, though it matters not."},
	Pilot_Level_Obs = {"Good. Keep at it. This is only a prelude to the horrors to come."},
	Mech_ShieldDown = {"Exposed again.","The machine's flesh is exposed again."},

	-- Damage Done
	Vek_Drown = {"Feed the bugs above to the beasts below."},
	Vek_Fall = {"The unreverberate blackness of the abyss claims another."},
	Vek_Smoke = {"How I wish I could, like this Vek, return to the mists of blindness and ignorance."},
	Vek_Frozen = {"Many monsters are trapped in the ice, even nowadays. It seems a versatile method of disposal."},
	VekKilled_Self = {"I will perform haruspicy later.","The beast is felled.","Stay on your guard, more of the loathsome beasts could be upon you."},
	VekKilled_Obs = {"Have your glory, #main_first. What matters is preparing for what comes after the Vek.","Good, #main_first.","More may come, #main_first."},
	VekKilled_Vek = {"Foolish beasts.","Strength in abundance but little brain."},

	DoubleVekKill_Self = {"It matters not.","Still not efficient enough given their numbers."},
	DoubleVekKill_Obs = {"You are a great soldier, but we need a great tactician... no, a great diplomat."},
	DoubleVekKill_Vek = {"Foolish beasts."},

	MntDestroyed_Self = {"Mountains... Shoggoths could be there."},
	MntDestroyed_Obs = {"Shatter the odious mountains."},
	MntDestroyed_Vek = {"Better that than us."},

	PowerCritical = {"With power dwindling, this machine will soon become our tomb."},
	Bldg_Destroyed_Self = {"I have made a... mistake.","I thought I saw..."},
	Bldg_Destroyed_Obs = {"Are you... one of them?"},
	Bldg_Destroyed_Vek = {"More death. More ashes. More disappointment.", "Obdurate monster."},
	Bldg_Resisted = {"It is in the crucible of war that men... and buildings, it seems... reveal their mettle."},

	Meta_GoingInsane1 = {"It has found me! Run!"},
	Meta_GoingInsane2 = {"It has found me! Run!"},
	Meta_GoingInsane3 = {"It has found me! Run!"},
	Meta_GoingInsane4 = {"It has found me! Run!"},
	Meta_GoingInsane5 = {"It has found me! Run!"},
	Meta_GoingInsane6 = {"It has found me! Run!"},
	Meta_GoingInsane7 = {"It has found me! Run!"},
	Meta_GoingInsane8 = {"It has found me! Run!"},
	Meta_GoingInsane9 = {"It has found me! Run!"},
	Meta_GoingInsane10 = {"It has found me! Run!"},
	Meta_GoingInsane11 = {"It has found me! Run!"},
	Meta_GoingInsane12 = {"It has found me! Run!"},
	Meta_GoingInsane13 = {"It has found me! Run!"},
	Meta_GoingInsane14 = {"It has found me! Run!"},
	-- Shared Missions
	--[[Mission_Train_TrainStopped = {},
	Mission_Train_TrainDestroyed = {},
	Mission_Block_Reminder = {},

	-- Archive
	Mission_Airstrike_Incoming = {},
	Mission_Tanks_Activated = {},
	Mission_Tanks_PartialActivated = {},
	Mission_Dam_Reminder = {},
	Mission_Dam_Destroyed = {},]]
	Mission_Satellite_Destroyed = {"Good. Attracting the attention of the Outer Ones is the last thing we need."},
	Mission_Satellite_Imminent = {"Each pebble we toss out of our earthly pen attracts Their gaze.", "We should destroy these, not protect them, lest the Old Ones take notice of us."},
	Mission_Satellite_Launch = {"We should have destroyed it when we had the chance.", "Damn that sentimental Dewey.", "The shoreless seas hold worse things than the Vek, and we disturbed them."},
	--[[Mission_Mines_Vek = {},

	-- RST
	Mission_Terraform_Destroyed = {},
	Mission_Terraform_Attacks = {},
	Mission_Cataclysm_Falling = {},
	Mission_Lightning_Strike_Vek = {},
	Mission_Solar_Destroyed = {},
	Mission_Force_Reminder = {},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {},
	Mission_Factory_Destroyed = {},
	Mission_Factory_Spawning = {},
	Mission_Reactivation_Thawed = {},
	Mission_SnowStorm_FrozenVek = {},
	Mission_SnowStorm_FrozenMech = {},
	BotKilled_Self = {},
	BotKilled_Obs = {},

	-- Detritus
	Mission_Disposal_Destroyed = {},
	Mission_Disposal_Activated = {},
	Mission_Barrels_Destroyed = {},
	Mission_Power_Destroyed = {},
	Mission_Teleporter_Mech = {},
	Mission_Belt_Mech = {},]]
}