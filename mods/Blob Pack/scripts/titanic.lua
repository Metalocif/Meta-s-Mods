easyEdit.bossList:get("archive"):addBoss("Mission_TitanicGooBoss")

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath
local writepath = "img/units/aliens/"
local readpath = path .. writepath
local imagepath = writepath:sub(5,-1)

local weaponPreview = require(path .."scripts/libs/weaponPreview")

modApi:appendAsset(writepath .."titanicgoo.png", readpath .."titanicgoo.png")
modApi:appendAsset(writepath .."deathgootitanic.png", readpath .."deathgootitanic.png")
-- modApi:appendAsset(writepath .."titanicgoo_death.png", readpath .."titanicgoo_death.png")
-- modApi:appendAsset(writepath .."titanicgoo_emerge.png", readpath .."titanicgoo_emerge.png")
modApi:appendAsset(writepath .."titanicgoow.png", readpath .."titanicgoow.png") --should never be used but just in case

modApi:appendAsset("img/effects/shotup_giganticgoo.png", path.."img/effects/shotup_giganticgoo.png")
modApi:appendAsset("img/combat/tiles_grass/gooacid.png", path.."img/combat/tiles_grass/gooacid.png")
modApi:appendAsset("img/combat/tiles_grass/goohole.png", path.."img/combat/tiles_grass/goohole.png")
modApi:appendAsset("img/combat/tiles_grass/goolava.png", path.."img/combat/tiles_grass/goolava.png")
modApi:appendAsset("img/combat/tiles_grass/goowater.png", path.."img/combat/tiles_grass/goowater.png")
Location["img/combat/tiles_grass/gooacid.png"] = Point(-26,2)
Location["img/combat/tiles_grass/goohole.png"] = Point(-26,2)
Location["img/combat/tiles_grass/goolava.png"] = Point(-26,2)
Location["img/combat/tiles_grass/goowater.png"] = Point(-26,2)

local a = ANIMS
local base = a.EnemyUnit:new{Image = imagepath .."titanicgoo.png", PosX = -40, PosY = 1, NumFrames = 1, Height = 1 }
-- local baseEmerge = a.BaseEmerge:new{Image = imagepath .."titanicgoo_emerge.png", PosX = -20, PosY = 1, Height = 1}
a.titanicgoo  =	base
-- a.titanicgooe =	baseEmerge
a.titanicgooa =	base:new{ Image = "units/aliens/titanicgoo.png", NumFrames = 1 }
a.titanicgood =	base:new{ Image = "units/aliens/deathgootitanic.png", NumFrames = 7, Time = 0.2, Loop = false }
a.titanicgoow =	base:new{ Image = "units/aliens/titanicgoow.png", PosY = 10 }

---- MISSION DESCRIPTION
Mission_TitanicGooBoss = Mission_Boss:new{
	Name = "Titanic Goo",
	BossPawn = "Meta_TitanicGooBoss",
	GlobalSpawnMod = -2,
	
	Target = 0,
	BossText = "Destroy the Titanic Goo"
}

local adjOffsets = { VEC_UP, VEC_UP + VEC_RIGHT, VEC_RIGHT * 2, VEC_RIGHT * 2 + VEC_DOWN, VEC_DOWN * 2, VEC_DOWN * 2 + VEC_RIGHT, VEC_LEFT, VEC_LEFT + VEC_DOWN }

