local mod = mod_loader.mods["Meta_OmegaVextra"]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath

local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

local trait = require(scriptPath..'libs/trait')

-------------
--   Art   --
-------------


local names = {"anthill", "antlion", "cockroach", "dragonfly", "fly", "icecrawler", "mantis", "pillbug", "silkworm", "stinkbug", "termites", "thunderbug"}

for i = 1, #names do
	local name = names[i]
	local capitalizedName = name:sub(1,1):upper()..name:sub(2)
	modApi:appendAsset(writepath.."Omega"..name..".png", readpath.."Omega"..name..".png")
	modApi:appendAsset(writepath.."Omega"..name.."a.png", readpath.."Omega"..name.."a.png")
	modApi:appendAsset(writepath.."Omega"..name.."_death.png", readpath.."Omega"..name.."_death.png")
	modApi:appendAsset(writepath.."Omega"..name.."_emerge.png", readpath.."Omega"..name.."_emerge.png")
	a["Omega"..name] = a["DNT_"..name]:new{ Image = "units/aliens/Omega"..name..".png"}
	a["Omega"..name.."e"] = a["DNT_"..name.."e"]:new{ Image = "units/aliens/Omega"..name.."_emerge.png"}
	a["Omega"..name.."d"] = a["DNT_"..name.."d"]:new{ Image = "units/aliens/Omega"..name.."_death.png"}
	a["Omega"..name.."a"] = a["DNT_"..name.."a"]:new{ Image = "units/aliens/Omega"..name.."a.png"}
	
	modApi:appendAsset("img/portraits/enemy/Omega"..capitalizedName.."2.png",resourcePath.."img/portraits/enemy/Omega"..capitalizedName.."2.png")
end

local summonNames = {"fant", "workerant", "soldierant"}
for i = 1, #summonNames do
	local name = summonNames[i]
	local capitalizedName = string.gsub(name:sub(1,1):upper()..name:sub(2), "ant", "Ant")
	modApi:appendAsset(writepath.."Omega"..name..".png", readpath.."Omega"..name..".png")
	modApi:appendAsset(writepath.."Omega"..name.."a.png", readpath.."Omega"..name.."a.png")
	modApi:appendAsset(writepath.."Omega"..name.."_death.png", readpath.."Omega"..name.."_death.png")
	a["Omega"..name] = a["DNT_"..name]:new{ Image = "units/aliens/Omega"..name..".png"}
	a["Omega"..name.."d"] = a["DNT_"..name.."d"]:new{ Image = "units/aliens/Omega"..name.."_death.png"}
	a["Omega"..name.."a"] = a["DNT_"..name.."a"]:new{ Image = "units/aliens/Omega"..name.."a.png"}
	
	modApi:appendAsset("img/portraits/enemy/Omega"..capitalizedName.."1.png",resourcePath.."img/portraits/enemy/Omega"..capitalizedName.."1.png")
end

modApi:appendAssets("img/effects/", "img/effects/")

---------------
--   Pawns   --
---------------


OmegaDNT_Anthill2 = Pawn:new
{
	Name = "Omega Anthill",
	Health = 4,
	MoveSpeed = 2,
	Burrows = true,
	Pushable = false,
	VoidShockImmune = true,
	SkillList = {"OmegaAnthillAtk2"},
	Image = "Omegaanthill",
	SoundLocation = "/enemy/burrower_1/",
	Portrait = "enemy/OmegaAnthill2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
	IsDeathEffect = true
}
AddPawn("OmegaDNT_Anthill2")

OmegaExplosion_Down = Emitter:new{
	image = "combat/icons/icon_explode.png",
	x = -12,
	y = -5,
	max_alpha = 0.5,
	min_alpha = 0.5,
	angle = 90,
	rot_speed = 0,
	angle_variance = 0,
	random_rot = false,
	lifespan = 0.75,
	burst_count = 1,
	speed = 0.75,
	birth_rate = 0,
	gravity = false,
	layer = LAYER_FRONT
}


