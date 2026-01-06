local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/effects/omegaspiderwebitem.png", resourcePath.."img/effects/omegaspiderwebitem.png")
modApi:appendAsset("img/effects/shotup_smallrocks.png", resourcePath.."img/effects/shotup_smallrocks.png")
modApi:appendAsset("img/effects/stinger_R.png", resourcePath.."img/effects/stinger_R.png")
modApi:appendAsset("img/effects/stinger_U.png", resourcePath.."img/effects/stinger_U.png")

OmegaBurnbugAtk2 = Skill:new{
	Damage = 2,
	Class = "Enemy",
	Name = "Trampling Proboscis",
	Description = "Grapple for 2 damage, pulling the Vek towards objects or units. Will go through units, terrain, and buildings if used from a distance.",
	LaunchSound = "/enemy/burnbug_1/attack_launch",
	PullSound = "/enemy/burnbug_1/attack_pull",
	PathSize = 8,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,0),
		Target = Point(2,1),
		Mountain = Point(2,4),
		CustomPawn = "OmegaBurnbug2",
	}
}

function OmegaBurnbugAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1, p2)
	
	local distance = p1:Manhattan(target)
	if distance > 2 then
	
		while Board:IsValid(target) do
			target = target + DIR_VECTORS[direction]
		end
		
		
		if not Board:IsValid(target) then
			while Board:IsBlocked(target, PATH_PROJECTILE) do
				target = target - DIR_VECTORS[direction]
			end
		end
		distance = p1:Manhattan(target)
		local damage = SpaceDamage(target)
		damage.bHidePath = true
		damage.sSound = self.PullSound
		ret:AddQueuedProjectile(damage,"effects/shot_grapple")
		
		if Board:IsBlocked(target, PATH_PROJECTILE) then
			ret:AddQueuedCharge(Board:GetSimplePath(p1, target), FULL_DELAY)	
			
			for i = 1, distance-1 do
				damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i, self.Damage)
				ret:AddQueuedDamage(damage)
				ret:AddQueuedDelay(0.06)
				ret:AddQueuedBounce(p1 + DIR_VECTORS[direction]*i, -3)
				-- if i < distance and i > 0 then ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[direction]*i, self.Damage)) end
			end
		end
	else
		local damage = SpaceDamage(target)
		damage.bHidePath = true
		ret:AddQueuedProjectile(damage,"effects/shot_grapple")
		
		damage = SpaceDamage(target, self.Damage)
		damage.sSound = self.PullSound
		ret:AddQueuedDamage(damage)
		if Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() then	-- If it's a pawn
			ret:AddQueuedCharge(Board:GetSimplePath(target, p1 + DIR_VECTORS[direction]), FULL_DELAY)
		elseif Board:IsBlocked(target, PATH_GROUND) then     --If it's an obstruction
			ret:AddQueuedCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)	
		end
	
	end
	return ret
end

OmegaMosquitoAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Flak Tentacles",
	Description = "Smoke the user and its surroundings, preparing to strike the target for 2 damage.",
	Class = "Enemy",
	Webbing = false,
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaMosquito2"
	}
}

function OmegaMosquitoAtk2:GetSkillEffect(p1, p2)
	--maybe have it swallow smoke once the attack is done?
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local sound = SpaceDamage(p2)
	ret:AddDamage(SoundEffect(p2,self.SoundBase.."/attack_smoke"))
	local damage = SpaceDamage(p1,0)
	damage.sAnimation = ""
	damage.iSmoke = 1
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		damage.loc = p1 + DIR_VECTORS[i]
		ret:AddDamage(damage)
	end
	
	damage = SpaceDamage(p2,self.Damage)
	damage.sSound = self.SoundBase.."/attack"
	damage.sAnimation = "explomosquito_"..direction
	damage.iSmoke = -1
	local clearSmoke = SpaceDamage(p1)
	clearSmoke.iSmoke = -1
	ret:AddQueuedDamage(clearSmoke)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local clearSmoke2 = SpaceDamage(curr)
		clearSmoke2.iSmoke = -1
		if curr ~= p2 then ret:AddQueuedDamage(clearSmoke2) end
	end
	ret:AddQueuedMelee(p1, damage)
	
	return ret
end	

