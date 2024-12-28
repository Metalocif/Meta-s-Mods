local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local pilotSkill_tooltip = mod.libs.pilotSkill_tooltip
-- local repairApi = mod.libs.repairApi
-- local path2 = mod_loader.mods[modApi.currentMod].resourcePath
-- local personalities = require(path2 .."scripts/libs/personality")
-- local dialog = require(path2 .."scripts/pilots/dialog_metalocif")

local pilot = {
	Id = "Pilot_StSIronclad",
	Personality = "StSIronclad",
	Name = "Ironclad",
	Sex = SEX_MALE,
	Skill = "StSIroncladSkill",
	Voice = "/voice/archimedes",
	Blacklist = {"Thick"},
}

function this:init(mod)
	CreatePilot(pilot)
	pilotSkill_tooltip.Add(pilot.Skill, PilotSkill("Demonic Power", "Heals 1 HP per turn. When damaged, sets adjacent tiles on fire."))
end

-- add personality.
-- local personality = personalities:new{ Label = "StSIronclad" }
-- personality:AddDialog(dialog)
-- Personality["StSIronclad"] = personality


return this
