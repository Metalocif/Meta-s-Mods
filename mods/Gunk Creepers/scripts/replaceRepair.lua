
---------- This file should not be altered -----
---------- Unless you're really sure you know what you're doing -------

local modApiExt
local Selected
local weaponReplacements = {}
local pilotTooltipOverrides = {}

--remove fire from repair's tipimage so other
--tipimages don't all have black smoke in them.
local Skill_Repair_Origin = Skill_Repair.TipImage.Unit or Point(2,2)
Skill_Repair.TipImage.Fire = nil

local function GetRepairSkill(pawn)
	
	--search through every replaced repair entry
	--and look for a match for either pilot or mech.
	for _, v in ipairs(weaponReplacements) do
		if pawn:IsAbility(v.sPilotSkill) or v.sMech == pawn:GetType() then
			return v.sSkill
		end
		--if v.sPilotSkill == pawn:GetPersonality() or v.sMech == pawn:GetType() then
		--	return v.sSkill
		--end
	end
	
	--No repair replacements found;
	--using default repair skill.
	return nil
end

local function GetField(skill, field, default)
	return type(skill["Get"..field]) == 'function'	and	skill["Get"..field](skill)
													or	skill[field]
													or	default
													or	nil
end

--Recursive search for the CustomTipImage of a weapon.
--The name CustomTipImage is misleading.
--It is the string of the weapon containing the tipimage.
local function GetTipSkill(sSkill)
	local customTipImage = GetField(_G[sSkill], "CustomTipImage")
	if customTipImage and customTipImage ~= "" and customTipImage ~= sSkill then
		return GetTipSkill(customTipImage)
	end
	return sSkill
end

local function AddTipPawn(board, entry, point, type)
	if not board:IsPawnSpace(point) then
		board:AddPawn(type, point)
		if board:IsPawnSpace(point) then
			local pawn = board:GetPawn(point)
			if modApiExt.string:endsWith(entry, "Damaged") then
				test.SetHealth(pawn, 1)
			end
		end
	end
end

local function AddTipEffect(board, point, effect)
	local damage = SpaceDamage(point)
	damage[effect] = EFFECT_CREATE
	board:DamageSpace(damage)
end

local function InTipImage()
	--return not Board.gameBoard --Doesn't work.
	return Board:GetSize() == Point(6, 6)
end


--------------------------------------------------------
-------------------- SETUP TIPIMAGE --------------------

local function IterateBoard(cond, action)
	assert(type(cond) == "function")
	assert(type(action) == "function")
	
	local size = Board:GetSize()
	for x = 0, size.x - 1 do
		for y = 0, size.y - 1 do
			local p = Point(x, y)
			if cond(p) then action(p) end
		end
	end
end

-- Some juggling to make sure terrain returns to default.
local function ClearTerrain(point)
	Board:SetTerrain(point, TERRAIN_ICE)
	local damage = SpaceDamage(point)
	damage.iFire = EFFECT_CREATE
	Board:DamageSpace(damage)
	Board:SetTerrain(point, TERRAIN_ROAD)
	damage.iFire = EFFECT_REMOVE
	Board:DamageSpace(damage)
end

