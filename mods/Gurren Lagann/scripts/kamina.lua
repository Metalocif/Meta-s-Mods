local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
local repairApi = mod.libs.repairApi
-- local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")
local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/kamina_personality")

local pilot = {
	Id = "Pilot_Kamina",
	Personality = "Kamina",
	Name = "Kamina",
	Sex = SEX_MALE,
	Skill = "KaminaSkill",
	Voice = "/voice/henry",
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Spiral Power", "Using Repair boosts this unit; when the unit is boosted, it turns into Giga Drill Breaker."))
	repairApi:SetRepairSkill{
		Weapon = "KaminaSkill_Link",
		Icon = "img/weapons/repair_Kamina.png",
		IsActive = function(pawn)
			return pawn:IsAbility(pilot.Skill)
		end
	}
	  
	--Put Weapon Definition Here
	KaminaSkill_Link = Skill:new {
		Name = "Spiral Power",
		Description = "If unboosted, gain boost; otherwise, uses Giga Drill Breaker, charging through units, dealing KILL damage.",
		TipImage = {
			Unit = Point(2,5),
			Enemy1 = Point(2,4),
			Mountain = Point(2,3),
			Enemy2 = Point(2,2),
			Target = Point(2,1),
		}
	}

	function KaminaSkill_Link:GetTargetArea(point)
		local ret = PointList()
		ret:push_back(point)
		if Board:GetPawn(point) and Board:GetPawn(point):IsBoosted() then
			for i = DIR_START, DIR_END do
				for j = 1, 8 do
					local curr = point + DIR_VECTORS[i] * j
					if not Board:IsValid(curr) then break end
					ret:push_back(curr)
				end
			end
		end
		return ret
	end
	
	Location["effects/GIGADRILLBREAKER_killicon.png"] = Point(-14,6)

	function KaminaSkill_Link:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local user = Board:GetPawn(p1)
		if p1 ~= p2 then
			--GIGA
			--DRILL
			--BREAKER
			ret:AddVoice("GIGADRILLBREAKER", user:GetId())
			ret:AddDelay(1)
			local direction = GetDirection(p2-p1)
			local dummydamage = SpaceDamage(p2)
			dummydamage.bHide = true
			ret:AddProjectile(dummydamage, "effects/GIGADRILLBREAKER",NO_DELAY)
			ret:AddDelay(0.1)
			ret:AddCharge(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
			for i = 1, p1:Manhattan(p2) - 1 do
				ret:AddDelay(0.016)
				local damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,DAMAGE_DEATH)
				damage.sImageMark = "effects/GIGADRILLBREAKER_killicon.png"
				ret:AddDamage(damage)
				if p1 + DIR_VECTORS[direction]*(i+1) == p2 then
					ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(Point(-1, -1))", user:GetId()))
					local endDamage = SpaceDamage(p2 ,DAMAGE_DEATH)
					endDamage.sImageMark = "effects/GIGADRILLBREAKER_killicon.png"
					ret:AddDamage(endDamage)
					ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), p2:GetString()))
				end	
			end	
		else
			local damage = SpaceDamage(p1, -1)
			damage.iFire = EFFECT_REMOVE
			damage.iAcid = EFFECT_REMOVE
			damage.sScript = string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString())
			damage.sImageMark = "combat/icons/icon_boosted.png"
			ret:AddDamage(damage)
		end
		return ret
	end
end

-- add personality.
local personality = personalities:new{ Label = "Kamina" }
personality:AddDialog(dialog)
Personality["Kamina"] = personality


return this
