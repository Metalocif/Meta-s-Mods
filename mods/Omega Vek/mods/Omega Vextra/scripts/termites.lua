
OmegaTermitesAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Digging Claws",
	Description = "If the front tile is crackable, crack it to throw a rock at a distant target; otherwise, strike it.",
	Class = "Enemy",
	Webbing = false,
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaTermites2"
	}
}

function OmegaTermitesAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		-- local terrain = Board:GetTerrain(curr)
		if Board:IsCrackable(curr) then
		-- if terrain == TERRAIN_ICE or terrain == TERRAIN_MOUNTAIN or terrain == TERRAIN_ICE or terrain == TERRAIN_ROAD then
			for j = 2, 7 do
				ret:push_back(point + DIR_VECTORS[i] * j)
			end
		end
		-- ret:push_back(curr)
	end
	return ret
end

function OmegaTermitesAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	
	-- local terrain = Board:GetTerrain(curr)
	if Board:IsCrackable(target) and not Board:GetPawn(target) then
	-- if terrain == TERRAIN_ICE or terrain == TERRAIN_MOUNTAIN or terrain == TERRAIN_ICE or terrain == TERRAIN_ROAD then
		local crackMaker = SpaceDamage(target)
		crackMaker.iCrack = 1
		ret:AddQueuedMelee(p1, crackMaker)
		ret:AddQueuedArtillery(SpaceDamage(p2, self.Damage), "effects/shotup_rock.png")
	else
		ret:AddQueuedMelee(p1, SpaceDamage(target, self.Damage))
	end
	
	return ret
end	

OmegaTermitesAtkB = OmegaTermitesAtk2:new{Damage=4, Class = "Enemy",Name = "Mining Claws",}