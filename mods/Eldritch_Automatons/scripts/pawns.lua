local mod = modApi:getCurrentMod()

local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = path .."img/units/player/"

local files = {
	"mech_tentacle.png",
	"mech_tentacle_a.png",
	"mech_tentacle_w.png",
	"mech_tentacle_w_broken.png",
	"mech_tentacle_broken.png",
	"mech_tentacle_ns.png",
	"mech_tentacle_h.png",
	
	"mech_worm.png",
	"mech_worm_a.png",
	"mech_worm_w.png",
	"mech_worm_w_broken.png",
	"mech_worm_broken.png",
	"mech_worm_ns.png",
	"mech_worm_h.png",
	"mech_worm_emerge.png",
	
	"mech_octopus.png",
	"mech_octopus_a.png",
	"mech_octopus_w.png",
	"mech_octopus_w_broken.png",
	"mech_octopus_broken.png",
	"mech_octopus_ns.png",
	"mech_octopus_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
local a=ANIMS
a.mech_tentacles =a.MechUnit:new{Image="units/player/mech_tentacle.png", PosX = -22, PosY = 4}
a.mech_tentaclesa = a.MechUnit:new{Image="units/player/mech_tentacle_a.png",  PosX = -20, PosY = -10, NumFrames = 8 }
a.mech_tentaclesw = a.MechUnit:new{Image="units/player/mech_tentacle_w.png", -22, PosY = -3}
a.mech_tentacles_broken = a.MechUnit:new{Image="units/player/mech_tentacle_broken.png", PosX = -20, PosY = -10 }
a.mech_tentaclesw_broken = a.MechUnit:new{Image="units/player/mech_tentacle_w_broken.png", PosX = -20, PosY = -3 }
a.mech_tentacles_ns = a.MechIcon:new{Image="units/player/mech_tentacle_ns.png"}

a.mech_worm =	a.MechUnit:new{Image = "units/player/mech_worm.png", PosX = -21, PosY = -3}
a.mech_worma =	a.MechUnit:new{Image = "units/player/mech_worm_a.png", PosX = -20, PosY = -1, NumFrames = 4 }
a.mech_wormw =	a.MechUnit:new{Image = "units/player/mech_worm_w.png", PosX = -20, PosY = -1 }
a.mech_worm_broken = a.MechUnit:new{Image="units/player/mech_worm_broken.png", PosX = -25, PosY = -10 }
a.mech_wormw_broken = a.MechUnit:new{Image="units/player/mech_worm_w_broken.png", PosX = -25, PosY = -6 }
a.mech_worm_ns = a.MechIcon:new{Image="units/player/mech_worm_ns.png"}
a.mech_worme = a.MechIcon:new{Image="units/player/mech_worm_emerge.png", PosX = -18, PosY = -10, Loop = false, NumFrames = 10, Time = .07}

a.mech_octopus = a.MechUnit:new{Image="units/player/mech_octopus.png", PosX = -17, PosY = -19, Height = 3}
a.mech_octopusa = a.MechUnit:new{Image="units/player/mech_octopus_a.png", PosX = -25, PosY = -1, NumFrames = 4 }
a.mech_octopusw = a.MechUnit:new{Image="units/player/mech_octopus_w.png", PosX = -25, PosY = 4 }
a.mech_octopus_broken = a.MechUnit:new{Image="units/player/mech_octopus_broken.png", PosX = -25, PosY = -1 }
a.mech_octopusw_broken = a.MechUnit:new{Image="units/player/mech_octopus_w_broken.png", PosX = -25, PosY = -1}
a.mech_octopus_ns = a.MechIcon:new{Image="units/player/mech_octopus_ns.png", PosX = 15, PosY=20}


Mech_Tentacular = Pawn:new{
	Name = "Tentacular Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	LargeShield = true,
	Image = "mech_tentacles",
	SkillList = {"Meta_EldritchTentacles"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}
AddPawn("mech_tentacles")

Mech_Worm = Pawn:new{
	Name = "Worm Mech",
	Class = "Science",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Pushable = false,	--makes sense & useful for Tentacles to do slingshot maneuvers
	Image = "mech_worm",
	SkillList = {"Meta_EldritchInsanity"},
	SoundLocation = "/enemy/burrower_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}
AddPawn("mech_worm")

Mech_Octopus = Pawn:new{
	Name = "Octopus Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "mech_octopus",
	SkillList = {"Meta_TentacularServant"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}
AddPawn("mech_octopus")


local oldMove = Move.GetTargetArea
function Move:GetTargetArea(p, ...)
	local mover = Board:GetPawn(p)
	local options = mod_loader.currentModContent[mod.id].options
	--if options.Meta_BurrowersCanThroughWater and options.Meta_BurrowersCanThroughWater.enabled then moverPathType = mover:GetPathProf() else moverPathType = PATH_GROUND end
	if mover and mover:GetType() == "Mech_Worm" then
		local pathType
		if Board:GetTerrain(p) == TERRAIN_WATER or Board:GetTerrain(p) == TERRAIN_ICE then pathType = mover:GetPathProf() else pathType = PATH_FLYER end
		local old = extract_table(Board:GetReachable(p, mover:GetMoveSpeed(), pathType))
		local ret = PointList()

		for _, v in ipairs(old) do
			local terrain = Board:GetTerrain(v)
			-- if terrain ~= TERRAIN_HOLE and (terrain ~= TERRAIN_WATER or (options.Meta_BurrowersCanIntoWater and options.Meta_BurrowersCanIntoWater.enabled) or pathType == mover:GetPathProf()) then
			--if not water, or we can burrow into water because of the mod option, or we are walking and not burrowing
				ret:push_back(v)
			-- end
		end

		return ret
	end

	return oldMove(self, p, ...)
end

local oldMove = Move.GetSkillEffect
function Move:GetSkillEffect(p1, p2, ...)
	local mover = Board:GetPawn(p1)
	if mover and mover:GetType() == "Mech_Worm" then
		local ret = SkillEffect()
		local pawnId = mover:GetId()
		ret:AddBurrow(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
		ret:AddSound("/enemy/shared/crawl_out")
		ret:AddDelay(0.7)	--burrowing anim duration
		local path = extract_table(Board:GetPath(p1, p2, PATH_FLYER))
		local dist = #path - 1
		for i = 1, #path do
			local p = path[i]
			if Board:GetTerrain(p) ~= TERRAIN_WATER then ret:AddBounce(p, -2) end
			ret:AddDelay(.32 / dist)
		end
		return ret
	end

	return oldMove(self, p1, p2, ...)
end