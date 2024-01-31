local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Celebi"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Celebi = Mission_Infinite:new{
	Name = "Mystifying Forest",
	Objectives = Objective("Capture Celebi",1,1),
	Target = 0,
	BallID = -1,
}

function Mission_Poke_Celebi:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_CelebiBoss")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
end

function Mission_Poke_Celebi:NextTurn() 
	if Board:IsPawnAlive(self.Target) and Game:GetTeamTurn() == TEAM_PLAYER then
		Board:AddAnimation(Board:GetPawn(self.Target):GetSpace(), "clockAnimRev", ANIM_DELAY)
		self.TurnLimit = self.TurnLimit + 1
	end
end

function Mission_Poke_Celebi:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Poke_Celebi:UpdateObjectives()
	local status = (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Capture Celebi",status)
end

function Mission_Poke_Celebi:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Celebi:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_CelebiCapture:isComplete() then achievements.Poke_CelebiCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then
	    objectives = { objectives } 
	end
	
	local total_rep = 0
	local total_possible = 0
	for i,v in ipairs(objectives) do
		total_rep = v.rep + total_rep
		total_possible = v.potential + total_possible
	end
	
	if total_rep == total_possible then
		return "Success"
	elseif total_rep == 0 then
		return "Failure"
	else
		return "Partial"
	end
end

--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end

function this:load(mod, options, version)
	corpMissions.Add_Missions_High("Mission_Poke_Celebi", "Corp_Grass")
end

return this