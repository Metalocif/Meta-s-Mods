local mod = modApi:getCurrentMod()

local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = path .."img/units/player/"
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_Hydra.png", path .."img/portraits/pilots/Pilot_Meta_Hydra.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_Wyvern.png", path .."img/portraits/pilots/Pilot_Meta_Wyvern.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_Drake.png", path .."img/portraits/pilots/Pilot_Meta_Drake.png")

local files = {
	"Meta_Hydra.png",
	"Meta_Hydraa.png",
	"Meta_Hydra_w.png",
	"Meta_Hydra_w_broken.png",
	"Meta_Hydra_broken.png",
	"Meta_Hydra_ns.png",
	"Meta_Hydra_h.png",
	
	"Meta_Wyvern.png",
	"Meta_Wyverna.png",
	"Meta_Wyvern_w.png",
	"Meta_Wyvern_w_broken.png",
	"Meta_Wyvern_broken.png",
	"Meta_Wyvern_ns.png",
	"Meta_Wyvern_h.png",
	
	"Meta_Drake.png",
	"Meta_Drakea.png",
	"Meta_Drake_w_broken.png",
	"Meta_Drake_broken.png",
	"Meta_Drake_ns.png",
	"Meta_Drake_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
local a=ANIMS
a.Meta_Hydra =a.MechUnit:new{Image="units/player/Meta_Hydra.png", PosX = -22, PosY = 4}
a.Meta_Hydraa = a.MechUnit:new{Image="units/player/Meta_Hydraa.png",  PosX = -20, PosY = -10, NumFrames = 12 }
a.Meta_Hydraw = a.MechUnit:new{Image="units/player/Meta_Hydra_w.png", -22, PosY = -3}
a.Meta_Hydra_broken = a.MechUnit:new{Image="units/player/Meta_Hydra_broken.png", PosX = -20, PosY = -10 }
a.Meta_Hydraw_broken = a.MechUnit:new{Image="units/player/Meta_Hydra_w_broken.png", PosX = -20, PosY = -3 }
a.Meta_Hydra_ns = a.MechIcon:new{Image="units/player/Meta_Hydra_ns.png"}

a.Meta_Wyvern =	a.MechUnit:new{Image = "units/player/Meta_Wyvern.png", PosX = -21, PosY = -3}
a.Meta_Wyverna =	a.MechUnit:new{Image = "units/player/Meta_Wyverna.png", PosX = -25, PosY = -11, NumFrames = 4 }
a.Meta_Wyvernw =	a.MechUnit:new{Image = "units/player/Meta_Wyvern_w.png", PosX = -25, PosY = -6 }
a.Meta_Wyvern_broken = a.MechUnit:new{Image="units/player/Meta_Wyvern_broken.png", PosX = -25, PosY = -10 }
a.Meta_Wyvernw_broken = a.MechUnit:new{Image="units/player/Meta_Wyvern_w_broken.png", PosX = -25, PosY = -6 }
a.Meta_Wyvern_ns = a.MechIcon:new{Image="units/player/Meta_Wyvern_ns.png"}

a.Meta_Drake = a.MechUnit:new{Image="units/player/Meta_Drake.png", PosX = -17, PosY = -19, Height = 3}
a.Meta_Drakea = a.MechUnit:new{Image="units/player/Meta_Drakea.png", PosX = -25, PosY = -16, NumFrames = 8 }
a.Meta_Drake_broken = a.MechUnit:new{Image="units/player/Meta_Drake_broken.png", PosX = -22, PosY = -10 }
a.Meta_Drakew_broken = a.MechUnit:new{Image="units/player/Meta_Drake_w_broken.png", PosX = -22, PosY = -10}
a.Meta_Drake_ns = a.MechIcon:new{Image="units/player/Meta_Drake_ns.png", PosX = 15, PosY=20}

CreatePilot{
	Id = "Pilot_Meta_Hydra",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Meta_Wyvern",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Meta_Drake",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}

modApi:addPalette{
    id = "Meta_Ac_Drak",
    image = "units/player/Meta_Drake_ns.png",
    name = "Dragonscale",
    PlateHighlight = {255,233,25},
    PlateLight     = {108,178,126},
    PlateMid       = {63,72,71},
    PlateDark      = {28,35,34},
    PlateOutline   = {12,11,13},
    BodyHighlight  = {102,103,93},
    BodyColor      = {58,58,54},
    PlateShadow    = {20,20,20},
}

Meta_Hydra = Pawn:new{
	Name = "Techno-Hydra",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	LargeShield = true,
	Image = "Meta_Hydra",
	ImageOffset = modApi:getPaletteImageOffset("Meta_Ac_Drak"),
	SkillList = {"Meta_HydraWeapon"},
	SoundLocation = "/enemy/digger_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
	IsDragon = true,	--cross-mod interaction with Pokemon
}
AddPawn("Meta_Hydra")

Meta_Wyvern = Pawn:new{
	Name = "Techno-Wyvern",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Meta_Wyvern",
	ImageOffset = modApi:getPaletteImageOffset("Meta_Ac_Drak"),
	SkillList = {"Meta_WyvernWeapon"},
	SoundLocation = "/enemy/dung_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
	IsDragon = true,
}
AddPawn("Meta_Wyvern")

Meta_Drake = Pawn:new{
	Name = "Techno-Drake",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
    Flying=true,
	IgnoreFire=true,
	LargeShield = true,
	Image = "Meta_Drake",
	ImageOffset = modApi:getPaletteImageOffset("Meta_Ac_Drak"),
	SkillList = {"Meta_DrakeWeapon"},
	SoundLocation = "/enemy/moth_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
	IsDragon = true,
}
AddPawn("Meta_Drake")