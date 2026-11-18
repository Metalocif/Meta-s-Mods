local this = {}
local path = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path .. "scripts/libs/personality")
local dialog = require(path .. "scripts/pilots/weaponmaster_personality")

local pilot = {
	Id = "Pilot_weaponmaster",
	Personality = "weaponmaster",
	PowerCost = 1,
	Name = "Phalanx",
	Sex = SEX_AI,
	Skill = "WeaponInstructorSkill",
	Voice = "/voice/ai",
}

local baseDescription = "Weapons gain different effects depending on the classes of powered weapons."

local WeaponInstructorDescriptions = {
	Prime = "Prime: Once per mission, act again after damaging at least two Vek at once.",
	Brute = "Brute: Push all adjacent tiles the weapon would not push.",
	Ranged = "Ranged: Deal +1 damage to target next to another mech.",
	Science = "Science: Before applying weapon effects, shield all affected buildings.",
	TechnoVek = "Cyborg: Deal +1 damage to leader Vek.",
	Any = "Any: Gain a shield before attacking.",
}

local WeaponInstructorClassOrder = {
	"Prime",
	"Brute",
	"Ranged",
	"Science",
	"TechnoVek",
}

local LevelUpSkillsDescriptions = {
	Grid = "+3 Grid Def: On deployment, shield all adjacent buildings.",
	Reactor = "+1 Reactor Core: Move by teleporting.",
	Opener = "Opener: Deal +1 damage on the first turn of a mission.",
	Closer = "Finisher: Deal +1 damage on the last turn of a mission.",
	Popular = "Popular Hero: At end of turn, evacuate all adjacent buildings.",
	Thick = "Thick Skin: Cannot be frozen.",
	Skilled = "Skilled: Repair fully heals.",
	Invulnerable = "Invulnerable: Once per mission, revives at the start of your turn.",
	Adrenaline = "Adrenaline: Gain 1 free tile movement if ending turn on a space an enemy would attack.",
	Pain = "Masochist: At start of turn, if damaged, become targeted.",
	Regen = "Technician: Can repair adjacent friendly units.",
	Conservative = "Conservative: When expending the last use of a weapon with limited uses, gain +1 grid.",
	["Not Vanilla"] = "Other: Shield all mechs at the start of battle.",
}

local LevelUpSkillsOrder = {
	"Grid",
	"Reactor",
	"Opener",
	"Closer",
	"Popular",
	"Thick",
	"Skilled",
	"Invulnerable",
	"Adrenaline",
	"Pain",
	"Regen",
	"Conservative",
	"Not Vanilla",
}

local function GetWeaponClass(weaponType)
	local weapon = weaponType and _G[weaponType]
	if type(weapon) == "table" then
		return weapon.Class
	end
end

local function IsSkillOnPawn(pawn, skillName)
	local skillId
	if not cplus_plus_ex then
		if skillName == "Grid" then skillId = 2 end
		if skillName == "Reactor" then skillId = 3 end
		if skillName == "Opener" then skillId = 4 end
		if skillName == "Closer" then skillId = 5 end
		if skillName == "Popular" then skillId = 6 end
		if skillName == "Thick" then skillId = 7 end
		if skillName == "Skilled" then skillId = 8 end
		if skillName == "Invulnerable" then skillId = 9 end
		if skillName == "Adrenaline" then skillId = 10 end
		if skillName == "Pain" then skillId = 11 end
		if skillName == "Regen" then skillId = 12 end
		if skillName == "Conservative" then skillId = 13 end
	end
	if cplus_plus_ex then
		if skillName == "Not Vanilla" then
			local pilot = pawn:GetPilot()
			if not pilot then return end -- AI pilots are nil
			for _, earnedSkillId in ipairs(cplus_plus_ex:getPilotEarnedSkillIds(pilot)) do
				local info = cplus_plus_ex:getRegisteredSkillInfo(earnedSkillId)
				if info.category ~= "Vanilla" then return true end
			end
			return false
		end
		if cplus_plus_ex:isSkillOnPawn(skillName, pawn) then return true end
	else
		for i = 0, 2 do
			if GameData and GameData.current and GameData.current["pilot"..i].id == "Pilot_Galatea"
			and ((GameData.current["pilot"..i].skill1 == skillId and GameData.current["pilot"..i].level > 0) or 
			(GameData.current["pilot"..i].skill2 == skillId and GameData.current["pilot"..i].level > 1)) then
				return true
			end
		end
		return false
	end
end

