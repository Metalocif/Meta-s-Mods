local mod = modApi:getCurrentMod()
local path = mod.resourcePath
local artiArrows = require(path .."scripts/artiArrows/artiArrows")
local options = mod_loader.currentModContent[mod.id].options

---- MISSION DESCRIPTION
Mission_KingSlimeBoss = Mission_Boss:new{
	SpawnStartMod = -1,
	SpawnMod = -1,
	BossText = "Destroy the King Slime",
	BossPawn = "KingSlimeBoss",
}

function Mission_KingSlimeBoss:StartMission()
	self:StartBoss()
	self:GetSpawner():BlockPawns("Jelly_Explode")	--spawns a baby every turn
end

local a = ANIMS
local base = a.EnemyUnit:new{Image = "units/aliens/kingslime.png", PosX = -30, PosY = -10, NumFrames = 1, Height = 1 }
a.kingslime  =	base
a.kingslimea =	base:new{ Image = "units/aliens/kingslimea.png", NumFrames = 6, Frames = {0,1,2,3,4,5,4} }
a.kingslimed =	base:new{ Image = "units/aliens/deathgoo_king.png", NumFrames = 7, Time = 0.2, Loop = false }
a.kingslimew =	base:new{ Image = "units/aliens/kingslimew.png", PosY = -10 }
local baseCrowned = a.EnemyUnit:new{Image = "units/aliens/kingslime_crowned.png", PosX = -30, PosY = -25, NumFrames = 1, Height = 1 }
a.kingslime_crowned  =	baseCrowned
a.kingslime_crowneda =	baseCrowned:new{ Image = "units/aliens/kingslime_crowneda.png", NumFrames = 6, Frames = {0,1,2,3,4,5,4} }
a.kingslime_crownedd =	baseCrowned:new{ Image = "units/aliens/deathgoo_kingcrowned.png", NumFrames = 7, Time = 0.2, Loop = false }
a.kingslime_crownedw =	baseCrowned:new{ Image = "units/aliens/kingslime_crownedw.png", PosY = -25 }

KingSlimeBoss = {
	Name = "King Goo",
	Health = 5,
	MoveSpeed = 3,
	GetImage = function()
		if options.Meta_KingSlimeIsCrowned and options.Meta_KingSlimeIsCrowned.enabled then return "kingslime_crowned" else return "kingslime" end
	end,
	Portrait = "enemy/BlobBoss",
	SkillList = { "KingSlimeBossAtk" },
	Massive = true,
	DefaultTeam = TEAM_ENEMY,
	Ranged = 1,
	SoundLocation = "/enemy/goo_boss/",
	ImpactMaterial = IMPACT_BLOB,
	Tier = TIER_BOSS
}
AddPawn("KingSlimeBoss") 


KingSlimeBossAtk = Skill:new{
	Name = "Gooey Leap",
	Description = "Leap to a tile, damaging adjacent locations and spawning a small goo behind.",
	PathSize = 1,
	ScoreNothing = 3,
	Damage = 3,
	Class = "Enemy",
	TipImage = {
		Unit = Point(2,3),
		Building = Point(1,1),
		Target = Point(2,1),
		CustomPawn = "KingSlimeBoss",
	}
}

function KingSlimeBossAtk:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 2, 5 do
			local curr = p1 + DIR_VECTORS[dir] * i
			if Board:IsValid(curr) and not (Board:IsBlocked(curr, PATH_GROUND)) then ret:push_back(curr) end
		end
	end
	
	return ret
end

function KingSlimeBossAtk:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	if not user then return ret end
	
	local dir = GetDirection(p2-p1)
	local destination = p2
	if Board:IsBlocked(p2, PATH_PROJECTILE) then destination = p1 end
	
	if destination ~= p1 then
		ret:AddScript(string.format("Board:SetDangerous(%s)", p2:GetString()))

		ret:AddQueuedScript(string.format([[
			local leap = PointList();
			leap:push_back(%s);
			leap:push_back(%s);
			fx = SkillEffect();
			fx:AddLeap(leap, NO_DELAY);
			Board:AddEffect(fx);
		]], p1:GetString(), p2:GetString()))
	
		ret:AddQueuedDelay(0.06)
		local dummyDamage = SpaceDamage(p1)
		dummyDamage.sImageMark = artiArrows.ColorUp(dir)
		ret:AddQueuedDamage(dummyDamage)
		local landingDamage = SpaceDamage(p2)
		landingDamage.sImageMark = artiArrows.ColorDown(dir)
		ret:AddQueuedDamage(landingDamage) 
		
		if Board:GetPawn(p1) and Board:GetPawn(p1):GetType() == "KingSlimeBoss" then
			local move = PointList()
			move:push_back(p1)
			move:push_back(destination)
			ret:AddQueuedMove(move, NO_DELAY) -- charge preview
			ret.q_effect:back().bHide = true -- hide charge arrow path
		end
	end
	
	ret:AddQueuedDelay(-1)
	ret:AddQueuedBounce(destination, 3)
	ret:AddQueuedDelay(0.1)
	for i = DIR_START, DIR_END do
		local curr = destination+DIR_VECTORS[i]
		ret:AddQueuedBounce(curr, 1)
		local damage = SpaceDamage(curr, self.Damage)
		damage.sAnimation = "airpush_"..i
		ret:AddQueuedDamage(damage)
	end

	local spawner = SpaceDamage(p1)
	spawner.sPawn = "BlobBossSmall"
	spawner.sImageMark = artiArrows.ColorUp(dir)
	if destination ~= p1 then ret:AddQueuedDropper(spawner, "units/aliens/slime_B3.png") end
	return ret
end	

easyEdit.bossList:get("archive"):addBoss("Mission_KingSlimeBoss")