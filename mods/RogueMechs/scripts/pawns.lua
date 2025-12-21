local path = mod_loader.mods[modApi.currentMod].resourcePath

local RMlist = {"mech_charge", "mech_dstrike", "mech_punch", "mech_laser", "mech_mirror", "mech_electric", 
"mech_guard", "brute_bulk", "ranged_minelayer", "prime_firefighter", "ranged_trimissile" }
for i, v in ipairs(RMlist) do
	modApi:appendAsset("img/units/player/rogue/"..v..".png", path .."img/units/player/rogue/"..v..".png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_a.png", path .."img/units/player/rogue/"..v.."_a.png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_broken.png", path .."img/units/player/rogue/"..v.."_broken.png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_w.png", path .."img/units/player/rogue/"..v.."_w.png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_w_broken.png", path .."img/units/player/rogue/"..v.."_w_broken.png")
end

local RMlistFlying = {"brute_needle" }
for i, v in ipairs(RMlistFlying) do
	modApi:appendAsset("img/units/player/rogue/"..v..".png", path .."img/units/player/rogue/"..v..".png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_a.png", path .."img/units/player/rogue/"..v.."_a.png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_broken.png", path .."img/units/player/rogue/"..v.."_broken.png")
	modApi:appendAsset("img/units/player/rogue/"..v.."_w_broken.png", path .."img/units/player/rogue/"..v.."_w_broken.png")
end
modApi:appendAsset("img/portraits/enemy/pilot.png", path .."img/portraits/enemy/pilot.png")

modApi:appendAsset("img/units/player/rogue/bombling.png", path .."img/units/player/rogue/bombling.png")
modApi:appendAsset("img/units/player/rogue/bombling_a.png", path .."img/units/player/rogue/bombling_a.png")
modApi:appendAsset("img/units/player/rogue/bombling_death.png", path .."img/units/player/rogue/bombling_death.png")
	
local a = ANIMS
a.RMMechPunch =					a.MechUnit:new{ Image = "units/player/rogue/mech_punch.png", PosX = -17, PosY = -1, Height = 1, }
a.RMMechPuncha =				a.MechUnit:new{ Image = "units/player/rogue/mech_punch_a.png", PosX = -16, PosY = -1, NumFrames = 4, Height = 1, }
a.RMMechPunchw =				a.MechUnit:new{ Image = "units/player/rogue/mech_punch_w.png", PosX = -17, PosY = 8, Height = 1, }
a.RMMechPunch_broken = 			a.MechUnit:new{ Image = "units/player/rogue/mech_punch_broken.png", PosX = -15, PosY = -2, Height = 1, }
a.RMMechPunchw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_punch_w_broken.png", PosX = -17, PosY = 13, Height = 1, }

a.RMMechDStrike = 				a.MechUnit:new{ Image = "units/player/rogue/mech_dstrike.png", PosX = -18, PosY = -5, Height = 1, }
a.RMMechDStrikea = 				a.MechUnit:new{ Image = "units/player/rogue/mech_dstrike_a.png", PosX = -18, PosY = -5, NumFrames = 4, Height = 1, }
a.RMMechDStrikew = 				a.MechUnit:new{ Image = "units/player/rogue/mech_dstrike_w.png", PosX = -18, PosY = 8, Height = 1, }
a.RMMechDStrike_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_dstrike_broken.png", PosX = -23, PosY = -5, Height = 1, }
a.RMMechDStrikew_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_dstrike_w_broken.png", PosX = -23, PosY = 8, Height = 1, }

a.RMMechLaser =					a.MechUnit:new{ Image = "units/player/rogue/mech_laser.png", PosX = -15, PosY = -8, Height = 1, }
a.RMMechLasera =				a.MechUnit:new{ Image = "units/player/rogue/mech_laser_a.png", PosX = -15, PosY = -8, NumFrames = 4, Height = 1, }
a.RMMechLaserw =				a.MechUnit:new{ Image = "units/player/rogue/mech_laser_w.png", PosX = -15, PosY = 4, Height = 1, }
a.RMMechLaser_broken = 			a.MechUnit:new{ Image = "units/player/rogue/mech_laser_broken.png", PosX = -15, PosY = -1, Height = 1, }
a.RMMechLaserw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_laser_w_broken.png", PosX = -15, PosY = 9, Height = 1, }

