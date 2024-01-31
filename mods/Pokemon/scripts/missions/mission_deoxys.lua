local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Deoxys"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Deoxys = Mission_Infinite:new{
	Name = "Meteorite Crater",
	Objectives = Objective("Capture Deoxys",1,1),
	Target = 0,
	BallID = -1,
	CustomTile = "tiles_debris",
}

function Mission_Poke_Deoxys:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_DeoxysBoss")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
end

function Mission_Poke_Deoxys:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Poke_Deoxys:UpdateObjectives()
	local status = (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Capture Deoxys",status)
end

function Mission_Poke_Deoxys:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Deoxys:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_DeoxysCapture:isComplete() then achievements.Poke_DeoxysCapture:addProgress{ complete = true } end
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
	corpMissions.Add_Missions_High("Mission_Poke_Deoxys", "Corp_Acid")
end

return this