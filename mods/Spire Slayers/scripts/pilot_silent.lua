local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
-- local repairApi = mod.libs.repairApi
-- local path2 = mod_loader.mods[modApi.currentMod].resourcePath
-- local personalities = require(path2 .."scripts/libs/personality")
-- local dialog = require(path2 .."scripts/pilots/dialog_metalocif")

local pilot = {
	Id = "Pilot_StSSilent",
	Personality = "StSSilent",
	Name = "Silent",
	Sex = SEX_FEMALE,
	Skill = "StSSilentSkill",
	Voice = "/voice/archimedes",
	ToxinImmune = true,
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Noxious Huntress", "Gains Blade Dance at the start of battle if possible. Otherwise, applies Toxin to adjacent enemies after each turn."))
end

-- add personality.
-- local personality = personalities:new{ Label = "StSSilent" }
-- personality:AddDialog(dialog)
-- Personality["StSSilent"] = personality


return this