a.RMMechCharge = 				a.MechUnit:new{ Image = "units/player/rogue/mech_charge.png", PosX = -19, PosY = 5, Height = 1, }
a.RMMechChargea = 				a.MechUnit:new{ Image = "units/player/rogue/mech_charge_a.png", PosX = -19, PosY = 5, NumFrames = 4, Height = 1, }
a.RMMechChargew = 				a.MechUnit:new{ Image = "units/player/rogue/mech_charge_w.png", PosX = -19, PosY = 12, Height = 1, }
a.RMMechCharge_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_charge_broken.png", PosX = -19, PosY = 7, Height = 1, }
a.RMMechChargew_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_charge_w_broken.png", PosX = -20, PosY = 14, Height = 1, }

a.RMMechMirror = 				a.MechUnit:new{ Image = "units/player/rogue/mech_mirror.png", PosX = -20, PosY = 3}
a.RMMechMirrora = 				a.MechUnit:new{ Image = "units/player/rogue/mech_mirror_a.png", PosX = -20, PosY = 3, NumFrames = 4, Height = 1, }
a.RMMechMirrorw = 				a.MechUnit:new{ Image = "units/player/rogue/mech_mirror_w.png", PosX = -19, PosY = 12, Height = 1, }
a.RMMechMirror_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_mirror_broken.png", PosX = -20, PosY = 3, Height = 1, }
a.RMMechMirrorw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_mirror_w_broken.png", PosX = -20, PosY = 11, Height = 1, }

a.RMMechElec = 					a.MechUnit:new{ Image = "units/player/rogue/mech_electric.png", PosX = -20, PosY = -14}
a.RMMechEleca = 				a.MechUnit:new{ Image = "units/player/rogue/mech_electric_a.png", PosX = -21, PosY = -14, NumFrames = 4, Height = 1, }
a.RMMechElecw = 				a.MechUnit:new{ Image = "units/player/rogue/mech_electric_w.png", PosX = -19, PosY = 1, Height = 1, }
a.RMMechElec_broken = 			a.MechUnit:new{ Image = "units/player/rogue/mech_electric_broken.png", PosX = -18, PosY = -10, Height = 1, }
a.RMMechElecw_broken = 			a.MechUnit:new{ Image = "units/player/rogue/mech_electric_w_broken.png", PosX = -19, PosY = 2, Height = 1, }

a.RMMechBulk = 					a.MechUnit:new{ Image = "units/player/rogue/brute_bulk.png", PosX = -18, PosY = -5}
a.RMMechBulka = 				a.MechUnit:new{ Image = "units/player/rogue/brute_bulk_a.png", PosX = -20, PosY = -5, NumFrames = 4, Height = 1, }
a.RMMechBulk_broken = 			a.MechUnit:new{ Image = "units/player/rogue/brute_bulk_broken.png", PosX = -19, PosY = 1, Height = 1, }
a.RMMechBulkw = 				a.MechUnit:new{ Image = "units/player/rogue/brute_bulk_w.png", PosX = -18, PosY = 9, Height = 1, }
a.RMMechBulkw_broken = 			a.MechUnit:new{ Image = "units/player/rogue/brute_bulk_w_broken.png", PosX = -19, PosY = 13, Height = 1, }

a.RMMechDispersal =				a.MechUnit:new{ Image = "units/player/rogue/prime_firefighter.png", PosX = -18, PosY = -9, Height = 1, }
a.RMMechDispersala =			a.MechUnit:new{ Image = "units/player/rogue/prime_firefighter_a.png", PosX = -18, PosY = -8, NumFrames = 4, Height = 1, }
a.RMMechDispersal_broken = 		a.MechUnit:new{ Image = "units/player/rogue/prime_firefighter_broken.png", PosX = -19, PosY = -10, Height = 1, }
a.RMMechDispersalw =			a.MechUnit:new{ Image = "units/player/rogue/prime_firefighter_w.png", PosX = -17, PosY = -2, Height = 1, }
a.RMMechDispersalw_broken = 	a.MechUnit:new{ Image = "units/player/rogue/prime_firefighter_w_broken.png", PosX = -17, PosY = 4, Height = 1, }

