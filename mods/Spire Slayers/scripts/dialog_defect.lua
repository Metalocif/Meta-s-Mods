
-- Adds a personality without the use of a csv file.
-- Table of responses to various triggers.
return {
	-- Game States
	Gamestart = {"[OBJECTIVE] VEK must be EXTERMINATED" },
	FTL_Found = {"[QUERY] ORIGIN"},
	FTL_Start = {""},
	Gamestart_PostVictory = {"[OBJECTIVE] VEK must be EXTERMINATED"},
	Death_Revived = {"[QUERY] RESTORE from BACKUP"},
	Death_Main = {"[ERROR] SYSTEM"},
	Death_Response = {"[QUERY] ALIVE"},
	Death_Response_AI = {"[QUERY] ALIVE"},
	TimeTravel_Win = {"[ERROR] VEK LOCATION"},
	Gameover_Start = {"[WARNING] CRITICAL POWER"},
	Gameover_Response = {"[WARNING] CRITICAL POWER"},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"[LOG] POWER INCREASE",},
	Upgrade_NoWeapon = {"[WARNING] NO WEAPON"},
	Upgrade_PowerGeneric = {"[LOG] POWER INCREASE",},
	
	-- Mid-Battle
	MissionStart = {"[WARNING] BATTLE MODE ENGAGED"},
	Mission_ResetTurn = {"[WARNING] TIME ANOMALY"},
	MissionEnd_Dead = {"[LOG] BATTLE MODE DISENGAGED"},
	MissionEnd_Retreat = {"[WARNING] VEK ALIVE"},

	MissionFinal_Start = {"[WARNING] HOT ENVIRONMENT"},
	MissionFinal_StartResponse = {"[LOG] POWER RESTORED"},
	MissionFinal_FallStart = {"[WARNING] FALLING"},
	MissionFinal_FallResponse = {"[WARNING] FALLING"},
	MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"[CONFUSION]"},
	MissionFinal_BombResponse = {"[OBJECTIVE] PROTECT the BOMB"},
	MissionFinal_CaveStart = {"[OBJECTIVE] PROTECT the BOMB"},
	MissionFinal_BombDestroyed = {"[WARNING] BOMB DESTROYED"},
	MissionFinal_BombArmed = {"[LOG] BATTLE MODE DISENGAGED"},

	PodIncoming = {"[LOG] POD DETECTED"},
	PodResponse = {"[OBJECTIVE] PROTECT POD"},
	PodCollected_Self = {"[LOG] POD PROTECTED"},
	PodDestroyed_Obs = {"[LOG] POD DESTROYED"},
	Secret_DeviceSeen_Mountain = {"[LOG] DEVICE DETECTED"},
	Secret_DeviceSeen_Ice = {"[LOG] DEVICE DETECTED"},
	Secret_DeviceUsed = {"[CONFUSION]"},
	Secret_Arriving = {"[CONFUSION]"},
	Emerge_Detected = {"[LOG] BURROW DETECTED"},
	Emerge_Success = {"[WARNING] VEK DETECTED"},
	Emerge_FailedMech = {"[LOG] VEK BLOCKED"},
	Emerge_FailedVek = {"[CONFUSION]"},

	-- Mech State
	Mech_LowHealth = {"[WARNING] SYSTEMS CRITICAL"},
	Mech_Webbed = {"[WARNING] MOVEMENT IMPOSSIBLE"},
	Mech_Shielded = {"[LOG] FORCE FIELD ACTIVE"},
	Mech_Repaired = {"[LOG] REPAIRS COMPLETE"},
	Pilot_Level_Self = {"[LOG] UPGRADE"},
	Pilot_Level_Obs = {},
	Mech_ShieldDown = {"[LOG] FORCE FIELD DESTROYED"},

	-- Damage Done
	Vek_Drown = {"[LOG] VEK DROWNED [QUERY] WATER ORB"},
	Vek_Fall = {"[LOG] VEK FELL"},
	Vek_Smoke = {"[LOG] VEK SMOKED"},
	Vek_Frozen = {"[LOG] VEK FROZEN"},
	VekKilled_Self = {"[LOG] VEK SLAIN" },
	VekKilled_Obs = {"[LOG] VEK SLAIN"},
	VekKilled_Vek = {"[CONFUSION]"},

	DoubleVekKill_Self = {"[LOG] VEK SLAIN [LOG] VEK SLAIN"},
	DoubleVekKill_Obs = {"[LOG] VEK SLAIN [LOG] VEK SLAIN"},
	DoubleVekKill_Vek = {"[CONFUSION] [CONFUSION] [CONFUSION]"},

	MntDestroyed_Self = {"[LOG] TERRAIN ALTERED"},
	MntDestroyed_Obs = {"[LOG] TERRAIN ALTERED"},
	MntDestroyed_Vek = {"[LOG] TERRAIN ALTERED"},

	PowerCritical = {"[WARNING] CRITICAL POWER"},
	Bldg_Destroyed_Self = {"[CONFUSION]"},
	Bldg_Destroyed_Obs = {"[CONFUSION]"},
	Bldg_Destroyed_Vek = {"[LOG] TERRAIN ALTERED"},
	Bldg_Resisted = {},


	-- Shared Missions
	Mission_Train_TrainStopped = {"[LOG] TRAIN DAMAGED"},
	Mission_Train_TrainDestroyed = {"[LOG] TRAIN DESTROYED"},
	Mission_Block_Reminder = {"[OBJECTIVE] BLOCK VEK"},

	-- Archive
	Mission_Airstrike_Incoming = {"[WARNING] INCOMING BOMBS"},
	Mission_Tanks_Activated = {"[LOG] TANKS ACTIVE"},
	Mission_Tanks_PartialActivated = {"[LOG] TANK ACTIVE"},
	Mission_Dam_Reminder = {"[OBJECTIVE] DAM"},
	Mission_Dam_Destroyed = {"[LOG] DAM DESTROYED"},
	Mission_Satellite_Destroyed = {"[LOG] SATELLITE DESTROYED"},
	Mission_Satellite_Imminent = {"[WARNING] LIFTOFF"},
	Mission_Satellite_Launch = {"[LOG] SATELLITE LAUNCHED"},
	Mission_Mines_Vek = {"[CONFUSION]"},

	-- RST
	Mission_Terraform_Destroyed = {"[LOG] TERRAFORMER DESTROYED"},
	Mission_Terraform_Attacks = {"[WARNING] TERRAFORMING"},
	Mission_Cataclysm_Falling = {"[WARNING] COLLAPSE"},
	Mission_Lightning_Strike_Vek = {"[WARNING] LIGHTNING"},
	Mission_Solar_Destroyed = {"[LOG] SOLAR PANELS DESTROYED"},
	Mission_Force_Reminder = {"[OBJECTIVE] DESTROY MOUNTAINS"},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {"[LOG] VEK FROZEN"},
	Mission_Factory_Destroyed = {"[LOG] FACTORY DESTROYED"},
	Mission_Factory_Spawning = {"[LOG] SIBLING BORN"},
	Mission_Reactivation_Thawed = {},
	Mission_SnowStorm_FrozenVek = {"[LOG] VEK FROZEN"},
	Mission_SnowStorm_FrozenMech = {"[LOG] MECH FROZEN"},
	BotKilled_Self = {"[GRIEF]"},
	BotKilled_Obs = {"[GRIEF]"},

	-- Detritus
	Mission_Disposal_Destroyed = {"[LOG] DISPOSAL UNIT DESTROYED"},
	Mission_Disposal_Activated = {"[WARNING] EXTERMINATING"},
	Mission_Barrels_Destroyed = {"[LOG] VAT DESTROYED"},
	Mission_Power_Destroyed = {"[LOG] POWER SOURCE DESTROYED"},
	Mission_Teleporter_Mech = {"[LOG] UPDATING LOCATION DATA"},
	Mission_Belt_Mech = {"[LOG] UPDATING LOCATION DATA"},
}