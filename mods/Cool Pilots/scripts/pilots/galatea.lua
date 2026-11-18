--Galatea hooks
--Mission start (grid def)
--Mission start/load game/undo turn/next phase (+1 reactor, opener, finisher)
--Frozen (thick skin)
--Turn start (invulnerable)
--End turn (popular)
--skill build (skilled/opener/finisher)
--target area build (technician)
--skill effect end (conservative)

local this = {}

local mod = mod_loader.mods[modApi.currentMod]
local path = mod.scriptPath
local path2 = mod_loader.mods[modApi.currentMod].resourcePath
local personalities = require(path2 .."scripts/libs/personality")
local dialog = require(path2 .."scripts/pilots/galatea_personality")

local pilot = {
	Id = "Pilot_Galatea",
	Personality = "Galatea",
	PowerCost = 1,
	Name = "Galatea",
	Sex = SEX_AI,
	Skill = "GalateaSkill",
	Voice = "/voice/ai",
	Blacklist = {"Health","Movement","Move","MoveSpeed","Move Speed"},
}

function this:GetPilot()
	return pilot
end

--Add voicelines for specific subskill triggers?

function this:init(mod)
	CreatePilot(pilot)
	modApi:setText("Pilot_GalateaSkill_Title", "Protean")
	modApi:setText("Pilot_GalateaSkill_Text", "Gains different effects depending on level up skills. Even unpowered, grants +3 XP per battle.")
end


local baseDescription = "Gains different effects depending on level up skills. Even unpowered, grants +3 XP per battle."



local personality = personalities:new{ Label = "Galatea" }
personality:AddDialog(dialog)
Personality["Galatea"] = personality

-- Skill indexes:
-- 0	+2 HP
-- 1	+1 move?
--2	+3 grid def	
--3	mech reactor
--4	opener?
--5	finisher
--6	popular hero
--7	thick skin
--8	skilled
--9	invulnerable
--10	adrenaline
--11	masochist
--12	technician?
--13	conservative

-- +1 REACTOR: teleport


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

local oldMove = Move.GetTargetArea
function Move:GetTargetArea(p, ...)
	local mover = Board:GetPawn(p)
	if not mover:IsAbility("GalateaSkill") then return oldMove(self, p, ...) end
	if IsSkillOnPawn(mover, "Reactor") then
		local area = extract_table(general_DiamondTarget(p, mover:GetMoveSpeed()))
		local ret = PointList()
		for _, v in ipairs(area) do
			local terrain = Board:GetTerrain(v)
			if not Board:IsBlocked(v, mover:GetPathProf()) then
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
	if not mover:IsAbility("GalateaSkill") then return oldMove(self, p1, p2, ...) end
	if IsSkillOnPawn(mover, "Reactor") then
		if Board:GetDistance(p1, p2, mover:GetPathProf()) > mover:GetMoveSpeed() then
			ret:AddTeleport(p1, p2, NO_DELAY)
			ret:AddVoice("ReactorTrigger", mover:GetId())
			return ret
		end
	end
	return oldMove(self, p1, p2, ...)
end