a.RMMechMiner =					a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer.png", PosX = -20, PosY = -3, Height = 1, }
a.RMMechMinera =				a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_a.png", PosX = -21, PosY = -3, NumFrames = 4, Height = 1, }
a.RMMechMiner_broken = 			a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_broken.png", PosX = -22, PosY = -4, Height = 1, }
a.RMMechMinerw =				a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_w.png", PosX = -21, PosY = 10, Height = 1, }
a.RMMechMinerw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_w_broken.png", PosX = -19, PosY = 8, Height = 1, }

a.RMMechGuard = 				a.MechUnit:new{ Image = "units/player/rogue/mech_guard.png", PosX = -17, PosY = -3}
a.RMMechGuarda = 				a.MechUnit:new{ Image = "units/player/rogue/mech_guard_a.png", PosX = -17, PosY = -3, NumFrames = 4 }
a.RMMechGuardw = 				a.MechUnit:new{ Image = "units/player/rogue/mech_guard_w.png", PosX = -19, PosY = 9 }
a.RMMechGuard_broken = 			a.MechUnit:new{ Image = "units/player/rogue/mech_guard_broken.png", PosX = -16, PosY = -5 }
a.RMMechGuardw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/mech_guard_w_broken.png", PosX = -18, PosY = 8 }

a.RMMechTrimissile =			a.MechUnit:new{ Image = "units/player/rogue/ranged_trimissile.png", PosX = -18, PosY = -10 }
a.RMMechTrimissilea =			a.MechUnit:new{ Image = "units/player/rogue/ranged_trimissile_a.png", PosX = -18, PosY = -10, NumFrames = 4 }
a.RMMechTrimissilew =			a.MechUnit:new{ Image = "units/player/rogue/ranged_trimissile_w.png", PosX = -14, PosY = 4 }
a.RMMechTrimissile_broken = 	a.MechUnit:new{ Image = "units/player/rogue/ranged_trimissile_broken.png", PosX = -20, PosY = -3 }
a.RMMechTrimissilew_broken = 	a.MechUnit:new{ Image = "units/player/rogue/ranged_trimissile_w_broken.png", PosX = -14, PosY = 9 }

a.RMMechNeedle =				a.MechUnit:new{ Image = "units/player/rogue/brute_needle.png", PosX = -25, PosY = -12 }
a.RMMechNeedlea =				a.MechUnit:new{ Image = "units/player/rogue/brute_needle_a.png", PosX = -26, PosY = -14, NumFrames = 4 }
a.RMMechNeedle_broken = 		a.MechUnit:new{ Image = "units/player/rogue/brute_needle_broken.png", PosX = -27, PosY = -8 }
a.RMMechNeedlew_broken = 		a.MechUnit:new{ Image = "units/player/rogue/brute_needle_w_broken.png", PosX = -19, PosY = 6 }

a.RMMechMiner =					a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer.png", PosX = -20, PosY = -3 }
a.RMMechMinera =				a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_a.png", PosX = -21, PosY = -3, NumFrames = 4 }
a.RMMechMiner_broken = 			a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_broken.png", PosX = -22, PosY = -4 }
a.RMMechMinerw =				a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_w.png", PosX = -21, PosY = 10 }
a.RMMechMinerw_broken = 		a.MechUnit:new{ Image = "units/player/rogue/ranged_minelayer_w_broken.png", PosX = -19, PosY = 8 }

a.RMBombling =					a.MechUnit:new{ Image = "units/player/rogue/bombling.png", PosX = -12, PosY = 8 }
a.RMBomblinga =					a.MechUnit:new{ Image = "units/player/rogue/bombling_a.png", PosX = -12, PosY = 6, NumFrames = 4 }
a.RMBomblingd = 				a.MechUnit:new{ Image = "units/player/rogue/bombling_death.png",PosX = -33,PosY = -16,NumFrames = 10,Time = 0.14,Loop = false}


