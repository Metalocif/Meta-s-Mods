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

local name = "nestedgoo" 

modApi:appendAsset(writepath..name..".png", readpath..name..".png")
modApi:appendAsset(writepath..name.."2.png", readpath..name.."2.png")
modApi:appendAsset(writepath..name.."3.png", readpath..name.."3.png")

-- modApi:appendAsset(writepath..name.."a.png", readpath..name.."a.png")
-- modApi:appendAsset(writepath.."emergegoo.png", readpath.."emergegoo.png")
-- modApi:appendAsset(writepath..name.."_death.png", readpath..name.."_death.png")

a.Meta_nestedgoo1 = a.EnemyUnit:new{Image = imagepath .. name..".png", PosX = -17, PosY = 10, Height = 1}
a.Meta_nestedgoo1e = a.BaseEmerge:new{Image = imagepath .. "emergegoo.png", PosX = -20, PosY = 5, NumFrames = 10, Height = 1}
a.Meta_nestedgoo1d = a.BaseEmerge:new{Image = imagepath .. "deathgoo.png", PosX = -20, PosY = 5, NumFrames = 7, Height = 1, Loop = false}
a.Meta_nestedgoo1a = a.Meta_nestedgoo1:new{ Image = imagepath..name..".png", NumFrames = 1 }

a.Meta_nestedgoo2 = a.EnemyUnit:new{Image = imagepath .. name.."2.png", PosX = -20, PosY = 3, Height = 1}
a.Meta_nestedgoo2e = a.BaseEmerge:new{Image = imagepath .. "emergegoobig.png", PosX = -23, PosY = -5, NumFrames = 12, Height = 1}
a.Meta_nestedgoo2d = a.BaseEmerge:new{Image = imagepath .. "deathgoobig.png", PosX = -23, PosY = 5, NumFrames = 7, Height = 1, Loop = false}
a.Meta_nestedgoo2a = a.Meta_nestedgoo2:new{ Image = imagepath..name.."2.png", NumFrames = 1 }

a.Meta_nestedgoo3 = a.EnemyUnit:new{Image = imagepath .. name.."3.png", PosX = -28, PosY = -8, Height = 1}
a.Meta_nestedgoo3e = a.BaseEmerge:new{Image = imagepath .. "emergegoohuge.png", PosX = -23, PosY = -5, NumFrames = 14, Height = 1}
a.Meta_nestedgoo3d = a.BaseEmerge:new{Image = imagepath .. "deathgoohuge.png", PosX = -23, PosY = -5, NumFrames = 7, Height = 1, Loop = false}
a.Meta_nestedgoo3a = a.Meta_nestedgoo3:new{ Image = imagepath..name.."3.png", NumFrames = 1 }


-------------
-- Weapons --
-------------

Meta_nestedgooAtk1_StarfishAtk = Skill:new{
	Name = "Pseudopod Strike",
	Description = "Strikes nearby tiles with pseudopods; the number of strikes depends on the unit's size.",
	Class = "Enemy",
	SoundBase = "/enemy/blobber_1",
	Icon = "weapons/enemy_blobber1.png",
	PathSize = 1,
	Damage = 2,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,3),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		Building1 = Point(3,3),
		Building2 = Point(2,1),
		Building3 = Point(2,3),
		CustomPawn = "Meta_nestedgoo1",
	}
}

function Meta_nestedgooAtk1_StarfishAtk:GetTargetArea(point)
	ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		ret:push_back(curr)
	end
	return ret
end

function Meta_nestedgooAtk1_StarfishAtk:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local pawn = Board:GetPawn(p1)
	if pawn ~= nil then
	
		--check for adjacent gunk to eat unqueued, used on all goos
		if GetCurrentMission().GunkTable == nil then GetCurrentMission().GunkTable = {} end
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and CustomAnim:get(Board:GetPawn(curr):GetId(), "gunk") then
				if Board:GetPawn(p1) and not Board:GetPawn(p1):IsDamaged() then
					ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), Board:GetPawn(p1):GetHealth() + 1))
				end
				ret:AddDamage(SpaceDamage(p1, -1))
				ret:AddQueuedScript(string.format("CustomAnim:rem(%s, %q)", Board:GetPawn(curr):GetId(), "gunk"))
				ret:AddQueuedScript("table.remove(GetCurrentMission().GunkTable,"..pawn:GetId()..")")
			end
		end
	
		local anim = pawn:GetCustomAnim()
		if anim == "" then anim = _G[pawn:GetType()].Image end
		local tier = 0
		if anim == "Meta_nestedgoo1" then tier = 1 end
		if anim == "Meta_nestedgoo2" then tier = 2 end
		if anim == "Meta_nestedgoo3" then tier = 3 end
		if tier == 1 or tier == 3 then
			if Board:GetPawn(p2) and CustomAnim:get(Board:GetPawn(p2):GetId(), "gunk") then
				if Board:GetPawn(p1) and not Board:GetPawn(p1):IsDamaged() then
					ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), Board:GetPawn(p1):GetHealth() + 1))
				end
				ret:AddQueuedDamage(SpaceDamage(p1, -1))
				ret:AddQueuedScript(string.format("CustomAnim:rem(%s, %q)", Board:GetPawn(p2):GetId(), "gunk"))
			end
			local damage = SpaceDamage(p2, self.Damage)
			damage.sAnimation = "explogoomosquito_"..dir
			damage.sSound = self.SoundBase.."/attack"
			ret:AddQueuedDamage(damage)
		end
		if tier >= 2 then
			local curr = p1 + DIR_VECTORS[(dir+1)%4] + DIR_VECTORS[(dir+2)%4]
			if Board:GetPawn(curr) and CustomAnim:get(Board:GetPawn(curr):GetId(), "gunk") then
				if Board:GetPawn(p1) and not Board:GetPawn(p1):IsDamaged() then
					ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), Board:GetPawn(p1):GetHealth() + 1))
				end
				ret:AddQueuedDamage(SpaceDamage(p1, -1))
				ret:AddQueuedScript(string.format("CustomAnim:rem(%s, %q)", Board:GetPawn(curr):GetId(), "gunk"))
			end
			local damage = SpaceDamage(curr,self.Damage)
			damage.sAnimation = "explogoostarfish_"..(dir+1)%4
			damage.sSound = self.SoundBase.."/attack"
			ret:AddQueuedDamage(damage)
			
			curr = p1 + DIR_VECTORS[(dir+2)%4] + DIR_VECTORS[(dir+3)%4]
			if Board:GetPawn(curr) and CustomAnim:get(Board:GetPawn(curr):GetId(), "gunk") then
				if Board:GetPawn(p1) and not Board:GetPawn(p1):IsDamaged() then
					ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), Board:GetPawn(p1):GetHealth() + 1))
				end
				ret:AddQueuedDamage(SpaceDamage(p1, -1))
				ret:AddQueuedScript(string.format("CustomAnim:rem(%s, %q)", Board:GetPawn(curr):GetId(), "gunk"))
			end
			damage = SpaceDamage(curr,self.Damage)
			damage.sAnimation = "explogoostarfish_"..(dir+2)%4
			damage.sSound = self.SoundBase.."/attack"
			ret:AddQueuedDamage(damage)
		end
	end
	return ret
