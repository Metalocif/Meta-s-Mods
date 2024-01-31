Mission_LelielBoss = Mission_Boss:new{
	Name = "Leliel",
	BossPawn = "EVA_LelielBoss",
	SpawnStartMod = -2,
	BossText = "Destroy the Angel Leliel",
}

EVA_LelielBoss = Pawn:new{
	Name = "Leliel",
	Health = 9,
	MoveSpeed = 5,
	Ranged = 0,
	Image = "EVA_LelielBoss",
	--ImageOffset = 2,
	SkillList = { "EVA_LelielBossAtk1" },	
	SoundLocation = "/enemy/goo_boss/",
	-- Flying = true,
	Pushable = false,
	Portrait = "enemy/EVA_LelielBoss",
	ImpactMaterial = IMPACT_FLESH,			
	Tier = TIER_BOSS,
	Massive=true,
	Corpse=false,					--definitely shouldn't have a corpse
	DefaultTeam = TEAM_ENEMY,
	IsDeathEffect = true,			--used to remove the shadow graphics and pseudo-web on death
	MoveSkill = "EVA_LelielMove",	--used to make it burrow so it fades in and out visually instead of walking
}

AddPawnName("EVA_LelielBoss")

EVA_LelielMove = Skill:new
{

}

function EVA_LelielMove:GetTargetArea(point)
	LOG("getting targets")
	return Board:GetReachable(point, Pawn:GetMoveSpeed(), Pawn:GetPathProf())
end

function EVA_LelielMove:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	LOG("moving")
	ret:AddBurrow(Board:GetPath(p1, p2, PATH_FLYER), FULL_DELAY)
	return ret
end


function EVA_LelielBoss:GetDeathEffect(point)
	local ret = SkillEffect()
	for dir = DIR_START, DIR_END do
		local pawn = Board:GetPawn(point+DIR_VECTORS[dir])
		if pawn and not pawn:IsFlying() and not pawn:IsGuarding() then
			ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(2)",pawn:GetId()))	--just reset it to 2, you've been slowed or w/e
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(\"%s\")", pawn:GetId(), _G[pawn:GetType()].Image))
		end
		ret:AddScript(string.format("CustomAnim:rem(%s, %q)", Point(point + DIR_VECTORS[dir]):GetString(), "lelielShadowAnim"))
	end
	return ret
end

EVA_LelielBoss.GetCustomPositionScore = function(self, p2)
	if not Board:IsValid(p2) or Board:IsPod(p2) or Board:IsEdge(p2) or Board:IsDangerous(p2) then return -100 end
	local score = 0
	for dir = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[dir]
		local target = Board:GetPawn(curr)
		if target and 
		not target:IsFlying() and 	--only affects grounded enemies & we use the pawn's water anim
		not target:IsGuarding() then --moves targets so we need them to not be stable
		--this makes it ignores Vek/AI/deployables/anything set with that personality
		--ideally we should also check whether the pilot's sex is AI/Vek
			if Board:GetTerrain(curr) == TERRAIN_WATER then return -100 end
			if target:GetPersonality() ~= "Artificial" then score = score + 1 end
		--target:GetTeam() ~= self:GetTeam() not needed because GetPersonality returns Artificial for Vek.
		end
	end
	LOG(score)
	return score
end

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
LOG(resourcePath)
local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

local customAnim = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/customAnim")

modApi:appendAsset("img/units/aliens/EVA_LelielBoss.png", readpath.."EVA_LelielBoss.png")
modApi:appendAsset("img/units/aliens/EVA_LelielBossa.png", readpath.."EVA_LelielBossa.png")
modApi:appendAsset("img/units/aliens/EVA_LelielBoss_emerge.png", readpath.."EVA_LelielBoss_emerge.png")
modApi:appendAsset("img/units/aliens/EVA_LelielBoss_death.png", readpath.."EVA_LelielBoss_death.png")

local base = a.EnemyUnit:new{Image = "units/aliens/EVA_LelielBoss.png", PosX = -23, PosY = -16, Height = 1}	
local baseEmerge = a.BaseEmerge:new{Image = "units/aliens/EVA_LelielBoss_emerge.png", PosX = -23, PosY = -16, NumFrames = 4, Height = 1, Loop = false, Time=0.1}

a.EVA_LelielBoss = base
a.EVA_LelielBosse = baseEmerge
a.EVA_LelielBossa = base:new{ Image = "units/aliens/EVA_LelielBossa.png", NumFrames = 4, PosX = -23, PosY = -16, Height = 1 }
a.EVA_LelielBossd = base:new{ Image = "units/aliens/EVA_LelielBoss_death.png", PosX = -23, PosY = -16, Loop = false, NumFrames = 4, Time = .15, Height = 1 }

modApi:appendAsset("img/portraits/enemy/EVA_LelielBoss.png", resourcePath.."img/portraits/enemy/EVA_LelielBoss.png")

modApi:appendAsset("img/effects/lelielshadow.png", resourcePath.."img/effects/lelielshadow.png")

-- Location["effects/lelielshadow.png"] = Point(-20, -40)

a.lelielShadowAnim = Animation:new{
	Image = "effects/lelielshadow.png",
	NumFrames = 1,
	Loop = true,
	PosX = -27,
	PosY = 1,
	Time = 1,
	Layer = ANIMS.LAYER_FLOOR
}

EVA_LelielBossAtk1 = Skill:new{
	Name = "Black Hole",	--haha geddit
	Description = "Attempts to pull every adjacent nonflying unit into its body, killing it instantly.",
	Icon = "weapons/LelielBlackHole.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 0,	
	Push = 0,
	TipImage = {
		CustomPawn = "EVA_LelielBoss",
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(1,1),
		Target = Point(2,1),
	}
}

local path = mod_loader.mods[modApi.currentMod].scriptPath
local worldConstants = require(path .."libs/worldConstants")

function EVA_LelielBossAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	if Board:GetPawn(p1) then local lelielId = Board:GetPawn(p1):GetId() end
	--we do need to check for this otherwise we get an error on Leliel's death because there is no pawn in p1
	local pullDamage = SpaceDamage(p1, 0)
	worldConstants:setGravity(ret, 0.1)
	for dir = DIR_START, DIR_END do
		local pawn = Board:GetPawn(p1+DIR_VECTORS[dir])
		if pawn and not pawn:IsFlying() and not pawn:IsGuarding() then
			
			ret:AddScript(string.format("CustomAnim:add(%s, \"lelielShadowAnim\")", Point(p1 + DIR_VECTORS[dir]):GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(-10)",pawn:GetId()))	--ideally store the old MS in a mission variable cause it could be different from base
			
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):Fall(2)",pawn:GetId()))
			ret:AddQueuedDelay(1)
			
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(\"%sw\")", pawn:GetId(), _G[pawn:GetType()].Image))
			ret:AddQueuedDamage(SpaceDamage(p1+DIR_VECTORS[dir], DAMAGE_DEATH))

		end
		ret:AddQueuedScript(string.format("CustomAnim:rem(%s, %q)", Point(p1 + DIR_VECTORS[dir]):GetString(), "lelielShadowAnim"))
		--we need it here because we remove the anim even if there is no pawn anymore
	end
	worldConstants:resetGravity(ret)
	return ret
end