function GetBestWeapon()
	if Pawn:GetWeaponCount() <= 1 then return 1 end
	local p = Pawn:GetSpace()
	local bestScore1 = -100
	local bestScore2 = -100
	local movables = extract_table(Board:GetReachable(p, Pawn:GetMoveSpeed(), Pawn:GetPathProf()))
	for _, p1 in ipairs(movables) do
		for _, p2 in ipairs(extract_table(_G[Pawn:GetWeaponType(1)]:GetTargetArea(p1))) do
			local score = _G[Pawn:GetWeaponType(1)]:GetTargetScore(p1, p2) + ScorePositioning(p2, Pawn)
			if score > bestScore1 then bestScore1 = score end
		end
		for _, p2 in ipairs(extract_table(_G[Pawn:GetWeaponType(2)]:GetTargetArea(p1))) do
			local score = _G[Pawn:GetWeaponType(2)]:GetTargetScore(p1, p2) + ScorePositioning(p2, Pawn)
			if score > bestScore2 then bestScore2 = score end
		end
	end
	LOG(Pawn:GetType(), bestScore1, bestScore2)
	if bestScore1 >= bestScore2 then return 1 else return 2 end
	--this defaults to first weapon if they are equal because presumably first weapon is the "standard" one
	--since second weapon may be a limited or ultimate move, better to only use it when strictly better
end



