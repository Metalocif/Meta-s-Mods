-- Adds a personality without the use of a csv file.

-- Unique identifier for personality.
local personality = "EvaAsuka"

-- Table of responses to various triggers.
local tbl = {
	--Game States
	Gamestart = {"Alright! Time to show everyone how it's done.", "Eyes on me, everyone; this is how a real pilot saves the world."},
	FTL_Found = {"Is this an extraterrestrial? Take that, Fermi!"},		--Asuka is supposed to be university-educated
	FTL_Start = {"Is this being an ally of humanity, or of Angels?"},	--this can trigger in a custom squad, I think
	Gamestart_PostVictory = {},	--should never trigger
	Death_Revived = {"...Mother?", "I thought... I thought I was dead.", "This can't be happening..."},
	Death_Main = {},	--goes berserk, we don't want this to trigger
	Death_Response = {"#main_first!"},
	Death_Response_AI = {"Hah. This is why the world needs us."},
	TimeTravel_Win = {"Piece of cake.", "I expect statues of me.", "Good job, you two. I guess you weren't completely useless out there."},
	Gameover_Start = {"What...! I failed?"},
	Gameover_Response = {"My Unit 02 is running out of power!"},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"Yes, give the cores to me. It's not like the others would make great use of them."},
	Upgrade_NoWeapon = {"You give that back!", "Is this meant to be a challenge?", "Even the greatest of pilots needs weapons, you know."},
	Upgrade_PowerGeneric = {"Yes, give the cores to me. It's not like the others would make great use of them."},
	
	-- Mid-Battle
	MissionStart = {"Here I go!", "Stand back and cheer for me.", "Don't get in my way, you two."},
	Mission_ResetTurn = {"Incredible... To think of the energies required to open a breach...", "A great way to correct the mistakes of the other Children."},
	MissionEnd_Dead = {"I did it!", "Good job, team.", "As long as you keep following my lead, everything will work out."},
	MissionEnd_Retreat = {"Tch! At least they're gone."},

	MissionFinal_Start = {"Sorry, but I am not diving in lava again.", "Did we check nothing is inside that volcano?"},
	MissionFinal_StartResponse = {"Unit 02 charged!", "Time to save the world!"},
	MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"Aaaaaaaaaaaaaaaah!"},
	MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"This place is... like the Geofront, somehow?"},
	MissionFinal_BombResponse = {"Nice, a big bomb. How... sophisticated."},
	MissionFinal_CaveStart = {"Don't let them touch the bomb!"},
	MissionFinal_BombDestroyed = {"Don't mess it up again!"},
	MissionFinal_BombArmed = {"Okay, let's evacuate."},

	PodIncoming = {"Time travel should not be possible. This technology is fascinating."},
	PodResponse = {"Let's rescue whoever is insane."},
	PodCollected_Self = {"Alright, I'm done with the rescue mission."},
	PodDestroyed_Obs = {"Scheisse!"},
	Secret_DeviceSeen_Mountain = {"There is something inside the mountain."},
	Secret_DeviceSeen_Ice = {"Something shines under the ice."},
	Secret_DeviceUsed = {"My Eva just used it on its own."},
	Secret_Arriving = {"What is this?"},
	Emerge_Detected = {"Uh, more Vek are coming."},
	Emerge_Success = {"I will not run away!"},
	Emerge_FailedMech = {"Don't - come - any - closer..."},
	Emerge_FailedVek = {"That's perfect!"},

	-- Mech State
	Mech_LowHealth = {"Scheisse!"},
	Mech_Webbed = {"Verdammt!"},
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
	Mission_tosx_Juggernaut_Destroyed = { "I'm sorry.",},
	Mission_tosx_Juggernaut_Ram = {"Whoa! Be careful, everyone."},
	Mission_tosx_Zapper_On = {"We can zap them from far away? Great!"},
	Mission_tosx_Zapper_Destroyed = {"I'm sorry.",},
	Mission_tosx_Warper_Destroyed = {"I'm sorry.",},
	Mission_tosx_Battleship_Destroyed = {"I'm sorry."},
	
	
	
	
	
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
