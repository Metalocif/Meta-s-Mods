local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath

local pilot = {
	Id = "Pilot_MonHun",
	Personality = "MonHun",
	Name = "Hunter",
	Sex = SEX_MALE,
	Skill = "MonHunSkill",
	Voice = "/voice/archimedes",
}

function this:init(mod)
	CreatePilot(pilot)
	modApi:setText("Pilot_MonHunSkill_Title", "Carve")
	modApi:setText("Pilot_MonHunSkill_Text", "Bosses leave corpses. Standing next to a boss corpse grants a Hunter Weapon. Hunter Weapons are stronger.")
end


return this