modApi:addPalette({
    ID = "Meta_RogueMechs_1",
    Name = "Rogue Rift Walkers",
	PlateHighlight = {191,40,40},
	PlateLight     = {134,126,83},
	PlateMid       = {68,73,61},
	PlateDark      = {37,37,37},
	PlateOutline   = {20,20,20},
	BodyHighlight  = {139,144,132},
	BodyColor      = {71,71,71},
	PlateShadow    = {35,35,35},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_2",
    Name = "Rogue Rusting Hulks",
    Image = "units/player/mech_pulse_ns.png",
	PlateHighlight = {234,141,141},
	PlateLight     = {167,124,89},
	PlateMid       = {111,67,51},
	PlateDark      = {38,38,38},
	PlateOutline   = {12,12,12},
	BodyHighlight  = {89,89,89},
	BodyColor      = {44,44,44},
	PlateShadow    = {20,20,20},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_3",
    Name = "Rogue Zenith Guard",
    Image = "units/player/mech_charge_ns.png",
	PlateHighlight = {218,79,79},
	PlateLight     = {97,118,123},
	PlateMid       = {61,61,62},
	PlateDark      = {35,35,35},
	PlateOutline   = {29,29,29},
	BodyHighlight  = {128,126,122},
	BodyColor      = {59,59,59},
	PlateShadow    = {29,29,29},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_4",
    Name = "Rogue Blitzkrieg",
    Image = "units/player/mech_electric_ns.png",
	PlateHighlight = {249,142,142},
	PlateLight     = {245,252,185},
	PlateMid       = {124,120,87},
	PlateDark      = {70,60,48},
	PlateOutline   = {22,19,17},
	BodyHighlight  = {146,154,157},
	BodyColor      = {77,79,88},
	PlateShadow    = {29,30,34},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_5",
    Name = "Rogue Steel Judoka",
    Image = "units/player/mech_judo_ns.png",
	PlateHighlight = {174,44,44},
	PlateLight     = {82,76,65},
	PlateMid       = {37,38,34},
	PlateDark      = {19,21,21},
	PlateOutline   = {9,10,11},
	BodyHighlight  = {223,209,195},
	BodyColor      = {81,81,81},
	PlateShadow    = {38,38,38},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_6",
    Name = "Rogue Flame Behemoths",
    Image = "units/player/mech_flame_ns.png",
	PlateHighlight = {220,89,89},
	PlateLight     = {151,87,106},
	PlateMid       = {103,48,68},
	PlateDark      = {60,33,40},
	PlateOutline   = {26,16,18},
	BodyHighlight  = {131,116,103},
	BodyColor      = {66,58,52},
	PlateShadow    = {29,29,25},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_7",
    Name = "Rogue Frozen Titans",
    Image = "units/player/mech_guard_ns.png",
	PlateHighlight = {219,84,116},
	PlateLight     = {169,230,220},
	PlateMid       = {114,144,120},
	PlateDark      = {69,81,83},
	PlateOutline   = {23,25,28},
	BodyHighlight  = {113,114,113},
	BodyColor      = {77,80,82},
	PlateShadow    = {43,47,49},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_8",
    Name = "Rogue Hazardous Mechs",
    Image = "units/player/mech_leap_ns.png",
	PlateHighlight = {184,87,87},
	PlateLight     = {139,112,109},
	PlateMid       = {75,63,65},
	PlateDark      = {50,42,46},
	PlateOutline   = {17,15,16},
	BodyHighlight  = {102,109,92},
	BodyColor      = {64,67,63},
	PlateShadow    = {24,26,24},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_9",
    Name = "Rogue Bombermechs",
    Image = "advanced/units/player/brute_pierce_ns.png",
	PlateHighlight = {216,89,89},
	PlateLight     = {210,161,62},
	PlateMid       = {148,85,71},
	PlateDark      = {86,44,46},
	PlateOutline   = {22,13,14},
	BodyHighlight  = {65,93,99},
	BodyColor      = {39,49,56},
	PlateShadow    = {18,20,24},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_10",
    Name = "Rogue Arachnophiles",
    Image = "advanced/units/player/brute_bulk_ns.png",
	PlateHighlight = {217,74,74},
	PlateLight     = {223,103,201},
	PlateMid       = {113,75,134},
	PlateDark      = {43,36,48},
	PlateOutline   = {18,14,23},
	BodyHighlight  = {171,175,162},
	BodyColor      = {87,94,92},
	PlateShadow    = {47,46,37},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_11",
    Name = "Rogue Mist Eaters",
    Image = "advanced/units/player/brute_needle_ns.png",
	PlateHighlight = {188,44,44},
	PlateLight     = {73,206,137},
	PlateMid       = {59,84,86},
	PlateDark      = {32,40,45},
	PlateOutline   = {17,16,14},
	BodyHighlight  = {107,84,67},
	BodyColor      = {55,42,40},
	PlateShadow    = {31,29,30},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_12",
    Name = "Rogue Heat Sinkers",
    Image = "advanced/units/player/prime_firefighter_ns.png",
	PlateHighlight = {182,90,113},
	PlateLight     = {78,94,74},
	PlateMid       = {39,41,39},
	PlateDark      = {17,19,18},
	PlateOutline   = {7,7,8},
	BodyHighlight  = {59,58,57},
	BodyColor      = {33,33,32},
	PlateShadow    = {11,11,11},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_13",
    Name = "Rogue Cataclysm",
    Image = "advanced/units/player/prime_bottlecap_ns.png",
	PlateHighlight = {206,164,164},
	PlateLight     = {191,191,191},
	PlateMid       = {131,78,61},
	PlateDark      = {57,57,57},
	PlateOutline   = {27,27,27},
	BodyHighlight  = {154,154,154},
	BodyColor      = {97,97,97},
	PlateShadow    = {42,42,42},
    }
)
modApi:addPalette({
    ID = "Meta_RogueMechs_14",
    Name = "Rogue Secret Squad",
    Image = "units/player/vek_scarab_ns.png",
	PlateHighlight = {255,86,116},
	PlateLight     = {139, 121, 164},
	PlateMid       = {85,110,112},
	PlateDark      = {36,65,65},
	PlateOutline   = {19,15,6},
	BodyHighlight  = {252,255,210},
	BodyColor      = {111,125,112},
	PlateShadow    = {64,54,48},
    }
)



