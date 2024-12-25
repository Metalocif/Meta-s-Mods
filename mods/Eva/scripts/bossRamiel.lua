Mission_RamielBoss = Mission_Boss:new{
	Name = "Ramiel",
	BossPawn = "EVA_RamielBoss",
	SpawnStartMod = -2,
	BossText = "Destroy the Angel Ramiel",
	islandLock = 3,
}
--IslandLocks.Mission_SwarmerBoss = 3

EVA_RamielBoss = Pawn:new{
	Name = "Ramiel",
	Health = 9,
	MoveSpeed = 3,
	Ranged=1,
	Image = "EVA_RamielBoss",
	--ImageOffset = 2,
	SkillList = { "EVA_RamielBossAtk1" },	--I also want the reflexive shot thing, since that's a big part of its battle in the anime
	SoundLocation = "/enemy/goo_boss/",
	Flying = true,
	Portrait = "enemy/EVA_RamielBoss",
	ImpactMaterial = IMPACT_METAL,			--yes, I know it has blood and all
	Tier = TIER_BOSS,
	Massive=true,
	Corpse=false,
	DefaultTeam = TEAM_ENEMY,
}
AddPawnName("EVA_RamielBoss")

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local writepath = "img/units/aliens/"
local readpath = resourcePath .. writepath
local imagepath = writepath:sub(5,-1)
local a = ANIMS

modApi:appendAsset("img/units/aliens/EVA_RamielBoss.png", readpath.."EVA_RamielBoss.png")
modApi:appendAsset("img/units/aliens/EVA_RamielBossa.png", readpath.."EVA_RamielBossa.png")
modApi:appendAsset("img/units/aliens/EVA_RamielBoss_emerge.png", readpath.."EVA_RamielBoss_emerge.png")
modApi:appendAsset("img/units/aliens/EVA_RamielBoss_death.png", readpath.."EVA_RamielBoss_death.png")

local base = a.EnemyUnit:new{Image = "units/aliens/EVA_RamielBoss.png", PosX = -23, PosY = -16, Height = 1}	--, PosX = -23, PosY = -16
local baseEmerge = a.BaseEmerge:new{Image = "units/aliens/EVA_RamielBoss_emerge.png", NumFrames = 10, Height = 1}

a.EVA_RamielBoss = base
a.EVA_RamielBosse = baseEmerge
a.EVA_RamielBossa = base:new{ Image = "units/aliens/EVA_RamielBossa.png", NumFrames = 12, PosX = -23, PosY = -16, Height = 1 }
a.EVA_RamielBossd = base:new{ Image = "units/aliens/EVA_RamielBoss_death.png", Loop = false, NumFrames = 10, Time = .15, Height = 1 }

-- modApi:appendAsset("img/portraits/enemy/EVA_RamielBoss.png", resourcePath.."img/portraits/enemy/EVA_RamielBoss.png")

local effects = {
	"ramiellaser_hit.png",
	"ramiellaser_R.png",
	"ramiellaser_R1.png",
	"ramiellaser_R2.png",
	"ramiellaser_start.png",
	"ramiellaser_U.png",
	"ramiellaser_U1.png",
	"ramiellaser_U2.png",
}
for _, effect in ipairs(effects) do
	modApi:appendAsset("img/effects/".. effect, resourcePath .. "img/effects/" .. effect)
	Location["effects/"..effect] = Point(-12,3)
end
modApi:appendAsset("img/effects/shotup_ramielreactiveshot.png", resourcePath.."img/effects/shotup_ramielreactiveshot.png")


EVA_RamielBossAtk1 = LaserDefault:new{
	Name = "Particle Beam",
	Description = "Obliterate everything in a direction with a powerful particle beam. Only stopped by mountains and energy shields.",
	Icon = "weapons/RamielParticleBeam.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 5,
	--MinDamage= 5,	
	Push = 0,
	LaserArt = "effects/ramiellaser",
	TipImage = {			--add shields to preview
		CustomPawn = "EVA_RamielBoss",
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(1,1),
		Target = Point(2,1),
	}
}