function OmegaMosquitoAtk2:GetTargetScore(p1,p2)
	--Omega Mosquito smokes surrounding tiles, so it has to check for fires, pawns on fire, and queued allies
	local ret = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsQueued() then ret = ret - 100 end
		if pawn and pawn:IsFire() then
			if pawn:GetTeam() == TEAM_ENEMY then
				ret = ret + 2
			else
				ret = ret - 2
			end
		elseif Board:IsFire(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then
			ret = ret + 1
		end
	end
	if Board:GetTerrain(p2) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
    return ret
end

OmegaScarabAtk2 = LineArtillery:new{   
	ArtillerySize = 5,
	Name = "Sputtering Glands",
	Description = "Lob an artillery shot at a single target for 1 damage. Also fires at all mechs, wherever they are.",
	Explosion = "ExploArt1",
	Damage = 1,
	Class = "Enemy",
	Icon = "weapons/enemy_crab1.png",
	ImpactSound = "/impact/generic/explosion",
	Projectile = "effects/shotup_crab2.png",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(1,0),
		Building = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaScarab2"
	}
}

function OmegaScarabAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddQueuedArtillery(SpaceDamage(p2, self.Damage),self.Projectile, NO_DELAY)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		local loc = p2
		if pawn then loc = pawn:GetSpace() end	--necessary check if you don't have three pawns in eg. tipimages
		if loc ~= p2 then ret:AddQueuedArtillery(SpaceDamage(loc, self.Damage), self.Projectile, NO_DELAY) end
	end
	if Board:IsTipImage() then
		ret:AddQueuedArtillery(SpaceDamage(Point(2,2), self.Damage), self.Projectile, NO_DELAY)
		ret:AddQueuedArtillery(SpaceDamage(Point(1,0), self.Damage), self.Projectile, NO_DELAY)
	end
	return ret
end

function OmegaScarabAtk2:GetTargetScore(p1,p2)
	--Omega Scarab autofires at all mechs, so it only cares if p2 contains a building or a nonmech
	local ret = 0
	for i = 0, 2 do
		if Board:GetPawn(i) and not Board:GetPawn(i):IsDead() then ret = ret + 5 end
	end
	if Board:GetTerrain(p2) == TERRAIN_BUILDING then 
		ret = ret + 5
	elseif Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER and not Board:GetPawn(p2):IsMech() then 
		ret = ret + 5
	else
		ret = ret + 1
	end
    return ret
end

OmegaDiggerAtk2 = DiggerAtk1:new{
	Damage = 1,
	Push = true,
	Class = "Enemy",
	Name = "Shoving Tusks",
	Description = "Create a defensive rock wall before shoving adjacent tiles for 1 damage.",
	Icon = "weapons/enemy_rocker1.png",
	LaunchSound = "",
	SoundId = "digger_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "OmegaDigger2"
	}
}

function OmegaDiggerAtk2:GetTargetScore(p1,p2)
	--Omega Digger pushes rocks, so it is fine with buildings two tiles away as well
	local ret = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn1 = Board:GetPawn(curr)
		local pawn2 = Board:GetPawn(curr + DIR_VECTORS[i])
		if Board:GetTerrain(curr) == TERRAIN_BUILDING then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_PLAYER then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:GetQueuedTarget() ~= Point(-1, -1) then ret = ret - 5 end
		local canSpawnRock = Board:IsBlocked(curr, PATH_PROJECTILE)
		if canSpawnRock and pawn2 and pawn2:GetTeam() == TEAM_ENEMY and pawn2:GetQueuedTarget() ~= Point(-1, -1) then ret = ret - 5 end
		if (Board:GetTerrain(curr + DIR_VECTORS[i]) == TERRAIN_BUILDING or pawn2 and pawn2:GetMoveSpeed() == 0) and canSpawnRock then ret = ret + 5 end
	end
    return ret
end


OmegaDungAtk2 = DungAtk1:new{	--tumblebug
	Damage = 1,
	PathSize = 1,
	RockCount = 1,
	Name = "Incendiary Prizes",
	Description = "Create an explosive boulder and set it on fire, then prepares to create another.",
	Class = "Enemy",
	SoundId = "dung_1",
	LaunchSound = "",
	Deployed = "BombRock",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "OmegaDung2"
	}
}

function OmegaDungAtk2:GetTargetScore(p1,p2)
	--Omega Tumblebug creates bombs, so it wants empty spaces adjacent to stuff
	local ret = 0
	if Board:IsBlocked(p2, PATH_GROUND) or Board:IsSmoke(p2) then return -100 end
	for j = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[j]
		local pawn = Board:GetPawn(curr)
		if Board:GetTerrain(curr) == TERRAIN_BUILDING then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_PLAYER then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsQueued() then ret = ret - 5 end
	end
    return ret