RMMechPunch0 = Pawn:new
{
	Name = "Rogue Combat Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechPunch",
	SkillList = {"RMMechPunchAtk1"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_1"),
}
AddPawn("RMMechPunch0")
RMMechPunch1 = RMMechPunch0:new
{
	Name = "Rogue Combat Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechPunch",
	SkillList = {"RMMechPunchAtk1"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_1"),
}
AddPawn("RMMechPunch1")
RMMechPunch2 = RMMechPunch0:new
{
	Name = "Rogue Combat Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Ranged = 1,
	Image = "RMMechPunch",
	SkillList = {"RMMechPunchAtk2"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_1"),
}
AddPawn("RMMechPunch2")
RMMechPunch3 = RMMechPunch0:new
{
	Name = "Rogue Combat Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Ranged = 1,
	Image = "RMMechPunch",
	SkillList = {"RMMechPunchAtk2", "RMVortexFist"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_1"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechPunch3")



RMMechDStrike0 = Pawn:new
{
	Name = "Rogue Siege Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 2,
	MoveSpeed = 3,
	Ranged = 1,
	Image = "RMMechDStrike",
	SkillList = {"RMMechDStrikeAtk1"},
	SoundLocation = "/mech/distance/dstrike_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_5"),
}
RMMechDStrike1 = RMMechDStrike0:new
{
	Name = "Rogue Siege Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Ranged = 1,
	Image = "RMMechDStrike",
	SkillList = {"RMMechDStrikeAtk1"},
	SoundLocation = "/mech/distance/dstrike_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_5"),
}
RMMechDStrike2 = RMMechDStrike0:new
{
	Name = "Rogue Siege Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Ranged = 1,
	Image = "RMMechDStrike",
	SkillList = {"RMMechDStrikeAtk2"},
	SoundLocation = "/mech/distance/dstrike_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_5"),
}
RMMechDStrike3 = RMMechDStrike0:new
{
	Name = "Rogue Siege Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Ranged = 1,
	Image = "RMMechDStrike",
	SkillList = {"RMMechDStrikeAtk2", "RMMissileBarrage"},
	SoundLocation = "/mech/distance/dstrike_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_5"),
	GetWeapon = GetBestWeapon,
}



RMMechLaser0 = Pawn:new
{
	Name = "Rogue Laser Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechLaser",
	SkillList = {"RMMechLaserAtk1"},
	SoundLocation = "/mech/prime/laser_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechLaser0")
RMMechLaser1 = RMMechLaser0:new
{
	Name = "Rogue Laser Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechLaser",
	SkillList = {"RMMechLaserAtk1"},
	SoundLocation = "/mech/prime/laser_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechLaser1")
RMMechLaser2 = RMMechLaser0:new
{
	Name = "Rogue Laser Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechLaser",
	SkillList = {"RMMechLaserAtk2"},
	SoundLocation = "/mech/prime/laser_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechLaser2")
RMMechLaser3 = RMMechLaser0:new
{
	Name = "Rogue Laser Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechLaser",
	SkillList = {"RMMechLaserAtk2", "RMTitaniteBlade"},
	SoundLocation = "/mech/prime/laser_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechLaser3")



RMMechCharge0 = Pawn:new
{
	Name = "Rogue Charge Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Ranged = 1,
	Armor = true,
	Image = "RMMechCharge",
	SkillList = {"RMMechChargeAtk1"},
	SoundLocation = "/mech/brute/charge_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechCharge0")
RMMechCharge1 = RMMechCharge0:new
{
	Name = "Rogue Charge Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Armor = true,
	Image = "RMMechCharge",
	SkillList = {"RMMechChargeAtk1"},
	SoundLocation = "/mech/brute/charge_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechCharge1")
