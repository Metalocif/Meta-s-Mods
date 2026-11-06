local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath
--local previewer = require(scriptPath.."weaponPreview/api")

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

local name = "lavagoo" 

a.Meta_lavagoo = a.EnemyUnit:new{Image = imagepath .. name..".png", PosX = -20, PosY = 5, Height = 1}
a.Meta_lavagooe = a.BaseEmerge:new{Image = imagepath .. name.."_e.png", PosX = -23, PosY = -5, NumFrames = 10, Height = 1}
a.Meta_lavagooa = a.Meta_lavagoo:new{ Image = imagepath..name..".png", NumFrames = 1 }
a.Meta_lavagood = a.Meta_lavagoo:new{ Image = imagepath..name.."_d.png", NumFrames = 7, Loop = false }

a.Meta_lavagoo2 = a.EnemyUnit:new{Image = imagepath .. name.."2.png", PosX = -20, PosY = 0, Height = 1}
a.Meta_lavagoo2e = a.BaseEmerge:new{Image = imagepath .. name.."2_e.png", PosX = -23, PosY = 5, NumFrames = 12, Height = 1}
a.Meta_lavagoo2a = a.Meta_lavagoo2:new{ Image = imagepath..name.."2.png", NumFrames = 1 }
a.Meta_lavagoo2d = a.Meta_lavagoo2:new{ Image = imagepath..name.."2_d.png", NumFrames = 7, Loop = false }


-------------
-- Weapons --
-------------

Meta_lavagooAtk1 = Skill:new{
	Name = "Lava Plume",
	Description = "Sprays lava, damaging and setting tiles on fire. Causes gunk to explode, damaging adjacent tiles as well.",
	Class = "Enemy",
	SoundBase = "/enemy/scarab_1",
	Icon = "weapons/enemy_centipede1.png",
	PathSize = 2,
	Damage = 1,
	Range = 8,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy1 = Point(2,2),
		Enemy2 = Point(3,2),
		CustomPawn = "Meta_lavagoo1",
	}
}

function Meta_lavagooAtk1:GetTargetArea(point)
	ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end

function Meta_lavagooAtk1:GetSkillEffect(p1,p2)
	ret = SkillEffect()
	
	local blob = Board:GetPawn(p1)
	if not blob then return ret end
	local distance = p1:Manhattan(p2)
	local dir = GetDirection(p2-p1)	
	--check for adjacent gunk to eat unqueued, used on all goos
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local gunkedPawn = Board:GetPawn(curr)
		if gunkedPawn and Status.GetStatus(gunkedPawn:GetId(), "Gunk") then
			ret:AddScript(string.format("Status.HealFromGunk(%s)", blob:GetId()))
			ret:AddScript(string.format("Status.RemoveStatus(%s, Gunk)", gunkedPawn:GetId()))
		end
	end
	
	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[dir]*i
		local damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i,self.Damage)
		if (Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk")) or
		Board:GetItem(curr) == "Meta_BlobGunk" then
			local exploDamage1 = SpaceDamage(curr + DIR_VECTORS[(dir+1)%4], self.Damage)
			exploDamage1.sAnimation = "explopush"..self.Damage.."_"..(dir+1)%4
			ret:AddQueuedDamage(exploDamage1)
			local exploDamage2 = SpaceDamage(curr + DIR_VECTORS[(dir+3)%4], self.Damage)
			exploDamage2.sAnimation = "explopush"..self.Damage.."_"..(dir+3)%4
			ret:AddQueuedDamage(exploDamage2)
			if i == distance then
				local exploDamage3 = SpaceDamage(curr + DIR_VECTORS[dir], self.Damage)
				exploDamage3.sAnimation = "explopush"..self.Damage.."_"..dir
				ret:AddQueuedDamage(exploDamage3)
			end
		end
		damage.iFire = EFFECT_CREATE
		if i == distance then 	
			damage.sAnimation = "flamethrower"..distance.."_"..dir
		end
		ret:AddQueuedDamage(damage)
	end
	return ret
end


Meta_lavagooAtk2 = Meta_lavagooAtk1:new{
	Name = "Lava Jet",
	Damage = 2,
	PathSize = 3,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,0),
		Enemy1 = Point(2,2),
		Enemy2 = Point(3,2),
		Building = Point(2,0),
		CustomPawn = "Meta_lavagoo2",
	}
}

-----------
-- Pawns --
-----------

Meta_lavagoo1 = Pawn:new{
	Name = "Lava Goo",
	Health = 3,
	MoveSpeed = 3,
	Image = "Meta_lavagoo",
	-- Ranged = 1,
	SkillList = { "Meta_lavagooAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	Portrait = "enemy/BlobBoss",
	IgnoreFire = true,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	Corpse = true,
	IsDeathEffect = true,
}
AddPawn("Meta_lavagoo1")

Meta_lavagoo2 = Pawn:new{
	Name = "Alpha Lava Goo",
	Health = 5,
	MoveSpeed = 3,
	Image = "Meta_lavagoo2",
	-- Ranged = 1,
	SkillList = { "Meta_lavagooAtk2" },
	SoundLocation = "/enemy/goo_boss/",
	Portrait = "enemy/BlobBoss",
	IgnoreFire = true,
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_ALPHA,
	Corpse = true,
	IsDeathEffect = true,
}
AddPawn("Meta_lavagoo2")

function Meta_lavagoo1:GetDeathEffect(point)
    if Board:GetTerrain(point) ~= TERRAIN_HOLE and Board:GetTerrain(point) ~= TERRAIN_WATER then
        Board:SetFire(point, true)
    end
    if Board:GetPawn(point) then Board:GetPawn(point):SetCorpse(false) end
	return SkillEffect()
end

function Meta_lavagoo2:GetDeathEffect(point)
    if Board:GetTerrain(point) ~= TERRAIN_HOLE and Board:GetTerrain(point) ~= TERRAIN_WATER then
        Board:SetFire(point, true)
    end
    if Board:GetPawn(point) then Board:GetPawn(point):SetCorpse(false) end
	return SkillEffect()
end

easyEdit.enemyList:get("archive"):addEnemy("Meta_lavagoo","Unique")


--Hook to fix a bug where the cockroach corpse would show up when retreating/evacuating
local function HOOK_MissionEnd(mission,effect)
	local enemies = extract_table(Board:GetPawns(TEAM_ENEMY))
	for _, id in pairs(enemies) do
		local pawn = Board:GetPawn(id)
		if pawn:GetType() == "Meta_lavagoo1" or pawn:GetType() == "Meta_lavagoo2" then
			pawn:SetCorpse(false)
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addMissionEndHook(HOOK_MissionEnd)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
