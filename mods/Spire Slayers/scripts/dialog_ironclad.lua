-- Ironclad Personality (Slay the Spire inspired, callback-heavy)
-- Gruff, haunted, obedient. Demon Blood, Burning Pact, strength through pain.
return {
-- Game States
Gamestart = {"The fire still burns. Give the order.", "Another climb. Another debt.", "I march because you command it."},
FTL_Found = {"A relic of steel and light. I do not trust it.", "This feels like cursed power.", "If it helps the climb, we use it."},
FTL_Start = {"Very well. I step forward.", "The path is chosen.", "I will endure."},
Gamestart_PostVictory = {"Victory does not lift the weight.", "The Spire taught me this feeling.", "We go on."},
Death_Revived = {"My blood refuses to cool.", "Not yet.", "Pulled back from the brink."},
Death_Main = {"The fire finally dims.", "My strength was spent.", "Use what I bought you."},
Death_Response = {"You fought well.", "Rest. Your climb ends.", "Your burden is over."},
Death_Response_AI = {"It served its purpose.", "A tool, well used.", "Acceptable."},
TimeTravel_Win = {"Another ascent awaits.", "The cycle turns again.", "Point the way."},
Gameover_Start = {"This climb fails.", "We fall here.", "The fire cannot carry us."},
Gameover_Response = {"Then we begin again.", "Choose a new path.", "I will carry it."},


-- UI Barks
Upgrade_PowerWeapon = {"The blade thirsts.", "Strength answers pain.", "Good."},
Upgrade_NoWeapon = {"Fists have carried me before.", "Steel is optional. Pain is not.", "I have fought with less."},
Upgrade_PowerGeneric = {"My guard tightens.", "I feel steadier.", "This helps the climb."},


-- Mid-Battle
MissionStart = {"I am ready.", "Give the signal.", "I will not falter."},
Mission_ResetTurn = {"Again.", "Endure.", "I can take more."},
MissionEnd_Dead = {"They are spent.", "The fire consumes them.", "Next."},
MissionEnd_Retreat = {"They flee.", "Let them remember this.", "We continue."},


MissionFinal_Start = {"This place feels eerie.", "Wrong. Hostile.", "Still, I advance."},
MissionFinal_StartResponse = {"If this is the cost, I pay it.", "I trust your call.", "Say when."},
MissionFinal_FallStart = {"I despise heights.", "This is not a fair fight.", "Hold together."},
MissionFinal_FallResponse = {"Never again.", "Steel should not fly.", "Focus."},
MissionFinal_Pylons = {"Strange things.", "I will protect them.", "They look magical."},
MissionFinal_Bomb = {"A weapon of finality.", "An explosive construct. I am familiar.", "I will guard it."},
MissionFinal_BombResponse = {"It hums with energy.", "Power always asks a price.", "I am listening."},
MissionFinal_CaveStart = {"Heat. Stone. Enemies.", "Familiar.", "I am ready."},
MissionFinal_BombDestroyed = {"That should have ended everything.", "Strange power.", "Be wary."},
MissionFinal_BombArmed = {"Then we leave.", "Cover the retreat.", "Move."},


PodIncoming = {"Something descends.", "Another test.", "I stand ready."},
PodResponse = {"If it fights, I answer.", "If it lives, we decide.", "Your call."},
PodCollected_Self = {"You rise with us.", "Your climb begins.", "Do not waste it."},
PodDestroyed_Obs = {"Unnecessary loss.", "A shame.", "We move on."},
Secret_DeviceSeen_Mountain = {"The mountain feels alive.", "Like a relic chamber.", "Dangerous."},
Secret_DeviceSeen_Ice = {"Frozen power.", "Contained for a reason.", "Proceed carefully."},
Secret_DeviceUsed = {"The pact is sealed.", "Stand ready.", "It comes."},
Secret_Arriving = {"That is no natural craft.", "Heaven-born, perhaps.", "Guard it."},
Emerge_Detected = {"The ground stirs.", "Enemies rise.", "Brace."},
Emerge_Success = {"They surface.", "Meet them head-on.", "Strike."},
Emerge_FailedMech = {"Not strong enough.", "Good.", "Again."},
Emerge_FailedVek = {"They misjudge us.", "Exploit it.", "Advance."},


-- Mech State
Mech_LowHealth = {"Pain sharpens me.", "I can still fight.", "I can his his laughter..."},
Mech_Webbed = {"Restrained.", "Cut me loose.", "Hmph."},
Mech_Shielded = {"A barrier.", "Armor of ashes.", "Temporary."},
Mech_Repaired = {"It will hold.", "Enough.", "Back to the fight."},
Pilot_Level_Self = {"Strength rises.", "The fire answers.", "I will use it."},
Pilot_Level_Obs = {"You grow stronger.", "Good.", "We need it."},
Mech_ShieldDown = {"So be it.", "I rely on myself.", "Advance."},


-- Damage Done
Vek_Drown = {"The depths claim it.", "Efficient.", "Acceptable."},
Vek_Fall = {"Gravity finishes it.", "Good.", "Next."},
Vek_Smoke = {"Choking.", "Press.", "End it."},
Vek_Frozen = {"Stillness.", "Break it.", "Now."},
VekKilled_Self = {"Another enemy spent.", "The fire grows.", "Next."},
VekKilled_Obs = {"Well struck.", "Clean kill.", "Again."},
VekKilled_Vek = {"They tear each other apart.", "Fools.", "Use it."},


DoubleVekKill_Self = {"Two paid for one.", "Efficient strike.", "Good."},
DoubleVekKill_Obs = {"Strong blow.", "Well timed.", "Keep going."},
DoubleVekKill_Vek = {"They destroy themselves.", "Let them.", "Advance."},


MntDestroyed_Self = {"The ground breaks.", "It slows them.", "Worth it."},
MntDestroyed_Obs = {"Collateral damage.", "Necessary.", "Continue."},
MntDestroyed_Vek = {"They ruin everything.", "Mindless.", "They pay."},


PowerCritical = {"The machine weakens.", "Time is short.", "Act."},
Bldg_Destroyed_Self = {"This weighs on me.", "I obeyed.", "Remember it."},
Bldg_Destroyed_Obs = {"Careless.", "We protect them.", "Do better."},
Bldg_Destroyed_Vek = {"They slaughter without thought.", "Unforgivable.", "Kill them."},
Bldg_Resisted = {"They endure.", "Good.", "That matters."},

-- Shared Missions
Mission_Train_TrainStopped = {"It will not move.", "Secure it.", "Await orders."},
Mission_Train_TrainDestroyed = {"Steel wasted.", "A loss.", "Move on."},
Mission_Block_Reminder = {"We hold here.", "No retreat.", "Stand."},


-- Archive
Mission_Airstrike_Incoming = {"The sky burns.", "Take cover.", "Now."},
Mission_Tanks_Activated = {"Small warriors.", "Brave.", "Support them."},
Mission_Tanks_PartialActivated = {"One remains.", "Protect it.", "It still serves."},
Mission_Dam_Reminder = {"That structure matters.", "Guard it.", "No mistakes."},
Mission_Dam_Destroyed = {"The waters break loose.", "So be it.", "Adapt."},
Mission_Satellite_Destroyed = {"It falls.", "Another loss.", "Continue."},
Mission_Satellite_Imminent = {"It prepares to rise.", "I do not understand it.", "Protect it."},
Mission_Satellite_Launch = {"It departs.", "Objective holds.", "Stand down."},
Mission_Mines_Vek = {"They trigger it.", "Good.", "Use it."},


-- RST
Mission_Terraform_Destroyed = {"It reshaped the land.", "Now gone.", "A shame."},
Mission_Terraform_Attacks = {"It turns hostile.", "Defend.", "Strike."},
Mission_Cataclysm_Falling = {"The world breaks.", "Stand firm.", "Endure."},
Mission_Lightning_Strike_Vek = {"Fire from above.", "Effective.", "Again."},
Mission_Solar_Destroyed = {"Power lost.", "We adapt.", "We must."},
Mission_Force_Reminder = {"I do not know this term.", "Just point.", "I strike."},


-- Pinnacle
Mission_Freeze_Mines_Vek = {"They are trapped.", "End them.", "Now."},
Mission_Factory_Destroyed = {"The machines fall silent.", "Good.", "I distrust them."},
Mission_Factory_Spawning = {"More constructs.", "They multiply.", "Destroy them."},
Mission_Reactivation_Thawed = {"It wakes.", "Be ready.", "I am."},
Mission_SnowStorm_FrozenVek = {"They are still.", "Leave them.", "Move."},
Mission_SnowStorm_FrozenMech = {"Our own are trapped.", "Unacceptable.", "Free them."},
BotKilled_Self = {"A tool breaks.", "It served.", "Continue."},
BotKilled_Obs = {"Only a construct.", "Focus.", "We fight."},


-- Detritus
Mission_Disposal_Destroyed = {"That device mattered.", "A loss.", "Proceed."},
Mission_Disposal_Activated = {"They are consumed.", "Efficient.", "Again."},
Mission_Barrels_Destroyed = {"Crude weapons.", "Effective.", "Use them."},
Mission_Power_Destroyed = {"The lights fade.", "Complications.", "Adapt."},
Mission_Teleporter_Mech = {"I feel displaced.", "I dislike this.", "Still here."},
Mission_Belt_Mech = {"The ground moves me.", "Unnatural.", "Focus."},
}