function EVA_RamielBossAtk1:AddLaser(ret,point,direction,queued,forced_end)
	-- local queued = queued or false
	local queued = true
	local damage = self.Damage
	local start = point - DIR_VECTORS[direction]
	while Board:IsValid(point) and damage > 0 do
		
		local dam = SpaceDamage(point, damage)
		local pawn = Board:GetPawn(point)
		if forced_end == point or (Board:IsBuilding(point) and Board:IsShield(point)) or (pawn and pawn:IsShield()) or Board:GetTerrain(point) == TERRAIN_MOUNTAIN or not Board:IsValid(point + DIR_VECTORS[direction]) then
		--unlike LaserBase's version, this goes through unshielded buildings, but stops on shielded pawns; stil stopped by mountains 
			if queued then 
				ret:AddQueuedProjectile(dam,self.LaserArt)
			else
				ret:AddProjectile(start,dam,self.LaserArt,FULL_DELAY)
			end
			break
		else
			if queued then
				ret:AddQueuedDamage(dam)  
			else
				ret:AddDamage(dam)
			end
		end
		
		if pawn then damage = damage - pawn:GetHealth() end

		point = point + DIR_VECTORS[direction]	
	end
end

function EVA_RamielBossAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	
	self:AddLaser(ret, target, direction)	--fourth argument should be true
	-- local mission = GetCurrentMission()
	-- if mission then
		-- if not mission.lastTurnReactiveFire then mission.lastTurnReactiveFire = -1 end
		-- if mission.reactiveFireBlacklist == nil then mission.reactiveFireBlacklist = {} end
		-- if mission.lastTurnReactiveFire < Game:GetTurnCount() then 
			-- mission.lastTurnReactiveFire = Game:GetTurnCount()
			-- mission.ReactiveFireAmmo = 3
			-- mission.reactiveFireBlacklist[Board:GetPawn(0):GetSpace():GetString()] = true
			-- mission.reactiveFireBlacklist[Board:GetPawn(1):GetSpace():GetString()] = true
			-- mission.reactiveFireBlacklist[Board:GetPawn(2):GetSpace():GetString()] = true
			-- LOG("Ramiel reactive fire reloaded.")
		-- end
		-- local targets = extract_table(general_DiamondTarget(p1, 3))
		-- for i = 1, #targets do
			-- local pawn = Board:GetPawn(targets[i])
			-- if pawn and pawn:IsMech() and mission.ReactiveFireAmmo > 0 and Game:GetTeamTurn() == TEAM_PLAYER and not mission.reactiveFireBlacklist[targets[i]:GetString()] then
				-- LOG(save_table(mission.reactiveFireBlacklist))
				-- mission.ReactiveFireAmmo = mission.ReactiveFireAmmo - 1
				-- fx = SkillEffect()
				-- local damage = SpaceDamage(targets[i], 2)
				-- damage.sAnimation = "ExploAir1"
				-- fx:AddArtillery(p1, damage, "effects/shotup_ramielreactiveshot.png", NO_DELAY)
				-- fx:AddDelay(-1)
				-- Board:AddEffect(fx)
				-- mission.reactiveFireBlacklist[targets[i]:GetString()] = true
				-- break
			-- end
		-- end
	-- end
	return ret
end





local function EVENT_onModsLoaded()
	modapiext:addPawnDamagedHook(function(mission, pawn, damageTaken)	--bonded/shocked, remove sleep
		if not (mission and pawn) then return end
		local id = pawn:GetId()
		if pawn and Pawn and pawn:GetType() == "EVA_RamielBoss" and Game:GetTeamTurn() == TEAM_PLAYER and pawn:GetSpace():Manhattan(Pawn:GetSpace()) <= 3 and damageTaken> 0 and not pawn:IsDead() then 
			local fx = SkillEffect()
			local damage = SpaceDamage(Pawn:GetSpace(), 2)
			damage.sAnimation = "ExploAir1"
			fx:AddArtillery(pawn:GetSpace(), damage, "effects/shotup_ramielreactiveshot.png", PROJ_DELAY)
			Board:AddEffect(fx)
		end
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)