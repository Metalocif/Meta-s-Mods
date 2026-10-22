local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
-- local repairApi = mod.libs.repairApi
local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/dialog_necrobinder")

local pilot = {
	Id = "Pilot_StSNecrobinder",
	Personality = "StSNecrobinder",
	Name = "Necrobinder",
	Sex = SEX_FEMALE,
	Skill = "StSNecrobinderSkill",
	Voice = "/voice/chen",
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Bound Hand", "At the start of battle, spawns Osty. Revive it every turn."))
end

-- add personality.
local personality = personalities:new{ Label = "StSNecrobinder" }
personality:AddDialog(dialog)
Personality["StSNecrobinder"] = personality

ANIMS.StS_Osty = ANIMS.MechUnit:new{Image="units/player/osty.png", PosX = -15, PosY = -9}
ANIMS.StS_Ostya = ANIMS.MechUnit:new{Image="units/player/ostya.png", PosX = -15, PosY = -9, NumFrames = 4, Frames={0,1,2,3,2,1}}
ANIMS.StS_Ostyd = ANIMS.MechUnit:new{Image="units/player/ostyd.png", PosX = -17, PosY = -9, NumFrames = 7, Loop = false, Time = 0.08, }


StS_Osty = Pawn:new{
	Name = "Osty",
	Class = "",
	Health = 1,
	MoveSpeed = 2,
	Massive = true,
	Corpse = true,
	Image = "StS_Osty",
	SkillList = {"StS_PullAggro", "StS_Unleash"},
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_STONE,
}


StS_PullAggro = Skill:new{  
	Name = "Pull Aggro",
	Description = "Optionally jump to a location, then taunt adjacent enemies.",
	Class = "",
	Icon = "weapons/PullAggro.png",
	Rarity = 1,
	Range = 4,
	Damage = 0,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(1,1),
		Target = Point(2,1)
	}
}

function StS_PullAggro:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 2, self.Range do
			if not Board:IsBlocked(point + DIR_VECTORS[i] * j, PATH_GROUND) then ret:push_back(point + DIR_VECTORS[i] * j) end
		end
	end
	return ret
end	

function StS_PullAggro:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local talker
	local suffix = ""
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSNecrobinderSkill") then talker = pawn break end
	end
	if p1 ~= p2 then suffix = "Jump" end
	ret:AddVoice("PullAggro"..suffix, talker:GetId())
	if p1 ~= p2 then
		local move = PointList()
		move:push_back(p1)
		move:push_back(p2)
		ret:AddLeap(move, FULL_DELAY)
	end
	
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetTeam() == TEAM_ENEMY then
			local removeWeb = SpaceDamage(curr, 0, DIR_FLIP)
			removeWeb.bHide = true
			ret:AddDamage(removeWeb)
			ret:AddDamage(removeWeb)	--this flips the pawn twice, deleting webs
			ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", pawn:GetId(), p2:GetString()))
		end
	end
	return ret
end	

StS_Unleash = Skill:new{  
	Name = "Unleash",
	Description = "Pushes an adjacent enemy.",
	Class = "",
	Icon = "weapons/Unleash.png",
	Rarity = 1,
	PathSize = 1,
	Damage = 1,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(1,1),
		Target = Point(2,1)
	}
}

function StS_Unleash:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end	

function StS_Unleash:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local talker
	local suffix = ""
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSNecrobinderSkill") and not pawn:IsDead() then talker = pawn break end
	end
	if talker then
		if Board:GetPawn(p2) and Board:GetPawn(p2):GetId() == talker:GetId() then 
			suffix = "Self" 
		elseif Board:IsBuilding(p2) then 
			suffix = "Building" 
		elseif Board:GetPawn(p2) and Board:GetPawn(p2):IsMech() then
			suffix = "Mech"
		elseif Board:GetPawn(p2) then
			suffix = ""
		elseif Board:GetTerrain(p2) == TERRAIN_FOREST then
			suffix = "Forest"
		elseif Board:GetTerrain(p2) == TERRAIN_ICE then
			suffix = "Ice"
		elseif Board:GetTerrain(p2) == TERRAIN_MOUNTAIN then
			suffix = "Mountain"
		elseif Board:IsCracked(p2) then
			suffix = "Cracked"
		end
		ret:AddVoice("Unleash"..suffix, talker:GetId())
	end
	ret:AddMelee(p1, SpaceDamage(p2, self.Damage, dir))
	return ret
end	

AddPawn("StS_Osty")

return this