end

function OmegaDungAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local spawn = SpaceDamage(p2, 0)
	spawn.iFire = 1
	spawn.sPawn = self.Deployed

	if self:CanSpawnRock(p2) then
		ret:AddSound("/enemy/"..self.SoundId.."/spawn_rock")
		ret:AddDamage(spawn)
		-- if not Board:IsBlocked(p2, PATH_GROUND) then ret:AddQueuedDamage(spawn) end
	end	
	return ret
end


OmegaFireflyAtk2 = Skill:new{
	Name = "Phasing Thorax",
	Description = "Launch a phasing mass of goo dealing 2 damage to the first two targets hit.",
	Damage = 2,
	PathSize = 1,
	Range = RANGE_PROJECTILE,
	Class = "Enemy",
	Icon = "weapons/enemy_firefly1.png",
	Explosion = "ExploFirefly2",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Projectile = "effects/shot_firefly",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "OmegaFirefly2"
	}
}


function OmegaFireflyAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
			
	local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	local second_tar = GetProjectileEnd(first_tar,first_tar+DIR_VECTORS[dir],PATH_PROJECTILE)  
	local damage = nil
	if Board:IsValid(second_tar) and second_tar ~= first_tar then
		
		local damage = SpaceDamage(second_tar, self.Damage)
		
		damage.sAnimation = self.Explosion
		ret:AddQueuedProjectile(damage, self.Projectile, NO_DELAY)
		
		local distance = first_tar:Manhattan(p1)
		ret:AddQueuedDelay(distance*0.1 + 0.2)
		local first_damage = SpaceDamage(first_tar, self.Damage)
		first_damage.sAnimation = self.Explosion
		ret:AddQueuedDamage(first_damage)
		
	else
	
		local damage = SpaceDamage(first_tar, 0, dir)
		damage.sAnimation = self.Explosion
		ret:AddQueuedProjectile(damage, self.Projectile)
		
	end
	return ret
end



OmegaCentipedeAtk2 = Skill:new{
	Name = "Dissolving Vomit",
	Description = "Swallows A.C.I.D. on adjacent tiles to heal, then releases acidic vomit on adjacent tiles, dealing 2 damage. Applies A.C.I.D. on the user.",
	Damage = 2,
	Class = "Enemy",
	Icon = "weapons/enemy_firefly1.png",
	Explosion = "ExploFirefly2",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Projectile = "effects/shot_firefly2",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		Acid = Point(3,3),
		CustomPawn = "OmegaCentipede2"
	}
}

function OmegaCentipedeAtk2:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function OmegaCentipedeAtk2:GetTargetScore(p1,p2)
	--Omega Centipede eats acid, so it cares about using this attack adjacent to acid
	local ret = 1
	local missingHealth = Board:GetPawn(p1):GetMaxHealth() - Board:GetPawn(p1):GetHealth()
	if Status.GetStatus(Board:GetPawn(p1):GetId(), "Hemorrhage") then missingHealth = 0 end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if Board:IsAcid(curr) and missingHealth > 0 then 
			ret = ret + 2 
			missingHealth = missingHealth - 1
		end	--healing 3 > hitting one thing?
		if Board:GetTerrain(curr) == TERRAIN_BUILDING then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_PLAYER then ret = ret + 5 end
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsAcid() then
			if pawn:GetQueuedTarget() == Point(-1, -1) then 
				ret = ret + 2	--slurps acid from ally but won't hit it
			else
				ret = ret - 5	--slurps acid from ally and will hit it
			end
			missingHealth = missingHealth - 1
		end
	end
    return ret
end

function OmegaCentipedeAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local acidCount = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		local cleanupDamage = SpaceDamage(curr)
		cleanupDamage.iAcid = -1
		if Board:IsAcid(curr) or (pawn and pawn:IsAcid()) then
			ret:AddDamage(cleanupDamage)
			acidCount = acidCount + 1
		end
		local damage = SpaceDamage(curr, 2)
		damage.iAcid = 1
		ret:AddQueuedDamage(damage)
	end
	local applyAcid = SpaceDamage(p1, -acidCount)
	applyAcid.iAcid = 1
	applyDamage.sAnimation = "Splash_acid"
	ret:AddDamage(applyAcid)
	return ret
end


OmegaBouncerAtk2 = Skill:new{
	Name = "Ramming Horns",
	Description = "Deal 2 damage to the target and pushes it, then pushes itself into the target's tile.",
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/bouncer_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		Building = Point(2,0),
		CustomPawn = "OmegaBouncer2"
	}
}

function OmegaBouncerAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local damage = SpaceDamage(p2,self.Damage, direction)
	damage.sAnimation = "SwipeClaw2"
	damage.sSound = self.SoundBase.."/attack"
	ret:AddQueuedMelee(p1,damage)
	
	damage = SpaceDamage(p1, 0, direction)
	ret:AddQueuedDamage(damage)	
	
	return ret
end	


OmegaMothAtk2 = LineArtillery:new{   
	Name = "Abhorrent Pellets",
	Description = "Launch an artillery attack for 3 damage, pushing the target and everything around the shooter.",
	ArtillerySize = 5,
	Explosion = "ExploArt1",
	Damage = 3,
	Class = "Enemy",
	ImpactSound = "/enemy/moth_1/attack_impact",
	LaunchSound = "/enemy/moth_1/attack_launch",
	Projectile = "effects/shotup_crab1.png",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(1,3),
		Target = Point(2,1),
		CustomPawn = "OmegaMoth2"
	}
}

function OmegaMothAtk2:GetTargetScore(p1,p2)
	--Omega Moth pushes adjacent, so we make sure they are not queued allies
	local ret = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:IsQueued() then ret = ret - 100 end
	end
	if Board:GetTerrain(p2) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
    return ret
end

function OmegaMothAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	
	for i = DIR_START, DIR_END do
		local damage = SpaceDamage(p1+DIR_VECTORS[i], 0, i)
		damage.sAnimation = "airpush_"..i
		ret:AddQueuedDamage(damage)
	end
	damage = SpaceDamage(p2, self.Damage, dir)
	ret:AddQueuedArtillery(damage, self.Projectile)
	
	return ret
end


OmegaLeaperAtk2 = Skill:new{
	Name = "Impeding Fangs",
	Description = "Webs all adjacent enemies, preparing to strike a target for 3 damage.",
	PathSize = 1,
	Icon = "weapons/enemy_scorpion1.png",	
	Damage = 3,
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/scorpion_soldier_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Enemy2 = Point(1,2),
		Target = Point(2,1),
		CustomPawn = "OmegaLeaper2"
	}
}

function OmegaLeaperAtk2:GetTargetScore(p1,p2)
	--Omega Leaper webs all adjacent and is stable, so it wants to be adjacent to as many enemies as possible
	local ret = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if curr == p2 then
			if Board:GetTerrain(p2) == TERRAIN_BUILDING or (pawn and pawn:GetTeam() == TEAM_PLAYER) then ret = ret + 5 end
		else
			if pawn and pawn:GetTeam() == TEAM_PLAYER then ret = ret + 2 end
		end
	end
    return ret
end

function OmegaLeaperAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	for i = DIR_START, DIR_END do
		local curr = p1+DIR_VECTORS[i]
		if (Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER) or Board:GetTerrain(curr) == TERRAIN_BUILDING then
			local sound = SpaceDamage(p2)
			ret:AddDamage(SoundEffect(p2,self.SoundBase.."/attack_web"))
			ret:AddGrapple(p1,curr,"hold")
		end
	end
	
	local damage = SpaceDamage(p2,self.Damage)
	damage.sAnimation = "SwipeClaw2"
	damage.sSound = self.SoundBase.."/attack"
	ret:AddQueuedMelee(p1,damage)
		
	return ret
end	 


OmegaHornetAtk2 = Skill:new{
	Name = "Propelled Stringer",
	Description = "Stab 3 tiles in a row in front of the unit for 2 damage.",
	Damage = 2,
	PathSize = 1,
	Class = "Enemy",
	Icon = "weapons/enemy_hornet1.png",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(1,1),
		Target = Point(2,1),
		CustomPawn = "OmegaHornet2"
	}
}

function OmegaHornetAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)	
	
	local damage = SpaceDamage(p2,self.Damage)
	damage.sAnimation = "explohornet_"..direction
	
	ret:AddQueuedMelee(p1,damage, NO_DELAY)
	damage.loc = p2 + DIR_VECTORS[(direction + 1)% 4]
	ret:AddQueuedDamage(damage)
	damage.loc = p2 - DIR_VECTORS[(direction + 1)% 4]
	ret:AddQueuedDamage(damage)
	return ret
end	


