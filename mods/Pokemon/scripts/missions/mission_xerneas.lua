local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Xerneas"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Xerneas = Mission_Infinite:new{
	Name = "Tree of Life",
	Objectives = Objective("Protect Xerneas",1,1),
	XerneasId = 0,
}

function Mission_Poke_Xerneas:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_XerneasHelper")
	self.XerneasId = pawn:GetId()
	Board:SpawnPawn(pawn)
	pawn:SetPowered(false)
end

function Mission_Poke_Xerneas:NextTurn() 
	if Board:IsPawnAlive(self.XerneasId) and Game:GetTurnCount() == 3 and Game:GetTeamTurn() == TEAM_PLAYER then
		Board:GetPawn(self.XerneasId):SetCustomAnim("Poke_Xerneas")
		Board:GetPawn(self.XerneasId):SetPowered(true)
	end
end

function Mission_Poke_Xerneas:GetDestroyedCount()
	if not Board:IsPawnAlive(self.XerneasId) then
		return 1
	end
	return 0
end

function Mission_Poke_Xerneas:UpdateObjectives()
	local status = Board:IsPawnAlive(self.XerneasId) and OBJ_STANDARD
	Game:AddObjective("Protect Xerneas",status)
end


function Mission_Poke_Xerneas:GetCompletedObjectives()
	if not Board:IsPawnAlive(self.XerneasId) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Xerneas:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if Board:IsPawnAlive(self.XerneasId) then
		if not achievements.Poke_XerneasCapture:isComplete() then achievements.Poke_XerneasCapture:addProgress{ complete = true } end
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
	corpMissions.Add_Missions_High("Mission_Poke_Xerneas", "Corp_Grass")
end

return this