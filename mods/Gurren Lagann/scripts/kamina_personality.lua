return {
	--Custom lines
	GIGADRILLBREAKER = {
		"Giga... Drill... BREAKER!",
		-- "This drill is humanity's soul! It's my soul! Do you seriously think it's gonna be wiped out by the likes of you?!"
	},
	
    -- Game States

    --This happens at the start of a new game
    Gamestart = {
        "Kick logic to the curb and do the impossible!",
        "The great Kamina has arrived!",
    },
    --Happens on the island screen after finding the FTL pilot in a pod.
    FTL_Found = {
        "You were stuck in that tin can? Well, get out here and show me your fighting spirit!",
        "Another member for Team Dai-Gurren! Don't worry about the logic, just kick reason to the curb!",
        "An alien? Hah! As long as you've got a burning soul, you're one of us!",
		"I don't care if you're an alien! As long as you are fighting by my side, we are soul brothers!"
    },
    --Happens after you start a new game with an FTL pilot.
    FTL_Start = {
        "I don't care where you're from, space-man! I only care about where we're going - straight to the top!",
        "Different worlds, same sky! Let's pierce through them all!",
    },
    --Start of new game after winning
    Gamestart_PostVictory = {
        "New timeline, same story! We kick logic to the curb and do the impossible!",
        "We won once, we'll win again! That's the way Team Dai-Gurren rolls!",
        "My drill is the drill that creates the heavens! Let's save this world too!",
    },
    --If this unit is dead, but gets repaired
    Death_Revived = {
        "I'm not dead yet! A real man never dies, even if he's killed!",
        "Did you think that was enough to stop the mighty Kamina?!",
    },
    --If this unit dies.
    Death_Main = {
        "Later... buddies...",
    },
    --If another unit dies.
    Death_Response = {
        "Don't look away! Etch this into your soul! This is the path #main chose!",
        "#main!! You idiot... you weren't supposed to go before me!",
        "Grit those teeth! We carry their spirit with us now!",
    },
    --If another Mech dies but it doesn't have a pilot to die.
    Death_Response_AI = {
        "Tch. Just a hunk of metal. It didn't have enough fighting spirit!",
        "We lost a machine, but we haven't lost the fight! Keep moving!",
    },
    --Last thing pilot says before time traveling after a victory.
    TimeTravel_Win = {
        "Our drill will pierce through time itself! On to the next battle!",
        "This victory is just the beginning! We're heading for the horizon!",
        "So long, space! Team Dai-Gurren is moving out!",
    },
    --Right when you lose
    Gameover_Start = {
        "Damn it! We didn't have enough fighting spirit... We have to retreat!",
        "Not here! I refuse to let it end here! We're trying again!",
        "Grr... We'll come back! Ten times - no, a hundred times stronger!",
    },
    --Response to above
    Gameover_Response = {
        "Don't you dare give up! We'll spin on back and fix this mess!",
        "Lift your head up! We're just taking a detour to victory!",
    },

    -- UI Barks
    --Turn on a new weapon.
    Upgrade_PowerWeapon = {
        "Now that's some firepower! Time to combine!",
        "Heh. With this, I'll blast a hole straight through the universe!",
        "A new weapon for a new legend!",
    },
    --If you have no weapon powered.
    Upgrade_NoWeapon = {
        "Hey! Are you trying to make me fight with my bare hands? ...Because I will!",
        "I need a weapon! How am I supposed to drill without a drill?!",
    },
    --Diverting reactor power to either Health or Move
    Upgrade_PowerGeneric = {
        "More power! More speed! More everything!",
        "That's it! Pour that energy right into the engine!",
    },

    -- Mid-Battle
    --Generic mission start
    MissionStart = {
        "Just who the hell do you think I am?!",
        "Let's see ya grit those teeth!",
        "Alright, you ugly bastards! Come and get some!",
        "I'll break through the heavens and the earth! Just watch me!",
		"The reputation of #squad echoes far and wide. When they talk about its badass leader - the man of indomitable spirit and masculinity - they're talking about me! The mighty Kamina!"
    },
    --Triggers after a turn reset
    Mission_ResetTurn = {
        "If you mess up, you just rewrite the story! That's how Team Dai-Gurren rolls!",
        "Hold on! My soul is telling me that was the wrong move!",
        "Let's try that again! With more guts this time!",
    },
    --Generic mission end where enemies are all killed
    MissionEnd_Dead = {
        "That's how we do it! A man's soul burns hottest in the aftermath!",
        "Too easy! Bring me something bigger next time!",
        "They never stood a chance against the mighty Kamina!",
    },
    --Generic mission end when enemies retreat
    MissionEnd_Retreat = {
        "Yeah, you better run! And don't come back!",
        "Running away? They couldn't handle our combination!",
        "Cowards! A real warrior faces his destiny head-on!",
    },

    --Plays at the start of the final mission
    MissionFinal_Start = {
        "This is it! The final drill! We're gonna pierce the heavens with this one!",
        "Everything has led to this moment! Don't blink!",
        "Let's go! We'll show them the power of the human race!",
    },
    --Incoming power pylons
    MissionFinal_StartResponse = {
        "Power from the sky? Hah, looks like the heavens are on our side!",
        "Grab that power and don't let go!",
    },
    --Plays at the start of the ground falling in the final mission
    MissionFinal_FallStart = {
        "The earth is crumbling? Then we'll fight in the air!",
        "Who cares about the ground?! We aim for the top!",
    },
    --Plays once the ground shakes
    MissionFinal_FallResponse = {
        "Whoa! Keep your footing! The world can't handle our weight!",
        "Let it shake! It just makes the battle more exciting!",
		"Hah! This is the last time I go back underground!",
    },
    --Before dropping the bomb
    MissionFinal_BombResponse = {
        "There's no drill big enough for this hive! Cover the bomb!",
        "We're gonna blow this hive sky high!",
    },
    --Plays at the start of the final cave section
    MissionFinal_CaveStart = {
        "Underground? This is where I started! I know how to drill out of here!",
        "Darkness is just a canvas for us to shine on!",
    },
    --When the bomb is destroyed
    MissionFinal_BombDestroyed = {
        "They broke the bomb? Then bring another one! We never stop!",
        "Don't panic! We'll just have to try harder!",
    },
    --When the bomb is armed
    MissionFinal_BombArmed = {
        "It's ready! Get ready for the fireworks!",
        "This is the end for you, bug-faces!",
    },

    --Pod is about to fall
    PodIncoming = {
        "A present from the stars? Heads up!",
        "Something's coming down! Let's grab it!",
    },
    --Response to above
    PodResponse = {
        "Don't let the bugs get that pod! It's ours!",
        "Secure the package! Might be something cool inside!",
    },
    --Pod collected
    PodCollected_Self = {
        "Got it! Let's see what treasure we dug up!",
        "Mine! Maybe it's a new pair of shades...",
    },
    --Pod destroyed
    PodDestroyed_Obs = {
        "Hey! That was ours! You'll pay for that!",
        "They smashed the loot! Unforgivable!",
    },
    --Secret object was inside a mountain
    Secret_DeviceSeen_Mountain = {
        "There was something inside the rock! Good thing we smashed it!",
        "A secret in the mountain? Looks ancient!",
    },
    --Secret object was under water after destroying ice
    Secret_DeviceSeen_Ice = {
        "Look! Something was hiding under the ice!",
        "We cracked the ice and found a prize!",
    },
    -- Secret object used
    Secret_DeviceUsed = {
        "I don't know what this does, but it feels powerful!",
        "Ancient tech? Let's power it up with fighting spirit!",
    },
    -- Secret pod found
    Secret_Arriving = {
        "That pod looks different... It's glowing with energy!",
        "A special delivery? Just for me?",
    },
    --Emerges are queued
    Emerge_Detected = {
        "They're coming from below! Get ready to stomp 'em!",
        "More beastmen trying to surface? Not on my watch!",
    },
    --Vek Emerges
    Emerge_Success = {
        "They popped up! Alright, let's send 'em back down!",
        "Here they come! Don't flinch!",
    },
    --Mech blocks Emerging Vek
    Emerge_FailedMech = {
        "Blocked! You're not getting past me!",
        "Stay down! The surface belongs to us!",
        "I'm standing right here! Try moving me!",
    },
    --Vek Block Emerging Vek
    Emerge_FailedVek = {
        "Hah! They're blocking each other! Idiots!",
        "Even the bugs are fighting amongst themselves!",
    },

    -- Mech State
    --Mech has 1 hp.
    Mech_LowHealth = {
        "Just a scratch! My fighting spirit hasn't even started burning yet!",
        "I don't need armor! I have guts!",
        "This isn't over! I can still fight!",
    },
    --Mech is webbed
    Mech_Webbed = {
        "Get off me! You can't tie down a man's soul!",
        "Webs? Gross! I'll rip this stuff apart!",
        "Hey! Let go! I've got places to be!",
    },
    --Mech is shielded
    Mech_Shielded = {
        "A barrier? Nice! But I prefer offense over defense!",
        "Invincible! Nothing can touch me now!",
    },
    --Mech uses repair.
    Mech_Repaired = {
        "Patched up and ready to rock!",
        "Good as new! Let's get back in there!",
		"We brawlers are sustained by willpower!"
    },
    --Pilot levels up
    Pilot_Level_Self = {
        "I can feel the power surging! I'm evolving!",
        "This is the power of the spiral! I'm getting stronger every second!",
        "Who the hell do you think I am? I'm just getting started!",
    },
    --Pilot is observed to level up
    Pilot_Level_Obs = {
        "Yeah! That's it! Show me what you got!",
        "You're getting stronger! Don't let it go to your head!",
    },
    --Mech's shield is removed
    Mech_ShieldDown = {
        "Shield's gone! Now it's a real man's fight!",
        "Bah! I didn't need that bubble anyway!",
    },

    -- Damage Done
    --Vek drowns
    Vek_Drown = {
        "Take a bath, you filthy beast!",
        "Sunk 'em! They won't be coming back up!",
    },
    --Vek falls down a hole
    Vek_Fall = {
        "Go back to the hole you crawled out of!",
        "Gravity works! Catch ya later!",
    },
    --Vek is put in smoke
    Vek_Smoke = {
        "Can't hit what you can't see!",
        "Smoke 'em out! They're confused!",
    },
    --Vek is frozen
    Vek_Frozen = {
        "Chill out! Hah!",
        "Frozen solid! Look at 'em, stuck like a statue!",
    },
    --Self killed Vek
    VekKilled_Self = {
        "Take that! Straight to the face!",
        "One down! Who's next?!",
        "That's the power of #squad!",
    },
    -- Ally killed Vek
    VekKilled_Obs = {
        "Nice shot! You've got guts, kid!",
        "That's it! Keep that momentum going!",
        "Awesome! Let's combine our attacks!",
    },
    -- Vek killed Vek
    VekKilled_Vek = {
        "Hah! They're taking each other out!",
        "Friendly fire? More like friendly help!",
    },
    --Self killed two Vek
    DoubleVekKill_Self = {
        "Two birds with one stone! Or two bugs with one drill!",
        "Out of my way! I'll take you all on!",
    },
    --Ally killed two Vek
    DoubleVekKill_Obs = {
        "Whoa! Did you see that?! Amazing!",
        "Double kill! That's what I'm talking about!",
    },
    --Vek killed two Vek
    DoubleVekKill_Vek = {
        "They're clumsy! Let 'em destroy each other!",
        "Look at that chaos! It's beautiful!",
    },
    --Self destroyed Mountain
    MntDestroyed_Self = {
        "If it's in my way, I'll smash it! Mountain or not!",
        "I'll drill a path straight through the earth!",
    },
    --Ally destroyed Mountain
    MntDestroyed_Obs = {
        "Yeah! Break it down! Clear the path!",
        "Nothing stands in our way! Not even mountains!",
    },
    --Vek destroyed Mountain
    MntDestroyed_Vek = {
        "Hey, watch the scenery! You're making a mess!",
        "They're tearing up the landscape!",
    },
    --Grid power is critical
    PowerCritical = {
        "The people are counting on us! Don't let the lights go out!",
        "We're on the edge! But that's when we shine the brightest!",
        "Protect the grid with your life! Grit your teeth!",
    },
    --Self destroyed building
    Bldg_Destroyed_Self = {
        "Damn it! I got carried away!",
    },
    --Ally destroyed building
    Bldg_Destroyed_Obs = {
        "Hey! Watch where you're aiming!",
        "You destroyed a house! Focus, damn it!",
    },
    --Vek destroyed building
    Bldg_Destroyed_Vek = {
        "Those monsters! They're targeting the people!",
        "I won't forgive you! You'll pay for that!",
    },
    --Building resisted with Grid
    Bldg_Resisted = {
        "Yeah! The people's spirit held strong!",
        "Lucky! The defenses held!",
    },

    -- Shared Missions
    --Train damaged
    Mission_Train_TrainStopped = {
        "The train's hit! Protect the cargo!",
        "Don't let them hit it again!",
    },
    --Train totally destroyed
    Mission_Train_TrainDestroyed = {
        "We lost the train! Damn it all!",
        "I failed to protect them...",
    },
    --Remind player to block emerging Vek
    Mission_Block_Reminder = {
        "Don't let 'em come up! Stomp 'em down!",
        "Put a lid on it! Block those holes!",
    },

    -- Archive
    --Airstrike Incoming
    Mission_Airstrike_Incoming = {
        "Air support! Rain hell on 'em!",
        "Here comes the cavalry! clear the way!",
    },
    --Both tanks activated
    Mission_Tanks_Activated = {
        "Tanks are rolling! Heavy metal backup!",
        "Alright! The old tech still has some kick!",
    },
    --Only one tank activate
    Mission_Tanks_PartialActivated = {
        "We've only got one tank? Better than nothing!",
        "One tank is enough if it's got spirit!",
    },
    -- Reminder to destroy dam
    Mission_Dam_Reminder = {
        "Break that dam! Wash 'em away!",
        "Smash the wall! Let the water flow!",
    },
    -- Dam destroyed
    Mission_Dam_Destroyed = {
        "Flood 'em out! Yeah!",
        "Water power! Cleanse the earth!",
    },
    --Trigger when first satellite is destroyed
    Mission_Satellite_Destroyed = {
        "We lost a rocket! Keep the other one safe!",
        "They smashed the launch! Don't let it happen again!",
    },
    --Triggers when the Satellite queues its launch
    Mission_Satellite_Imminent = {
        "It's about to launch! Clear the sky!",
        "Blast off imminent! Hold the line!",
    },
    --Triggers when the satellite actually takes off
    Mission_Satellite_Launch = {
        "Go! Fly to the stars!",
        "Piercing the heavens! Look at it go!",
    },
    --Vek Killed by Mine
    Mission_Mines_Vek = {
        "Boom! Watch your step!",
        "Blown to bits! Hah!",
    },

    -- RST
    --If the terraformer is destroyed
    Mission_Terraform_Destroyed = {
        "The machine's busted! We needed that!",
        "They wrecked the terraformer! Uncool!",
    },
    --After the player uses the terraformer
    Mission_Terraform_Attacks = {
        "Turn the earth into a weapon! Yeah!",
        "Reshape the battlefield! That's the spirit!",
    },
    --Triggers when ground is falling
    Mission_Cataclysm_Falling = {
        "The ground's giving way! Watch your step!",
        "The whole island is crumbling! Stay mobile!",
    },
    --If lightning hits a Vek
    Mission_Lightning_Strike_Vek = {
        "Struck by lightning! The sky hates you too!",
        "Fried bug! Smells like victory!",
    },
    --Solar panel destroyed
    Mission_Solar_Destroyed = {
        "They smashed the panels! We need that power!",
        "Hey! Don't touch the glass!",
    },
    --Remind player to destroy the mountains
    Mission_Force_Reminder = {
        "We need to clear these mountains! Start drilling!",
        "Smash those rocks! Make some room!",
    },

    -- Pinnacle
    --Vek Frozen by Mine.
    Mission_Freeze_Mines_Vek = {
        "Ice trap! Stay cool, ugly!",
        "Frozen in their tracks!",
    },
    --Bot Factory destroyed
    Mission_Factory_Destroyed = {
        "The factory's gone! That's a waste of good metal!",
        "We failed to protect the tech!",
    },
    --Bot Factory spawning
    Mission_Factory_Spawning = {
        "Here comes a robot! Hope it's friendly!",
        "New bot rolling out! Is it with us or against us?",
    },
    --A selection of enemies on the map are freed from ice
    Mission_Reactivation_Thawed = {
        "They're thawing out! Get ready for round two!",
        "The ice is melting! Wake up call!",
    },
    --Snowstorm freezes Vek
    Mission_SnowStorm_FrozenVek = {
        "The storm got 'em! Nice!",
        "Frozen solid by the wind! Stay frosty!",
    },
    --Snowstorm freezes speaking Mech
    Mission_SnowStorm_FrozenMech = {
        "I'm frozen! My hot blood will melt right through this!",
        "Too cold! I need to burn hotter!",
    },
    --Player kills a hostile Bot
    BotKilled_Self = {
        "Scrap metal! Sorry, robot!",
        "You were in my way! Down you go!",
    },
    --Player is observed to kill a hostile Bot
    BotKilled_Obs = {
        "Turning 'em into scrap! Nice work!",
        "Good job, #main!",
    },

    -- Detritus
    --Player was supposed to defend the Disposal unit and it was destroyed
    Mission_Disposal_Destroyed = {
        "The disposal unit is toast! That's bad!",
        "We lost the acid gun! Fight harder!",
    },
    --Player uses Disposal Unit
    Mission_Disposal_Activated = {
        "Melt 'em down! Acid shower!",
        "Time for a chemical bath! Yeah!",
    },
    --A.C.I.D. barrel destroyed
    Mission_Barrels_Destroyed = {
        "Splash! Acid everywhere!",
        "Pop goes the barrel! Hope they like the burn!",
    },
    --Power plant is destroyed
    Mission_Power_Destroyed = {
        "Power plant down! We're losing energy!",
        "They hit the generator! Protect the grid!",
    },
    --Mech teleports
    Mission_Teleporter_Mech = {
        "Instant transmission! I'm everywhere!",
        "Warp speed! You can't catch me!",
    },
    --Mech moves on conveyor
    Mission_Belt_Mech = {
        "Riding the rails! This is kinda fun!",
        "Moving without walking! Technology is wild!",
    },
}