OmegaBurrowerAtk2 = Skill:new{
	Name = "Digging Carapace",
	Description = "Create a defensive rock wall before lobbing rocks at 3 tiles in a row for 2 damage.",
	Damage = 2,
	PathSize = 1,
	Class = "Enemy",
	Icon = "weapons/enemy_hornet1.png",
	Projectile = "effects/shotup_smallrocks.png",
	TipImage = {
		Unit = Point(2,0),
		Enemy = Point(2,2),
		Building = Point(1,1),
		Target = Point(2,2),
		CustomPawn = "OmegaBurrower2"
	}
}

function OmegaBurrowerAtk2:GetTargetScore(p1,p2)
	--Omega Burrower wants to make a ton of rocks, so we check adjacent spaces are clear
	local ret = 0
	local direction = GetDirection(p2 - p1)	
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if Board:IsBlocked(curr, PATH_GROUND) then ret = ret - 1 end
		if pawn and not pawn:IsQueued() then ret = ret - 1 end
	end
	if Board:GetTerrain(p2) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
	if Board:GetTerrain(p2 + DIR_VECTORS[(direction + 1)% 4]) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2 + DIR_VECTORS[(direction + 1)% 4]) and Board:GetPawn(p2 + DIR_VECTORS[(direction + 1)% 4]):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
	if Board:GetTerrain(p2 - DIR_VECTORS[(direction + 1)% 4]) == TERRAIN_BUILDING then ret = ret + 5 end
	if Board:GetPawn(p2 - DIR_VECTORS[(direction + 1)% 4]) and Board:GetPawn(p2 - DIR_VECTORS[(direction + 1)% 4]):GetTeam() == TEAM_PLAYER then ret = ret + 5 end
    return ret
end

function OmegaBurrowerAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
		end
	end
    return ret
end


function OmegaBurrowerAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)	
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		if not Board:IsBlocked(curr,PATH_PROJECTILE) and Board:GetTerrain(curr) ~= TERRAIN_WATER and not Board:IsPod(curr) then
			local damage = SpaceDamage(curr)
			damage.sPawn = "Wall"
			ret:AddDamage(damage)
		end
		local damage = SpaceDamage(p2,self.Damage)
		
		ret:AddQueuedArtillery(damage, self.Projectile, NO_DELAY)
		damage.loc = p2 + DIR_VECTORS[(direction + 1)% 4]
		ret:AddQueuedArtillery(damage, self.Projectile, NO_DELAY)
		damage.loc = p2 - DIR_VECTORS[(direction + 1)% 4]
		ret:AddQueuedArtillery(damage, self.Projectile, NO_DELAY)
	end	
	return ret
end	


OmegaScorpionAtk2 = Skill:new{
	Name = "Pressurized Spinneret",
	Description = "Web an adjacent target, preparing to fire a short-ranged projectile in its direction for 2 damage.",
	PathSize = 1,
	Icon = "weapons/enemy_scorpion1.png",	
	Damage = 2,
	Range = 2,
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/scorpion_soldier_1",
	Projectile = "effects/stinger",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaScorpion2"
	}
}

function OmegaScorpionAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	if not Board:IsBlocked(target, PATH_PROJECTILE) then target = target + DIR_VECTORS[direction] end
	local sound = SpaceDamage(p2)
	ret:AddDamage(SoundEffect(p2,self.SoundBase.."/attack_web"))
	ret:AddGrapple(p1,p2,"hold")
	
	local damage = SpaceDamage(target, self.Damage)
	damage.sSound = self.SoundBase.."/attack"
	
	ret:AddQueuedProjectile(damage, self.Projectile)
		
	return ret
end	

function OmegaScorpionAtk2:GetTargetScore(p1,p2)
	local ret = 0
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	local target2 = Point(-1, -1)
	if not Board:IsBlocked(target, PATH_PROJECTILE) then target2 = target + DIR_VECTORS[direction] end
	local meleePawn = Board:GetPawn(target)
	local rangedPawn = Board:GetPawn(target2)
	--strive to web a pawn with a target that cannot move behind it
	if meleePawn and meleePawn:GetTeam() == TEAM_PLAYER and 
	(Board:IsBuilding(target2) or (rangedPawn and rangedPawn:IsMissionCritical() and rangedPawn:GetMoveSpeed() == 0))then
		ret = 10
	--if not, attack a pawn in melee or a building
	elseif (meleePawn and meleePawn:GetTeam() == TEAM_PLAYER) or Board:IsBuilding(target) or Board:IsBuilding(target2) then
		ret = 6
	--if not, shooting at a pawn is fine
	elseif (rangedPawn and rangedPawn:GetTeam() == TEAM_PLAYER) then
		ret = 5
	end
	if meleePawn and meleePawn:GetTeam() == TEAM_PLAYER and Board:IsCracked(target) then ret = ret + 5 end
	return ret
