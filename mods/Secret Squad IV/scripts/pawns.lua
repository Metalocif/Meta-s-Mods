local mod = modApi:getCurrentMod()

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_TechnoBlobber.png", path .."img/portraits/pilots/Pilot_Meta_TechnoBlobber.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_TechnoSpider.png", path .."img/portraits/pilots/Pilot_Meta_TechnoSpider.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Meta_TechnoFirefly.png", path .."img/portraits/pilots/Pilot_Meta_TechnoFirefly.png")
-- locate our mech assets.
local mechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Meta_TechnoBlobber.png",
	"Meta_TechnoBlobbera.png",
	"Meta_TechnoBlobber_w.png",
	"Meta_TechnoBlobber_w_broken.png",
	"Meta_TechnoBlobber_broken.png",
	"Meta_TechnoBlobber_ns.png",
	"Meta_TechnoBlobber_h.png",
	"sludge.png",
	"sludgea.png",
	"slime_B3_death.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
local a=ANIMS
a.Meta_TechnoBlobber =a.MechUnit:new{Image="units/player/Meta_TechnoBlobber.png", PosX = -32, PosY = 4}
a.Meta_TechnoBlobbera = a.MechUnit:new{Image="units/player/Meta_TechnoBlobbera.png",  PosX = -30, PosY = 4, NumFrames = 4 }
a.Meta_TechnoBlobberw = a.MechUnit:new{Image="units/player/Meta_TechnoBlobber_w.png", -22, PosY = 10}
a.Meta_TechnoBlobber_broken = a.MechUnit:new{Image="units/player/Meta_TechnoBlobber_broken.png", PosX = -22, PosY = 4 }
a.Meta_TechnoBlobberw_broken = a.MechUnit:new{Image="units/player/Meta_TechnoBlobber_w_broken.png", PosX = -20, PosY = 10 }
a.Meta_TechnoBlobber_ns = a.MechIcon:new{Image="units/player/Meta_TechnoBlobber_ns.png"}

a.meta_sludge =a.MechUnit:new{Image="units/player/sludge.png", PosX = -22, PosY = -6}
a.meta_sludgea = a.MechUnit:new{Image="units/player/sludgea.png",  PosX = -20, PosY = -6, NumFrames = 8 }
a.meta_sludge_death = a.MechUnit:new{Image="units/player/slime_B3_death.png",  PosX = -20, PosY = -6, NumFrames = 8 }