end

-----------
-- Pawns --
-----------

Meta_nestedgoo1 = Pawn:new{
	Name = "Nested Goo",
	Health = 1,
	MoveSpeed = 3,
	Image = "Meta_nestedgoo2",
	Ranged = 0,
	SkillList = { "Meta_nestedgooAtk1_StarfishAtk" },
	SoundLocation = "/enemy/goo_boss/",
	Portrait = "enemy/Goo",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	IsDeathEffect = true,
	Corpse = true,
}
AddPawn("Meta_nestedgoo1")

function Meta_nestedgoo1:GetDeathEffect(point)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(point)
	local mission = GetCurrentMission()
	if mission.Meta_GooAnims == nil then mission.Meta_GooAnims = {} end
	if pawn and not (Board:IsTerrain(point, TERRAIN_WATER) or Board:IsTerrain(point, TERRAIN_HOLE) or Board:IsTerrain(point, TERRAIN_MOUNTAIN)) then
		local anim = pawn:GetCustomAnim()
		if anim == "" then anim = _G[pawn:GetType()].Image end
		local tier
		if anim == "Meta_nestedgoo1" then tier = 1 end
		if anim == "Meta_nestedgoo2" then tier = 2 end
		if anim == "Meta_nestedgoo3" then tier = 3 end
		if tier > 1 then
			modApi:runLater(function() Board:GetPawn(point):SetCustomAnim("Meta_nestedgoo"..tier-1) end)
			mission.Meta_GooAnims[pawn:GetId()] = "Meta_nestedgoo"..tier-1
			pawn:SetHealth(pawn:GetMaxHealth())
		else
			pawn:SetCorpse(false)
		end
	elseif pawn then 
		pawn:SetCorpse(false)
	end
	return ret
end

Meta_nestedgoo2 = Meta_nestedgoo1:new{
	Name = "Alpha Nested Goo",
	Health = 1,
	MoveSpeed = 3,
	Image = "Meta_nestedgoo3",
	Ranged = 0,
	SkillList = { "Meta_nestedgooAtk1_StarfishAtk" },
	SoundLocation = "/enemy/goo_boss/",
	Portrait = "enemy/Goo",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_ALPHA,
	IsDeathEffect = true,
	Corpse = true,
}
AddPawn("Meta_nestedgoo2")

function Meta_nestedgoo2:GetDeathEffect(point)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(point)
	local mission = GetCurrentMission()
	if mission.Meta_GooAnims == nil then mission.Meta_GooAnims = {} end
	if pawn and not (Board:IsTerrain(point, TERRAIN_WATER) or Board:IsTerrain(point, TERRAIN_HOLE) or Board:IsTerrain(point, TERRAIN_MOUNTAIN)) then
		local anim = pawn:GetCustomAnim()
		if anim == "" then anim = _G[pawn:GetType()].Image end
		local tier
		if anim == "Meta_nestedgoo1" then tier = 1 end
		if anim == "Meta_nestedgoo2" then tier = 2 end
		if anim == "Meta_nestedgoo3" then tier = 3 end
		if tier > 1 then
			modApi:runLater(function() Board:GetPawn(point):SetCustomAnim("Meta_nestedgoo"..tier-1) end)
			mission.Meta_GooAnims[pawn:GetId()] = "Meta_nestedgoo"..tier-1
			pawn:SetHealth(pawn:GetMaxHealth())
		else
			pawn:SetCorpse(false)
		end
	elseif pawn then 
		pawn:SetCorpse(false)
	end
	return ret
end

easyEdit.enemyList:get("archive"):addEnemy("Meta_nestedgoo","Core")