function OmegaDNT_Anthill2:GetDeathEffect(point)
	--purely for visuals
	local noOtherAnthill = true
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(id) and Board:GetPawn(id):GetType() == "OmegaDNT_Anthill2" then noOtherAnthill = false end
	end
	if not noOtherAnthill then return SkillEffect() end
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(id) and (Board:GetPawn(id):GetType() == "OmegaWorkerAnt1" or Board:GetPawn(id):GetType() == "OmegaFAnt1" or Board:GetPawn(id):GetType() == "OmegaSoldierAnt1") then 
			Board:Ping(Board:GetPawn(id):GetSpace(),GL_Color(255,0,0))
			Board:AddBurst(Board:GetPawn(id):GetSpace(),"OmegaExplosion_Down",DIR_NONE)
		end
	end
	return SkillEffect()
end

OmegaDNT_Antlion2 = Pawn:new
{
	Name = "Omega Antlion",
	Health = 4,
	MoveSpeed = 3,
	SkillList = {"OmegaAntlionAtk2"},
	Image = "Omegaantlion",
	SoundLocation = "/enemy/burrower_1/",
	Portrait = "enemy/OmegaAntlion2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
	Burrows = true,
	Pushable = false
}
AddPawn("OmegaDNT_Antlion2")

OmegaDNT_Cockroach2 = Pawn:new
{
	Name = "Omega Cockroach",
	Health = 3,
	MoveSpeed = 3,
	Ranged = 1,
	SkillList = {"OmegaCockroachAtk2"},
	Image = "Omegacockroach",
	SoundLocation = "/enemy/moth_2/",
	Portrait = "enemy/OmegaCockroach2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Corpse = true,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_Cockroach2")

trait:add{
	pawnType = "OmegaDNT_Cockroach2",
	icon = mod_loader.mods["Djinn_NAH_Tatu_Vextra"].resourcePath.."img/combat/traits/DNT_cockroach_trait.png",
	--icon_offset = Point(0,-15),
	desc_title = "Undying",
	desc_text = "Revives at the start of your turn, unless its corpse was drowned, frozen, or on fire.",
}

OmegaDNT_Dragonfly2 = Pawn:new
{
	Name = "Omega Dragonfly",
	Health = 4,		--could maybe be 5, as it can suicide?
	MoveSpeed = 4,
	Flying = true,
	SkillList = {"OmegaDragonflyAtk2"},
	Image = "Omegadragonfly",
	SoundLocation = "/enemy/moth_2/",
	Portrait = "enemy/OmegaDragonfly2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_Dragonfly2")

function StartDodgy()
	if Pawn:GetTurnCount() <= 1 then Status.ApplyDodge(Pawn:GetId(), 1, 1, "Leap", true) end
	return 1
end
OmegaDNT_Fly2 = Pawn:new
{
	Name = "Omega Fly",
	Health = 3,
	MoveSpeed = 4,
	Flying = true,
	SkillList = {"OmegaFlyAtk2"},
	Image = "Omegafly",
	SoundLocation = "/enemy/moth_2/",
	Portrait = "enemy/OmegaFly2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
	GetWeapon = StartDodgy,
}
AddPawn("OmegaDNT_Fly2")

OmegaDNT_IceCrawler2 = Pawn:new
{
	Name = "Omega Ice Crawler",
	Health = 4,
	MoveSpeed = 4,
	Ranged = 1,
	SkillList = {"OmegaIcecrawlerAtk2"},
	Image = "Omegaicecrawler",
	SoundLocation = "/enemy/beetle_1/",
	Portrait = "enemy/OmegaIcecrawler2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_IceCrawler2")

OmegaDNT_Mantis2 = Pawn:new
{
	Name = "Omega Mantis",
	Health = 4,
	MoveSpeed = 3,
	Jumper = true,
	SkillList = {"OmegaMantisAtk2"},
	Image = "Omegamantis",
	SoundLocation = "/enemy/leaper_2/",
	Portrait = "enemy/OmegaMantis2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_Mantis2")

function StartTough()
	if Pawn:GetTurnCount() <= 1 then Status.ApplyTough(Pawn:GetId(), 1) end
	return 1