-- make a list of our files.
local files = {
	"Meta_TechnoSpider.png",
	"Meta_TechnoSpidera.png",
	"Meta_TechnoSpider_w.png",
	"Meta_TechnoSpider_w_broken.png",
	"Meta_TechnoSpider_broken.png",
	"Meta_TechnoSpider_ns.png",
	"Meta_TechnoSpider_h.png",
	
	"Meta_spiderling.png",
	"Meta_spiderlinga.png",
	"Meta_spiderling_hatch.png",
	"Meta_spiderling_death.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
a.Meta_TechnoSpider =	a.MechUnit:new{Image = "units/player/Meta_TechnoSpider.png", PosX = -21, PosY = -3}
a.Meta_TechnoSpidera =	a.MechUnit:new{Image = "units/player/Meta_TechnoSpidera.png", PosX = -21, PosY = -3, NumFrames = 4 }
a.Meta_TechnoSpiderw =	a.MechUnit:new{Image = "units/player/Meta_TechnoSpider_w.png", PosX = -19, PosY = 6 }
a.Meta_TechnoSpider_broken = a.MechUnit:new{Image="units/player/Meta_TechnoSpider_broken.png", PosX = -21, PosY = -3 }
a.Meta_TechnoSpiderw_broken = a.MechUnit:new{Image="units/player/Meta_TechnoSpider_w_broken.png", PosX = -19, PosY = 6 }
a.Meta_TechnoSpider_ns = a.MechIcon:new{Image="units/player/Meta_TechnoSpider_ns.png"}

a.Meta_spiderling = 	a.MechUnit:new{ Image = "units/player/Meta_spiderling.png", PosX = -15, PosY = 9 }
a.Meta_spiderlinga = 	a.Meta_spiderling:new{ Image = "units/player/Meta_spiderlinga.png", PosX = -15, PosY = 9, NumFrames = 6  }
a.Meta_spiderlinge =	a.BaseEmerge:new{ Image = "units/player/Meta_spiderling_hatch.png", PosX = -15, PosY = 9, NumFrames = 5, Time =0.1, Sound = "/enemy/spiderling_egg/hatch" }
a.Meta_spiderlingd = 	a.Meta_spiderling:new{ Image = "units/player/Meta_spiderling_death.png", PosX = -21, PosY = 10, NumFrames = 8, Time = 0.14, Loop = false }


local files = {
	"Meta_TechnoFirefly.png",
	"Meta_TechnoFireflya.png",
	"Meta_TechnoFirefly_w.png",
	"Meta_TechnoFirefly_w_broken.png",
	"Meta_TechnoFirefly_broken.png",
	"Meta_TechnoFirefly_ns.png",
	"Meta_TechnoFirefly_h.png",
	
	"Meta_TechnoFirefly2.png",
	"Meta_TechnoFirefly2a.png",
	"Meta_TechnoFirefly2_w_broken.png",
	"Meta_TechnoFirefly2_broken.png",
	"Meta_TechnoFirefly2_ns.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
a.Meta_TechnoFirefly = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly.png", PosX = -25, PosY = -2}
a.Meta_TechnoFireflya = a.MechUnit:new{Image="units/player/Meta_TechnoFireflya.png", PosX = -25, PosY = -2, NumFrames = 4 }
a.Meta_TechnoFireflyw = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly_w.png", PosX = -24, PosY = 6 }
a.Meta_TechnoFirefly_broken = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly_broken.png", PosX = -12, PosY = -10 }
a.Meta_TechnoFireflyw_broken = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly_w_broken.png", PosX = -12, PosY = -10}
a.Meta_TechnoFirefly_ns = a.MechIcon:new{Image="units/player/Meta_TechnoFirefly_ns.png"}

a.Meta_TechnoFirefly2 = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly2.png", PosX = -25, PosY = -12}
a.Meta_TechnoFirefly2a = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly2a.png", PosX = -25, PosY = -12, NumFrames = 4 }
a.Meta_TechnoFirefly2_broken = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly2_broken.png", PosX = -12, PosY = -10 }
a.Meta_TechnoFirefly2w_broken = a.MechUnit:new{Image="units/player/Meta_TechnoFirefly2_w_broken.png", PosX = -12, PosY = -10}
a.Meta_TechnoFirefly2_ns = a.MechIcon:new{Image="units/player/Meta_TechnoFirefly2_ns.png"}

CreatePilot{
	Id = "Pilot_Meta_TechnoBlobber",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Meta_TechnoSpider",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Meta_TechnoFirefly",
	Personality = "Vek",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}

-- modApi:addPalette({
    -- ID = "Palette_Meta_SS4",
    -- Image="units/player/Meta_TechnoBlobber.png",
    -- Name = "Gunky Vek",
    -- PlateHighlight = {255, 226, 171},
    -- PlateLight     = {200, 156, 88},
    -- PlateMid       = {121, 83, 76},
    -- PlateDark      = {47, 37, 53},
    -- PlateOutline   = {12, 19, 31},
    -- PlateShadow    = {58, 74, 128},
    -- BodyColor      = {72, 183, 215},
    -- BodyHighlight  = {248, 249, 193},
-- })

modApi:addPalette({
    ID = "Palette_Meta_SS4",
    Name = "Viridian Metal",
    Image = "units/player/Meta_TechnoMoth_ns.png",
    PlateHighlight = {255,226,171},
    PlateLight     = {139, 121, 164},
    PlateMid       = {85, 88, 112},
    PlateDark      = {36, 41, 65},
    PlateOutline   = {12,19,31},
    PlateShadow    = {60,87,89},
    BodyColor      = {69,116,98},
    BodyHighlight  = {79,146,107},
    }
)


Meta_TechnoBlobber = Pawn:new{
	Name = "Techno-Blobber",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Meta_TechnoBlobber",
	ImageOffset = modApi:getPaletteImageOffset("Palette_Meta_SS4"),
	-- ImageOffset = 8,
	SkillList = {"meta_blobber"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,

}
AddPawn("Meta_TechnoBlobber")

Meta_TechnoSpider = Pawn:new{
	Name = "Techno-Spider",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Jumper = true,
	Image = "Meta_TechnoSpider",
	ImageOffset = 8,
	SkillList = {"meta_spider"},
	SoundLocation = "/enemy/spider_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
}
AddPawn("Meta_TechnoSpider")

Meta_TechnoFirefly = Pawn:new{
	Name = "Techno-Firefly",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Meta_TechnoFirefly",
	ImageOffset = modApi:getPaletteImageOffset("Palette_Meta_SS4"),
	-- ImageOffset = 8,
	SkillList = {"meta_firefly"},
	SoundLocation = "/enemy/firefly_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
	MaxLevelFlyingGraphics = "Meta_TechnoFirefly2"
}
AddPawn("Meta_TechnoFirefly")