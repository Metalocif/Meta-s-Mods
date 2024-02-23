local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Arceus"}
local corpMissions = require(path .."corpMissions")

local resourcePath =  mod_loader.mods[mod].resourcePath

modApi:addMap(resourcePath .."maps/Poke_Boss_Pillars_Arceus.map")

Mission_Poke_Arceus = Mission_Infinite:new{
	Name = "Spear Pillars",
	Objectives = Objective("Capture Arceus",1,1),
	Target = 0,
	BallID = -1,
	CustomTile = "tiles_Pillars",
	MapTags = { "Poke_Boss_Pillars_Arceus" },
	BlockSecret = true,
	BonusPool = { BONUS_KILL_FIVE, BONUS_MECHS, BONUS_PACIFIST },
	BossPawn = "Poke_ArceusBoss",
}

function Mission_Poke_Arceus:StartMission()
	for _, p in ipairs(Board) do
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

function Mission_Poke_Arceus:NextTurn()
	if self.ShadowForceTarget ~= nil and Game:GetTeamTurn() == TEAM_ENEMY then
		local ret = SkillEffect()
		Board:DamageSpace(SpaceDamage(self.ShadowForceTarget, DAMAGE_DEATH))
		CustomAnim:rem(self.ShadowForceTarget, "QueuedShot")
		for i = DIR_START, DIR_END do
			local curr = self.ShadowForceTarget + DIR_VECTORS[i]
			Board:DamageSpace(SpaceDamage(curr, DAMAGE_DEATH))
			CustomAnim:rem(curr, "QueuedShot")
		end
		Board:AddAnimation(self.ShadowForceTarget, "darkpulseAnim", ANIM_NO_DELAY)
		Board:AddEffect(ret)
		Board:GetPawn(self.Target):SetSpace(self.ShadowForceTarget)
		Board:GetPawn(self.Target):RemoveWeapon(1)
		Board:GetPawn(self.Target):AddWeapon("Poke_DevourLight")
		-- weaponPreview:ClearMarks()
		self.ShadowForceTarget = nil
	end
end

function Mission_Poke_Arceus:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then return 1 end
	return 0
end

function Mission_Poke_Arceus:UpdateObjectives()
	local status = (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Capture Arceus",status)
end

function Mission_Poke_Arceus:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Arceus:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.Target)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_ArceusCapture:isComplete() then achievements.Poke_ArceusCapture:addProgress{ complete = true } end
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
	corpMissions.Add_Missions_High("Mission_Poke_Arceus", "Corp_Snow")
end

return this