local function EVENT_onModsLoaded()
	-- POPULAR HERO: evacuate adjacent buildings on end of turn
	modApi:addPreEnvironmentHook(function(mission)
		for id = 0, 2 do
			if Board:GetPawn(id) and Board:GetPawn(id):IsAbility("GalateaSkill") and Game:GetSector() < 5 then 
				if IsSkillOnPawn(Board:GetPawn(id), "Popular") then
					local flag = false
					for dir = DIR_START, DIR_END do
						local curr = Board:GetPawn(id):GetSpace() + DIR_VECTORS[dir]
						if Board:IsBuilding(curr) then
							Board:SetPopulated(false, curr);
							Board:Ping(curr, GL_Color(255,255,255,1));
							Game:TriggerSound("/ui/battle/population_points");
							flag = true
						end
					end
					if flag then
						local fx = SkillEffect()
						fx:AddVoice("PopularTrigger"..Game:GetSector(), id)
						Board:AddEffect(fx)
					end
				end
			end
		end
	end)
	-- THICK SKIN: freeze immune
	modapiext:addPawnIsFrozenHook(function(mission, pawn, isFrozen)
		if not (pawn and pawn:IsAbility("GalateaSkill") and isFrozen) then return end
		if IsSkillOnPawn(pawn, "Thick") then
			pawn:SetFrozen(false)
			local fx = SkillEffect()
			fx:AddVoice("ThickSkinTrigger"..Game:GetSector(), pawn:GetId())
			Board:AddEffect(fx)
		end
	end)
	-- TECHNICIAN: can repair adjacent
	modapiext:addTargetAreaBuildHook(function(mission, pawn, weaponId, p1, targetArea)
		if not (pawn and pawn:IsAbility("GalateaSkill") and weaponId == "Skill_Repair") then return end
		if IsSkillOnPawn(pawn, "Regen") then
			for dir = DIR_START, DIR_END do
				if Board:GetPawn(p1 + DIR_VECTORS[dir]) and Board:GetPawn(p1 + DIR_VECTORS[dir]):GetTeam() == TEAM_PLAYER then targetArea:push_back(p1 + DIR_VECTORS[dir]) end
			end
		end
	end)
	-- SKILLED: repair fully heals
	-- OPENER/FINISHER: +1 damage on first/last turn
	modapiext:addSkillBuildHook(function(mission, pawn, weaponId, p1, p2, skillEffect)
		if pawn and pawn:IsAbility("GalateaSkill") then
			for i = 0, 2 do
				if GameData and GameData.current and GameData.current["pilot"..i].id == "Pilot_Galatea" then
					if weaponId == "Skill_Repair" and (IsSkillOnPawn(pawn, "Regen") or IsSkillOnPawn(pawn, "Skilled")) then
						local flagSkilled = false
						local flagTechnician = false
						for _, fx in ipairs(extract_table(skillEffect.effect)) do
							if fx.iDamage < 0 and IsSkillOnPawn(pawn, "Skilled") then fx.iDamage = -10 flagSkilled = true end
							if fx.loc ~= pawn:GetSpace() and IsSkillOnPawn(pawn, "Regen") then flagTechnician = true end
						end
						if flagTechnician then
							skillEffect:AddVoice("TechnicianTrigger"..Game:GetSector(), pawn:GetId())
						elseif flagSkilled then
							skillEffect:AddVoice("SkilledTrigger"..Game:GetSector(), pawn:GetId())
						end
					elseif weaponId ~= "Move" and
					((IsSkillOnPawn(pawn, "Opener") and Game:GetTurnCount() == 0) or 
					(IsSkillOnPawn(pawn, "Closer") and Game:GetTurnCount() == mission.TurnLimit)) then
						local flag = false
						for _, fx in ipairs(extract_table(skillEffect.effect)) do
							if fx.iDamage > 0 and fx.iDamage ~= DAMAGE_ZERO and fx.iDamage ~= DAMAGE_DEATH then fx.iDamage = fx.iDamage + 1 flag = true end
							if fx.iDamage < 0 then fx.iDamage = fx.iDamage - 1 flag = true end
						end
						if flag then
							skillEffect:AddVoice("OpenerFinisherTrigger"..Game:GetSector(), pawn:GetId())
						end
					end
				end
			end
		end
	end)
	-- CONSERVATIVE: +1 grid on limited weapon last use
	-- ADRENALINE: gain bonus move if space is targeted after action
	modapiext:addSkillEndHook(function(mission, pawn, weaponId, p1, p2)
		if pawn and pawn:IsAbility("GalateaSkill") then
			for i = 0, 2 do
				if GameData and GameData.current and GameData.current["pilot"..i].id == "Pilot_Galatea" then
					if (GameData.current["pilot"..i].skill1 == 13 and GameData.current["pilot"..i].level > 0) or 
					(GameData.current["pilot"..i].skill2 == 13 and GameData.current["pilot"..i].level > 1) then
						for j = 1, pawn:GetWeaponCount() do
							if pawn:GetWeaponType(j) == weaponId and pawn:GetWeaponLimitedRemaining(j) == 0 and _G[pawn:GetWeaponType(j)].Limited > 0 then
								Game:ModifyPowerGrid(1)
								local fx = SkillEffect()
								fx:AddVoice("ConservativeTrigger"..Game:GetSector(), pawn:GetId())
								Board:AddEffect(fx)
							end
						end
					end
					if weaponId ~= "Move" and 
					(GameData.current["pilot"..i].skill1 == 10 and GameData.current["pilot"..i].level > 0) or 
					(GameData.current["pilot"..i].skill2 == 10 and GameData.current["pilot"..i].level > 1) then
						local point = pawn:GetSpace()
						local isTargeted
						for _, pawnID in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
							local enemy = Board:GetPawn(pawnID)		
							if enemy:GetQueuedTarget() ~= Point(-1, -1) then
								local fx = _G[enemy:GetQueuedWeapon()]:GetSkillEffect(enemy:GetSpace(), enemy:GetQueuedTarget())
								for _, spaceDamage in ipairs(extract_table(fx.q_effect)) do
									if spaceDamage.loc == point then 
										modApi:runLater(function() pawn:SetBonusMove(1) pawn:SetActive(true) end) 
										local fx = SkillEffect()
										fx:AddVoice("AdrenalineTrigger"..Game:GetSector(), pawn:GetId())
										Board:AddEffect(fx)
										break 
									end
								end
							end
						end
					end
				end
			end
		end
	end)
	-- MASOCHIST: at start of turn, become targeted if damaged
	-- INVULNERABLE: at start of turn, revive if dead once per mission
	modApi:addNextTurnHook(function(mission)
		for id = 0, 2 do
			if Board:GetPawn(id) and Board:GetPawn(id):IsAbility("GalateaSkill") then
				if Board:GetPawn(id):IsDead() and not mission.InvulnerableGalateaRevived then
					for i = 0, 2 do
						if GameData and GameData.current and GameData.current["pilot"..i].id == "Pilot_Galatea" then
							if (GameData.current["pilot"..i].skill1 == 9 and GameData.current["pilot"..i].level > 0) or 
							(GameData.current["pilot"..i].skill2 == 9 and GameData.current["pilot"..i].level > 1) then
								Board:GetPawn(id):ApplyDamage(SpaceDamage(Board:GetPawn(id):GetSpace(), -1))
								mission.InvulnerableGalateaRevived = true
								local fx = SkillEffect()
								fx:AddVoice("InvulnerableTrigger"..Game:GetSector(), id)
								Board:AddEffect(fx)
							end
						end
					end
				elseif Board:GetPawn(id):IsDamaged() then 
					for i = 0, 2 do
						if GameData and GameData.current and GameData.current["pilot"..i].id == "Pilot_Galatea" then
							if ((GameData.current["pilot"..i].skill1 == 11 and GameData.current["pilot"..i].level > 0) or 
							(GameData.current["pilot"..i].skill2 == 11 and GameData.current["pilot"..i].level > 1)) and
							not Status.GetStatus(id, "Targeted") then
								Status.ApplyTargeted(id, 5)
								local fx = SkillEffect()
								fx:AddVoice("MasochistTrigger"..Game:GetSector(), id)
								Board:AddEffect(fx)
							end
						end
					end
				end
			end
		end
	end)
	modApi:addMissionEndHook(function()		--Permanent passive: gain 3 XP every mission
		--stolen from Tosx's cauldron pilots with Lemonymous idea to focus XP on a single pawn
		for i = 0, 2 do
			local pawn = Board:GetPawn(i)
			if pawn and pawn:GetPersonality() == "Galatea" and not pawn:IsDead() then
				-- First check for soldier/abomination psions, just in case one doesn't retreat?
				local foes = extract_table(Board:GetPawns(TEAM_ENEMY))
				for i,id in pairs(foes) do
					local pawn = Board:GetPawn(id)
					if pawn:GetType():sub(1,5) == "Jelly_Health1" or pawn:GetType():sub(1,5) == "Jelly_Boss" then
						anysoldier = true
					end
				end
				local victim = anysoldier and "Scarab1" or "Scorpion1"
				local pawnxp = PAWN_FACTORY:CreatePawn(victim)
				
				local point = Board:GetTile(function(p)
					return not Board:IsBlocked(p, PATH_GROUND)
				end)
				
				Board:AddPawn(pawnxp,point)
				pawnxp:SetInvisible(true)
				local fx = SkillEffect()
				fx:AddScript("GAME.GalateaWantsSilence = true")
				fx:AddScript(string.format("Board:GetPawn(%s):Kill(true)", pawnxp:GetId()))
				fx.iOwner = i
				fx:AddScript("modApi:runLater(function() GAME.GalateaWantsSilence = nil end)")
				Board:AddEffect(fx)
				-- modApi:scheduleHook(10000, function() GAME.GalateaWantsSilence = nil end)
				--if not for this, Galatea triggers a voice line about killing a pawn after the end of the mission, blocking the game from moving to results screen for a while
			end
		end
	end)
	modApi:addVoiceEventHook(function(eventInfo, customOdds, suppress)
		if GAME.GalateaWantsSilence == true then GAME.GalateaWantsSilence = nil return true end
		return false
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

-- GRID DEF: shield adjacent buildings on deployment
-- NOT VANILLA: shield all mechs
modApi.events.onPawnLanded:subscribe(function(pawnId)
	GAME.GalateaWantsSilence = nil --just to make sure
	if Board:GetPawn(pawnId) and Board:GetPawn(pawnId):IsAbility("GalateaSkill") then
		if IsSkillOnPawn(Board:GetPawn(pawnId), "Grid") then
			local flag = false
			for dir = DIR_START, DIR_END do
				if Board:GetTerrain(Board:GetPawn(pawnId):GetSpace() + DIR_VECTORS[dir]) == TERRAIN_BUILDING then
					Board:AddShield(Board:GetPawn(pawnId):GetSpace() + DIR_VECTORS[dir])
					flag = true
				end
			end
			if flag then
				local fx = SkillEffect()
				fx:AddVoice("GridDefTrigger"..Game:GetSector(), pawnId)
				Board:AddEffect(fx)
			end
		end
		if IsSkillOnPawn(Board:GetPawn(pawnId), "Not Vanilla") then
			for i = 0, 2 do
				Board:GetPawn(i):SetShield(true)
			end
		end
	end
end)

return this