function Mission_TitanicGooBoss:NextPawn(pawn_tables, name_only)
	local goos = { "Meta_nestedgoo", "Meta_splittinggoo", "Meta_pylongoo", "Meta_shapeshifter", "Meta_spikygoo", "Meta_sludgegoo" }
	local diff = GetDifficulty()
	local island = GetSector()
	local alphaRate = math.min(diff / 6 + island / 10, 1)
	--bullshit formula that should spit out a number equal to between 0 and 1
	--higher the more islands finished and on higher difficulties
	--hopefully more or less equivalent to vanilla alpha generation, though their algorithm smooths it out AFAICT
	local suffix
	if math.random() >= alphaRate then suffix = 2 else suffix = 1 end
	local next_pawn = goos[math.random(#goos)] .. suffix
	
	if not name_only then
		return PAWN_FACTORY:CreatePawn(next_pawn)
	end
	
	return next_pawn
end


function Mission_TitanicGooBoss:NextTurn() 
	if Game:GetTeamTurn() == TEAM_ENEMY then
		if Board:IsPawnAlive(self.Target) then
			local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(1, 1) }
			local boss = Board:GetPawn(self.Target)
			local tile = boss:GetSpace()
			for _, offset in ipairs(offsets) do
				local curr = tile + offset
				if Board:IsSmoke(tile) then Board:SetSmoke(tile, false, false) end
			end
		end
	end
end

function Mission_TitanicGooBoss:StartBoss()
	local pawn = PAWN_FACTORY:CreatePawn("Meta_TitanicGooBoss")
	self.Target = pawn:GetId()
	--we try to find a tile where the goo won't be on a mountain/building/pawn/spawning tiles/adjacent to a building
	--every time we fail, we abandon a criterion
	--AFAICT in testing it never failed even the first attempt, but you never know with modded maps and whatnot
	local tiles = extract_table(Board:GetTiles(function(p)
		local isNotBlockedOrSpawning = not Board:IsBlocked(p, PATH_MASSIVE) and not Board:IsSpawning(p) and
			   not Board:IsBlocked(p + Point(0,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(0,1)) and
			   not Board:IsBlocked(p + Point(1,0), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,0)) and
			   not Board:IsBlocked(p + Point(1,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,1))
		if not isNotBlockedOrSpawning then return false end
		if p.x == 7 or p.y == 7 or p.y < 4 then return false end
		for _, offset in ipairs(adjOffsets) do
			if Board:IsBuilding(p + offset) then return false end
		end
		return true
	end))
	
	if #tiles == 0 then
		LOG("failed first GetTiles")
		tiles = extract_table(Board:GetTiles(function(p)
			local isNotBlockedOrSpawning = not Board:IsBlocked(p, PATH_MASSIVE) and not Board:IsSpawning(p) and
				   not Board:IsBlocked(p + Point(0,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(0,1)) and
				   not Board:IsBlocked(p + Point(1,0), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,0)) and
				   not Board:IsBlocked(p + Point(1,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,1))
			if not isNotBlockedOrSpawning then return false end
			if p.x == 7 or p.y == 7 then return false end
			for _, offset in ipairs(adjOffsets) do
				if Board:IsBuilding(p + offset) then return false end
			end
			return true
		end))
	end
	
	if #tiles == 0 then 
		LOG("failed second GetTiles")
		tiles = extract_table(Board:GetTiles(function(p)
			local isNotBlockedOrSpawning = not Board:IsBlocked(p, PATH_MASSIVE) and not Board:IsSpawning(p) and
				   not Board:IsBlocked(p + Point(0,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(0,1)) and
				   not Board:IsBlocked(p + Point(1,0), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,0)) and
				   not Board:IsBlocked(p + Point(1,1), PATH_MASSIVE) and not Board:IsSpawning(p + Point(1,1))
			if not isNotBlockedOrSpawning then return false end
			if p.x == 7 or p.y == 7 then return false end
			return true
		end))
	end
	
	if #tiles == 0 then 
		LOG("failed third GetTiles")
		tiles = extract_table(Board:GetTiles(function(p)
			local isNotBlocked = not Board:IsBlocked(p, PATH_MASSIVE) and
				   not Board:IsBlocked(p + Point(0,1), PATH_MASSIVE) and
				   not Board:IsBlocked(p + Point(1,0), PATH_MASSIVE) and
				   not Board:IsBlocked(p + Point(1,1), PATH_MASSIVE) 
			if not isNotBlocked then return false end
			if p.x == 7 or p.y == 7 then return false end
			return true
		end))
	end
	
	if #tiles == 0 then LOG("failed fourth GetTiles") tiles = extract_table(Board:GetTiles()) end
	--let's be extra safe
	Board:AddPawn(pawn, random_removal(tiles))
end

function Mission_TitanicGooBoss:UpdateMission() 
	--runs every frame, but this should help prevent ridiculous-looking cheese
	--AFAICT, if there is a hole on the boss' main tile, it falls, otherwise it doesn't; same with liquid
	--so it would be very counterintuitive
	--also helps prevents issues where forests that are not on the bottom-most tile look ugly because the front half sticks out
	
	if Board:IsPawnAlive(self.Target) then --and Game:GetTurnCount() >= 1 then
		local pawn = Board:GetPawn(self.Target)
		local p1 = pawn:GetSpace()
		pawn:SetFlying(true)			--for weapons that remove flying; I made one
		local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(1, 1) }
		for _, offset in ipairs(offsets) do
			local tile = p1 + offset
			if Board:GetTerrain(tile) == TERRAIN_WATER and Board:IsTerrain(tile,TERRAIN_LAVA) then
				Board:SetTerrain(tile, TERRAIN_ROAD)
				Board:SetCustomTile(tile, "goolava.png")
			elseif Board:GetTerrain(tile) == TERRAIN_HOLE then
				Board:SetTerrain(tile, TERRAIN_ROAD)
				Board:SetCustomTile(tile, "goohole.png")
			elseif Board:GetTerrain(tile) == TERRAIN_WATER and Board:IsAcid(tile) then
				Board:SetTerrain(tile, TERRAIN_ROAD)
				Board:SetCustomTile(tile, "gooacid.png")
			elseif Board:GetTerrain(tile) == TERRAIN_WATER then
				Board:SetTerrain(tile, TERRAIN_ROAD)
				Board:SetCustomTile(tile, "goowater.png")
			else
				Board:SetTerrain(tile, TERRAIN_ROAD)
			end
			-- Board:SetFire(tile, false)
		end
	end
