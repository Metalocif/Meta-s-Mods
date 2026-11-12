local mod = modApi:getCurrentMod()

modApi:appendAssets("img/units/player/", "img/units/player/")
local a=ANIMS
a.mech_gurrenlagann =a.MechUnit:new{Image="units/player/mech_gurrenlagann.png", PosX = -22, PosY = 4}
a.mech_gurrenlaganna = a.MechUnit:new{Image="units/player/mech_gurrenlagann_a.png",  PosX = -20, PosY = -10, NumFrames = 2, Time = 0.5 }
a.mech_gurrenlagann_noglasses =a.MechUnit:new{Image="units/player/mech_gurrenlagann_noglasses.png", PosX = -22, PosY = 4}
a.mech_gurrenlagann_noglassesa = a.MechUnit:new{Image="units/player/mech_gurrenlagann_noglasses_a.png",  PosX = -20, PosY = -10, NumFrames = 2, Time = 0.5 }
a.mech_gurrenlagannw = a.MechUnit:new{Image="units/player/mech_gurrenlagann_w.png", PosX = -20, PosY = -10}
a.mech_gurrenlagann_broken = a.MechUnit:new{Image="units/player/mech_gurrenlagann_broken.png", PosX = -20, PosY = -10 }
a.mech_gurrenlagannw_broken = a.MechUnit:new{Image="units/player/mech_gurrenlagann_w_broken.png", PosX = -20, PosY = -10 }
a.mech_gurrenlagann_ns = a.MechIcon:new{Image="units/player/mech_gurrenlagann_ns.png"}

a.mech_dayakkaiser =	a.MechUnit:new{Image = "units/player/mech_dayakkaiser.png", PosX = -20, PosY = -7}
a.mech_dayakkaisera =	a.MechUnit:new{Image = "units/player/mech_dayakkaiser_a.png", PosX = -20, PosY = -7, NumFrames = 6, Frames = {0,1,2,1,3,4,5,4}, Time = 0.5}
a.mech_dayakkaiserw =	a.MechUnit:new{Image = "units/player/mech_dayakkaiser_w.png", PosX = -20, PosY = -7 }
a.mech_dayakkaiser_broken = a.MechUnit:new{Image="units/player/mech_dayakkaiser_broken.png", PosX = -20, PosY = -7 }
a.mech_dayakkaiserw_broken = a.MechUnit:new{Image="units/player/mech_dayakkaiser_w_broken.png", PosX = -20, PosY = -7 }
a.mech_dayakkaiser_ns = a.MechIcon:new{Image="units/player/mech_dayakkaiser_ns.png"}

a.mech_kittan = a.MechUnit:new{Image="units/player/mech_kittan.png", PosX = -15, PosY = -1}
a.mech_kittana = a.MechUnit:new{Image="units/player/mech_kittan_a.png", PosX = -15, PosY = -1, NumFrames = 2, Time = 0.5 }
a.mech_kittanw = a.MechUnit:new{Image="units/player/mech_kittan_w.png", PosX = -15, PosY = -1 }
a.mech_kittan_broken = a.MechUnit:new{Image="units/player/mech_kittan_broken.png", PosX = -15, PosY = -1 }
a.mech_kittanw_broken = a.MechUnit:new{Image="units/player/mech_kittan_w_broken.png", PosX = -15, PosY = -1}
a.mech_kittan_ns = a.MechIcon:new{Image="units/player/mech_kittan_ns.png"}

modApi:addPalette({
    ID = "Meta_GurrenLagannPalette",
    Name = "Spiral Red",
    Image = "units/player/mech_gurrenlagann_ns.png",
    PlateHighlight = {84,252,0},
    PlateLight     = {216, 60, 67},
    PlateMid       = {118, 49, 77},
    PlateDark      = {36, 41, 65},
    PlateOutline   = {12,19,31},
    PlateShadow    = {35, 40, 50},
    BodyColor      = {67,72,68},
    BodyHighlight  = {134,146,120},
    }
)

modApi:addPalette({
    ID = "Meta_DayakkaiserPalette",
    Name = "Spiral Blue",
    Image = "units/player/mech_dayakkaiser_ns.png",
    PlateHighlight = {221,141,140},
    PlateLight     = {92, 168, 203},
    PlateMid       = {40, 102, 148},
    PlateDark      = {17, 46, 66},
    PlateOutline   = {12,19,31},
    PlateShadow    = {60,87,89},
    BodyColor      = {67,72,68},
    BodyHighlight  = {134,146,120},
    }
)

modApi:addPalette({
    ID = "Meta_KingKittanPalette",
    Name = "Spiral Yellow",
    Image = "units/player/mech_kittan_ns.png",
    PlateHighlight = {236,103,83},
    PlateLight     = {247, 200, 109},
    PlateMid       = {144, 117, 13},
    PlateDark      = {76, 57, 15},
    PlateOutline   = {12,19,31},
    PlateShadow    = {34,36,34},
    BodyColor      = {67,72,68},
    BodyHighlight  = {134,146,120},
    }
)


Mech_GurrenLagann = Pawn:new{
	Name = "Gurren Lagann",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	LargeShield = true,
	Image = "mech_gurrenlagann",
	ImageOffset = modApi:getPaletteImageOffset("Meta_GurrenLagannPalette"),
	SkillList = {"Meta_DrillStrike", "Meta_SunglassesBoomerang"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Mech_GurrenLagann")

Mech_Dayakkaiser = Pawn:new{
	Name = "Dayakkaiser",
	Class = "Ranged",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "mech_dayakkaiser",
	ImageOffset = modApi:getPaletteImageOffset("Meta_DayakkaiserPalette"),
	SkillList = {"Meta_RepeatingCannon"},
	SoundLocation = "/enemy/burrower_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("mech_dayakkaiser")

Mech_Kittan = Pawn:new{
	Name = "King Kittan",
	Class = "Brute",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "mech_kittan",
	ImageOffset = modApi:getPaletteImageOffset("Meta_KingKittanPalette"),
	SkillList = {"Meta_Stinger"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("mech_kittan")