end
OmegaDNT_Pillbug2 = Pawn:new{
	Name = "Omega Isopod",
	Health = 4,
	MoveSpeed = 2,
	Ranged = 1,
	Image = "Omegapillbug",
	ImageOffset = 1,
	-- Armor = true,
	SkillList = { "OmegaPillbugAtk2" },
	SoundLocation = "/enemy/digger_2/",
	Portrait = "enemy/OmegaPillbug2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_FLESH,
	Tier = TIER_OMEGA,
	GetWeapon = StartTough,		--mostly to test Tough
}
AddPawn("OmegaDNT_Pillbug2")

function StartRepulsive()
	if Pawn:GetTurnCount() <= 1 then Status.ApplyRepulsive(Pawn:GetId(), 0) end
	return 1
end
OmegaDNT_Silkworm2 = Pawn:new
{
	Name = "Omega Silkworm",
	Health = 4,
	MoveSpeed = 4,
	SkillList = {"OmegaSilkwormAtk2"},
	Image = "Omegasilkworm",
	SoundLocation = "/enemy/scorpion_soldier_1/",
	Portrait = "enemy/OmegaSilkworm2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
	GetWeapon = StartRepulsive,
}

AddPawn("OmegaDNT_Silkworm2")

OmegaDNT_Stinkbug2 = Pawn:new
{
	Name = "Omega Stinkbug",
	Health = 4,
	MoveSpeed = 3,
	SkillList = {"OmegaStinkbugAtk2"},
	Image = "Omegastinkbug",
	SoundLocation = "/enemy/scorpion_soldier_1/",
	Portrait = "enemy/OmegaStinkbug2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
	IsDeathEffect = true,
	Corpse = true,
}
AddPawn("OmegaDNT_Stinkbug2")

modApi:appendAsset("img/combat/icons/OmegaStinkbugTrait.png", resourcePath.."img/combat/icons/OmegaStinkbugTrait.png")
trait:add{
	pawnType = "OmegaDNT_Stinkbug2",
	icon = resourcePath.."img/combat/icons/OmegaStinkbugTrait.png",
	--icon_offset = Point(0,-15),
	desc_title = "Chemical Deterrence",	
	desc_text = "If killed, applies temporary smoke and toxin on all adjacent tiles.",
}

function OmegaDNT_Stinkbug2:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if not Board:IsValid(point) then return ret end
	if not mission then return ret end
	if Board:GetTerrain(point) == TERRAIN_HOLE then return ret end
	if not mission.DNT_FartList then mission.DNT_FartList = {} end
	local anim1 = IsPassiveSkill("Electric_Smoke") and "DNT_FartFrontDark" or "DNT_FartFront"
	local anim2 = IsPassiveSkill("Electric_Smoke") and "DNT_FartBackDark" or "DNT_FartBack"
	local anim3 = IsPassiveSkill("Electric_Smoke") and "DNT_FartAppearDark" or "DNT_FartAppear"
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		LOG(curr:GetString())
		local damage = SpaceDamage(curr)
		damage.iToxin = 1
		damage.iSmoke = 1
		ret:AddDamage(damage)
		Board:AddAnimation(curr, anim1, ANIM_NO_DELAY)
		Board:AddAnimation(curr, anim2, ANIM_NO_DELAY)
		Board:AddAnimation(curr, anim3, ANIM_NO_DELAY)
		GetCurrentMission().DNT_FartList[curr.x+curr.y*10] = curr
	end
	Board:GetPawn(point):SetCorpse(false)
	return ret
end

OmegaDNT_Termites2 = Pawn:new
{
	Name = "Omega Termites",
	Health = 4,		--consistent with most ranged Vek
	MoveSpeed = 3,
	Ranged = 1,
	SkillList = {"OmegaTermitesAtk2"},
	Image = "Omegatermites",
	SoundLocation = "/enemy/digger_2/",
	Portrait = "enemy/OmegaTermites2",
	ImageOffset = 1,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_Termites2")

OmegaDNT_Thunderbug2 = Pawn:new{
	Name = "Omega Thunderbug",
	Health = 4,		--consistent with most ranged Vek
	MoveSpeed = 4,
	Ranged = 1,
	Image = "Omegathunderbug",
	ImageOffset = 1,
	SkillList = { "OmegaThunderbugAtk2" },
	SoundLocation = "/enemy/beetle_2/",
	Portrait = "enemy/OmegaThunderbug2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_OMEGA,
}
AddPawn("OmegaDNT_Thunderbug2")