end


OmegaShamanAtk2 = ShamanAtk2:new{ 
	Name = "Reviving Spores",
	Description = "Launch a short-lived Omega Spore. While a Plasmodia is alive, Vek leave corpses.",
	MyPawn = "OmegaTotem2", 
	Class = "Enemy",	
	MyArtillery =  "advanced/effects/shotup_totem2.png",
	ImpactSound = "/enemy/shaman_2/attack_impact",
	LaunchSound = "/enemy/shaman_2/attack_launch",
	Explosion = "",
	TipImage = {
		CustomPawn = "OmegaShaman2",
		Unit = Point(3,3),
		Target = Point(3,1),
		Second_Origin = Point(3,1),
		Second_Target = Point(1,1),
		Enemy = Point(1,1),
	}
}  

function OmegaShamanAtk2:GetTargetScore(p1,p2)
	--Omega Spore fires a healing projectile, so we want to spawn it somewhere it can hit the best targets
	local ret = 0
	if Board:IsBlocked(p2, PATH_GROUND) then return -100 end
	for i = DIR_START, DIR_END do
		local target = GetProjectileEnd(p2,p2+DIR_VECTORS[i])  
		local pawn = Board:GetPawn(target)
		local score = 2
		if pawn and pawn:GetTeam() == TEAM_ENEMY then
			if pawn:IsDead() then score = 20
			elseif pawn:IsDamaged() then score = 5
			end
			if pawn:IsFire() then score = score + 2 end
			if pawn:IsAcid() then score = score + 2 end
			if pawn:IsFrozen() then score = score + 2 end
		end
		ret = math.max(ret, score)
	end
	return ret
end

function OmegaShamanAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	local mission = GetCurrentMission()
	if not mission then return ret end
	mission.hadCorpseBeforeOmegaPlasmodia = mission.hadCorpseBeforeOmegaPlasmodia or {}
	damage.sPawn = self.MyPawn
	ret:AddArtillery(damage, self.MyArtillery)
		
	for dir = DIR_START, DIR_END do 
		damage = SpaceDamage(p2 + DIR_VECTORS[dir])
		ret:AddDamage(damage)
	end
	
	for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		if Board:GetPawn(i) and not Board:GetPawn(i):IsMinor() and not Board:GetPawn(i):GetType() == "OmegaShaman2" then
			if mission.hadCorpseBeforeOmegaPlasmodia[i] == nil then 
				mission.hadCorpseBeforeOmegaPlasmodia[i] = Board:GetPawn(i):IsCorpse() 
				LOG("storing corpse for "..Board:GetPawn(i):GetMechName())
			end
			Board:GetPawn(i):SetCorpse(true)
		end
	end
	
	return ret
end

OmegaTotemAtk2 = Skill:new{
	Name = "Reviving Secretion",
	Description = "Sacrifice self to launch a projectile that heals 1 HP. Can revive Vek corpses.",
	Damage = -1,
	PathSize = 1,
	Range = RANGE_PROJECTILE,
	Class = "Enemy",
	Icon = "weapons/enemy_firefly1.png",
	Explosion = "",
	LaunchSound = "/enemy/totem_1/attack",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Projectile = "effects/shot_firefly",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Totem1"
	}
}
function OmegaTotemAtk2:GetTargetScore(p1,p2)
	--Omega Spore fires a healing projectile, so we want to prioritize corpses > damaged, and count status effects
	local ret = 0
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2)  
	local pawn = Board:GetPawn(target)
	if pawn and pawn:GetTeam() == TEAM_ENEMY then
		if pawn:IsDead() then ret = 20 
		elseif pawn:IsDamaged() then ret = 5
		end
		if pawn:IsFire() then ret = ret + 2 end
		if pawn:IsAcid() then ret = ret + 2 end
		if pawn:IsFrozen() then ret = ret + 2 end
	else
		ret = -10
	end
	return ret
end

function OmegaTotemAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2)  
	
	local damage = SpaceDamage(target, self.Damage)
	damage.sScript = string.format([[modApi:runLater(function()
		local pawn = Board:GetPawn(%s)
		if pawn and pawn:IsDead() then pawn:SetHealth(1) end
	end)]], target:GetString())
	ret:AddProjectile(damage,self.Projectile)
	ret:AddDamage(SpaceDamage(p1,DAMAGE_DEATH))
	
	return ret
