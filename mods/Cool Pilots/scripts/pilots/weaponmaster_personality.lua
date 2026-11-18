
return {
	--Game States
	Gamestart = {"Instructor Phalanx, here to train newbies from the battlefield.","Hello, commander. I did notice the weaker mettle of recent recruits, but I never thought they would turn to an old robot like me.","It is time for me to apply that which I taught to so many."},
	FTL_Found = {"Come from the stars to help us fight? Glorious.","I've never taught an alien before. New firsts, at my age!"},
	FTL_Start = {},
	Gamestart_PostVictory = {"Former Instructor Phalanx, here to save another timeline."},
	Death_Revived = {"Hah! Me, die? I was just teaching Death how to wield a scythe properly!","I know every weapon there will ever be. How to use them, and how to counter them. Deathly scythes included!"},
	Death_Main = {"No! Without me, they can't tell a reticle from a clavicle!","My pupils, make me proud.", "And so I die, after I sent so many to die themselves.","Dulce et decorum est pro mundia mori.","I fall as all weapons eventually do - spent, scarred, and replaced.","Remember what I taught you."},
	Death_Response = {"You were a fine soldier. Never again shall we see your like.","#main_first's bravery will inspire us.","Let's avenge #main_first.","A soldier like #main_first is not replaced. He is studied."},
	Death_Response_AI = {"Oh.","One less weapon in our arsenal."},
	TimeTravel_Win = {"Whatever the timeline, I will fight; whatever the weapon, I'll wield it.","And so our campaign starts anew. Perhaps I will learn something from it this time.", "Let this be my final lesson to you: there is no stronger weapon than time, for it falls all warriors."},
	Gameover_Start = {"We lost? I failed? I sent so many to die... in vain?","I see. I'll make sure to cover that in next timeline's 'How to kill Vek' crash course.","To think we lost to bugs that never bothered to invent rifles. Disgraceful."},
	Gameover_Response = {"Perhaps you were not taught as well as I remember.","Let's move on. A new timeline. Perhaps new weapons - better weapons.","The Vek will fight the same war twice. We will not."},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"Ah, yes, I know this one.","Not my favourite weapon, but it'll do.","I once saw a private destroy his captain's office with that! Unintentionally, I'm sure.","You wouldn't happen to have the Mk. 2 version of that? Mk. 1 is a little... underpowered for my taste.", "How about a paint job? It's a cheap way to buy morale! ... What do you mean you can't spare 90 gallons of golden paint?", "With every weapon, the first lesson is: which one is the business end?"},
	Upgrade_NoWeapon = {"And what is a weaponmaster without its weapons?","I was using that.","Should I just go back to instructing newbies?","Oh, are you finally giving it the paint job I asked for? I was thinking golden accents would be a good compromise..."},
	Upgrade_PowerGeneric = {"And let that be a lesson to you all: the strongest weapon is nothing without a strong body.","Perhaps we could put more of those cores in my weapons?"},
	
	-- Mid-Battle
	MissionStart = {"Follow my example and you'll be back home in one piece.","We are wielding the greatest weapons ever made, the culmination of thousands of years.", "HQ keeps denying my requests for paint jobs. Bug blood will have to do!", "Oh, I think I taught that exact situation back in the days.", "What use is a weapon that never fires? What good a soldier that never fights?", "These weapons were forged to save humanity. Their makers will be proud."},
	Mission_ResetTurn = {"And let that be a lesson to you all: no one does perfect the first time! Let's not give the Vek a second chance, now.", "Learn from what I showed you a moment ago.", "...oh, no, I hate repeating myself.", "I'm sorry, I was giving an important lesson, could you wait until I'm done before you do that?", "Okay, enough practice."},
	MissionEnd_Dead = {"Complete victory, as expected!","And let that be a lesson to you all: to kill a Vek, aim at the kneecaps.","Good job, recruits.","You made me proud today.","You've learnt well."},
	MissionEnd_Retreat = {"A tactical victory is better than a pyrrhic defeat.","Let them run; we won't cull the invasion by killing one Vek at a time.","Don't give chase; nothing is more dangerous than a cornered beast."},

	MissionFinal_Start = {"A fantastic backdrop for the end of our epic.","Without power, our weapons are as useless as a cast iron sword.","Finally, retaliation."},
	MissionFinal_StartResponse = {"A lovely tool. We need nothing but courage now.","You know, kinetic bombardment can be devastating. Why not just drop those on the Vek?"},
	MissionFinal_FallStart = {"Descent underway. Gravity remains undefeated.", "Brace yourselves. Final exams are rarely gentle."},
	MissionFinal_FallResponse = {"As we fall, our spirits rise.", "Land on your feet. Whatever is in there won't be friendly.", "Cornered armies fight to the death. Be wary."},
	MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"We don't need to slay. We need to destroy. Our weapons are not adequate.", "It is time for a firepower upgrade, don't you think?"},
	MissionFinal_BombResponse = {"New assignment: protect the bomb."},
	MissionFinal_CaveStart = {"We must protect the bomb. Pylons and your own mechs come second.","One last battle.","Make me proud."},
	MissionFinal_BombDestroyed = {"We need another."},
	MissionFinal_BombArmed = {"My compliments to Mr. Renfield.","I don't think bombs are very elegant, but the Vek wouldn't know elegance if it slapped them in the face! And I would know.","Well, playing soldier was fun, but I miss teaching."},

	PodIncoming = {"Oh, a Time Pod. Someone, somewhen, thought our weapons were lacking. They are right.","I have an idea for a weapon: a rifle that fires into the past."},
	PodResponse = {"'Dibs' on swords and lances.","I understand the appeal of Christmas better now."},
	PodCollected_Self = {"A gift from the future. Perhaps an unknown weapon - to you, not me, of course.","Any improvement to our arsenal is welcome.","I have been looking to branch out."},
	PodDestroyed_Obs = {"No!","We needed that.","We had no choice."},
	Secret_DeviceSeen_Mountain = {"Something shines within the mountain. A Vek nest?","What is in there?"},
	Secret_DeviceSeen_Ice = {"I see something under the ice. A weapon? A Vek? …something else?"},
	Secret_DeviceUsed = {"I'm not sure what that did."},
	Secret_Arriving = {"I've never seen such a device before. Impossible!"},
	Emerge_Detected = {"More Vek are coming. Why do they always get reinforcements and we don't?"},
	Emerge_Success = {"More Vek to kill.","Okay, these are yours."},
	Emerge_FailedMech = {"And let that be a lesson to you all: the easiest way to cull your enemy's numbers is to prevent them from reaching the battlefield."},
	Emerge_FailedVek = {"A cheap trick, but an effective one.","One less Vek to worry about - for now."},

	-- Mech State
	Mech_LowHealth = {"All part of the plan, I assure you.","It's impressive my mech is still able to fight; this speaks for proper weapon care.", "Nothing like a brush with death!", "Come, beasts. I am ready."},
	Mech_Webbed = {"Hah. The retiarius technique? How primitive.","Fool! I am trained in all forms of combat, including grappling!","Let me demonstrate how to act while restrained."},
	Mech_Shielded = {"And let that be a lesson to you all: the best offense is a good defense. Oh, you already knew that?","With enough protection, risks can be taken that enable new offensive strategies.", "Historically, a pike and a shield was the most effective gear by far.","One day, mankind will take to the stars and trade with the aliens for their secret technology: shields that are not blue."},
	Mech_Repaired = {"And let that be a lesson to you all: a good warrior takes care of its gear.", "Superb, time to go back to the fight."},
	Pilot_Level_Self = {"Ah, I just... had a realization. How strange.","Wait, why did I not do this before?", "It seems the simtraining I went through did not teach me everything after all.", "Even instructors benefit from practice."},
	Pilot_Level_Obs = {"I see you listened to my lessons carefully.","Oh, you paid attention."},
	Mech_ShieldDown = {"No more shield. Good. Their blue hue prevents me from taking in the gore of vanquished Vek.","No more shield. Good. Their blue hue prevents Vek from taking in the sight of their slayer.","Without a shield, rely on armor. Without armor, rely on your shield. Without either, run."},

	-- Damage Done
	Vek_Drown = {"And let that be a lesson to you all: a warrior's greatest weapon is... water? No, that can't be right...  ","Farewell!","Remember this: terrain is merely a weapon awaiting activation."},
	Vek_Fall = {"Always let physics do the work for you. Gravity is one example.","And let that be a lesson to you all: gravity always wins, don't fight it.","I want that pit filled to the brim with Vek corpses!"},
	Vek_Smoke = {"And let that be a lesson to you all: stay unseen. An unseen warrior is a safe warrior.","Smoke is great! Not only does it prevent a Vek from attacking, it lingers, making for a safe space.","You can't kill what you can't see."},
	Vek_Frozen = {"And let that be a lesson to you all: a frozen Vek is more or less a dead Vek.","Don't let them free it. I'm keeping it as a trophy!"},
	VekKilled_Self = {"Behold!","Hah! I have seen that from every angle in a thousand thousand simulations!","You are welcome, people of Earth!","Learn from my example.","Have you ever seen such a majestic kill?", "I am recording all this, of course."},
	VekKilled_Obs = {"Oh, not bad.","Stylish.","Your handling needs work, but that was very nice."},
	VekKilled_Vek = {"And let that be a lesson to you all: never interrupt your enemy while it is making a mistake.","Inelegant, but what would you expect from beasts?", "I won't let you steal my spotlight!"},

	DoubleVekKill_Self = {"And let that be a lesson to you all: if you find a way to kill one Vek, keep looking.","Oh, what would you do without your instructor?","As one of the recruits said the other day: 'A true warrior doesn't mind getting his sword bloody'. He'll be a fine soldier. Rest of his group, not so much - they thought it was a joke!","I was shown a documentary about a sniper during my training phase which emphasized the importance of efficiency. It left an impression on me."},
	DoubleVekKill_Obs = {"That was impressive.","I am proud.","Well struck!", "That's right!", "Very efficient! I approve."},
	DoubleVekKill_Vek = {"Recruits, that Vek is doing better than you.","I see potential in this one.", "Have we ever thought about recruiting and training Vek?"},

	MntDestroyed_Self = {"Such power at my disposal.","These weapons are very effective.", "I wish we could make such easy work of the Vek Hive."},
	MntDestroyed_Obs = {"No, that was not a Vek. I guess they look similar from an angle.","Remember, you should be aiming at the Vek.", "If you can shatter a mountain, you can shatter a Vek."},
	MntDestroyed_Vek = {"I'd rather they hit the mountains instead of us.","A natural shield."},

	PowerCritical = {"Let's remember that we can't fight without power.","The top priority of a soldier is to stay alive. Keep our mechs functional!", "Perhaps humans forget this more easily, but we need the Grid to fight."},
	Bldg_Destroyed_Self = {"Sometimes, in war, you have to do terrible things.","I couldn't see any other way.","I know my weapons, and it was the only way."},
	Bldg_Destroyed_Obs = {"Perhaps you were asleep during our first class, but the Vek look like bugs, not buildings!","Your aim is off!"},
	Bldg_Destroyed_Vek = {"If this was just target practice to you before...","Avenge these people!", "Let your grief sharpen your weapons!"},
	Bldg_Resisted = {"Our gamble paid off."},


	-- Shared Missions
	Mission_Train_TrainStopped = {"I wish we could repair it.", "Protect whatever is left!"},
	Mission_Train_TrainDestroyed = {"It can't be helped at this point."},
	Mission_Block_Reminder = {"Remember, the Vek cannot be allowed to emerge here!","A blocked Vek is as good as a dead Vek... for a minute or so."},

	-- Archive
	Mission_Airstrike_Incoming = {"Death from above... cowardly but effective.","These once changed the face of war, you know.","Air superiority once decided wars outright. Now it merely delays defeat. Still, do not stand beneath it."},
	Mission_Tanks_Activated = {"The greatest weapon in the world, or so it was a couple centuries ago.","I am fond of tanks. They are a midway point between medieval armor and today's mechs."},
	Mission_Tanks_PartialActivated = {"Go, soldier. Avenge your comrade."},
	Mission_Dam_Reminder = {"Remember to strike down that dam.","We have the greatest weapon of all against Vek... water, somehow... ready. Use it."},
	Mission_Dam_Destroyed = {"Good, now drown the rest.","Make use of that natural barrier."},
	Mission_Satellite_Destroyed = {"I'm surprised a giant barrel of fuel can be destroyed so easily."},
	Mission_Satellite_Imminent = {"It's going to explode beautifully, but stay far away.","That's my favourite part."},
	Mission_Satellite_Launch = {"The greatest weapon of all, information...","And away it goes, into the stars."},
	Mission_Mines_Vek = {"A cowardly weapon.","Be mindful of those."},

	-- RST
	Mission_Terraform_Destroyed = {"And let that be a lesson to you all: great power is useless without enough range to use it.", "Another reminder that a weapon’s limitations matter more than its potential."},
	Mission_Terraform_Attacks = {"Devastating, but fragile.","I would like that mounted on a mech."},
	Mission_Cataclysm_Falling = {"Let's give gravity a little help."},
	Mission_Lightning_Strike_Vek = {"Nature can be a deadly enemy. Always be prepared for the unexpected.","Our weapons are deadly, but nature can be even deadlier."},
	Mission_Solar_Destroyed = {"Without the Grid, our weapons are useless.","The Vek are trying to deprive us of supplies. Smart."},
	Mission_Force_Reminder = {"How about some target practice, recruits? I'd be surprised if you missed those.","Time to destroy those mountains."},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {"They're not dead. Be mindful of the ice."},
	Mission_Factory_Destroyed = {"I wish these robots were willing to cooperate a little more."},
	Mission_Factory_Spawning = {"Autonomous weapons are never trusted, and neither should they."},
	Mission_Reactivation_Thawed = {"The Vek are thawing out... perhaps we could greet them warmly."},
	Mission_SnowStorm_FrozenVek = {"The weather is our ally.","General Winter claims another.","And let that be a lesson to you all: the cold is still and silent, but as lethal as fire."},
	Mission_SnowStorm_FrozenMech = {"Frozen, but not in fear."},
	BotKilled_Self = {"And let that be a lesson to you: sometimes, even allies can become threats.","Their subpersona routines are no match for our skills."},
	BotKilled_Obs = {"Good, good."},

	-- Detritus
	Mission_Disposal_Destroyed = {"And let that be a lesson to you all: great power is useless without mobility."},
	Mission_Disposal_Activated = {"Such a devastating weapon.","Let's protect it with our lives."},
	Mission_Barrels_Destroyed = {"Not only should we use the environment to our advantage, we should also modify it.","Use the A.C.I.D. pits to drown the Vek."},
	Mission_Power_Destroyed = {"Our Mechs need power to run. Logistics win wars."},
	Mission_Teleporter_Mech = {"When every second counts, teleportation can save lives.", "With these teleporters, we have the element of surprise on our side. Use it to your advantage."},
	Mission_Belt_Mech = {"Positioning is the heart of tactics.","Slow, but any bit of speed is welcome."},
	
	-- Meridia
	Mission_lmn_Convoy_Destroyed = {"Logistics win wars."},
	Mission_lmn_FlashFlood_Flood = {"Our greatest weapon: water, somehow.","A natural barrier and a deadly weapon all in one."},
	Mission_lmn_Geyser_Launch_Mech = {"That may be useful to evade attacks."},
	Mission_lmn_Geyser_Launch_Vek = {"Our greatest weapon: water, somehow.","That's a lot of pressure."},
	Mission_lmn_Volcanic_Vent_Erupt_Vek = {"The unmatched power of nature."},
	Mission_lmn_Wind_Push = {"I doubt the Vek have meteorologists. Let's use that to our advantage."},
	Mission_lmn_Runway_Imminent = {"Work together to clear a path!","That plane will get to the skies on a runway of dead Vek!"},
	Mission_lmn_Runway_Crashed = {"Reminiscent of a kamikaze. Perhaps the greatest weapon is human life."},
	Mission_lmn_Runway_Takeoff = {"Excellent takeoff, but don't let your guard down.","Hopefully it's safe from hornets."},
	Mission_lmn_Greenhouse_Destroyed = {"The roses..."},
	Mission_lmn_Geothermal_Plant_Destroyed = {"We needed that power."},
	Mission_lmn_Hotel_Destroyed = {"We have no use for luxury residencies in a war."},
	Mission_lmn_Agroforest_Destroyed = {"These trees could have been spears for our soldiers... a couple millennia ago..."},


	
	-- Island missions
	Mission_tosx_Juggernaut_Destroyed = {
		"And let that be a lesson to you: glass is a very poor material to make a cannon.",
		"Brittle indeed.",
	},
	Mission_tosx_Juggernaut_Ram = {
		"Devastating, but brittle like unquenched steel.",
		"Perhaps we should steer it ourselves.",
	},
	Mission_tosx_Zapper_On = {
		"This seems like a very useful weapon.",
		"The power of lightning. I'd like more such weapons.",
	},
	Mission_tosx_Zapper_Destroyed = {
		"One less weapon in our arsenal.",
		"A shame.",
	},
	Mission_tosx_Warper_Destroyed = {
		"One less weapon in our arsenal.",
		"A shame.",
	},
	Mission_tosx_Battleship_Destroyed = {
		"And let that be a lesson to you: nothing good comes from staying in the water.",
	},
	Mission_tosx_Siege_Now = {
		"Be ready, everyone; this will be a grand battle.",
	},
	Mission_tosx_Plague_Spread = {
		"Chemical warfare... Ineffective and cruel, a weapon of terror. Disgusting.",
	},
	Mission_tosx_Sonic_Destroyed = {
		"One less weapon in our arsenal.",
	},
	Mission_tosx_Tanker_Destroyed = {
		"The water that kills Vek by its abundance kills humans by its absence.",
		"The water of life spills, and the sands drink it greedily."
	},
	Mission_tosx_Rig_Destroyed = {
		"We lost a brave man today.",
		"That man forged his own weapons."
	},
	Mission_tosx_GuidedKill = {
		"Perfectly targeted.",
		"We appreciate the support.",
	},
	Mission_tosx_NuclearSpread = {
		"Radiation. Terrifying.",
		"A terrible way to die for human, beast, and AI alike."
	},
	Mission_tosx_RaceReminder = {
		"We have a race to decide. Morale depends on the strangest things.",
		"Competition is a curious motivator. Remember that spectacle will not distract the Vek."
	},
	Mission_tosx_MercsPaid = {
		"They sell their lives dirt cheap.",
		"Funds for blood is the oldest barter."
	},
	Mission_tosx_RigUpgraded = {
		"Remarkable.",
		"Imagine what he could do in proper conditions."
	},
	
	
	
}