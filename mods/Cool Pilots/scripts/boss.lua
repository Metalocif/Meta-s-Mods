local mod = mod_loader.mods[modApi.currentMod]

local a = ANIMS
local base = a.EnemyUnit:new{Image = "units/aliens/rathalos.png", PosX = -20, PosY = -15, NumFrames = 1, Height = 1 }
a.rathalos  =	base
a.rathalose =	base
a.rathalosa =			base:new{ Image = "units/aliens/rathalosa.png", NumFrames = 3 }
a.rathalosd =			base:new{ Image = "units/aliens/rathalos_death.png", NumFrames = 8, Time = 0.1, Loop = false }
a.rathalos_attack =		base:new{ Image = "units/aliens/rathalos_attack.png", PosY = -39, NumFrames = 2, Lengths = {1, 10}, }
a.rathalos_ascent =		base:new{ Image = "units/aliens/rathalos_ascent.png", PosY = -39, NumFrames = 8, Lengths = {0.3,0.3,0.3,0.3,0.3,0.3,0.3,10},  }
a.rathalos_descent =	base:new{ Image = "units/aliens/rathalos_ascent.png", PosY = -39, NumFrames = 8, Frames = {7,6,5,4,3,2,1,0}, Lengths = {0.3,0.3,0.3,0.3,0.3,0.3,0.3,10} }

---- MISSION DESCRIPTION
Mission_RathalosBoss = Mission_Boss:new{
	Name = "Rathalos",
	BossPawn = "Meta_RathalosBoss",
	GlobalSpawnMod = -1,
	Target = 0,
	BossText = "Hunt the Rathalos"
}

Emitter_RathalosScream = Emitter:new{
	image = "combat/tiles_grass/dust.png",
	x = -20,
	y = -39,
	max_alpha = 0.25,
	angle_variance = 360,
	angle = 0,
	-- variance = 12,
	lifespan = 0.3,
	burst_count = 255,
	image_count = 1,
	max_particles = 255,
	speed = 5.75,
	birth_rate = 0,
	gravity = false,
	layer = LAYER_FRONT
}


-------- BOSS DESCRIPTION
Meta_RathalosBoss = {
	Health = 8,
	MoveSpeed = 4,
	Flying = true,			
	IgnoreFire = true,
	Image = "rathalos",
	Name = "Rathalos",
	SkillList = { "Meta_RathalosAtkB" },
	Massive = true,
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	Portrait = "enemy/Rathalos",
	SoundLocation = "/enemy/moth/",
	Corpse = true,			--just because
	Tier = TIER_BOSS,
}
AddPawn("Meta_RathalosBoss") 


Meta_RathalosAtkB = Skill:new{
	Name = "Rain of Fireballs",
	Class = "Enemy",
	PathSize = 8,
	Damage = 2,
	Description = "Rains fire over a large area.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(3,2),
		Target = Point(2,2),
		Water = Point(2,2),
		CustomPawn = "Meta_RathalosBoss"
	}
}

function Meta_RathalosAtkB:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 0, 7 do
			local curr = point + DIR_VECTORS[i] * j
			if not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
		end
	end
	return ret
end

function Meta_RathalosAtkB:GetSkillEffect(p1,p2)
	ret = SkillEffect()
	local user = Board:GetPawn(p1)
	if user and user:GetType() == "Meta_RathalosBoss" then
		--set animation to ascent, then attack
		ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "rathalos_ascent"))
		ret:AddQueuedDelay(2.4)	--8 frames * 0.3s
		ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "rathalos_attack"))
		ret:AddQueuedScript("Board:StartShake(1)")
		ret:AddQueuedEmitter(p1, "Emitter_RathalosScream")
		ret:AddQueuedDelay(0.1)
		ret:AddQueuedEmitter(p1, "Emitter_RathalosScream")
		ret:AddQueuedDelay(0.1)
		ret:AddQueuedEmitter(p1, "Emitter_RathalosScream")
		ret:AddQueuedDelay(0.8)		--first frame lasts 1 second, then proceeds to the second frame used during dash
	end
	ret:AddQueuedCharge(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
	for i = 1, p1:Manhattan(p2)-1 do
		local curr = p1 + DIR_VECTORS[GetDirection(p2-p1)] * i
		
		local damage = SpaceDamage(curr, self.Damage)
		damage.iFire = 1
		ret:AddQueuedDamage(damage)
		ret:AddBurst(curr, "Emitter_LavaPlume", DIR_NONE)
		ret:AddBurst(curr, "Emitter_LavaSpark", DIR_NONE)
		ret:AddQueuedDelay(0.1)
		ret:AddQueuedBounce(curr, 2)
	end
	
	if user and user:GetType() == "Meta_RathalosBoss" then
		--set animation to descent, then normal
		ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "rathalos_descent"))
		ret:AddQueuedDelay(2.1)
		ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "rathalosa"))
	end
	return ret
end

easyEdit.bossList:get("archive"):addBoss("Mission_RathalosBoss")