local function SetupBoard(board, sSkill)
	local unitIsFriendly = true
	sSkill = GetTipSkill(sSkill)
	local tipImage = GetField(_G[sSkill], "TipImage", {})
	local unitPoint = tipImage.Unit or tipImage.Unit_Damaged
	if unitPoint then
		local unitType = tipImage.CustomPawn or Selected:GetType()
		board:AddPawn(unitType, unitPoint)
		local pawn = board:GetPawn(unitPoint)
		unitIsFriendly = _G[unitType].DefaultTeam ~= TEAM_ENEMY and true or false
		test.SetMaxHealth(pawn, _G[unitType].Health or 3)
		if tipImage.Unit_Damaged then
			test.SetHealth(pawn, 1)
		end
	end
	local mechId = Selected:GetId()
	local defaultVek = "Scorpion2"
	for k, v in pairs(tipImage) do
		mechId = (mechId + 1) % 3
		local defaultMech = Game:GetPawn(mechId):GetType()
		if modApiExt.string:startsWith(k, "Enemy") then
			AddTipPawn(board, k, v, tipImage.CustomEnemy or unitIsFriendly and "Scorpion2" or defaultMech)
		elseif modApiExt.string:startsWith(k, "Friendly") then
			AddTipPawn(board, k, v, tipImage.CustomFriendly or unitIsFriendly and defaultMech or "Scorpion2")
		elseif modApiExt.string:startsWith(k, "Building") then
			board:SetTerrain(v, 1)
		elseif modApiExt.string:startsWith(k, "Rubble") then
			board:SetTerrain(v, 2)
		elseif modApiExt.string:startsWith(k, "Water") then
			board:SetTerrain(v, 3)
		elseif modApiExt.string:startsWith(k, "Mountain") then
			board:SetTerrain(v, 4)
		elseif modApiExt.string:startsWith(k, "Ice") then
			board:SetTerrain(v, 5)
		elseif modApiExt.string:startsWith(k, "Forest") then
			board:SetTerrain(v, 6)
		elseif modApiExt.string:startsWith(k, "Sand") then
			board:SetTerrain(v, 7)
		elseif modApiExt.string:startsWith(k, "Hole") then
			board:SetTerrain(v, 9)
		elseif modApiExt.string:startsWith(k, "Lava") then
			board:SetTerrain(v, 14)
		elseif modApiExt.string:startsWith(k, "Fire") then
			AddTipEffect(board, v, "iFire")
		elseif modApiExt.string:startsWith(k, "Smoke") then
			AddTipEffect(board, v, "iSmoke")
		elseif modApiExt.string:startsWith(k, "Acid") then
			AddTipEffect(board, v, "iAcid")
		--elseif modApiExt.string:startsWith(k, "Target") then
			--We change the target later.
		elseif modApiExt.string:startsWith(k, "Spawn") then
			board:SpawnPawn(unitIsFriendly and (tipImage.CustomEnemy	or "Scorpion2")
											or (tipImage.CustomFriendly or "Scorpion2")
										,v)
		elseif k == "Length" then
		end
	end
end

--[[
	NOT YET ADDED:
	
	Second_Origin
	Second_Target
--]]

local function ReplaceField(sField)
	local default = Weapon_Texts["Skill_Repair_".. sField]
	if default then
		Weapon_Texts["Skill_Repair_".. sField] = nil
	else
		default = Skill_Repair[sField]
	end
	Skill_Repair["Get".. sField] =
	function(self)
		if Pawn then
			local sSkill = GetRepairSkill(Pawn)
			if sSkill then
				if		modApiExt.string:endsWith(sSkill, "_A") or
						modApiExt.string:endsWith(sSkill, "_B")	then
					sSkill = string.sub(sSkill, 1, string.len(sSkill) - 2)
				elseif	modApiExt.string:endsWith(sSkill, "_AB") then
					sSkill = string.sub(sSkill, 1, string.len(sSkill) - 3)
				end
				return 	Weapon_Texts[sSkill .."_".. sField]	or
						_G[sSkill][sField]					or
						sSkill[sField]						or
						""
					--'Skill' with capital 'S' is the
					-- default skill most weapons are based on.
			end
		else
			--LOG("ReplaceField(".. sField ..") - Pawn is not set")
		end
		return default
	end
end


ReplaceField("Name")
ReplaceField("Description")
ReplaceField("Description2")
--ReplaceField("Class") --doesn't seem to do anything.
ReplaceField("PathSize")
ReplaceField("MinDamage")
ReplaceField("Damage")
ReplaceField("SelfDamage")
--ReplaceField("Limited") --shows up on tooltip, but doesn't seem to do anything. hide it.
ReplaceField("LaunchSound")
ReplaceField("ImpactSound")
ReplaceField("ProjectileArt")
ReplaceField("Web")
ReplaceField("Push")
ReplaceField("Acid")
ReplaceField("Range")
ReplaceField("Smoke")
ReplaceField("Fire")
ReplaceField("Shield")
--ReplaceField("TipImage") --Seems to do nothing.


