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
a.Meta_TechnoBlobber =a.MechUnit:new{Image="units/player/Meta_TechnoBlobber.png", PosX = -22, PosY = 4}
a.Meta_TechnoBlobbera = a.MechUnit:new{Image="units/player/Meta_TechnoBlobbera.png",  PosX = -20, PosY = 4, NumFrames = 4 }
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

local files = {
	"Meta_TechnoFirefly.png",
	"Meta_TechnoFireflya.png",
	"Meta_TechnoFirefly_w.png",
	"Meta_TechnoFirefly_w_broken.png",
	"Meta_TechnoFirefly_broken.png",
	"Meta_TechnoFirefly_ns.png",
	"Meta_TechnoFirefly_h.png",
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

Meta_TechnoBlobber = Pawn:new{
	Name = "Techno-Blobber",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Meta_TechnoBlobber",
	ImageOffset = 8,
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
	ImageOffset = 8,
	SkillList = {"meta_firefly"},
	SoundLocation = "/enemy/firefly_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_INSECT,
}
AddPawn("Meta_TechnoFirefly")