end

-------- BOSS DESCRIPTION
Meta_TitanicGooBoss = {
	Health = 12,
	MoveSpeed = 0,	--moves as part of its attack
	-- Ranged = 1,
	Pushable = false,
	Supermassive = true,	--uses a tweaked Tosx code to make it immune to holes/liquids
	Flying = true,			--here for Tosx's code
	IgnoreFlip = true,
	Image = "titanicgoo",
	Name = "Titanic Goo",
	ExtraSpaces = { Point(0,1), Point(1,0), Point(1,1) },			--chonky boy
	SkillList = { "Meta_TitanicGooAtk1", "Meta_TitanicGooAtk2" },
	-- Massive = true,
	ImpactMaterial = IMPACT_BLOB,
	DefaultTeam = TEAM_ENEMY,
	Portrait = "enemy/BlobBoss",
	SoundLocation = "/enemy/goo_boss/",
	Corpse = true,			--just for the DeathEffect
	IsDeathEffect = true,	--spread acid if acidified
	Tier = TIER_BOSS,
}
AddPawn("Meta_TitanicGooBoss") 

function Meta_TitanicGooBoss:GetWeapon()
	--the boss charges if any buildings are adjacent (but may attack pawns only), otherwise it jumps next to buildings
	local tile = Pawn:GetSpace()
	for _, offset in ipairs(adjOffsets) do
		if Board:IsBuilding(tile + offset) then return 1 end
	end
	return 2
end

function Meta_TitanicGooBoss:GetDeathEffect(point)
	--pawns with extra spaces don't apply acid to all their tiles on death, this fixes that
	local pawn = Board:GetPawn(point)
	if pawn:IsAcid() then
		Board:SetAcid(point + Point(0, 1), true)
		Board:SetAcid(point + Point(1, 0), true)
		Board:SetAcid(point + Point(1, 1), true)
	end
	pawn:SetCorpse(false)
	return SkillEffect()
end

Meta_TitanicGooAtk1 = Skill:new{
	Name = "Mountainous Appetite",
	Class = "Enemy",
	PathSize = 1,
	Description = "Advances in a direction, crushing anything there and filling pits and liquids with goo. Heals for each pawn killed.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(3,2),
		Target = Point(2,2),
		Water = Point(2,2),
		CustomPawn = "Meta_TitanicGooBoss"
	}
}