--------------------------------------------------------
------------------ FUNCTION OVERRIDES ------------------

local old_GetTargetArea = Skill_Repair.GetTargetArea
function Skill_Repair:GetTargetArea(point)
	local pawn = InTipImage() and Selected or Pawn
	local sSkill = GetRepairSkill(pawn)
	if sSkill then
		if InTipImage() then
			sSkill = GetTipSkill(sSkill) --making sure we check for any customTipImage
			IterateBoard(	function(point)
								return true
							end,
							function(point)
								Board:ClearSpace(point)
								ClearTerrain(point)
							end)
			SetupBoard(Board, sSkill)
			
			--Default GetTargetArea() to ensure GetSkillEffect() is called.
			return old_GetTargetArea(self, point)
		else
			return _G[sSkill]:GetTargetArea(point)
		end
	end
	
	--reapply the fire we removed from the tipimage.
	if InTipImage() then
		IterateBoard(	function(point)
							return point ~= Skill_Repair_Origin
						end,
						function(point)
							Board:ClearSpace(point)
							ClearTerrain(point)
						end)
		AddTipEffect(Board, point, "iFire")
	end
	
	return old_GetTargetArea(self, point)
end

local old_GetSkillEffect = Skill_Repair.GetSkillEffect
function Skill_Repair:GetSkillEffect(p1, p2)
	
	local sSkill = GetRepairSkill(InTipImage() and Selected or Pawn)
	if sSkill then
		if InTipImage() then
			sSkill = GetTipSkill(sSkill) --making sure we check for any customTipImage
			local tipImage = GetField(_G[sSkill], "TipImage", {})
			p1 = tipImage.Unit or tipImage.Unit_Damaged
			p2 = tipImage.Target
			local ret = _G[sSkill]:GetSkillEffect(p1, p2)
			--ret.piOrigin = p1 -- Doesn't work to set new origin.
			return ret
		end
		return _G[sSkill]:GetSkillEffect(p1, p2)
	end
	
	return old_GetSkillEffect(self, p1,p2)
end

local oldGetSkillInfo = GetSkillInfo
function GetSkillInfo(skill)
	if pilotTooltipOverrides[skill] then
		return PilotSkill(pilotTooltipOverrides[skill][1], pilotTooltipOverrides[skill][2])
	end
	return oldGetSkillInfo(skill)
end


--------------------------------------------------------
------------------------ HOOKS -------------------------

local onPawnSelected = function(mission, pawn)
	Selected = pawn
end

local onPawnDeselected = function(mission, pawn)
	Selected = nil
end


--------------------------------------------------------
------------------------ RETURN ------------------------

local load = function(_modApiExt)
	modApiExt = _modApiExt
	modApiExt:addPawnSelectedHook(onPawnSelected)
	modApiExt:addPawnDeselectedHook(onPawnDeselected)
end

--Allows the user to add additional fields
--the tooltip might detect, in case I missed some.
--Should be called from init in your mod's init.lua.
local function AddField(sField)
	ReplaceField(sField)
end

local ReplaceRepairForPilot = function(sPilotSkill, sWeapon, sPilotTooltip)
	table.insert(weaponReplacements, {sPilotSkill = sPilotSkill, sMech = "N/A", sSkill = sWeapon})
	pilotTooltipOverrides[sPilotSkill] = sPilotTooltip or {"",""}
end

local ReplaceRepairForMech = function(sMech, sWeapon)
	table.insert(weaponReplacements, {sPilotSkill = "N/A", sMech = sMech, sSkill = sWeapon})
end

return {
	load = load,
	AddField = AddField,
	ForPilot = ReplaceRepairForPilot,
	ForMech = ReplaceRepairForMech,
}