RMMechCharge2 = RMMechCharge0:new
{
	Name = "Rogue Charge Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Armor = true,
	Image = "RMMechCharge",
	SkillList = {"RMMechChargeAtk2"},
	SoundLocation = "/mech/brute/charge_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
}
AddPawn("RMMechCharge2")
RMMechCharge3 = RMMechCharge0:new
{
	Name = "Rogue Charge Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Armor = true,
	Image = "RMMechCharge",
	SkillList = {"RMMechChargeAtk2", "RMShrapnelCannon"},
	SoundLocation = "/mech/brute/charge_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_3"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechCharge3")



RMMechGuard0 = Pawn:new
{
	Name = "Rogue Guard Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 4,
	Image = "RMMechGuard",
	SkillList = {"RMMechGuardAtk1"},
	SoundLocation = "/mech/prime/guard_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechGuard0")
RMMechGuard1 = RMMechGuard0:new
{
	Name = "Rogue Guard Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechGuard",
	SkillList = {"RMMechGuardAtk1"},
	SoundLocation = "/mech/prime/guard_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechGuard1")
RMMechGuard2 = RMMechGuard0:new
{
	Name = "Rogue Guard Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechGuard",
	SkillList = {"RMMechGuardAtk2"},
	SoundLocation = "/mech/prime/guard_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechGuard2")
RMMechGuard3 = RMMechGuard0:new
{
	Name = "Rogue Guard Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechGuard",
	SkillList = {"RMMechGuardAtk2","RMPrimeSpear"},
	SoundLocation = "/mech/prime/guard_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechGuard3")



RMMechMirror0 = Pawn:new
{
	Name = "Rogue Mirror Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechMirror",
	SkillList = {"RMMechMirrorAtk1"},
	SoundLocation = "/mech/brute/mirror_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechMirror0")
RMMechMirror1 = RMMechMirror0:new
{
	Name = "Rogue Mirror Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMirror",
	SkillList = {"RMMechMirrorAtk1"},
	SoundLocation = "/mech/brute/mirror_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechMirror1")
RMMechMirror2 = RMMechMirror0:new
{
	Name = "Rogue Mirror Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMirror",
	SkillList = {"RMMechMirrorAtk2"},
	SoundLocation = "/mech/brute/mirror_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
}
AddPawn("RMMechMirror2")
RMMechMirror3 = RMMechMirror0:new
{
	Name = "Rogue Mirror Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMirror",
	SkillList = {"RMMechMirrorAtk2", "RMIceGenerator"},
	SoundLocation = "/mech/brute/mirror_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_7"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechMirror3")



RMMechDispersal0 = Pawn:new
{
	Name = "Rogue Dispersal Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechDispersal",
	SkillList = {"RMMechDispersalAtk1"},
	SoundLocation = "/mech/prime/dispersal_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_12"),
}
AddPawn("RMMechDispersal0")
RMMechDispersal1 = RMMechDispersal0:new
{
	Name = "Rogue Dispersal Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechDispersal",
	SkillList = {"RMMechDispersalAtk1"},
	SoundLocation = "/mech/prime/dispersal_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_12"),
}
AddPawn("RMMechDispersal1")
RMMechDispersal2 = RMMechDispersal0:new
{
	Name = "Rogue Dispersal Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechDispersal",
	SkillList = {"RMMechDispersalAtk2"},
	SoundLocation = "/mech/prime/dispersal_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_12"),
}
AddPawn("RMMechDispersal2")
RMMechDispersal3 = RMMechDispersal0:new
{
	Name = "Rogue Dispersal Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechDispersal",
	SkillList = {"RMMechDispersalAtk2", "RMRepairDrop"},
	SoundLocation = "/mech/prime/dispersal_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_12"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechDispersal3")



RMMechBulk0 = Pawn:new
{
	Name = "Rogue Bulk Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechBulk",
	SkillList = {"RMMechBulkAtk1"},
	SoundLocation = "/mech/brute/bulk_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_10"),
}
AddPawn("RMMechBulk0")
RMMechBulk1 = RMMechBulk0:new
{
	Name = "Rogue Bulk Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechBulk",
	SkillList = {"RMMechBulkAtk1"},
	SoundLocation = "/mech/brute/bulk_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_10"),
}
AddPawn("RMMechBulk1")
RMMechBulk2 = RMMechBulk0:new
{
	Name = "Rogue Bulk Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechBulk",
	SkillList = {"RMMechBulkAtk2"},
	SoundLocation = "/mech/brute/bulk_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_10"),
}
AddPawn("RMMechBulk2")
RMMechBulk3 = RMMechBulk0:new
{
	Name = "Rogue Bulk Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechBulk",
	SkillList = {"RMMechBulkAtk2", "RMEMRailgun"},
	SoundLocation = "/mech/brute/bulk_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_10"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechBulk3")



RMMechTrimissile0 = Pawn:new
{
	Name = "Rogue Triptych Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 2,
	MoveSpeed = 3,
	Image = "RMMechTrimissile",
	SkillList = {"RMMechTrimissileAtk1"},
	SoundLocation = "/mech/ranged/trimissile_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_13"),
}
AddPawn("RMMechTrimissile0")
RMMechTrimissile1 = RMMechTrimissile0:new
{
	Name = "Rogue Triptych Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Image = "RMMechTrimissile",
	SkillList = {"RMMechTrimissileAtk1"},
	SoundLocation = "/mech/ranged/trimissile_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_13"),
}
AddPawn("RMMechTrimissile1")
RMMechTrimissile2 = RMMechTrimissile0:new
{
	Name = "Rogue Triptych Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Image = "RMMechTrimissile",
	SkillList = {"RMMechTrimissileAtk2"},
	SoundLocation = "/mech/ranged/trimissile_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_13"),
}
AddPawn("RMMechTrimissile2")
RMMechTrimissile3 = RMMechTrimissile0:new
{
	Name = "Rogue Triptych Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 4,
	MoveSpeed = 4,
	Image = "RMMechTrimissile",
	SkillList = {"RMMechTrimissileAtk2", "RMHeavyArtillery"},
	SoundLocation = "/mech/ranged/trimissile_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_13"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechTrimissile3")



RMMechNeedle0 = Pawn:new
{
	Name = "Rogue Thruster Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 4,
	Image = "RMMechNeedle",
	SkillList = {"RMMechNeedleAtk1"},
	SoundLocation = "/mech/brute/needle_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	Flying = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_11"),
}
AddPawn("RMMechNeedle0")
RMMechNeedle1 = RMMechNeedle0:new
{
	Name = "Rogue Thruster Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechNeedle",
	SkillList = {"RMMechNeedleAtk1"},
	SoundLocation = "/mech/brute/needle_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	Flying = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_11"),
}
AddPawn("RMMechNeedle1")
RMMechNeedle2 = RMMechNeedle0:new
{
	Name = "Rogue Thruster Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechNeedle",
	SkillList = {"RMMechNeedleAtk2"},
	SoundLocation = "/mech/brute/needle_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	Flying = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_11"),
}
AddPawn("RMMechNeedle2")
RMMechNeedle3 = RMMechNeedle0:new
{
	Name = "Rogue Thruster Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 5,
	Image = "RMMechNeedle",
	SkillList = {"RMMechNeedleAtk2", "RMAstraBombs"},
	SoundLocation = "/mech/brute/needle_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	Flying = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_11"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechNeedle3")



RMMechMiner0 = Pawn:new
{
	Name = "Rogue Bombling Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechMiner",
	SkillList = {"RMMechMinerAtk1"},
	SoundLocation = "/mech/ranged/miner_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_9"),
}
AddPawn("RMMechMiner0")
RMMechMiner1 = RMMechMiner0:new
{
	Name = "Rogue Bombling Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMiner",
	SkillList = {"RMMechMinerAtk1"},
	SoundLocation = "/mech/ranged/miner_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_9"),
}
AddPawn("RMMechMiner1")
RMMechMiner2 = RMMechMiner0:new
{
	Name = "Rogue Bombling Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMiner",
	SkillList = {"RMMechMinerAtk2"},
	SoundLocation = "/mech/ranged/miner_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_9"),
}
AddPawn("RMMechMiner2")
RMMechMiner3 = RMMechMiner0:new
{
	Name = "Rogue Bombling Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechMiner",
	SkillList = {"RMMechMinerAtk2","RMRainingDeath"},
	SoundLocation = "/mech/ranged/miner_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_9"),
	GetWeapon = GetBestWeapon,
}
AddPawn("RMMechMiner3")