function Meta_TitanicGooAtk1:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point + VEC_UP)
	ret:push_back(point + VEC_LEFT) -- + VEC_DOWN)
	ret:push_back(point + VEC_DOWN * 2) -- + VEC_RIGHT)
	ret:push_back(point + VEC_RIGHT * 2)
	--ugly but easier to work with given extra spaces
	return ret
end

function Meta_TitanicGooAtk1:GetSkillEffect(p1,p2)
	ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local p3 
	if dir == DIR_UP then
		p3 = p2 + VEC_RIGHT
	elseif dir == DIR_LEFT then
		p3 = p2 + VEC_DOWN
	elseif dir == DIR_DOWN then
		p3 = p2 + VEC_RIGHT
	elseif dir == DIR_RIGHT then
		p3 = p2 + VEC_DOWN
	end
	local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(1, 1) }
	for _, offset in ipairs(offsets) do
		local curr = p1 + offset
		if Board:IsSmoke(curr) and Board:GetPawn(p1) then Board:GetPawn(p1):ClearQueued() return ret end
	end
	local food = 0
	local damage = SpaceDamage(p2, DAMAGE_DEATH)
	if Board:GetPawn(p2) then 
		food = food + 1 
		damage.sScript = string.format("Board:GetPawn(%s):SetCorpse(false)", p2:GetString())
		if CustomAnim:get(Board:GetPawn(p2):GetId(), "gunk") then food = food + 1 end
	end
	ret:AddQueuedDamage(damage)
	damage = SpaceDamage(p3, DAMAGE_DEATH)
	if Board:GetPawn(p3) then 
		food = food + 1 
		damage.sScript = string.format("Board:GetPawn(%s):SetCorpse(false)", p3:GetString())
		if CustomAnim:get(Board:GetPawn(p3):GetId(), "gunk") then food = food + 1 end
	end
	ret:AddQueuedDamage(damage)
	if Board:GetTerrain(p2) == TERRAIN_WATER and Board:IsTerrain(p2,TERRAIN_LAVA) then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p2:GetString(), TERRAIN_ROAD))	
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p2:GetString(), "goolava.png"))	
	elseif Board:GetTerrain(p2) == TERRAIN_HOLE then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p2:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p2:GetString(), "goohole.png"))	
	elseif Board:GetTerrain(p2) == TERRAIN_WATER and Board:IsAcid(p2) then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p2:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p2:GetString(), "gooacid.png"))	
	elseif Board:GetTerrain(p2) == TERRAIN_WATER then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p2:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p2:GetString(), "goowater.png"))	
	end
	if Board:GetTerrain(p3) == TERRAIN_WATER and Board:IsTerrain(p3,TERRAIN_LAVA) then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p3:GetString(), TERRAIN_ROAD))	
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p3:GetString(), "goolava.png"))	
	elseif Board:GetTerrain(p3) == TERRAIN_HOLE then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p3:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p3:GetString(), "goohole.png"))	
	elseif Board:GetTerrain(p3) == TERRAIN_WATER and Board:IsAcid(p3) then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p3:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p3:GetString(), "gooacid.png"))	
	elseif Board:GetTerrain(p3) == TERRAIN_WATER then
		ret:AddQueuedScript(string.format("Board:SetTerrain(%s, %s)", p3:GetString(), TERRAIN_ROAD))
		ret:AddQueuedScript(string.format("Board:SetCustomTile(%s, %q)", p3:GetString(), "goowater.png"))	
	end
	local q_move = PointList()
	
	q_move:push_back(p1)
	q_move:push_back(p1 + DIR_VECTORS[dir])
	--p2 is two tiles away in some directions because of extra spaces
	local healing = SpaceDamage(p1 + DIR_VECTORS[dir], -1 * food)
	healing.bHide = true
	ret:AddQueuedDamage(healing)
	ret:AddQueuedDelay(-1)
	ret:AddQueuedCharge(q_move, FULL_DELAY)
	ret:AddQueuedScript(string.format("Board:SetItem(%s, %q)", (p2 - DIR_VECTORS[dir] * 2):GetString(), "Meta_BlobGunk"))
	ret:AddQueuedScript(string.format("Board:SetItem(%s, %q)", (p3 - DIR_VECTORS[dir] * 2):GetString(), "Meta_BlobGunk"))
	return ret
