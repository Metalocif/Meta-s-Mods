local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Mewtwo"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Mewtwo = Mission_Infinite:new{
	Name = "Cerulean Cave",
	Objectives = Objective("Capture Mewtwo",1,1),
	Target = 0,
	BallID = -1,
	CustomTile = "tiles_lava",
	BonusPool = { BONUS_KILL_FIVE, BONUS_MECHS, BONUS_PACIFIST },
	MapTags = { "final_cave" },	--should take care of eg. sand on RST looking ugly with this tileset
}

function Mission_Poke_Mewtwo:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_MewtwoBoss")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
end

function Mission_Poke_Mewtwo:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Poke_Mewtwo:UpdateObjectives()
	local status = OBJ_STANDARD
	if not Board:IsPawnAlive(self.Target) then 
		if not Board:IsPawnAlive(self.BallID) then 
			status = OBJ_FAILED 
		else
			status = OBJ_COMPLETE 
		end
	end
	Game:AddObjective("Capture Mewtwo",status)
end

function Mission_Poke_Mewtwo:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) or not Board:IsPawnAlive(self.BallID) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Mewtwo:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_MewtwoCapture:isComplete() then achievements.Poke_MewtwoCapture:addProgress{ complete = true } end
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
	corpMissions.Add_Missions_High("Mission_Poke_Mewtwo", "Corp_Acid")
end

return this