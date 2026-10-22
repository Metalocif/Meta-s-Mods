local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
local repairApi = mod.libs.repairApi
customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")

local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/dialog_Regent")	
modApi:appendAsset("img/weapons/SovereignBlade.png", path2.."img/weapons/SovereignBlade.png")

local pilot = {
	Id = "Pilot_StSRegent",
	Personality = "StSRegent",
	Name = "Regent",
	Sex = SEX_ROBOT,
	Skill = "StSRegentSkill",
	Voice = "/voice/ai",
	PowerCost = 0,
}

ANIMS.StS_RegentBlade = ANIMS.MechUnit:new{Image="units/player/regentblade.png", PosX = -25, PosY = -2}
ANIMS.StS_RegentBladea = ANIMS.MechUnit:new{Image="units/player/regentbladea.png", PosX = -25, PosY = -2, NumFrames = 4 }


StS_RegentBlade = Pawn:new{
	Name = "Sovereign Blade",
	Class = "",
	Health = 2,
	MoveSpeed = 4,
	Massive = false,
	Corpse = false,
	Flying = true,
	Image = "StS_RegentBlade",
	SkillList = {"StS_SovereignBlade"},
	SoundLocation = "/enemy/blobber_2/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}


StS_SovereignBlade = Prime_Sword:new{  
	Name = "Sovereign Blade",
	Description = "Deal damage to the front three tiles.",
	Class = "",
	Icon = "weapons/SovereignBlade.png",
	Rarity = 1,
	PathSize = 1,
	Damage = 2,
	PowerCost = 0, --AE Change
	Limited = 0,
	Upgrades = 2,
	UpgradeCost = { 2,3 },
	UpgradeList = { "+1 Damage", "+2 Damage" },
	LaunchSound = "/weapons/sword",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Target = Point(2,2)
	}
}

function StS_SovereignBlade:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	ret:AddDamage(SoundEffect(p2,self.LaunchSound))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(dir + 1)% 4], self.Damage))
	ret:AddDamage(SpaceDamage(p2 - DIR_VECTORS[(dir + 1)% 4], self.Damage))
	local centerdamage = SpaceDamage(p2, self.Damage)
	centerdamage.sAnimation = "explosword_"..dir
	ret:AddDamage(centerdamage)
	return ret
end	

StS_SovereignBlade_A = StS_SovereignBlade:new{ Damage = 3, }
StS_SovereignBlade_B = StS_SovereignBlade:new{ Damage = 4, }
StS_SovereignBlade_AB = StS_SovereignBlade:new{ Damage = 5,}

AddPawn("StS_RegentBlade")

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Sovereign Blade", "Using Repair deploys an autonomous weapon. While it is deployed, repairing strengthens it."))
	
	repairApi:SetRepairSkill{
		Weapon = "StSRegentSkill_Link",
		Icon = "img/weapons/repair_Regent.png",
		IsActive = function(pawn)
			return pawn:IsAbility(pilot.Skill)
		end
	}

	StSRegentSkill_Link = Skill:new {
		Name = "Sovereign Blade",
		Description = "Push an adjacent tile, then deploys a Sovereign Blade there. If deployed, grants it +1 damage.",
		Icon = "img/weapons/repair_Regent.png",
		TipImage = {
			Unit = Point(2,3),
			Enemy = Point(2,2),
			Enemy2 = Point(3,3),
			Target = Point(2,3),
		},
	}

	function StSRegentSkill_Link:GetTargetArea(point)
		local ret = PointList()
		ret:push_back(point)
		for i = DIR_START, DIR_END do
			local curr = point + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if not pawn then 
				ret:push_back(curr)
			elseif pawn and not pawn:IsGuarding() and not Board:IsBlocked(curr + DIR_VECTORS[i], PATH_PROJECTILE) then
				ret:push_back(curr)
			end
		end
		return ret
	end

	function StSRegentSkill_Link:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local user = Board:GetPawn(p1)
		--regular repair
		if p1 == p2 then
			ret:AddDamage(SpaceDamage(p1, -1))
			return ret
		end
		
		--push target, add delay iff there was something to push
		local dir = GetDirection(p2-p1)
		local pushDamage = SpaceDamage(p2, 0, dir)
		pushDamage.sAnimation = "explopush1_"..dir
		ret:AddDamage(pushDamage)
		if Board:GetPawn(p2) then ret:AddDelay(1) end
		
		--get blade
		local blade
		for index, point in ipairs(Board) do
			if Board:GetPawn(point) and Board:GetPawn(point):GetType() == "StS_RegentBlade" then
				blade = Board:GetPawn(point)
				break
			end
		end
		if blade then
			--upgrade blade
			ret:AddDamage(SpaceDamage(blade:GetSpace(), -1))
			if blade:IsWeaponPowered("StS_SovereignBlade_B") then
				ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(1)", blade:GetId()))
				ret:AddScript(string.format("Board:GetPawn(%s):AddWeapon(%q, true)", blade:GetId(), "StS_SovereignBlade_AB"))
				ret:AddVoice("ForgeLV3", user:GetId())
			elseif blade:IsWeaponPowered("StS_SovereignBlade_A") then
				ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(1)", blade:GetId()))
				ret:AddScript(string.format("Board:GetPawn(%s):AddWeapon(%q, true)", blade:GetId(), "StS_SovereignBlade_B"))
				ret:AddVoice("ForgeLV2", user:GetId())
			elseif blade:IsWeaponPowered("StS_SovereignBlade") then
				ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(1)", blade:GetId()))
				ret:AddScript(string.format("Board:GetPawn(%s):AddWeapon(%q, true)", blade:GetId(), "StS_SovereignBlade_A"))
				ret:AddVoice("ForgeLV1", user:GetId())
			end
		else
			--make blade
			local spawner = SpaceDamage(p2)
			spawner.sPawn = "StS_RegentBlade"
			ret:AddDamage(spawner)
			ret:AddVoice("ForgeLV0", user:GetId())
		end
		return ret
	end
end

local personality = personalities:new{ Label = "StSRegent" }
personality:AddDialog(dialog)
Personality["StSRegent"] = personality


return this
