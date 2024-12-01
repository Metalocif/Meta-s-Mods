local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath

local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

local function IsTipImage()
	return Board:GetSize() == Point(6,6)
end

-------------
--   Art   --
-------------


local names = {"blobber", "spider", "beetle", "starfish", "crab", "burnbug", "firefly", "leaper", "scarab", "mosquito", "digger", "centipede", "bouncer", "moth", "dungbeetle", "hornet", "burrower", "scorpion", "shaman", "totem"} --list all

for i = 1, #names do
	local name = names[i]
	modApi:appendAsset(writepath.."Omega"..name..".png", readpath.."Omega"..name..".png")
	modApi:appendAsset(writepath.."Omega"..name.."a.png", readpath.."Omega"..name.."a.png")
	modApi:appendAsset(writepath.."Omega"..name.."_death.png", readpath.."Omega"..name.."_death.png")
	modApi:appendAsset(writepath.."Omega"..name.."_emerge.png", readpath.."Omega"..name.."_emerge.png")
	a["Omega"..name] = a[name]:new{ Image = "units/aliens/Omega"..name..".png"}
	a["Omega"..name.."e"] = a[name.."e"]:new{ Image = "units/aliens/Omega"..name.."_emerge.png"}
	a["Omega"..name.."d"] = a[name.."d"]:new{ Image = "units/aliens/Omega"..name.."_death.png"}
	a["Omega"..name.."a"] = a[name.."a"]:new{ Image = "units/aliens/Omega"..name.."a.png"}
end

modApi:appendAsset("img/portraits/enemy/OmegaBeetle2.png", resourcePath.."img/portraits/enemy/OmegaBeetle2.png")
modApi:appendAsset("img/portraits/enemy/OmegaBlobber2.png", resourcePath.."img/portraits/enemy/OmegaBlobber2.png")
modApi:appendAsset("img/portraits/enemy/OmegaBouncer2.png", resourcePath.."img/portraits/enemy/OmegaBouncer2.png")
modApi:appendAsset("img/portraits/enemy/OmegaBurnbug2.png", resourcePath.."img/portraits/enemy/OmegaBurnbug2.png")
modApi:appendAsset("img/portraits/enemy/OmegaBurrower2.png", resourcePath.."img/portraits/enemy/OmegaBurrower2.png")
modApi:appendAsset("img/portraits/enemy/OmegaCentipede2.png", resourcePath.."img/portraits/enemy/OmegaCentipede2.png")
modApi:appendAsset("img/portraits/enemy/OmegaCrab2.png", resourcePath.."img/portraits/enemy/OmegaCrab2.png")
modApi:appendAsset("img/portraits/enemy/OmegaDigger2.png", resourcePath.."img/portraits/enemy/OmegaDigger2.png")
modApi:appendAsset("img/portraits/enemy/OmegaDung2.png", resourcePath.."img/portraits/enemy/OmegaDung2.png")
modApi:appendAsset("img/portraits/enemy/OmegaFirefly2.png", resourcePath.."img/portraits/enemy/OmegaFirefly2.png")
modApi:appendAsset("img/portraits/enemy/OmegaHornet2.png", resourcePath.."img/portraits/enemy/OmegaHornet2.png")
modApi:appendAsset("img/portraits/enemy/OmegaLeaper2.png", resourcePath.."img/portraits/enemy/OmegaLeaper2.png")
modApi:appendAsset("img/portraits/enemy/OmegaMosquito2.png", resourcePath.."img/portraits/enemy/OmegaMosquito2.png")
modApi:appendAsset("img/portraits/enemy/OmegaMoth2.png", resourcePath.."img/portraits/enemy/OmegaMoth2.png")
modApi:appendAsset("img/portraits/enemy/OmegaScarab2.png", resourcePath.."img/portraits/enemy/OmegaScarab2.png")
modApi:appendAsset("img/portraits/enemy/OmegaScorpion2.png", resourcePath.."img/portraits/enemy/OmegaScorpion2.png")
modApi:appendAsset("img/portraits/enemy/OmegaShaman2.png", resourcePath.."img/portraits/enemy/OmegaShaman2.png")
modApi:appendAsset("img/portraits/enemy/OmegaSpider2.png", resourcePath.."img/portraits/enemy/OmegaSpider2.png")
modApi:appendAsset("img/portraits/enemy/Omegaspiderling1.png", resourcePath.."img/portraits/enemy/Omegaspiderling1.png")
modApi:appendAsset("img/portraits/enemy/OmegaStarfish2.png", resourcePath.."img/portraits/enemy/OmegaStarfish2.png")
modApi:appendAsset("img/portraits/enemy/OmegaTotem2.png", resourcePath.."img/portraits/enemy/OmegaTotem2.png")

---------------
--   Pawns   --
---------------

OmegaBurnbug2 = Pawn:new{
	Name = "Omega Burnbug",
	Health = 5,
	MoveSpeed = 3,
	Image = "Omegaburnbug",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "OmegaBurnbugAtk2" },
	SoundLocation = "/enemy/burnbug/",
	Portrait = "enemy/OmegaBurnbug2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBurnbug2")