local function UpdateWeaponInstructorDescription()
	if not Game then return end
	local phalanx, galatea
	if Game:GetPawn(0) then 
		if Game:GetPawn(0):GetAbility() == "WeaponInstructorSkill" then phalanx = Game:GetPawn(0) end
		if Game:GetPawn(0):GetAbility() == "GalateaSkill" then galatea = Game:GetPawn(0) end
	end
	if Game:GetPawn(1) then 
		if Game:GetPawn(1):GetAbility() == "WeaponInstructorSkill" then phalanx = Game:GetPawn(1) end
		if Game:GetPawn(1):GetAbility() == "GalateaSkill" then galatea = Game:GetPawn(1) end
	end
	if Game:GetPawn(2) then 
		if Game:GetPawn(2):GetAbility() == "WeaponInstructorSkill" then phalanx = Game:GetPawn(2) end
		if Game:GetPawn(2):GetAbility() == "GalateaSkill" then galatea = Game:GetPawn(2) end
	end
	
	if phalanx then
		local weapons = phalanx:GetPoweredWeaponTypes() or {}
		local primary = GetWeaponClass(weapons[1])
		local secondary = GetWeaponClass(weapons[2])
		local tertiary = GetWeaponClass(weapons[3])		--possible with StS pilots
		local quaternary = GetWeaponClass(weapons[4])	--very unlikely
		local equippedClasses = {}

		if primary and primary ~= "" then equippedClasses[primary] = true end
		if secondary and secondary ~= "" then equippedClasses[secondary] = true end
		if tertiary and tertiary ~= "" then equippedClasses[tertiary] = true end
		if quaternary and quaternary ~= "" then equippedClasses[quaternary] = true end

		local descriptionLines = { baseDescription }
		for _, class in ipairs(WeaponInstructorClassOrder) do
			if equippedClasses[class] then
				table.insert(descriptionLines, WeaponInstructorDescriptions[class])
			end
		end

		-- Any applies when either weapon slot has no class
		if primary == "" or secondary == "" or tertiary == "" or quaternary == "" then
			table.insert(descriptionLines, WeaponInstructorDescriptions.Any)
		end

		modApi:setText("Pilot_WeaponInstructorSkill_Text", table.concat(descriptionLines, "\n"))
	end
	if galatea then
		local descriptionLines = { "Gains different effects depending on level up skills. Even unpowered, grants +3 XP per battle." }
		for _, skill in ipairs(LevelUpSkillsOrder) do
			if IsSkillOnPawn(galatea, skill) then
				table.insert(descriptionLines, LevelUpSkillsDescriptions[skill])
			end
		end
		modApi:setText("Pilot_GalateaSkill_Text", table.concat(descriptionLines, "\n"))
	end
end

function this:GetPilot()
	return pilot
end

function this:init(mod)
	CreatePilot(pilot)
	modApi:setText("Pilot_WeaponInstructorSkill_Title", "Weapon Instructor")
	modApi:setText("Pilot_WeaponInstructorSkill_Text", "Weapons gain different effects depending on the classes of powered weapons.")
end

local personality = personalities:new{ Label = "weaponmaster" }
personality:AddDialog(dialog)
Personality["weaponmaster"] = personality

