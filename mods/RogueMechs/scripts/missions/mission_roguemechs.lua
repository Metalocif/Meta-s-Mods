local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Meta_RogueMechs"}
local corpMissions = require(path .."corpMissions")


Mission_Meta_RogueMechs = Mission_Infinite:new{
	Name = "Rogue Mechs",
	Objectives = Objective("Defeat the Rogue Mechs",2),
	Target1 = 0,
	Target2 = 0,
	Target3 = 0,
	SpawnStartMod = -3,
	GlobalSpawnMod = -1,
	UseBonus = false,
}

function Mission_Meta_RogueMechs:StartMission()
	if GAME.RMList == nil then GAME.RMList = {"RMMechDStrike", "RMMechPunch", "RMMechLaser", "RMMechCharge", "RMMechGuard", "RMMechBulk", "RMMechMirror", "RMMechDispersal", "RMMechMiner", "RMMechTrimissile", "RMMechNeedle", "RMMechElec"} end
	-- if GAME.RMList == nil then GAME.RMList = {"RMMechMiner", "RMMechElec", "RMMechNeedle"} end
	local pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..GetSector()-1)
	-- local pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..3)
	--each pawn exists in four versions suffixed 0 to 3, which spawn depending on the current island
	self.Target1 = pawn:GetId()
	Board:AddPawn(pawn)
	pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..GetSector()-1)
	-- pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..3)
	self.Target2 = pawn:GetId()
	Board:AddPawn(pawn)
	pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..GetSector()-1)
	-- pawn = PAWN_FACTORY:CreatePawn(random_removal(GAME.RMList)..3)
	self.Target3 = pawn:GetId()
	Board:AddPawn(pawn)
end

function Mission_Meta_RogueMechs:GetDestroyedCount()
	local count = 0
	if not Board:IsPawnAlive(self.Target1) then count = count + 1 end
	if not Board:IsPawnAlive(self.Target2) then count = count + 1 end
	if not Board:IsPawnAlive(self.Target3) then count = count + 1 end
	return count
end

function Mission_Meta_RogueMechs:UpdateObjectives()
	local status = not Board:IsPawnAlive(self.Target1) and not Board:IsPawnAlive(self.Target2) and not Board:IsPawnAlive(self.Target3) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Defeat the Rogue Mechs",status, REWARD_REP, 2)
end

function Mission_Meta_RogueMechs:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target1) or Board:IsPawnAlive(self.Target2) or Board:IsPawnAlive(self.Target3) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end
--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end

function this:load(mod, options, version)
	corpMissions.Add_Missions_High("Mission_Meta_RogueMechs")
end

return this