local mod = mod_loader.mods["Meta_OmegaBotsAndBugs"]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath

local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

-------------
--   Art   --
-------------


local names = {"blobberling", "crusher", "floater", "roach", "spitter", "swarmer", "wyrm"}

for i = 1, #names do
	local name = names[i]
	modApi:appendAsset(writepath.."Omega"..name..".png", readpath.."Omega"..name..".png")
	modApi:appendAsset(writepath.."Omega"..name.."a.png", readpath.."Omega"..name.."a.png")
	modApi:appendAsset(writepath.."Omega"..name.."_death.png", readpath.."Omega"..name.."_death.png")
	modApi:appendAsset(writepath.."Omega"..name.."_emerge.png", readpath.."Omega"..name.."_emerge.png")
	a["Omega"..name] = a["lmn_"..name]:new{ Image = "units/aliens/Omega"..name..".png"}
	a["Omega"..name.."e"] = a["lmn_"..name.."e"]:new{ Image = "units/aliens/Omega"..name.."_emerge.png"}
	a["Omega"..name.."d"] = a["lmn_"..name.."d"]:new{ Image = "units/aliens/Omega"..name.."_death.png"}
	a["Omega"..name.."a"] = a["lmn_"..name.."a"]:new{ Image = "units/aliens/Omega"..name.."a.png"}
end

---------------
--   Pawns   --
---------------

Omegalmn_Blobberling2 = Pawn:new{
	Name = "Omega Blobberling",
	Health = 3,
	MoveSpeed = 5,
	Image = "Omegablobberling",
	ImageOffset = 1,
	SkillList = { "lmn_BlobberlingAtk2" },
	SoundLocation = "/enemy/scarab_2/",
	Portrait = "enemy/lmn_Blobberling2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_ALPHA,
	AvoidingMines = true,
	Minor = true,
	IsDeathEffect = true,
}
AddPawn("Omegalmn_Blobberling2")

function Omegalmn_Blobberling2:GetDeathEffect(point)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		local damage = SpaceDamage(curr)
		damage.iAcid = EFFECT_CREATE
		ret:AddDamage(damage)
	end
	return ret
end

Omegalmn_Crusher2 = Pawn:new{
	Name = "Omega Crusher",
	Health = 6,
	MoveSpeed = 3,
	Image = "Omegacrusher",
	ImageOffset = 1,
	SkillList = { "OmegaCrusherAtk2" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Portrait = "enemy/lmn_Crusher2",
	Massive = true,
}
AddPawn("Omegalmn_Crusher2")

Omegalmn_Floater2 = Pawn:new{
	Name = "Omega Floater",
	Health = 4,
	Image = "Omegafloater",
	ImageOffset = 1,
	MoveSpeed = 2,
	SkillList = { "OmegaFloaterAtk2" },
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	SoundLocation = "/enemy/jelly/",
	Portrait = "enemy/lmn_Floater2",
	Flying = true,
	IsDeathEffect = true,	--makes an Omega Blobberling
}
AddPawn("Omegalmn_Floater2")

function Omegalmn_Floater2:GetDeathEffect(point)
	if not Board:IsBlocked(point, PATH_GROUND) then Board:AddPawn("Omegalmn_Blobberling2", point) end
end

Omegalmn_Roach2 = Pawn:new{
	Name = "Omega Roach",
	Health = 3,
	MoveSpeed = 4,
	Ranged = 1,
	Armor = true,
	Burrows = true,
	Pushable = false,
	Image = "Omegaroach",
	ImageOffset = 1,
	SkillList = { "OmegaRoachAtk2" },
	SoundLocation = "/enemy/scorpion_soldier_2/",
	Tier = TIER_ALPHA,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Portrait = "enemy/lmn_Roach2",
}
AddPawn("Omegalmn_Roach2")

Omegalmn_Spitter2 = Pawn:new{
	Name = "Omega Spitter",
	Health = 5,
	MoveSpeed = 3,
	Ranged = 1,
	Image = "Omegaspitter",
	ImageOffset = 1,
	SkillList = { "OmegaSpitterAtk2" },
	SoundLocation = "/enemy/centipede_2/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Portrait = "enemy/lmn_Spitter2",
}
AddPawn("Omegalmn_Spitter2")

Omegalmn_Swarmer2 = Pawn:new{
	Name = "Omega Swarmer",
	Health = 1,
	MoveSpeed = 4,
	Image = "Omegaswarmer",
	ImageOffset = 1,
	Portrait = "enemy/lmn_Swarmer2",
	SkillList = { "lmn_SwarmerAtk2" },
	SoundLocation = "/enemy/spiderling_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	HalfSpawn = true,
	Clones = 2,
}
AddPawn("Omegalmn_Swarmer2")

Omegalmn_Wyrm2 = Pawn:new{
	Name = "Omega Wyrm",
	Health = 5,
	MoveSpeed = 4,
	Image = "Omegawyrm",
	ImageOffset = 1,
	SkillList = { "OmegaWyrmAtk2" },
	SoundLocation = "/enemy/hornet_2/",
	Tier = TIER_ALPHA,
	Portrait = "enemy/lmn_Wyrm2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Flying = true,
}
AddPawn("Omegalmn_Wyrm2")