OmegaFirefly2 = Pawn:new{
	Name = "Omega Firefly",
	Health = 5,
	MoveSpeed = 3,
	Image = "Omegafirefly",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "OmegaFireflyAtk2" },
	SoundLocation = "/enemy/firefly/",
	Portrait = "enemy/OmegaFirefly2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaFirefly2")

OmegaLeaper2 = Pawn:new{
	Name = "Omega Leaper",
	Health = 3,
	MoveSpeed = 4,
	Image = "Omegaleaper",
	ImageOffset = 1,
	Pushable = false,
	Jumper = true,
	SkillList = { "OmegaLeaperAtk2" },
	SoundLocation = "/enemy/leaper/",
	Portrait = "enemy/OmegaLeaper2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaLeaper2")

OmegaScarab2 = Pawn:new{
	Name = "Omega Scarab",
	Health = 4,
	MoveSpeed = 3,
	Image = "Omegascarab",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "OmegaScarabAtk2" },
	SoundLocation = "/enemy/scarab/",
	Portrait = "enemy/OmegaScarab2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaScarab2")

OmegaMosquito2 = Pawn:new{
	Name = "Omega Mosquito",
	Health = 4,
	MoveSpeed = 3,
	Image = "Omegamosquito",
	ImageOffset = 1,
	SkillList = { "OmegaMosquitoAtk2" },
	SoundLocation = "/enemy/mosquito/",
	Portrait = "enemy/OmegaMosquito2",
	Flying = true,
	IgnoreSmoke = true,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaMosquito2")

OmegaDigger2 = Pawn:new{
	Name = "Omega Digger",
	Health = 2,
	MoveSpeed = 3,
	Image = "Omegadigger",
	ImageOffset = 1,
	SkillList = { "OmegaDiggerAtk2" },
	SoundLocation = "/enemy/digger/",
	Portrait = "enemy/OmegaDigger2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaDigger2")

OmegaCentipede2 = Pawn:new{
	Name = "Omega Centipede",
	Health = 8,		--pretty high given it's resistance to fire/push damage and immune to acid
	MoveSpeed = 3,
	Image = "Omegacentipede",
	ImageOffset = 1,
	SkillList = { "OmegaCentipedeAtk2" },
	SoundLocation = "/enemy/centipede/",
	Portrait = "enemy/OmegaCentipede2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaCentipede2")

OmegaBouncer2 = Pawn:new{
	Name = "Omega Bouncer",
	Health = 5,
	MoveSpeed = 4,
	Image = "Omegabouncer",
	ImageOffset = 1,
	SkillList = { "OmegaBouncerAtk2" },
	SoundLocation = "/enemy/bouncer/",
	Portrait = "enemy/OmegaBouncer2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBouncer2")

OmegaMoth2 = Pawn:new{
	Name = "Omega Moth",
	Health = 5,
	MoveSpeed = 4,
	Flying = true,
	Image = "Omegamoth",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "OmegaMothAtk2" },
	SoundLocation = "/enemy/moth/",
	Portrait = "enemy/OmegaMoth2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaMoth2")

OmegaDung2 = Pawn:new{
	Name = "Omega Tumblebug",
	Health = 5,
	MoveSpeed = 3,
	Image = "Omegadungbeetle",
	ImageOffset = 1,
	SkillList = { "OmegaDungAtk2" },
	SoundLocation = "/enemy/dung/",
	Portrait = "enemy/OmegaDung2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaDung2")

