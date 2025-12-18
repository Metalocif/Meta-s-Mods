local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
local repairApi = mod.libs.repairApi
local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")
local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/dialog_watcher")

local pilot = {
	Id = "Pilot_StSWatcher",
	Personality = "StSWatcher",
	Name = "Watcher",
	Sex = SEX_FEMALE,
	Skill = "StSWatcherSkill",
	Voice = "/voice/archimedes",
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Beyond Wisdom", "Using Repair toggles between Wisdom (reveals enemy spawns) and Blasphemy (each turn, Boost and lose 1 HP)."))
	repairApi:SetRepairSkill{
		Weapon = "StSWatcherSkill_Link",
		Icon = "img/weapons/repair_watcher.png",
		IsActive = function(pawn)
			return pawn:IsAbility(pilot.Skill)
		end
	}

	--Put Weapon Definition Here
	StSWatcherSkill_Link = Skill:new {
		Name = "Beyond Wisdom",
		Description = "Toggles between Wisdom and Blasphemy. Wisdom allows the Watcher to reveal enemy spawns; Blasphemy boosts and damages her every turn.",
		TipImage = {
			Unit = Point(2,3),
			Enemy = Point(2,2),
			Enemy2 = Point(3,3),
		}
	}

	function StSWatcherSkill_Link:GetTargetArea(point)
		local ret = PointList()
		ret:push_back(point)
		if Board:GetPawn(point) and customAnim:get(Board:GetPawn(point):GetId(), "WisdomStance") then
			for i = 0, 7 do
				for j = 0, 7 do
					if Board:IsSpawning(Point(i, j)) then ret:push_back(Point(i, j)) end
				end
			end
		end
		return ret
	end

	function StSWatcherSkill_Link:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local user = Board:GetPawn(p1)
		DoSaveGame()
		if customAnim:get(user:GetId(), "WisdomStance") then
			if Board:IsSpawning(p2) then	--reveal spawn
				if GetCurrentMission() then
					local spawnData = GetCurrentMission():GetSpawnPointData(p2)
					if Board:IsSpawning(p2) and spawnData then
						Board:AddAlert(p2, _G[spawnData.type].Name) 
					end
				end
			end
			if p1 == p2 then --stance switch
				ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "WisdomStance"))
				ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "BlasphemyStance"))
				ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", user:GetId()))
				ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", user:GetId()))
			end
		elseif customAnim:get(user:GetId(), "BlasphemyStance") then
			local damage = SpaceDamage(p1, -1)
			damage.iFire = EFFECT_REMOVE
			damage.iAcid = EFFECT_REMOVE
			ret:AddDamage(damage)
			ret:AddScript(string.format("customAnim:rem(%s, %q)", user:GetId(), "BlasphemyStance"))
			ret:AddScript(string.format("customAnim:add(%s, %q)", user:GetId(), "WisdomStance"))
		else
		end
		return ret
	end
end

-- add personality.
local personality = personalities:new{ Label = "StSWatcher" }
personality:AddDialog(dialog)
Personality["StSWatcher"] = personality


return this
