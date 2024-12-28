local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
local repairApi = mod.libs.repairApi
customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")

local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/dialog_defect")

local pilot = {
	Id = "Pilot_StSDefect",
	Personality = "StSDefect",
	Name = "Defect",
	Sex = SEX_ROBOT,
	Skill = "StSDefectSkill",
	Voice = "/voice/ai",
	PowerCost = 1,
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Chaos Orbs", "Using Repair rotates between four types of orbs and triggers their effects."))
	
	repairApi:SetRepairSkill{
		Weapon = "StSDefectSkill_LinkA",
		Icon = "img/weapons/repair_Defect.png",
		IsActive = function(pawn)
			if not GAME then return false end
			-- local mission = GAME.GetMission and GetCurrentMission()
			-- if not mission then return false end
			return pawn:IsAbility("StSDefectSkill") and GAME.StSDefectOrb == "Lightning"
		end
	}
	repairApi:SetRepairSkill{
		Weapon = "StSDefectSkill_LinkB",
		Icon = "img/weapons/repair_Defect.png",
		IsActive = function(pawn)
			if not GAME then return false end
			-- local mission = GAME.GetMission and GetCurrentMission()
			-- if not mission then return false end
			return pawn:IsAbility("StSDefectSkill") and GAME.StSDefectOrb == "Frost"
		end
	}
	repairApi:SetRepairSkill{
		Weapon = "StSDefectSkill_LinkC",
		Icon = "img/weapons/repair_Defect.png",
		IsActive = function(pawn)
			if not GAME then return false end
			-- local mission = GAME.GetMission and GetCurrentMission()
			-- if not mission then return false end
			return pawn:IsAbility("StSDefectSkill") and GAME.StSDefectOrb == "Dark"
		end
	}
	repairApi:SetRepairSkill{
		Weapon = "StSDefectSkill_LinkD",
		Icon = "img/weapons/repair_Defect.png",
		IsActive = function(pawn)
			if not GAME then return false end
			-- local mission = GAME.GetMission and GetCurrentMission()
			-- if not mission then return false end
			return pawn:IsAbility("StSDefectSkill") and GAME.StSDefectOrb == "Plasma"
		end
	}

	--Put Weapon Definition Here
	StSDefectSkill_Link = Skill:new {
		Icon = "img/weapons/repair_Defect.png",
		TipImage = {
			Unit = Point(2,3),
			Enemy = Point(2,2),
			Enemy2 = Point(3,3),
			Target = Point(2,3),
		},
	}
	StSDefectSkill_LinkA = StSDefectSkill_Link:new {
		Name = "Chaos Orbs - Lightning",
		Description = "Passive: deals 1 damage to adjacent pawns at the start of the enemy turn.\nEvoke: deals 2 damage to a pawn and shocks it, then channels a Frost orb.",
	}
	StSDefectSkill_LinkB = StSDefectSkill_Link:new {
		Name = "Chaos Orbs - Frost",
		Description = "Passive: chill adjacent pawns at the start of the enemy turn.\nEvoke: chill adjacent pawns and freeze the user, then channel a Dark orb.",
	}
	StSDefectSkill_LinkC = StSDefectSkill_Link:new {
		Name = "Chaos Orbs - Dark",
		Description = "Passive: blind enemy pawns at the start of the enemy turn.\nEvoke: deal 1 damage to a pawn for each turn the dark orb was active (max 3), then channels a Plasma orb.",
	}
	StSDefectSkill_LinkD = StSDefectSkill_Link:new {
		Name = "Chaos Orbs - Plasma",
		Description = "Passive: gain 1 movement.\nEvoke: reactivate an adjacent ally, then channel a Lightning orb.",
	}

	function StSDefectSkill_Link:GetTargetArea(point)
		local ret = PointList()
		if GAME.StSDefectOrb == "Lightning" or GAME.StSDefectOrb == "Dark" then
			for i = DIR_START, DIR_END do
				for j = 1, 8 do
					local curr = point + DIR_VECTORS[i] * j
					ret:push_back(curr)
					-- if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
				end
			end
		elseif GAME.StSDefectOrb == "Plasma" then
			for i = DIR_START, DIR_END do
				local curr = point + DIR_VECTORS[i]
				local pawn = Board:GetPawn(curr)
				if pawn and pawn:GetTeam() == TEAM_PLAYER and not pawn:IsActive() then ret:push_back(curr) end
			end
		else	--frost or none because unpowered
			ret:push_back(point)
		end
		
		return ret
	end

	function StSDefectSkill_Link:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local user = Board:GetPawn(p1)
		if GAME.StSDefectOrb == "Lightning" then 
			local damage = SpaceDamage(p2, 2)
			damage.sAnimation = "LightningBolt0"
			ret:AddDamage(damage)
			ret:AddSound("/props/lightning_strike")
			if Board:GetPawn(p2) then ret:AddScript(string.format("modApi:runLater(function() Status.ApplyShocked(%s) end)", Board:GetPawn(p2):GetId())) end
			if Board:GetSize() ~= Point(6, 6) then --I hate tip images
				ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "LightningOrb"))
				ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "FrostOrb"))
				ret:AddScript(string.format("GAME.StSDefectOrb = %q", "Frost"))
			end
		elseif GAME.StSDefectOrb == "Dark" then
			local damage = SpaceDamage(p2, math.min(GAME.StSDefectDarkOrbTurns, 3))
			ret:AddDamage(damage)
			if Board:GetSize() ~= Point(6, 6) then 
				ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "DarkOrb"))
				ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "PlasmaOrb"))
				ret:AddScript(string.format("GAME.StSDefectOrb = %q", "Plasma"))
			end
		elseif GAME.StSDefectOrb == "Frost" then
			for i = DIR_START, DIR_END do
				local curr = p1 + DIR_VECTORS[i]
				local pawn = Board:GetPawn(curr)
				if pawn then ret:AddScript(string.format("Status.ApplyChill(%s)", pawn:GetId())) end
				local freezeDamage = SpaceDamage(p1)
				freezeDamage.iFrozen = 1
				ret:AddDamage(freezeDamage)
			end
			if Board:GetSize() ~= Point(6, 6) then 
				ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "FrostOrb"))
				ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "DarkOrb"))
				ret:AddScript(string.format("GAME.StSDefectOrb = %q", "Dark"))
				ret:AddScript("GAME.StSDefectDarkOrbTurns = 0")
			end
		elseif GAME.StSDefectOrb == "Plasma" then
			ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p2:GetString()))
			if Board:GetSize() ~= Point(6, 6) then 
				ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "PlasmaOrb"))
				ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "LightningOrb"))
				ret:AddScript(string.format("GAME.StSDefectOrb = %q", "Lightning"))
			end
		end
		return ret
	end
end

local personality = personalities:new{ Label = "StSDefect" }
personality:AddDialog(dialog)
Personality["StSDefect"] = personality


return this
