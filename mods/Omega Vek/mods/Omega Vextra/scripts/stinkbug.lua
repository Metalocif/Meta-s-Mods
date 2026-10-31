OmegaStinkbugAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 2,
	Name = "Foul Spray",
	Description = "Strikes two tiles in front of the user, applying Toxin.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		Building = Point(2,0),
		CustomPawn = "OmegaStinkbug2"
	}
}

function OmegaStinkbugAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.Range do
			ret:push_back(point+DIR_VECTORS[i]*j)
		end
	end
	return ret
end	


function OmegaStinkbugAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local dist = p1:Manhattan(p2)
	for i = 1, dist do
		local damage = SpaceDamage(p1+DIR_VECTORS[dir]*i, self.Damage)
		damage.iToxin = 1
		ret:AddQueuedDamage(damage)
	end
	ret:AddQueuedEmitter(p1, "Emitter_FoulSpray"..dist.."_"..dir)
	return ret
end	


Emitter_FoulSpray1_0 = Emitter:new{
	image = "effects/smoke/acid_smoke.png",
	variance = 0,
	variance_x = 5,
	variance_y = 5,
	timer = 0.5,
	x = 3, y = -2,
	angle = 330,
	rot_speed = 0,
	angle_variance = 5,
	lifespan = 0.4,
	birth_rate = 0.005,
	speed = 4,
	seed = 4,
	min_alpha = 0.3,
	max_alpha = 0.4,
	gravity = false,
	random_rot = true,
	layer = LAYER_FRONT,
}
Emitter_FoulSpray1_1 = Emitter_FoulSpray1_0:new{ angle = 30, x = 3, y = 8,}
Emitter_FoulSpray1_2 = Emitter_FoulSpray1_0:new{ angle = 150, x = -3, y = 8,}
Emitter_FoulSpray1_3 = Emitter_FoulSpray1_0:new{ angle = 210, x = -3, y = -2,}

Emitter_FoulSpray2_0 = Emitter_FoulSpray1_0:new{ speed = 8, }
Emitter_FoulSpray2_1 = Emitter_FoulSpray1_1:new{ speed = 8, }
Emitter_FoulSpray2_2 = Emitter_FoulSpray1_2:new{ speed = 8, }
Emitter_FoulSpray2_3 = Emitter_FoulSpray1_3:new{ speed = 8, }

Emitter_FoulSpray3_0 = Emitter_FoulSpray1_0:new{ speed = 12, }
Emitter_FoulSpray3_1 = Emitter_FoulSpray1_1:new{ speed = 12, }
Emitter_FoulSpray3_2 = Emitter_FoulSpray1_2:new{ speed = 12, }
Emitter_FoulSpray3_3 = Emitter_FoulSpray1_3:new{ speed = 12, }

OmegaStinkbugAtkB = OmegaStinkbugAtk2:new{Damage=3, Range=3	,Class = "Enemy",Name = "Mephitic Spray",}


--Hook to fix a bug where the stinkbug corpse would show up when retreating/evacuating
local function HOOK_MissionEnd(mission,effect)
	local enemies = extract_table(Board:GetPawns(TEAM_ENEMY))
	for _, id in pairs(enemies) do
		local pawn = Board:GetPawn(id)
		if pawn:GetType() == "OmegaDNT_Stinkbug2" then
			pawn:SetCorpse(false)
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addMissionEndHook(HOOK_MissionEnd)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