local function EVENT_onModsLoaded()
	local function WeaponMastery(mission, pawn, weaponId, p1, skillEffect)
		-- Science: prepend shields to affected buildings.
		-- Brute: push adjacent tiles the weapon would not otherwise push.
		-- Prime: once per mission, act again after damaging at least two Vek.
		-- Ranged: deal +1 damage to targets adjacent to another mech.
		-- Cyborg: deal +1 damage to leader Vek.
		-- Any: gain a shield before attacking.
		if not pawn or not pawn:IsAbility(pilot.Skill)
			or tostring(weaponId) == "Move" or tostring(weaponId) == "Repair" then
			return
		end

		local weapons = pawn:GetPoweredWeaponTypes() or {}
		local primary = GetWeaponClass(weapons[1])
		local secondary = GetWeaponClass(weapons[2])

		local adjacentToOtherMechsLocs = {}
		for id = 0, 2 do
			local otherPawn = Board:GetPawn(id)
			if id ~= pawn:GetId() and otherPawn and not otherPawn:IsDead() then
				for dir = DIR_START, DIR_END do
					local curr = otherPawn:GetSpace() + DIR_VECTORS[dir]
					local key = curr.x * 10 + curr.y
					adjacentToOtherMechsLocs[key] = (adjacentToOtherMechsLocs[key] or 0) + 1
				end
			end
		end

		local shieldDamageLocs = {}
		local prependShields = false

		if primary == "Science" or secondary == "Science" then
			for _, fx in ipairs(extract_table(skillEffect.effect)) do
				if Board:GetTerrain(fx.loc) == TERRAIN_BUILDING then
					-- table.insert(shieldDamageLocs, fx.loc)
					-- prependShields = true
					fx.iShield = EFFECT_CREATE
				end
			end
		end

		if primary == "" or secondary == "" then
			table.insert(shieldDamageLocs, p1)
			prependShields = true
		end

		if prependShields then
			-- Preserve the normal effects, prepend shields, and leave q_effect unchanged.
			local oldEffectCopy = DamageList()
			for i = 1, skillEffect.effect:size() do
				oldEffectCopy:push_back(skillEffect.effect:index(i))
			end

			skillEffect.effect = DamageList()
			for _, loc in ipairs(shieldDamageLocs) do
				local damage = SpaceDamage(loc)
				damage.iShield = EFFECT_CREATE
				skillEffect.effect:push_back(damage)
			end

			for i = 1, oldEffectCopy:size() do
				skillEffect.effect:push_back(oldEffectCopy:index(i))
			end
		end

		for _, fx in ipairs(extract_table(skillEffect.effect)) do
			local target = Board:GetPawn(fx.loc)
			if target and target:GetTeam() == TEAM_ENEMY then
				local targetDef = _G[target:GetType()]
				if targetDef and targetDef.Tier == TIER_BOSS
					and (primary == "TechnoVek" or secondary == "TechnoVek")
					and fx.iDamage > 0 and fx.iDamage ~= DAMAGE_ZERO and fx.iDamage ~= DAMAGE_DEATH then
					fx.iDamage = fx.iDamage + 1
				end

				local key = target:GetSpace().x * 10 + target:GetSpace().y
				if adjacentToOtherMechsLocs[key]
					and (primary == "Ranged" or secondary == "Ranged")
					and fx.iDamage > 0 and fx.iDamage ~= DAMAGE_ZERO and fx.iDamage ~= DAMAGE_DEATH then
					fx.iDamage = fx.iDamage + 1
				end
			end
		end

		if primary == "Brute" or secondary == "Brute" then
			-- Mark directions already affected by the weapon, then add pushes to the rest.
			local pushedDirections = {}
			for _, fx in ipairs(extract_table(skillEffect.effect)) do
				if fx.loc:Manhattan(pawn:GetSpace()) == 1 then
					local dir = GetDirection(fx.loc - pawn:GetSpace())
					if not pushedDirections[dir] then
						if fx.iPush == DIR_NONE then fx.iPush = dir end
						pushedDirections[dir] = true
					end
				end
			end

			for dir = DIR_START, DIR_END do
				local adjacent = pawn:GetSpace() + DIR_VECTORS[dir]
				if not pushedDirections[dir] then
					skillEffect:AddDamage(SpaceDamage(adjacent, 0, dir))
				end
			end
		end

		if mission and not mission.WeaponmasterPrimeReplayed
			and (primary == "Prime" or secondary == "Prime") then
			local damageCounter = 0
			for _, fx in ipairs(extract_table(skillEffect.effect)) do
				local target = Board:GetPawn(fx.loc)
				if target and target:GetTeam() == TEAM_ENEMY then
					local threshold = 1
					if target:IsArmor() and not target:IsAcid() then
						threshold = 2
					end
					if Board:GetCustomTile(fx.loc) == "tosx_rocks_0.png"
						or target:IsShield() or target:IsFrozen() then
						threshold = 1000
					end
					-- DAMAGE_DEATH bypasses shields, ice, and rocks.
					if Board:GetCustomTile(fx.loc) == "tosx_whirlpool_0.png" then
						threshold = 1
					end
					if fx.iDamage >= threshold and fx.iDamage ~= DAMAGE_ZERO then
						damageCounter = damageCounter + 1
					end
				end
			end

			if damageCounter >= 2 then
				skillEffect:AddScript(string.format(
					"modApi:runLater(function() local pawn = Board:GetPawn(%d); if pawn then pawn:SetActive(true) end end); GetCurrentMission().WeaponmasterPrimeReplayed = true",
					pawn:GetId()
				))
			end
		end
	end

	-- These hooks cover both single-click and two-click weapons.
	modapiext:addSkillBuildHook(function(mission, pawn, weaponId, p1, p2, skillEffect)
		WeaponMastery(mission, pawn, weaponId, p1, skillEffect)
	end)
	modapiext:addFinalEffectBuildHook(function(mission, pawn, weaponId, p1, p2, p3, skillEffect)
		WeaponMastery(mission, pawn, weaponId, p1, skillEffect)
	end)
	
	sdlext.addFrameDrawnHook(function(screen)
		UpdateWeaponInstructorDescription(baseDescription)
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

return this
