-- Adds a personality without the use of a csv file.

-- Unique identifier for personality.
local personality = "EvaRei"

-- Table of responses to various triggers.
local tbl = {
	--Game States
	Gamestart = {"I am ready."},
	FTL_Found = {"What a strange being."},
	FTL_Start = {"We cannot speak, but we could learn to communicate."},	--this can trigger in a custom squad, I think
	Gamestart_PostVictory = {},	--should never trigger
	Death_Revived = {"Why am I alive again?"},
	Death_Main = {},	--goes berserk, we don't want this to trigger
	Death_Response = {"#main_first!"},
	Death_Response_AI = {"Machines can be replaced."},
	TimeTravel_Win = {"Good."},
	Gameover_Start = {"We are running out of power."},
	Gameover_Response = {"Help!"},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"Yes."},
	Upgrade_NoWeapon = {"Yes."},
	Upgrade_PowerGeneric = {"Good."},
	
	-- Mid-Battle
	MissionStart = {"I am ready."},
	Mission_ResetTurn = {"I see."},
	MissionEnd_Dead = {"Good."},
	MissionEnd_Retreat = {"Some are still alive."},

	MissionFinal_Start = {"Expecting pylon delivery as per mission briefings."},
	MissionFinal_StartResponse = {"Good."},
	MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"Ah!"},
	MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"We need additional weaponry."},
	MissionFinal_BombResponse = {"Good."},
	MissionFinal_CaveStart = {"I will protect the bomb."},
	MissionFinal_BombDestroyed = {"Bombs can be replaced."},
	MissionFinal_BombArmed = {"Good."},

	-- PodIncoming = {}
	-- PodResponse = {"I wonder whether I could go back to the past..."},
	-- PodCollected_Self = {"The pod is safe; I can go back to protecting people."},
	-- PodDestroyed_Obs = {"Oh no!"},
	-- Secret_DeviceSeen_Mountain = {"There is something inside the mountain."},
	-- Secret_DeviceSeen_Ice = {"Something shines under the ice."},
	-- Secret_DeviceUsed = {"My Eva just used it on its own."},
	-- Secret_Arriving = {"What is this?"},
	Emerge_Detected = {"More are coming."},
	-- Emerge_Success = {"I will not run away!"},
	Emerge_FailedMech = {"I will hold it back."},
	-- Emerge_FailedVek = {"That's perfect!"},

	-- Mech State
	Mech_LowHealth = {"If I die, I can be replaced."},
	Mech_Webbed = {"Ngh!"},
	Mech_Shielded = {"Good."},
	Mech_Repaired = {},	--would trigger on casting an AT Field as well; we'll do voice events in the hook instead.
	Pilot_Level_Self = {"Hm."},
	Pilot_Level_Obs = {"Congratulations."},
	Mech_ShieldDown = {"My shield is gone."},

	-- Damage Done
	Vek_Drown = {"Good." },
	Vek_Fall = {"Good."},
	-- Vek_Smoke = {"Smoke..."},
	-- Vek_Frozen = {"Things shrink when they cool down..."},
	-- VekKilled_Self = {"Raah!"},
	VekKilled_Obs = {"Good."},
	VekKilled_Vek = {"Good."},

	DoubleVekKill_Self = {"Raaaaaaaah!"},
	DoubleVekKill_Obs = {"Congratulations."},
	DoubleVekKill_Vek = {"Good."},

	-- MntDestroyed_Self = {"I still can't believe my Evangelion is this strong."},
	-- MntDestroyed_Obs = {"Wow."},
	-- MntDestroyed_Vek = {"Are they confusing mountains for buildings?"},

	PowerCritical = {"Power batteries are running low!"},
	Bldg_Destroyed_Self = {"No!"},
	Bldg_Destroyed_Obs = {"Stop!"},
	Bldg_Destroyed_Vek = {"No!"},
	Bldg_Resisted = {"Good."},


	-- Shared Missions
	-- Mission_Train_TrainStopped = {"I'm sorry."},
	-- Mission_Train_TrainDestroyed = {"I'm sorry."},
	-- Mission_Block_Reminder = {"If we can, let's hold them back."},

	-- Archive
	-- Mission_Airstrike_Incoming = {"They are coming to help us!"},
	-- Mission_Tanks_Activated = {"Please stay safe!"},
	-- Mission_Tanks_PartialActivated = {"I'm sorry we couldn't protect the other."},
	-- Mission_Dam_Reminder = {"Hey, shouldn't we break that dam?"},
	-- Mission_Dam_Destroyed = {"I don't like water, but neither do they."},
	-- Mission_Satellite_Destroyed = {"I'm sorry."},
	-- Mission_Satellite_Imminent = {"Be careful!"},
	-- Mission_Satellite_Launch = {"It's flying away, safe at last."},
	-- Mission_Mines_Vek = {"They're not N², but I don't think our Evas can survive these."},

	-- RST
	-- Mission_Terraform_Destroyed = {"I'm sorry."},
	-- Mission_Terraform_Attacks = {"Whoa!"},
	-- Mission_Cataclysm_Falling = {"Be careful, everyone!"},
	-- Mission_Lightning_Strike_Vek = {"That's scary!"},
	-- Mission_Solar_Destroyed = {"I'm sorry."},
	-- Mission_Force_Reminder = {"I'm not sure I understand why, but we were asked to destroy mountains, weren't we?"},

	-- Pinnacle
	-- Mission_Freeze_Mines_Vek = {"We don't have to worry about this one."},
	-- Mission_Factory_Destroyed = {"I'm sorry."},
	-- Mission_Factory_Spawning = {"So many of these little robots."},
	-- Mission_Reactivation_Thawed = {"They're breaking free!"},
	-- Mission_SnowStorm_FrozenVek = {"At least they are not moving now."},
	-- Mission_SnowStorm_FrozenMech = {"Help, I'm stuck!"},
	-- BotKilled_Self = {"I'm sorry, little robot."},
	-- BotKilled_Obs = {"Nice!"},

	-- Detritus
	-- Mission_Disposal_Destroyed = {"I'm sorry."},
	-- Mission_Disposal_Activated = {"So strong!"},
	-- Mission_Barrels_Destroyed = {"Reminds me of that Angel…"},
	-- Mission_Power_Destroyed = {"I'm sorry."},
	-- Mission_Teleporter_Mech = {"Woah!"},
	-- Mission_Belt_Mech = {"That's very slow compared to my Eva."},
	
	-- Meridia
	-- Mission_lmn_Convoy_Destroyed = {"I'm sorry."},
	-- Mission_lmn_FlashFlood_Flood = {"Scary!"},
	-- Mission_lmn_Geyser_Launch_Mech = {"Aaaaaaaaaaaaah!"},
	-- Mission_lmn_Geyser_Launch_Vek = {"That's terrifying! Water from below?"},
	-- Mission_lmn_Volcanic_Vent_Erupt_Vek = {"Be careful, everyone!"},
	-- Mission_lmn_Wind_Push = {"Whoa!"},
	-- Mission_lmn_Runway_Imminent = {"They're going to take off, be careful!"},
	-- Mission_lmn_Runway_Crashed = {"I'm sorry."},
	-- Mission_lmn_Runway_Takeoff = {"They're safe."},
	-- Mission_lmn_Greenhouse_Destroyed = {"I'm sorry."},
	-- Mission_lmn_Geothermal_Plant_Destroyed = {"I'm sorry."},
	-- Mission_lmn_Hotel_Destroyed = {"I'm sorry."},
	-- Mission_lmn_Agroforest_Destroyed = {"I'm sorry."},


	
	-- Island missions
	-- Mission_tosx_Juggernaut_Destroyed = { "I'm sorry.",},
	-- Mission_tosx_Juggernaut_Ram = {"Whoa! Be careful, everyone."},
	-- Mission_tosx_Zapper_On = {"We can zap them from far away? Great!"},
	-- Mission_tosx_Zapper_Destroyed = {"I'm sorry.",},
	-- Mission_tosx_Warper_Destroyed = {"I'm sorry.",},
	-- Mission_tosx_Battleship_Destroyed = {"I'm sorry."},
	
	
	
	
	
}

-- inner workings. no need to modify.
local PilotPersonality = {}

function PilotPersonality:GetPilotDialog(event)
	if self[event] ~= nil then 
		if type(self[event]) == "table" then
			return random_element(self[event])
		end
		
		return self[event]
	end
	
	--LOG("No pilot dialog found for an event!")
	LOG("No pilot dialog found for "..event.." event in "..self.Label)
	return ""
end

Personality[personality] = PilotPersonality
for trigger, texts in pairs(tbl) do
	if
		type(texts) == 'string' and
		type(texts) ~= 'table'
	then
		texts = {texts}
	end
	
	assert(type(texts) == 'table')
	Personality[personality][trigger] = texts
end
