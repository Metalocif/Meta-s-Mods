-- locate our mech assets.
local mod = modApi:getCurrentMod()
local pawnColor = modApi:getPaletteImageOffset(mod.id)

CreatePilot{
	Id = "Pilot_SlimeBeast",
	Personality = "Vek",
	Sex = SEX_VEK,
	Name = "Gloopy",
	Skill = "DjinnBlobDevour",
	Rarity = 0,
	Blacklist = {"Invulnerable","Popular"},
}

SlimeBeast = {
	Name = "Slime Beast",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Image = "SlimeBeast",
	ImageOffset = pawnColor,
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
	ImageOffset = pawnColor,
	SkillList = { "Djinn_SlimeletShove" },
	SoundLocation = "/enemy/goo_boss/",
	ImpactMaterial = IMPACT_BLOB,
	DefaultTeam = TEAM_PLAYER,
	Portrait = "pilots/Slimelet",
	Massive = false,
	Corpse = false,
	TempUnit = true,	
	OnAppliedGunk = Status.HealFromGunk,
}
AddPawn("Slimelet")

HarmonicMech = {
	Name = "Harmonic Mech",
	Class = "Science",
	Health = 3,
	MoveSpeed = 4,
	Image = "HarmonicMech",
	ImageOffset = pawnColor,
	SkillList = { "Djinn_Resonance" },
	SoundLocation = "/mech/brute/pierce_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("HarmonicMech")

GrungeMech = {
	Name = "Grunge Mech",
	Class = "Prime",
	Health = 2,
	MoveSpeed = 3,
	Image = "GrungeMech",
	ImageOffset = pawnColor,
	SkillList = { "Djinn_GunkSpray" },
	SoundLocation = "/mech/distance/artillery/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("GrungeMech")

-- local HOOK_onPawnDeployed = function(pawn)
	-- if pawn:GetWeaponType(1):find("^Djinn_SlimeSlam") or pawn:GetWeaponType(2):find("^Djinn_SlimeSlam") then
		-- pawn:SetHealth(1)
	-- end
-- end

-- local function EVENT_onModsLoaded()
	-- DjinnSlime_ModApiExt:addOnPawnDeployedHook(HOOK_onPawnDeployed)
-- end

-- modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
