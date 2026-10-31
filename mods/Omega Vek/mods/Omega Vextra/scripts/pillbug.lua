OmegaPillbugAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Projectile = "effects/DNT_upshot_Omegapillbug2.png",
	Effect1 = "effects/DNT_effect1_Omegapillbug2.png",
	Effect2 = "effects/DNT_effect2_Omegapillbug2.png",
	ImpSound = "/impact/generic/general",--"/props/boulder_impact",
	Range = 5,
	Name = "Chitinous Leap",
	Description = "Leap to one tile, bounce to another, then return to the starting position.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/scorpion_soldier_1",
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy1 = Point(2,0),
		Mountain = Point(2,1),
		Building = Point(2,2),
		CustomPawn = "DNT_Pillbug2",
	}
}

SkillEffect["New_AddQueuedArtillery"] = function(self, origin, damage, graphics, delay) -- add our own queued artillery that can start from anywhere
	local fx = SkillEffect()
	fx["AddArtillery"](fx, origin, damage, graphics, delay)
	self.q_effect:AppendAll(fx.effect)
end

function OmegaPillbugAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target1 = p2 + DIR_VECTORS[(dir+1)%4]
	local target2 = p2 + DIR_VECTORS[(dir-1)%4]
	local userId = Board:GetPawn(p1) and Board:GetPawn(p1):GetId() or -1
	-- ret:AddQueuedBounce(p1,2)
	local lastTile = p1
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(true)", userId)) -- hide pawn
	
	if Board:IsValid(target1) then
		local damage1 = SpaceDamage(target1,self.Damage)
		damage1.sSound = self.ImpSound
		ret:DNT_AddQueuedArtillery(damage1,self.Projectile,NO_DELAY) -- jump effect
		ret:AddQueuedDelay(0.01)
		ret:DNT_AddQueuedArtillery(SpaceDamage(target1),self.Effect1,NO_DELAY) -- after effect 1
		ret:AddQueuedDelay(0.01)
		ret:DNT_AddQueuedArtillery(SpaceDamage(target1),self.Effect2,FULL_DELAY) -- after effect 2
		-- ret:AddQueuedDelay(0.78)
		
		if Board:GetTerrain(target1) == TERRAIN_HOLE or Board:GetTerrain(target1) == TERRAIN_WATER then
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(false)", userId))
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetSpace(%s)", userId, target1:GetString()))
			return ret
		end 
		lastTile = target1
	end
	
	if Board:IsValid(target2) then
		local damage2 = SpaceDamage(target2,self.Damage)
		damage2.sSound = self.ImpSound
		ret:New_AddQueuedArtillery(lastTile, damage2,self.Projectile,NO_DELAY) -- jump effect
		ret:AddQueuedDelay(0.01)
		ret:New_AddQueuedArtillery(lastTile, SpaceDamage(target2),self.Effect1,NO_DELAY) -- after effect 1
		ret:AddQueuedDelay(0.01)
		ret:New_AddQueuedArtillery(lastTile, SpaceDamage(target2),self.Effect2,FULL_DELAY) -- after effect 2
		-- ret:AddQueuedDelay(0.78)
		
		if Board:GetTerrain(target1) == TERRAIN_HOLE or Board:GetTerrain(target1) == TERRAIN_WATER then
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(false)", userId))
			ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetSpace(%s)", userId, target1:GetString()))
			return ret
		end 
		lastTile = target2
	end 
	
	local damage3 = SpaceDamage(p1)
	damage3.sSound = self.ImpSound
	ret:New_AddQueuedArtillery(lastTile, damage3,self.Projectile,NO_DELAY) -- jump effect
	ret:AddQueuedDelay(0.01)
	ret:New_AddQueuedArtillery(lastTile, damage3,self.Effect1,NO_DELAY) -- after effect 1
	ret:AddQueuedDelay(0.01)
	ret:New_AddQueuedArtillery(lastTile, damage3,self.Effect2,FULL_DELAY) -- after effect 2
	-- ret:AddQueuedDelay(0.78)
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(false)", userId)) -- reveal pawn
	-- ret:AddQueuedDelay(0.7)
	ret:AddQueuedScript("Game:TriggerSound('/enemy/leaper_1/land')")
	
	ret:AddQueuedDelay(0.08)
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetInvisible(false)", userId)) -- show pawn
	ret:DNT_AddQueuedBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	
	-- Preview
	-- local move = PointList()
	-- move:push_back(p1)
	-- move:push_back(p3)
	-- ret:AddQueuedMove(move, NO_DELAY) 
	-- ret.q_effect:back().bHide = true 
	-- ret:AddQueuedDelay(0.5)

	return ret
end	

function OmegaPillbugAtk2:GetTargetScore(p1, p2)
	-- local ret = Skill.GetTargetScore(self, p1, p2)
	local ret = 0
	local dir = GetDirection(p2 - p1)
	local userId = Board:GetPawn(p1) and Board:GetPawn(p1):GetId() or -1
	
	for i = -1, 1, 2 do
		local target = p2 + DIR_VECTORS[(dir+i)%4]
		if Board:GetTerrain(target) == TERRAIN_HOLE or Board:GetTerrain(target) == TERRAIN_WATER then
			ret = -100
		end
		
		if Board:GetTerrain(target) == TERRAIN_BUILDING then ret = ret + 5 end
		if Board:GetPawn(target) and Board:GetPawn(target):GetTeam() == TEAM_PLAYER then
			if Board:GetPawn(target):IsFrozen() then 
				ret = ret - 5 
			else
				ret = ret + 5
			end 
		end 
		if Board:GetPawn(target) and Board:GetPawn(target):GetTeam() == TEAM_ENEMY then
			if Board:GetPawn(target):IsFrozen() then
				ret = ret + 5
			elseif Board:GetPawn(target):GetId() < userId then
				ret = ret - 5
			end
		end
		
		for j = DIR_START, DIR_END do
			if Board:GetTerrain(target + DIR_VECTORS[j]) == TERRAIN_HOLE or Board:GetTerrain(target + DIR_VECTORS[j]) == TERRAIN_WATER then
				ret = ret - 1
			end 
		end 
	end 
	
	return ret
end



OmegaPillbugAtkB = OmegaPillbugAtk2:new{Damage=4,Class = "Enemy",Name = "Adamantine Leap",}