end


OmegaCrabAtk2 = LineArtillery:new{   
	Name = "Staggered Expulsions",
	Description = "Launch artillery attack on 3 tiles for 2 damage (5 tile range).",
	ArtillerySize = 5,
	Explosion = "ExploArt1",
	Damage = 2,
	Type = 2, 
	Class = "Enemy",
	Icon = "weapons/enemy_crab1.png",
	ImpactSound = "/impact/generic/explosion",
	Projectile = "effects/shotup_crab1.png",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,0),
		Building = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Crab1"
	}
}


function OmegaCrabAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	ret:AddQueuedArtillery(SpaceDamage(p2, self.Damage), self.Projectile)
	ret:AddQueuedArtillery(SpaceDamage(p2 - DIR_VECTORS[dir] - DIR_VECTORS[(dir+1)%4], self.Damage), self.Projectile)
	ret:AddQueuedArtillery(SpaceDamage(p2 - DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4], self.Damage), self.Projectile)
	
	return ret
end



OmegaBeetleAtk2 = Skill:new{
	Name = "Explosive Pincers",
	Description = "Charge forward to deal 3 damage and push everything adjacent, dealing 1 self-damage.",
	Damage = 3,
	Class = "Enemy",
	LaunchSound = "/enemy/beetle_1/attack_charge",
	Icon = "weapons/brute_beetle.png",
	PathSize = 1,--just needs to target immediately adjacent locations
	Explosion = "ExploAir1",
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,3),
		Enemy = Point(2,1),
		CustomPawn = "OmegaBeetle2",
	}
}

function OmegaBeetleAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2,PATH_GROUND)
	local doDamage = true
	if not Board:IsBlocked(target,PATH_GROUND) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	if not Board:IsPawnSpace(target) and (Board:GetTerrain(target) == TERRAIN_WATER or Board:GetTerrain(target) == TERRAIN_HOLE) then ---run into water/hole and die!
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	local delay = self.Fire and NO_DELAY or FULL_DELAY
	ret:AddQueuedCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), delay)
	if doDamage then 
		for i = DIR_START, DIR_END do
			local damage = SpaceDamage(target - DIR_VECTORS[direction] + DIR_VECTORS[i], self.Damage, i)
			damage.sAnimation = "exploout2_"..i
			ret:AddQueuedDamage(damage)
		end
		local selfDamage = SpaceDamage(target - DIR_VECTORS[direction], 1)
		selfDamage.sAnimation = "ExploArt2"
		selfDamage.sSound = "/enemy/beetle_1/attack_impact"
		ret:AddQueuedDamage(selfDamage)
	end
	
	return ret
end

OmegaSpiderAtk2 = Skill:new{
	Name = "Hunter's Trap",
	Description = "Web an adjacent target, preparing to strike it, and lays webs on other surrounding tiles. Webs slow down anything that steps into them, and cause adjacent spiders and spiderlings to attack.",
	PathSize = 1,
	Icon = "weapons/enemy_scorpion1.png",	
	Damage = 2,
	Range = 1,
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/scorpion_soldier_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaSpider2"
	}
}

function OmegaSpiderAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	ret:AddDamage(SoundEffect(p2,self.SoundBase.."/attack_web"))
	ret:AddGrapple(p1,p2,"hold")
	
	local damage = SpaceDamage(p2, self.Damage)
	damage.sSound = self.SoundBase.."/attack"
	
	ret:AddQueuedMelee(p1, damage)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if curr ~= p2 and not Board:IsBlocked(curr, PATH_GROUND) then
			local itemSpawn = SpaceDamage(curr)
			itemSpawn.sItem = "OmegaVek_WebItem"
			ret:AddDamage(itemSpawn)
		end
	end
	return ret
end	

merge_table(TILE_TOOLTIPS, { OmegaVek_Web_Text = {"Omega Spider Web", "Triggers attacks of opportunity from adjacent spiders and spiderlings."} } )

