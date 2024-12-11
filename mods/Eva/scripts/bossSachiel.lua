Mission_SachielBoss = Mission_Boss:new{
	Name = "Sachiel",
	-- islandLock = 3,
	BossPawn = "EVA_SachielBoss",
	SpawnStartMod = -3,
	BossText = "Destroy the Angel Sachiel",
}

function Mission_SachielBoss:MissionEnd()
	local effect = SkillEffect()
	
	effect:AddScript("Board:StartMechTravel()")
	
	Board:AddEffect(effect)
end

EVA_SachielBoss = {
	Health = 9,
	MoveSpeed = 4,
	Name = "Sachiel",
	Image = "EVA_SachielBoss",
	SkillList = { "Sachiel_Punch" },
	Ranged = 0,
	SoundLocation = "/enemy/beetle_1/",
	Massive = true,
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	Tier = TIER_BOSS,
	IsDeathEffect = true,	--big explosion
	Corpse = true,
}
AddPawn("EVA_SachielBoss") 

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

modApi:appendAsset("img/units/aliens/EVA_SachielBoss.png", readpath.."EVA_SachielBoss.png")
modApi:appendAsset("img/units/aliens/EVA_SachielBossa.png", readpath.."EVA_SachielBossa.png")
modApi:appendAsset("img/units/aliens/EVA_SachielBoss_emerge.png", readpath.."EVA_SachielBoss_emerge.png")
modApi:appendAsset("img/units/aliens/EVA_SachielBoss_death.png", readpath.."EVA_SachielBoss_death.png")
modApi:appendAsset("img/units/aliens/EVA_SachielBoss_ball.png", readpath.."EVA_SachielBoss_ball.png")

local base = a.EnemyUnit:new{Image = "units/aliens/EVA_SachielBoss.png", PosX = -23, PosY = -16, Height = 1}	--, PosX = -23, PosY = -16
local baseEmerge = a.BaseEmerge:new{Image = "units/aliens/EVA_SachielBoss_emerge.png", NumFrames = 1, Height = 1}

a.EVA_SachielBoss = base
a.EVA_SachielBosse = baseEmerge
a.EVA_SachielBossa = base:new{ Image = "units/aliens/EVA_SachielBossa.png", NumFrames = 4, PosX = -23, PosY = -16, Height = 1 }
a.EVA_SachielBossd = base:new{ Image = "units/aliens/EVA_SachielBoss_death.png", Loop = false, NumFrames = 1, Time = .15, Height = 1 }
a.EVA_SachielBossball = base:new{ Image = "units/aliens/EVA_SachielBoss_ball.png", Loop = true, NumFrames = 1, Time = .15, Height = 1 }
a.EVA_SachielBossballa = base:new{ Image = "units/aliens/EVA_SachielBoss_ball.png", Loop = true, NumFrames = 1, Time = .15, Height = 1 }

Sachiel_Punch = Prime_Spear:new{  
	Name="Angel's Spear",
	Description ="Deals damage to a target and push it as far as possible.",
	Class = "Enemy",
	LaunchSound = "/weapons/titan_fist",
	Range = 3, -- Tooltip?
	PathSize = 1,
	Damage = 5,
	Push = 1,
	TipImage = StandardTips.Melee
}

function Sachiel_Punch:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local target1 = GetProjectileEnd(p1,p2)
	local target2 = GetProjectileEnd(target1,target1+DIR_VECTORS[direction])
	local distance1 = p1:Manhattan(target1)
	local distance2 = p1:Manhattan(target2-DIR_VECTORS[direction])
	if Board:IsBlocked(target2, PATH_PROJECTILE) then target2 = target2 - DIR_VECTORS[direction] end
	--we do this because the projectile may also end on an edge tile or something
	local damage = SpaceDamage(target1, self.Damage)
	ret:AddDamage(SpaceDamage(p1, -1))		--healing to simulate regen, may use vanilla regen anim
	ret:AddQueuedDamage(damage)
	-- ret:AddQueuedAnimation(p1 + DIR_VECTORS[direction], "sachielspear"..distance2.."_"..direction, ANIM_NO_DELAY)
	ret:AddQueuedCharge(Board:GetSimplePath(target1, target2), FULL_DELAY)
	--if this doesn't deal bump damage, add a manual push at the end or something

	return ret
end	

function EVA_SachielBoss:GetDeathEffect(point)
	local ret = SkillEffect()
	local user = Board:GetPawn(point)
	if not Board:GetPawn(point) then return ret end
	--find closest enemy, if found turn to ball, jump on it, explode
	local targets = extract_table(general_DiamondTarget(point, 2))
    for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:IsMech() then
			-- ret:AddDamage(SpaceDamage(point,-1))
			user:SetHealth(1)
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", point:GetString(), "EVA_SachielBossball"))
			local move = PointList()
			move:push_back(point)
			move:push_back(targets[k])
			ret:AddLeap(move, FULL_DELAY)
			point = targets[k]
			break
		end
    end
	
	local damage = SpaceDamage(point,2)
	damage.sAnimation = "ExploAir2"
	ret:AddDamage(damage)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir]
		ret:AddDamage(damage)
		ret:AddBounce(damage.loc, 5)
	end
	ret:AddDelay(0.25)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4]
		ret:AddDamage(damage)
		ret:AddBounce(damage.loc, 4)
	end
	ret:AddDelay(0.25)
	for dir = DIR_START, DIR_END do
		damage.loc = point + DIR_VECTORS[dir] *2
		ret:AddDamage(damage)
		ret:AddBounce(damage.loc, 3)
	end
	ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(0)", user:GetId()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), Point(-1, -1):GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCorpse(false)", user:GetId()))
	return ret
end