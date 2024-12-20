-- locate our mech assets.
local path = mod_loader.mods[modApi.currentMod].resourcePath

local files = {
    "Pilot_SlimeBeast.png",
    "Slimelet.png",
}
for _, file in ipairs(files) do
     modApi:appendAsset("img/portraits/pilots/".. file, path.."img/portraits/pilots/".. file)
end

-- make a list of our files.
local files = {
	"Grunge.png",
	"Grungea.png",
	"Grunge_ns.png",
	"Grunge_h.png",
	"Harmonic.png",
	"Harmonica.png",
	"Harmonic_ns.png",
	"Harmonic_h.png",
	"SlimeBeast.png",
	"SlimeBeasta.png",
	"SlimeBeast_ns.png",
	"SlimeBeast_h.png",
	"Slimelet.png",
	"Slimeleta.png",
}

-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, path .."img/units/player/".. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.GrungeMech =				a.MechUnit:new{Image = "units/player/Grunge.png", PosX = -23, PosY = 1 }
a.GrungeMecha =				a.MechUnit:new{Image = "units/player/Grungea.png", PosX = -23, PosY = 1, NumFrames = 4 }
a.GrungeMech_ns =				a.MechUnit:new{Image = "units/player/Grunge_ns.png", PosX = -23, PosY = 1 }
a.GrungeMech_h =				a.MechUnit:new{Image = "units/player/Grunge_h.png", PosX = -23, PosY = 1 }
a.GrungeMech_broken =			a.MechUnit:new{Image = "units/player/Grunge.png", PosX = -23, PosY = 1 }


a.HarmonicMech =				a.MechUnit:new{Image = "units/player/Harmonic.png", PosX = -23, PosY = 1 }
a.HarmonicMecha =				a.MechUnit:new{Image = "units/player/Harmonica.png", PosX = -23, PosY = 1, NumFrames = 4 }
a.HarmonicMech_ns =			a.MechUnit:new{Image = "units/player/Harmonic_ns.png", PosX = -23, PosY = 1 }
a.HarmonicMech_h =			a.MechUnit:new{Image = "units/player/Harmonic_h.png", PosX = -23, PosY = 1 }
a.HarmonicMech_broken =		a.MechUnit:new{Image = "units/player/Harmonic.png", PosX = -23, PosY = 1 }


a.SlimeBeast =				a.MechUnit:new{Image = "units/player/SlimeBeast.png", PosX = -23, PosY = 1 }
a.SlimeBeasta =				a.MechUnit:new{Image = "units/player/SlimeBeasta.png", PosX = -23, PosY = 1, NumFrames = 4 }
a.SlimeBeast_ns =				a.MechUnit:new{Image = "units/player/SlimeBeast_ns.png", PosX = -23, PosY = 1 }
a.SlimeBeast_h =				a.MechUnit:new{Image = "units/player/SlimeBeast_h.png", PosX = -23, PosY = 1 }
a.SlimeBeast_broken =			a.MechUnit:new{Image = "units/player/SlimeBeast.png", PosX = -23, PosY = 1 }


a.Slimelet =				a.MechUnit:new{Image = "units/player/Slimelet.png", PosX = -23, PosY = 1 }
a.Slimeleta =				a.MechUnit:new{Image = "units/player/Slimeleta.png", PosX = -23, PosY = 1, NumFrames = 4 }

CreatePilot{
	Id = "Pilot_SlimeBeast",
	Personality = "Vek",
	Sex = SEX_VEK,
	Name = "Gloopy",
	Skill = "DjinnDevour",
	Rarity = 0,
	Blacklist = {"Invulnerable","Popular"},
}

SlimeBeast = {
	Name = "Slime Beast",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Image = "SlimeBeast",
	ImageOffset = 1,
	SkillList = { "Djinn_SlimeSlam" },
	SoundLocation = "/enemy/goo_boss/",
	ImpactMaterial = IMPACT_BLOB,
	DefaultTeam = TEAM_PLAYER,
	Massive = true,
	OnAppliedGunk = Status.HealFromGunk,
}
AddPawn("SlimeBeast")

Slimelet = {
	Name = "Slimelet",
	Class = "",
	Health = 1,
	MoveSpeed = 3,
	Image = "Slimelet",
	ImageOffset = 1,
	SkillList = { "Djinn_SlimeletShove" },
	SoundLocation = "/enemy/goo_boss/",
	ImpactMaterial = IMPACT_BLOB,
	DefaultTeam = TEAM_PLAYER,
	Portrait = "pilots/Slimelet",
	Massive = false,
	Corpse = false,
	TempUnit = true,
}
AddPawn("Slimelet")

GrungeMech = {
	Name = "Grunge Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Image = "GrungeMech",
	ImageOffset = 1,
	SkillList = { "Djinn_GunkSpray" },
	SoundLocation = "/mech/brute/pierce_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("GrungeMech")

HarmonicMech = {
	Name = "Harmonic Mech",
	Class = "Science",
	Health = 2,
	MoveSpeed = 3,
	Image = "HarmonicMech",
	ImageOffset = 0,
	SkillList = { "Djinn_Resonance" },
	SoundLocation = "/mech/distance/artillery/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("HarmonicMech")

-- local HOOK_onPawnDeployed = function(pawn)
	-- if pawn:GetWeaponType(1):find("^Djinn_SlimeSlam") or pawn:GetWeaponType(2):find("^Djinn_SlimeSlam") then
		-- pawn:SetHealth(1)
	-- end
-- end

-- local function EVENT_onModsLoaded()
	-- DjinnSlime_ModApiExt:addOnPawnDeployedHook(HOOK_onPawnDeployed)
-- end

-- modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
