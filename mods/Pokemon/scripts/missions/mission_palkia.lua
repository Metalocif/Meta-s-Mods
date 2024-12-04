local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Palkia"}
local corpMissions = require(path .."corpMissions")

local resourcePath =  mod_loader.mods[mod].resourcePath

modApi:addMap(resourcePath .."maps/Poke_Boss_Pillars_Palkia.map")

Mission_Poke_Palkia = Mission_Infinite:new{
	Name = "Spear Pillars",
	Objectives = Objective("Capture Palkia",1,1),
	Target = 0,
	BallID = -1,
	CustomTile = "tiles_Pillars",
	MapTags = { "Poke_Boss_Pillars_Palkia" },
	BlockSecret = true,
	BonusPool = { BONUS_KILL_FIVE, BONUS_MECHS, BONUS_PACIFIST },
	BossPawn = "Poke_PalkiaBoss",
}

function Mission_Poke_Palkia:StartMission()
	for _, p in ipairs(Board) do
		--prevent items from spawning on deployment area as we can't deploy on items
		local drop_zone = extract_table(Board:GetZone("deployment"))
		local isDeploymentTile = false
		for _, p2 in pairs(drop_zone) do
			if p == p2 then isDeploymentTile = true break end
		end
		if Board:GetPawn(p) and Board:GetPawn(p):GetType() == self.BossPawn then self.Target = Board:GetPawn(p):GetId() end
		if Board:GetTerrain(p) == TERRAIN_ROAD and not isDeploymentTile then
			if math.random() > 0.93 and not Board:IsBlocked(p, PATH_PROJECTILE) then 
				Board:SetTerrain(p, 17)
				Board:SetItem(p, "Poke_TimeRune")
			elseif math.random() > 0.85 then 
				Board:SetItem(p, "Poke_Rubble"..math.random(1,4)) 		--decorative
			end
		end
	end
end

function Mission_Poke_Palkia:NextTurn()
	local totalHP = 0
	for i = 0, 2 do
		if Board:GetPawn(i) then totalHP = totalHP + Board:GetPawn(i):GetHealth() end
	end
	if totalHP == 0 then --mission will end soon
		modApi:conditionalHook(function()
			return modApi.deployment:isDeploymentPhase()
		end,
		function()
			for i = 0, 7 do
				for j = 0, 7 do
					Board:Crack(Point(i,j))
					Board:Bounce(Point(i,j), math.random(-10,10))
				end
			end
		end)
	end
end

function Mission_Poke_Palkia:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then return 1 end
	return 0
end

function Mission_Poke_Palkia:UpdateObjectives()
	local status = OBJ_STANDARD
	if not Board:IsPawnAlive(self.Target) then 
		if not Board:IsPawnAlive(self.BallID) then 
			status = OBJ_FAILED 
		else
			status = OBJ_COMPLETE 
		end
	end
	Game:AddObjective("Capture Palkia",status)
end

function Mission_Poke_Palkia:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) or not Board:IsPawnAlive(self.BallID) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Palkia:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_PalkiaCapture:isComplete() then achievements.Poke_PalkiaCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then objectives = { objectives }  end
	
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
	corpMissions.Add_Missions_High("Mission_Poke_Palkia", "Corp_Snow")
end

return this