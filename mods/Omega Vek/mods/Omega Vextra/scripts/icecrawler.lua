-- local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
-- modApi:appendAsset("img/effects/stinger_R.png", resourcePath.."img/effects/stinger_R.png")
-- modApi:appendAsset("img/effects/stinger_U.png", resourcePath.."img/effects/stinger_U.png")

OmegaIcecrawlerAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 3,
	Name = "Freezing Rimespewer",
	Description = "Release an icy gas with 3 range that instantly freezes buildings and mountains, then prepares to explode frozen locations.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,3),
		Mountain = Point(2,2),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Building2 = Point(1,0),
		Building3 = Point(1,2),
		Target = Point(2,0),
		-- CustomPawn = "OmegaMosquito2"
	}
}

function OmegaIcecrawlerAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local dist = p1:Manhattan(p2)
	-- Do anim, unqueued part, queued part
	for i=1,dist do
		curr = p1+DIR_VECTORS[dir]*i
		if Board:IsBuilding(curr) or Board:IsTerrain(curr, TERRAIN_MOUNTAIN) or (Board:IsTerrain(curr, TERRAIN_WATER) and not (Board:IsTerrain(curr, TERRAIN_LAVA) or Board:IsTerrain(curr, TERRAIN_ACID))) then
			local damage = SpaceDamage(curr)
			damage.iFrozen = 1
			ret:AddDamage(damage)
		end
		
		for j = DIR_START, DIR_END do
			local damage = SpaceDamage(curr + DIR_VECTORS[j], 0)
			if Board:IsFrozen(curr) then damage.iDamage = self.Damage end
			local notInArea = true
			--don't double hit buildings or hit self
			for k = 0, dist do
				if curr + DIR_VECTORS[j] == p1+DIR_VECTORS[dir]*k then notInArea = false end
			end 
			if notInArea then ret:AddQueuedDamage(damage) end
		end
		local unfreeze = SpaceDamage(curr, 0)
		if Board:IsFrozen(curr) then unfreeze.iDamage = DAMAGE_DEATH else unfreeze.bHide = true end
		ret:AddQueuedDamage(unfreeze)
	end
	animation2 = SpaceDamage(curr,0)
	animation2.sAnimation = "chillthrower"..dist.."_"..dir
	animation2.sSound = "/weapons/flamespreader"
	ret:AddDamage(animation2)
	return ret
end	

function OmegaIcecrawlerAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.Range do
			ret:push_back(point+DIR_VECTORS[i]*j)
		end
	end
	return ret
end	

function OmegaIcecrawlerAtk2:GetTargetScore(p1,p2)
	local ret = 0
	local dir = GetDirection(p2-p1)
	local dist = p1:Manhattan(p2)
	local userID = Board:GetPawn(p1) and Board:GetPawn(p1):GetId() or -1
	for i=1,dist do
		local curr = p1+DIR_VECTORS[dir]*i
		if Board:IsFrozen(curr) or Board:IsBuilding(curr) or Board:IsTerrain(curr, TERRAIN_MOUNTAIN) or (Board:IsTerrain(curr, TERRAIN_WATER) and not (Board:IsTerrain(curr, TERRAIN_LAVA) or Board:IsTerrain(curr, TERRAIN_ACID))) then
		--this happens unqueued, freezing curr; the queued part damages adjacent tiles to anything frozen
			for j = DIR_START, DIR_END do
				local curr2 = curr + DIR_VECTORS[j]
				if Board:GetPawn(curr2) and Board:GetPawn(curr2):GetTeam() == TEAM_PLAYER then ret = ret + 5 end 
				--explosion would reach player unit
				if Board:GetPawn(curr2) and Board:GetPawn(curr2):GetTeam() == TEAM_ENEMY and (Board:GetPawn(curr2):GetId() > userID or Board:GetPawn(curr2):GetMoveSpeed() == 0) then ret = ret - 5 end 
				--explosion would reach enemy unit that has moved or cannot move
				if Board:IsBuilding(curr2) then ret = ret + 5 end
				--explosion would reach building
			end
		end
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY and Board:GetPawn(curr):IsFrozen() then 
			ret = ret + 5 
			--count extra for freeing a teammate
			if Board:GetPawn(curr):GetId() > userID then ret = ret + 5 end
			--count double extra for freeing a teammate that will get to play as a result
		end
		
	end
    return ret
end


OmegaIcecrawlerAtkB = OmegaIcecrawlerAtk2:new{Range=4,Class = "Enemy",Name = "Freezing Frostspewer",}