-- Adds a personality without the use of a csv file.

-- Unique identifier for personality.
local personality = "EvaShinji"

-- Table of responses to various triggers.
local tbl = {
	--Game States
	Gamestart = {"I am the pilot of Unit 01."},
	FTL_Found = {"A being from another world? Then, could Angels..."},
	FTL_Start = {"Sorry, I don't understand what you are saying."},	--this can trigger in a custom squad, I think
	Gamestart_PostVictory = {},	--should never trigger
	Death_Revived = {"My Eva was... protecting me?", "...What happened?", "For a moment, I felt like... Mother?"},
	Death_Main = {},	--goes berserk, we don't want this to trigger
	Death_Response = {"#main_first!"},
	Death_Response_AI = {"If only these could control Evangelions."},
	TimeTravel_Win = {"We won! Earth is saved!","Good job, everyone!", "Where are we going?"},
	Gameover_Start = {"No! We are running out of power!", "Can't... move...!"},
	Gameover_Response = {"Help!"},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"Thank you."},
	Upgrade_NoWeapon = {"Sorry, but I need something to fight... right?"},
	Upgrade_PowerGeneric = {"I didn't think my Eva could get any stronger."},
	
	-- Mid-Battle
	MissionStart = {"I mustn't run away.", "I mustn't run away, I mustn't run away, I mustn't run away..."},
	Mission_ResetTurn = {"What happened?"},
	MissionEnd_Dead = {"Are they cheering for us?"},
	MissionEnd_Retreat = {"I hope the people are safe."},

	MissionFinal_Start = {"Sorry, but I am not diving in lava again.", "Did we check nothing is inside that volcano?"},
	MissionFinal_StartResponse = {"Unit 01 charged!", "I will not run away!"},
	MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"Aaaaaaaaaaaaaaaah!"},
	MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"This hive is gigantic! We can't do this!"},
	MissionFinal_BombResponse = {"Is this some kind of N² technology?"},
	MissionFinal_CaveStart = {"Don't let them touch the bomb!"},
	MissionFinal_BombDestroyed = {"Sorry..."},
	MissionFinal_BombArmed = {"I don't want a bomb blowing up in my face again."},

	PodIncoming = {"What is this?", "Something from the future?"},
	PodResponse = {"I wonder whether I could go back to the past..."},
	PodCollected_Self = {"The pod is safe; I can go back to protecting people."},
	PodDestroyed_Obs = {"Oh no!"},
	Secret_DeviceSeen_Mountain = {"There is something inside the mountain."},
	Secret_DeviceSeen_Ice = {"Something shines under the ice."},
	Secret_DeviceUsed = {"My Eva just used it on its own."},
	Secret_Arriving = {"What is this?"},
	Emerge_Detected = {"Uh, more Vek are coming."},
	Emerge_Success = {"I will not run away!"},
	Emerge_FailedMech = {"Don't - come - any - closer..."},
	Emerge_FailedVek = {"That's perfect!"},

	-- Mech State
	Mech_LowHealth = {"I mustn't run away I mustn't run away I mustn't run away I mustn't run away I mustn't run away"},
	Mech_Webbed = {"Help! I'm trapped!"},
	Mech_Shielded = {"It's like an AT Field...", "I feel... safe."},
	Mech_Repaired = {},	--would trigger on casting an AT Field as well; we'll do voice events in the hook instead.
	Pilot_Level_Self = {"I feel like my synchronization rate is increasing!"},
	Pilot_Level_Obs = {"Wow, good job!", "Congratulations on your promotion."},
	Mech_ShieldDown = {"No, my shield!"},

	-- Damage Done
	Vek_Drown = {"Wow, so Vek really can't swim either.", "Neither humans nor Vek were made to float." },
	Vek_Fall = {"At least it's far away from me."},
	Vek_Smoke = {"Smoke..."},
	Vek_Frozen = {"Things shrink when they cool down..."},
	VekKilled_Self = {"Raah!"},
	VekKilled_Obs = {"You did it!"},
	VekKilled_Vek = {"Good for us."},

	DoubleVekKill_Self = {"Raaaaaaaah!"},
	DoubleVekKill_Obs = {"Amazing!"},
	DoubleVekKill_Vek = {"Good Vek?"},

	MntDestroyed_Self = {"I still can't believe my Evangelion is this strong."},
	MntDestroyed_Obs = {"Wow."},
	MntDestroyed_Vek = {"Are they confusing mountains for buildings?"},

	PowerCritical = {"Power batteries are running low!"},
	Bldg_Destroyed_Self = {"I am so sorry."},
	Bldg_Destroyed_Obs = {"Stop! There are people inside!"},
	Bldg_Destroyed_Vek = {"Sorry...", "I can't let people die again!"},
	Bldg_Resisted = {"I can't believe it!"},


	-- Shared Missions
	Mission_Train_TrainStopped = {"I'm sorry."},
	Mission_Train_TrainDestroyed = {"I'm sorry."},
	Mission_Block_Reminder = {"If we can, let's hold them back."},

	-- Archive
	Mission_Airstrike_Incoming = {"They are coming to help us!"},
	Mission_Tanks_Activated = {"Please stay safe!"},
	Mission_Tanks_PartialActivated = {"I'm sorry we couldn't protect the other."},
	Mission_Dam_Reminder = {"Hey, shouldn't we break that dam?"},
	Mission_Dam_Destroyed = {"I don't like water, but neither do they."},
	Mission_Satellite_Destroyed = {"I'm sorry."},
	Mission_Satellite_Imminent = {"Be careful!"},
	Mission_Satellite_Launch = {"It's flying away, safe at last."},
	Mission_Mines_Vek = {"They're not N², but I don't think our Evas can survive these."},

	-- RST
	Mission_Terraform_Destroyed = {"I'm sorry."},
	Mission_Terraform_Attacks = {"Whoa!"},
	Mission_Cataclysm_Falling = {"Be careful, everyone!"},
	Mission_Lightning_Strike_Vek = {"That's scary!"},
	Mission_Solar_Destroyed = {"I'm sorry."},
	Mission_Force_Reminder = {"I'm not sure I understand why, but we were asked to destroy mountains, weren't we?"},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {"We don't have to worry about this one."},
	Mission_Factory_Destroyed = {"I'm sorry."},
	Mission_Factory_Spawning = {"So many of these little robots."},
	Mission_Reactivation_Thawed = {"They're breaking free!"},
	Mission_SnowStorm_FrozenVek = {"At least they are not moving now."},
	Mission_SnowStorm_FrozenMech = {"Help, I'm stuck!"},
	BotKilled_Self = {"I'm sorry, little robot."},
	BotKilled_Obs = {"Nice!"},

	-- Detritus
	Mission_Disposal_Destroyed = {"I'm sorry."},
	Mission_Disposal_Activated = {"So strong!"},
	Mission_Barrels_Destroyed = {"Reminds me of that Angel…"},
	Mission_Power_Destroyed = {"I'm sorry."},
	Mission_Teleporter_Mech = {"Woah!"},
	Mission_Belt_Mech = {"That's very slow compared to my Eva."},
	
	-- Meridia
	Mission_lmn_Convoy_Destroyed = {"I'm sorry."},
	Mission_lmn_FlashFlood_Flood = {"Scary!"},
	Mission_lmn_Geyser_Launch_Mech = {"Aaaaaaaaaaaaah!"},
	Mission_lmn_Geyser_Launch_Vek = {"That's terrifying! Water from below?"},
	Mission_lmn_Volcanic_Vent_Erupt_Vek = {"Be careful, everyone!"},
	Mission_lmn_Wind_Push = {"Whoa!"},
	Mission_lmn_Runway_Imminent = {"They're going to take off, be careful!"},
	Mission_lmn_Runway_Crashed = {"I'm sorry."},
	Mission_lmn_Runway_Takeoff = {"They're safe."},
	Mission_lmn_Greenhouse_Destroyed = {"I'm sorry."},
	Mission_lmn_Geothermal_Plant_Destroyed = {"I'm sorry."},
	Mission_lmn_Hotel_Destroyed = {"I'm sorry."},
	Mission_lmn_Agroforest_Destroyed = {"I'm sorry."},


	
	-- Island missions
	Mission_tosx_Juggernaut_Destroyed = {
		"I'm sorry.",
	},
	Mission_tosx_Juggernaut_Ram = {
		"Whoa! Be careful, everyone."
	},
	Mission_tosx_Zapper_On = {
		"We can zap them from far away? Great!"
	},
	Mission_tosx_Zapper_Destroyed = {
		"I'm sorry.",
	},
	Mission_tosx_Warper_Destroyed = {
		"I'm sorry.",
	},
	Mission_tosx_Battleship_Destroyed = {
		"I'm sorry."
	},
	
	
	
	
	
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