OmegaHornet2 = Pawn:new{
	Name = "Omega Hornet",
	Health = 4,
	MoveSpeed = 4,
	Image = "Omegahornet",
	ImageOffset = 1,
	SkillList = { "OmegaHornetAtk2" },
	SoundLocation = "/enemy/hornet/",
	Portrait = "enemy/OmegaHornet2",
	Flying = true,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaMosquito2")

OmegaBurrower2 = Pawn:new{
	Name = "Omega Burrower",
	Health = 2,
	Armor = true,
	Image = "Omegaburrower",
	ImageOffset = 1,
	MoveSpeed = 4,
	Ranged = 1,
	Burrows = true,
	DefaultTeam = TEAM_ENEMY,
	SkillList = {"OmegaBurrowerAtk2"},
	ImpactMaterial = IMPACT_INSECT,
	SoundLocation = "/enemy/burrower_2/",
	Portrait = "enemy/OmegaBurrower2",
	Pushable = false,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBurrower2")  

OmegaScorpion2 = Pawn:new{
	Name = "Omega Scorpion",
	Health = 5,
	MoveSpeed = 3,
	Image = "Omegascorpion",
	ImageOffset = 1,
	SkillList = { "OmegaScorpionAtk2" },
	SoundLocation = "/enemy/scorpion/",
	Portrait = "enemy/OmegaScorpion2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaScorpion2")


OmegaShaman2 = Pawn:new{
	Name = "Omega Plasmodia",
	Health = 5,
	MoveSpeed = 2,
	Image = "Omegashaman",
	ImageOffset = 1,
	SkillList = { "OmegaShamanAtk2" },
	SoundLocation = "/enemy/shaman/",
	Portrait = "enemy/OmegaShaman2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
	IsDeathEffect = true,
}
AddPawn("OmegaShaman2")

function OmegaShaman2:GetDeathEffect(point)
	for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(i):GetType() == "OmegaPlasmodia2" then return SkillEffect() end
	end
	for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		Board:GetPawn(i):SetCorpse(mission.hadCorpseBeforeOmegaPlasmodia[i])
	end
	return SkillEffect()
end

OmegaTotem2 = Pawn:new{
	Name = "Omega Spore",
	Health = 1,
	MoveSpeed = 0,
	Minor = true,
	Image = "Omegatotem",
	ImageOffset = 1,
	SkillList = { "OmegaTotemAtk2" },
	SoundLocation = "/enemy/totem/",
	Portrait = "enemy/OmegaTotem2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaTotem2")

OmegaCrab2 = Pawn:new{
	Name = "Omega Crab",
	Health = 5,
	MoveSpeed = 2,
	Image = "Omegacrab",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "OmegaCrabAtk2" },
	SoundLocation = "/enemy/crab/",
	Portrait = "enemy/OmegaCrab2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaCrab2")

OmegaBeetle2 = Pawn:new{
	Name = "Omega Beetle",
	Health = 5,
	MoveSpeed = 3,
	Image = "Omegabeetle",
	ImageOffset = 1,
	-- Ranged = 1,
	SkillList = { "OmegaBeetleAtk2" },
	SoundLocation = "/enemy/beetle/",
	Portrait = "enemy/OmegaBeetle2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBeetle2")


OmegaStarfish2 = Pawn:new{
	Name = "Omega Starfish",
	Health = 3,
	MoveSpeed = 4,
	Image = "Omegastarfish",
	ImageOffset = 1,
	Ranged = 1,
	SkillList = { "StarfishAtk2" },
	SoundLocation = "/enemy/starfish/",
	Portrait = "enemy/OmegaStarfish2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
	IsDeathEffect = true,
	DeathSpawn = "OmegaStarfish1"
}
AddPawn("OmegaStarfish2")

OmegaStarfish1 = {	--not actually different from Starfish1, I just couldn't get the game to make deathspawns minor and 1 max HP
	Name = "Starfish",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Image = "starfish",
	SkillList = { "StarfishAtk1" },
	SoundLocation = "/enemy/starfish_1/",
	Portrait = "enemy/Starfish1",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT
}
AddPawn("OmegaStarfish1")

function OmegaStarfish2:GetDeathEffect(point)
	local ret = SkillEffect()
	ret:AddSound("/enemy/goo_boss/split")
	local vicinity = extract_table(general_DiamondTarget(point,4))
	local spawnPoints = {}
	local backup = {}
	for i,v in ipairs(vicinity) do
		if not Board:IsBlocked(v,PATH_GROUND) and v ~= point then
			if point:Manhattan(v) > 2 then
				backup[#backup + 1] = v
			else
				spawnPoints[#spawnPoints + 1] = v
			end
		end
	end
	for i = 1, 2 do
		local damage = SpaceDamage(0)
		if #spawnPoints ~= 0 then
			damage.loc = random_removal(spawnPoints)
		elseif #backup ~= 0 then
			damage.loc = random_removal(backup)
		else
			ret:AddScript("Board:AddAlert("..point:GetString()..",\"Alert_BlobSpawn\")")
			break
		end
		damage.sPawn = self.DeathSpawn
		-- damage.sScript(string.format("Board:AddPawn(%q, %s)"), self.DeathSpawn, damage.loc:GetString())
		damage.sSound = '/impact/generic/blob'
		-- ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%q):SetMinor(true) end)", damage.loc:GetString()))
		-- ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%q):SetMaxHealth(1) end)", damage.loc:GetString()))
		ret:AddArtillery(damage,"effects/shotup_antB.png",NO_DELAY)
	end
	return ret
end

OmegaSpider2 = Pawn:new{
	Name = "Omega Spider",
	Health = 4,
	MoveSpeed = 4,
	Image = "Omegaspider",
	ImageOffset = 1,
	Jumper = true,
	SkillList = { "OmegaSpiderAtk2" },
	SoundLocation = "/enemy/spider/",
	Portrait = "enemy/OmegaSpider2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaSpider2")

OmegaBlobber2 = Pawn:new{
	Name = "Omega Blobber",
	Health = 4,
	MoveSpeed = 3,
	Image = "Omegablobber",
	ImageOffset = 1,
	SkillList = { "OmegaBlobberAtk2" },
	SoundLocation = "/enemy/blobber/",
	Portrait = "enemy/OmegaBlobber2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBlobber2")

OmegaBlob2 = {
	Name = "Omega Blob",
	Health = 1,
	MoveSpeed = 0,
	Image = "blob",
	ImageOffset = 1,
	Minor = true,
	SkillList = { },
	Explodes = true,
	SoundLocation = "/enemy/blob_2/",
	Portrait = "enemy/Blob2",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_ALPHA,
}
AddPawn("OmegaBlob2") 