local webdamage = SpaceDamage(0)
webdamage.sImageMark  = "combat/icons/noflyingicon.png"
OmegaVek_WebItem = { Image = "effects/omegaspiderwebitem.png", Damage = webdamage, Tooltip = "OmegaVek_Web_Text", Icon = "effects/omegaspiderwebitem.png", UsedImage = ""}
Location["effects/omegaspiderwebitem.png"] = Point(-20,0)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
	ret = SkillEffect()
    if removed_item == "OmegaVek_WebItem" then
        local pawn = Board:GetPawn(loc)
        if pawn then
			local damage = SpaceDamage(loc)
			-- damage.sScript=string.format("Board:GetPawn(%s):SetMoveSpeed(%s)",Board:GetPawn(loc):GetId(), Board:GetPawn(loc):GetMoveSpeed() - 1)
			Board:DamageSpace(damage)
			for i = DIR_START, DIR_END do
				local curr = loc + DIR_VECTORS[i]
				local hunter = Board:GetPawn(curr)
				if hunter and string.find(hunter:GetType(), "Spider") and hunter:GetTeam() ~= pawn:GetTeam() then
					ret:AddMelee(curr, SpaceDamage(loc, 1))
				end
			end
			Board:AddEffect(ret)
        end
    end
end)

OmegaBlobberAtk2 = LineArtillery:new{ 
	Name = "Explosive Growths",
	Description = "Throw a massive blob that cannot act but will explode when killed. On the last turn, will kill all its blobs instead if any are alive.", 
	ScoreNothing = 0, 
	MyPawn = "OmegaBlob2",
	Class = "Enemy",
	Icon = "weapons/enemy_blobber1.png",	
	MyArtillery =  "effects/shotup_blobber2.png",
	ImpactSound = "/impact/generic/blob",
	OnlyEmpty = true,
	Explosion = "",
	TipImage = {
		CustomPawn = "OmegaBlobber2",
		Unit = Point(2,3),
		Target = Point(2,1),
		Second_Origin = Point(2,1),
		Second_Target = Point(2,1),
		Enemy = Point(3,1),
		Enemy2 = Point(2,0),
	}
}

function OmegaBlobberAtk2:GetTargetScore(p1,p2)
	--Omega Spore kills allies on last turn, so it needs help doing that
	local ret = 0
	if GetCurrentMission():IsFinalTurn() then
		for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
			if Board:GetPawn(i):GetType() == "OmegaBlob2" then return 50 end
		end
	else
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:GetTeam() == TEAM_PLAYER then ret = ret + 5 end
			if pawn and pawn:GetTeam() == TEAM_ENEMY and pawn:GetType() ~= "OmegaBlob2" then ret = ret - 5 end	--we don't mind a chain of blobs
			if Board:GetTerrain(curr) == TERRAIN_BUILDING then ret = ret + 5 end
		end
	end
	return ret
end

function OmegaBlobberAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local willDetonate = false
	if GetCurrentMission():IsFinalTurn() then
		for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
			if Board:GetPawn(i):GetType() == "OmegaBlob2" then ret:AddQueuedDamage(SpaceDamage(Board:GetPawn(i):GetSpace(), DAMAGE_DEATH)) willDetonate = true end
		end
	end
	if not willDetonate then 
		local damage = SpaceDamage(p2)
		damage.sPawn = self.MyPawn
		ret:AddArtillery(damage, self.MyArtillery)
		for dir = DIR_START, DIR_END do 
			damage = SpaceDamage(p2 + DIR_VECTORS[dir],0)
			ret:AddDamage(damage)
		end
	end
	return ret
end

local function ClearBlobs(mission)
	for i = 0, 7 do
		for j = 0, 7 do
			local pawn = Board:GetPawn(Point(i,j))
			if pawn and pawn:GetType() == "OmegaBlob2" then
				Board:RemovePawn(pawn)
				Board:AddAnimation(Point(i, j), "Omegablobd", ANIM_NO_DELAY)
			end
		end
	end
end

local function PlasmodiaCorpsifier(mission)
	modApi:conditionalHook(function()
		return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
	end, 
	function()
		for _, i in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
			if Board:GetPawn(i) and Board:GetPawn(i):GetType() == "OmegaShaman2" then 
				for _, j in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
					if Board:GetPawn(j) and not Board:GetPawn(j):IsMinor() then Board:GetPawn(j):SetCorpse(true) end
				end
				break
			end
		end
		-- if mission.hadCorpseBeforeOmegaPlasmodia ~= nil then
			-- for _, id in ipairs(extract_table(mission.hadCorpseBeforeOmegaPlasmodia)) do
				-- if Board:GetPawn(id) then Board:GetPawn(id):SetCorpse(mission.hadCorpseBeforeOmegaPlasmodia[id]) end
			-- end
		-- end
	end)
end

local function EVENT_onModsLoaded()
	modApi:addMissionEndHook(ClearBlobs)
	modApi:addPostLoadGameHook(PlasmodiaCorpsifier)
end
modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)