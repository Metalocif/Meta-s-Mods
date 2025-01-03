
local mod = mod_loader.mods["lmn_bots_and_bugs"]
local path = mod.scriptPath
local modApiExt = mod.libs.modApiExt
local pawnSpace = require(path .."libs/pawnSpace")
local getNearestLoc = require(path .."libs/getNearestLoc")
local utils = require(path .."libs/utils")
local module_id = mod.id .."_doublespawn"
local cloneable = {
	"lmn_Swarmer1",
	"lmn_Swarmer2",
	"lmn_SwarmerBoss",
	"Omegalmn_Swarmer2",
}
local this = {}
local isMissionStart = false

local function isCloneable(pawn)
	return list_contains(cloneable, pawn:GetType())
end

lmn_DoubleSpawn = {}

function lmn_DoubleSpawn.CanSidestep(pawnId)
	local pawn = Board:GetPawn(pawnId)
	local moveSpeed = pawn:GetMoveSpeed()
	local pathing = pawn:GetPathProf()
	local p1 = pawn:GetSpace()

	-- prevent clone to step into deployment zone and pylon zone in final mission.
	local deployment = {}
	local pylons = {}

	if isMissionStart or Game:GetTurnCount() == 0 then
		deployment = utils.getDeploymentZone()
		pylons = extract_table(Board:GetZone("pylons"))
	end

	local p2 = getNearestLoc(p1, function(p)
		local result =
			p ~= p1										and
			not Board:IsBlocked(p, pathing)				and
			not Board:IsSpawning(p)						and
			not Board:IsDangerous(p)					and
			not Board:IsPod(p)							and
			not list_contains(deployment, p)			and
			not list_contains(pylons, p)

		if result then
			local path = Board:GetPath(p1, p, pathing)

			if path:empty() or path:size() - 1 > moveSpeed then
				return false
			end
		end

		return result
	end)

	if not p2 then
		return false
	end

	Board:SetDangerous(p2)
	local fx = SkillEffect()
	pawnSpace.FilterSpace(fx, p1, pawnId)
	fx:AddMove(Board:GetPath(p1, p2, pathing), NO_DELAY)
	pawnSpace.Rewind(fx)
	Board:AddEffect(fx)

	return true
end

function this:load()
	modApi:addPreMissionAvailableHook(function(mission)
		isMissionStart = true
	end)

	modApi:addPostMissionAvailableHook(function(mission)
		isMissionStart = false
	end)

	local function TryClonePawn(m, pawn)
		if not isCloneable(pawn) then
			return
		end

		local pawnId, pawnType = pawn:GetId(), pawn:GetType()
		local pData = _G[pawnType]
		LOG("Cloning "..pawnType)
		m[module_id] = m[module_id] or {}
		m[module_id][pawnId] = m[module_id][pawnId] or {}

		-- return if this pawn has replicated.
		if m[module_id][pawnId].hasDuped then
			return
		end

		-- init copy count.
		m[module_id][pawnId].copy = m[module_id][pawnId].copy or 0

		-- return if we have cloned this pawn enough.
		-- clone once by default for cloneable pawns.
		if m[module_id][pawnId].copy >= (pData.Clones or 1) then
			return
		end

		local p = pawn:GetSpace()
		local fx = SkillEffect()
		fx:AddDelay(.8)
		fx:AddScript(string.format([[
			local m = GetCurrentMission();
			local module_id, pawnId, p, type, copy = %q, %s, %s, %q, %s;

			if lmn_DoubleSpawn.CanSidestep(pawnId) then
				local clone = PAWN_FACTORY:CreatePawn(type);
				local cloneId = clone:GetId();

				m[module_id][cloneId] = m[module_id][cloneId] or {};
				m[module_id][cloneId].copy = copy + 1;

				Board:AddPawn(clone, p);
				clone:SpawnAnimation();
			end
		]], module_id, pawnId, p:GetString(), pawnType, m[module_id][pawnId].copy))

		Board:AddEffect(fx)
	end

	local function TryClonePawns(m)
		-- check if we need to clone any pawns after loading a game.
		for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ANY))) do
			local pawn = Board:GetPawn(id)
			TryClonePawn(m, pawn)
		end
	end

	modApiExt:addPawnTrackedHook(function(m, pawn)
		TryClonePawn(m, pawn)
	end)

	modApiExt:addResetTurnHook(function()
		-- board state is of before reset,
		-- so wait until it updates.
		modApi:runLater(TryClonePawns)
	end)

	modApiExt:addGameLoadedHook(function(mission)
		if mission then
			-- board is not created yet,
			-- so wait until it updates.
			modApi:runLater(TryClonePawns)
		end
	end)
end

return this
