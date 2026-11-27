local mod = modApi:getCurrentMod()

modApi:appendAssets("img/units/player/", "img/units/player/")
local a=ANIMS
a.mech_banshee =a.MechUnit:new{Image="units/player/banshee_ns.png", PosX = -22, PosY = 4}
a.mech_bansheea = a.MechUnit:new{Image="units/player/banshee_a.png",  PosX = -20, PosY = 4, NumFrames = 4, Time = 0.3 }
a.mech_banshee_chargeup = a.mech_bansheea:new{Image="units/player/banshee_chargeup.png", NumFrames = 12, Time = 0.1 }
a.mech_bansheew = a.mech_bansheea:new{Image="units/player/banshee_w.png"}
a.mech_banshee_broken = a.mech_bansheea:new{Image="units/player/banshee_broken.png"}
a.mech_bansheew_broken = a.mech_bansheea:new{Image="units/player/banshee_w_broken.png"}
a.mech_banshee_ns = a.MechIcon:new{Image="units/player/banshee_ns.png"}
a.mech_banshee_fadein = a.mech_bansheea:new{Image="units/player/banshee_fade.png", NumFrames = 4, Time = 0.05, Frames = {3,2,1,0}}
a.mech_banshee_fadeout = a.mech_bansheea:new{Image="units/player/banshee_fade.png", NumFrames = 4, Time = 0.05}

a.mech_wraith =	a.MechUnit:new{Image = "units/player/wraith_ns.png", PosX = -20, PosY = -7}
a.mech_wraitha =	a.MechUnit:new{Image = "units/player/wraith_a.png", PosX = -20, PosY = -7, NumFrames = 4, Time = 0.3}
a.mech_wraith_broken = a.mech_wraitha:new{Image="units/player/wraith_broken.png", PosX = -20, PosY = -7 }
a.mech_wraith_ns = a.MechIcon:new{Image="units/player/wraith_ns.png"}
a.mech_wraith_fadein = a.mech_wraitha:new{Image="units/player/wraith_fade.png", NumFrames = 4, Time = 0.05, Frames = {3,2,1,0}}
a.mech_wraith_fadeout = a.mech_wraitha:new{Image="units/player/wraith_fade.png", NumFrames = 4, Time = 0.05}

a.mech_reaper = a.MechUnit:new{Image="units/player/reaper_ns.png", PosX = -10, PosY = -1}
a.mech_reapera = a.MechUnit:new{Image="units/player/reaper_a.png", PosX = -20, PosY = -5, NumFrames = 4, Time = 0.3 }
a.mech_reaperw = a.mech_reapera:new{Image="units/player/reaper_w.png", }
a.mech_reaper_broken = a.mech_reapera:new{Image="units/player/reaper_broken.png"}
a.mech_reaperw_broken = a.mech_reapera:new{Image="units/player/reaper_w_broken.png"}
a.mech_reaper_ns = a.MechIcon:new{Image="units/player/reaper_ns.png"}
a.mech_reaper_fadein = a.mech_reapera:new{Image="units/player/reaper_fade.png", NumFrames = 4, Time = 0.05, Frames = {3,2,1,0}}
a.mech_reaper_fadeout = a.mech_reapera:new{Image="units/player/reaper_fade.png", NumFrames = 4, Time = 0.05}


modApi:addPalette({
    ID = "Meta_GravekeepersPalette",
    Name = "Dirgeful Blue",
    Image = "units/player/banshee_ns.png",
    PlateHighlight = {198,227,205},
    PlateLight     = {78, 100, 125},
    PlateMid       = {57,55,70},
    PlateDark      = {37, 30, 38},
    PlateOutline   = {12,31,19},
    PlateShadow    = {36,34,36},
    BodyColor      = {70,67,70},
    BodyHighlight  = {127,125,141},
    }
)


Mech_Banshee = Pawn:new{
	Name = "Banshee Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "mech_banshee",
	ImageOffset = modApi:getPaletteImageOffset("Meta_GravekeepersPalette"),
	SkillList = {"Gravekeepers_Banshee"},
	SoundLocation = "/mech/brute/tank/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Mech_Banshee")

Mech_Wraith = Pawn:new{
	Name = "Wraith Mech",
	Class = "Science",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "mech_wraith",
	ImageOffset = modApi:getPaletteImageOffset("Meta_GravekeepersPalette"),
	SkillList = {"Gravekeepers_Wraith", "Gravekeepers_Passive"},
	SoundLocation = "/mech/science/swap/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Mech_Wraith")

Mech_Reaper = Pawn:new{
	Name = "Reaper Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "mech_reaper",
	ImageOffset = modApi:getPaletteImageOffset("Meta_GravekeepersPalette"),
	SkillList = {"Gravekeepers_Reaper"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Mech_Banshee")

local oldMove = Move.GetTargetArea
function Move:GetTargetArea(p, ...)
	local mover = Board:GetPawn(p)
	local flag
	for i = 0, 2 do
		if Board:GetPawn(i) then
			local weapons = Board:GetPawn(i):GetPoweredWeaponTypes()
			if weapons[1] == "Gravekeepers_Passive" or weapons[1] == "Gravekeepers_Passive_A" or weapons[2] == "Gravekeepers_Passive" or weapons[2] == "Gravekeepers_Passive_A" then 
				flag = true 
				break
			end
		end
	end
	if not flag then return oldMove(self, p, ...) end
	if mover and mover:IsMech() then
		local area = extract_table(general_DiamondTarget(p, mover:GetMoveSpeed()))
		local ret = PointList()
		for _, v in ipairs(area) do
			local terrain = Board:GetTerrain(v)
			if (terrain ~= TERRAIN_HOLE or mover:IsFlying()) and not Board:GetPawn(v) then
				ret:push_back(v)
			end
		end
		return ret
	end
	return oldMove(self, p, ...)
end

local oldMove = Move.GetSkillEffect
function Move:GetSkillEffect(p1, p2, ...)
	local ret = SkillEffect()
	local mover = Board:GetPawn(p1)
	local flag
	for i = 0, 2 do
		if Board:GetPawn(i) then
			local weapons = Board:GetPawn(i):GetPoweredWeaponTypes()
			if weapons[1] == "Gravekeepers_Passive" or weapons[1] == "Gravekeepers_Passive_A" or weapons[2] == "Gravekeepers_Passive" or weapons[2] == "Gravekeepers_Passive_A" then 
				flag = true 
				break
			end
		end
	end
	if not flag then return oldMove(self, p1, p2, ...) end
	if mover and mover:IsMech() then
		--bells & whistles
		if mover:GetType() == "Mech_Banshee" then
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_banshee_fadeout"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", mover:GetId(), p2:GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_banshee_fadein"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_bansheea"))
		elseif mover:GetType() == "Mech_Wraith" then
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_wraith_fadeout"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", mover:GetId(), p2:GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_wraith_fadein"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_wraitha"))
		elseif mover:GetType() == "Mech_Reaper" then
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_reaper_fadeout"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", mover:GetId(), p2:GetString()))
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_reaper_fadein"))
			ret:AddDelay(0.2)
			ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", mover:GetId(), "mech_reapera"))
		else
			ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", mover:GetId(), p2:GetString()))
		end
		return ret
	end
	return oldMove(self, p1, p2, ...)
end