RMMechElec0 = Pawn:new
{
	Name = "Rogue Lightning Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 3,
	MoveSpeed = 3,
	Image = "RMMechElec",
	SkillList = {"RMMechElecAtk1"},
	SoundLocation = "/mech/prime/elec_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_4"),
}
AddPawn("RMMechElec0")
RMMechElec1 = RMMechElec0:new
{
	Name = "Rogue Lightning Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechElec",
	SkillList = {"RMMechElecAtk1"},
	SoundLocation = "/mech/prime/elec_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_4"),
}
AddPawn("RMMechElec1")
RMMechElec2 = RMMechElec0:new
{
	Name = "Rogue Lightning Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechElec",
	SkillList = {"RMMechElecAtk2"},
	SoundLocation = "/mech/prime/elec_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_4"),
}
AddPawn("RMMechElec2")
RMMechElec3 = RMMechElec0:new
{
	Name = "Rogue Lightning Mech",
	Class = "Enemy", Portrait = "enemy/pilot",
	Health = 5,
	MoveSpeed = 4,
	Image = "RMMechElec",
	SkillList = {"RMMechElecAtk2","RMWindTorrent"},
	SoundLocation = "/mech/prime/elec_mech/",
	DefaultTeam = TEAM_ENEMY, DefaultFaction = FACTION_BOTS,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Corpse = true,
	ImageOffset = modApi:getPaletteImageOffset("Meta_RogueMechs_4"),
}
AddPawn("RMMechElec3")