local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Delibird"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Delibird = Mission_Infinite:new{
	Name = "Snowy Peaks",
	Objectives = Objective("Protect Delibird",1,1),
	Target = 0,
	BallID = -1,
}

function Mission_Poke_Delibird:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_DelibirdHelper")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
end

function Mission_Poke_Delibird:NextTurn() 
end

function Mission_Poke_Delibird:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Poke_Delibird:UpdateObjectives()
	local delibirdAlive = Board:IsPawnAlive(self.Target) and OBJ_STANDARD or OBJ_FAILED
	Game:AddObjective("Protect Delibird", delibirdAlive)	
end

function Mission_Poke_Delibird:GetCompletedObjectives()
	if not Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Delibird:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
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
	corpMissions.Add_Missions_High("Mission_Poke_Delibird", "Corp_Snow")
end

return this