end

Meta_TitanicGooAtk2 = Skill:new{
	Name = "Mountainous Leap",
	Class = "Enemy",
	PathSize = 1,
	Description = "Leaps to a location, crushing anything there.",
	ScoreEnemy = 1,				--4 mechs matter less than one building
	ScoreFriendlyDamage = -1,	--Vek will move out of the way anyway
	ScoreBuilding = 5,
	ScoreNothing = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,0),
		Water = Point(3,2),
		CustomPawn = "Meta_TitanicGooBoss"
	}
}

function Meta_TitanicGooAtk2:GetTargetArea(point)
	return Board:GetTiles(function(p)
		if Board:IsTerrain(p, TERRAIN_MOUNTAIN) or Board:IsTerrain(p, TERRAIN_BUILDING) or 
		   Board:IsTerrain(p + Point(0,1), TERRAIN_MOUNTAIN) or Board:IsTerrain(p + Point(0,1), TERRAIN_BUILDING) or 
		   Board:IsTerrain(p + Point(1,0), TERRAIN_MOUNTAIN) or Board:IsTerrain(p + Point(1,0), TERRAIN_BUILDING) or 
		   Board:IsTerrain(p + Point(1,1), TERRAIN_MOUNTAIN) or Board:IsTerrain(p + Point(1,1), TERRAIN_BUILDING) then return false end
		for _, offset in ipairs(adjOffsets) do
			if Board:IsBuilding(p + offset) then return true end
		end
		return false
	end)
end

function Meta_TitanicGooAtk2:GetSkillEffect(p1,p2)
	ret = SkillEffect()
	local user = Board:GetPawn(p1)
	local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(1, 1) }
	for _, offset in ipairs(offsets) do
		local curr = p1 + offset
		if Board:IsSmoke(curr) and Board:GetPawn(p1) then Board:GetPawn(p1):ClearQueued() return ret end
	end
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(true)", p1:GetString()))
	ret:AddQueuedArtillery(SpaceDamage(p2, DAMAGE_DEATH), "effects/shotup_giganticgoo.png", PROJ_DELAY)
	ret:AddQueuedDamage(SpaceDamage(p2 + Point(0,1), DAMAGE_DEATH))
	ret:AddQueuedDamage(SpaceDamage(p2 + Point(1,0), DAMAGE_DEATH))
	ret:AddQueuedDamage(SpaceDamage(p2 + Point(1,1), DAMAGE_DEATH))
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetSpace(%s)", p1:GetString(), p2:GetString()))
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(false)", p2:GetString()))
	local food = 0
	for _, offset in ipairs(offsets) do
		local curr = p1 + offset
		if Board:IsSmoke(curr) and Board:GetPawn(p1) then Board:GetPawn(p1):ClearQueued() end
		local tile = p2 + offset
		if Board:GetPawn(tile) then 
			food = food + 1 
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCorpse(false)", tile:GetString()))
			if CustomAnim:get(Board:GetPawn(tile):GetId(), "gunk") then food = food + 1 end
		end
	end
	local healing = SpaceDamage(p2, -1 * food)
	healing.bHide = true
	ret:AddQueuedDamage(healing)
	return ret
end

function Meta_TitanicGooAtk2:GetTargetScore(p1, p2)
	local offsets = { Point(0, 0), Point(0, 1), Point(1, 0), Point(1, 1) }
	local score = 0
	for _, offset in ipairs(offsets) do
		local tile = p2 + offset
		local pawn = Board:GetPawn(tile)
		if pawn and pawn:GetTeam() == TEAM_PLAYER then score = score + 10 end
		if pawn and pawn:GetTeam() == TEAM_ENEMY then score = score - 1 end
	end
	return score
end

easyEdit.bossList:get("archive"):addBoss("Mission_TitanicGooBoss")
