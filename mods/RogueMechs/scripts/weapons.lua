RMMechPunchAtk1 = Skill:new {
	Name = "Titan Fist",
	Description = "Punch an adjacent tile, damaging and pushing it.",
	Damage = 2,
	PathSize = 1,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "RMMechPunch2",
	}
}

function RMMechPunchAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	damage = SpaceDamage(p2,self.Damage, direction)
	damage.sAnimation = "explopunch1_"..direction
	ret:AddQueuedMelee(p1, damage)
	return ret
end

RMMechPunchAtk2 = Skill:new {
	Name = "Titan Fist",
	Description = "Punch an adjacent tile, damaging and pushing it.",
	Damage = 4,
	PathSize = 1,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "RMMechPunch2",
	}
}

function RMMechPunchAtk2:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local doDamage = true
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "explopunch1_"..direction
	if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	ret:AddQueuedCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)
	if doDamage then
		damage.loc = target
		-- ret:AddQueuedMelee(target - DIR_VECTORS[direction], damage)
		ret:AddQueuedDamage(damage)
	end
	return ret
end

RMVortexFist = Skill:new {
	Name = "Vortex Fist",
	Description = "Damage and push all adjacent tiles to the left.",
	Damage = 3,
	PathSize = 1,
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,4),
		Enemy2 = Point(2,2),
		Enemy3 = Point(1,3),
		Enemy4 = Point(3,3),
		Target = Point(2,3),
		CustomPawn = "RMMechPunch2",
	}
}

function RMVortexFist:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function RMVortexFist:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local damage = SpaceDamage(p1 + DIR_VECTORS[i] ,self.Damage, (i-1)%4)
		damage.sAnimation = "explopunch1_"..(i-1)%4
		ret:AddQueuedDamage(damage)
	end
	return ret
end



RMMechDStrikeAtk1 = LineArtillery:new {
	Name = "Cluster Artillery",
	Description = "Damage and push tiles adjacent to a target.",
	Damage = 1,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "RMMechDStrike0",
	}
}

function RMMechDStrikeAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage, i)
		ret:AddQueuedArtillery(damage, "effects/shotup_guided_missile.png", NO_DELAY)
	end
	return ret
end

RMMechDStrikeAtk2 = RMMechDStrikeAtk1:new {
	Name = "Cluster Artillery",
	Description = "Damage and push tiles adjacent to a target.",
	Damage = 2,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "RMMechDStrike1",
	}
}



RMMissileBarrage = Skill:new {
	Name = "Cluster Artillery",
	Description = "Fires a missile barrage that hits every mech on the map.",
	Damage = 2,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "RMMechDStrike1",
	}
}

function RMMissileBarrage:GetTargetArea(point)
	ret = PointList()
	ret:push_back(point)
	return ret
end

function RMMissileBarrage:GetSkillEffect(p1, p2)
	local ret = SkillEffect()	
	for i = 0, 2 do
		ret:AddQueuedSound("/weapons/boulder_throw")
		local damage = SpaceDamage(Board:GetPawn(i):GetSpace(), self.Damage)
		damage.sAnimation = "ExploAir1"
		damage.bHidePath = true
		ret:AddQueuedArtillery(damage, "effects/shotup_missileswarm.png", 0.1)
	end
	
	return ret
end



RMMechLaserAtk1 = LaserDefault:new{
	Name = "Burst Beam",
	Description = "Fire a piercing beam that decreases in damage the further it goes.",
	Class = "Enemy",
	PathSize = 1,
	Damage = 3,
	Range = 1,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Building = Point(2,0),
		CustomPawn = "RMMechLaser0",
	}
}

function RMMechLaserAtk1:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end

function RMMechLaserAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	self:AddQueuedLaser(ret, target, direction)
	return ret
end

RMMechLaserAtk2 = RMMechLaserAtk1:new{
	Name = "Burst Beam",
	Description = "Fire a piercing beam that decreases in damage the further it goes.",
	Class = "Enemy",
	PathSize = 1,
	Damage = 4,
	Range = 1,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Building = Point(2,0),
		CustomPawn = "RMMechLaser1",
	}
}



RMTitaniteBlade = Skill:new{  
	Name = "Titanite Blade",
	Description = "Swing a massive sword to damage and push 3 tiles.",
	Class = "Enemy",
	Icon = "weapons/prime_sword.png",
	Rarity = 1,
	PathSize = 1,
	Damage = 4,
	Push = 1,
	LaunchSound = "/weapons/sword",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "RMMechLaser1",
	}
}

function RMTitaniteBlade:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	ret:AddQueuedSound(self.LaunchSound)
	ret:AddQueuedDamage(SpaceDamage(p2 + DIR_VECTORS[(direction + 1)% 4], self.Damage, direction))
	ret:AddQueuedDamage(SpaceDamage(p2 - DIR_VECTORS[(direction + 1)% 4], self.Damage, direction))
	local centerdamage = SpaceDamage(p2, self.Damage, direction)
	centerdamage.sAnimation = "explosword_"..direction
	ret:AddQueuedDamage(centerdamage)
	
	return ret
end	



RMMechChargeAtk1 = Skill:new{
	Class = "Enemy",
	Icon = "weapons/brute_beetle.png",	
	Name = "Ramming Engines",
	Description = "Dash in a line and slam into the target, pushing it and hurting yourself.",
	Rarity = 3,
	Explosion = "ExploAir1",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 1,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "RMMechCharge1",
	}
}
			
function RMMechChargeAtk1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local doDamage = true
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "ExploAir2"
	damage.sSound = self.ImpactSound
	if distance == 1 and doDamage then
		ret:AddQueuedMelee(p1,damage, NO_DELAY)
		if doDamage then ret:AddQueuedDamage(SpaceDamage( target - DIR_VECTORS[direction] , self.SelfDamage)) end
	else
		ret:AddQueuedCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)
		local temp = p1 
		while temp ~= target  do 
			ret:AddQueuedBounce(temp,-3)
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then ret:AddQueuedDelay(0.06) end
		end
		if doDamage then
			ret:AddQueuedDamage(damage)
			ret:AddQueuedDamage(SpaceDamage( target - DIR_VECTORS[direction] , self.SelfDamage))
		end
	end
	return ret
end

RMMechChargeAtk2 = RMMechChargeAtk1:new{
	Class = "Enemy",
	Icon = "weapons/brute_beetle.png",	
	Name = "Ramming Engines",
	Description = "Dash in a line and slam into the target, pushing it and hurting yourself.",
	Rarity = 3,
	Explosion = "ExploAir1",
	Push = 1,--TOOLTIP HELPER
	Damage = 4,
	SelfDamage = 2,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "RMMechCharge1",
	}
}



RMShrapnelCannon = TankDefault:new	{
	Name = "Shrapnel Cannon",
	Description = "Shoot a projectile that damages and pushes the targeted tile and the tiles to its left and right.",
	Class = "Enemy",
	Icon = "weapons/brute_splitshot.png",
	Explosion = "ExploAir1",
	Sound = "/general/combat/explode_small",
	Damage = 3,
	Push = 1,
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(1,1),
		Enemy3 = Point(3,1),
		Target = Point(2,1),
		CustomPawn = "RMMechCharge1",
	},
}
			
function RMShrapnelCannon:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2)  
	local damage = SpaceDamage(target, self.Damage, dir)
	damage.sAnimation = "explopush2_"..dir
	ret:AddQueuedProjectile(damage, self.ProjectileArt)
	damage = SpaceDamage(target+DIR_VECTORS[(dir-1)%4], self.Damage, (dir-1)%4)
	damage.sAnimation = "explopush2_"..((dir-1)%4)
	ret:AddQueuedDamage(damage)
	damage = SpaceDamage(target+DIR_VECTORS[(dir+1)%4], self.Damage, (dir+1)%4)
	damage.sAnimation = "explopush2_"..((dir+1)%4)
	ret:AddQueuedDamage(damage)
	return ret
end



RMMechGuardAtk1 = Skill:new{  
	Class = "Enemy",
	Name = "Spartan Shield",
	Description = "Bash the enemy, flipping its attack direction.",
	Icon = "weapons/prime_punchmech.png",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/weapons/shield_bash",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 2,
	Shield = false,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "RMMechGuard1",
	},
}
				
function RMMechGuardAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage, DIR_FLIP)
	damage.sAnimation = "SwipeClaw2"
	if self.Shield then
		local shield = SpaceDamage(p1,0)
		shield.iShield = EFFECT_CREATE
		ret:AddQueuedDamage(shield)
	end
	ret:AddQueuedMelee(p1, damage)
	return ret
end	

RMMechGuardAtk2 = RMMechGuardAtk1:new{  
	Class = "Enemy",
	Name = "Spartan Shield",
	Description = "Bash the enemy, flipping its attack direction.",
	Icon = "weapons/prime_punchmech.png",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/weapons/shield_bash",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 3,
	ScoreNothing = 1,	--that way, if the mech has nothing to do, it will shield itself
	Shield = true,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "RMMechGuard1",
	},
}



RMPrimeSpear = Skill:new{  
	Class = "Prime",
	Icon = "weapons/prime_spear.png",
	Name = "Prime Spear",
	Description = "Stab up to three tiles and push the furthest hit tile.",
	Explosion = "",
	Range = 3, 
	PathSize = 3,
	Damage = 2,
	Push = 1,
	Acid = 1,
	LaunchSound = "/weapons/sword",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "RMMechGuard1",
	}
}

function RMPrimeSpear:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) then break end
		end
	end
	
	return ret
end
				
function RMPrimeSpear:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)

	for i = 1, distance do
		local push = (i == distance) and direction or DIR_NONE
		local damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,self.Damage, push)
		if i == distance then damage.iAcid = self.Acid end
		if i == 1 then damage.sAnimation = "explospear"..distance.."_"..direction end
		ret:AddQueuedDamage(damage)
	end

	return ret
end	



RMMechMirrorAtk1 = Skill:new{
	Class = "Enemy",
	Name = "Janus Cannon",
	Description = "Fire two projectiles in opposite directions.",
	Icon = "weapons/brute_mirror.png",
	Sound = "/general/combat/explode_small",
	Damage = 1,
	Push = 1,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/mirror_shot",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(4,2),
		Target = Point(1,2),
		CustomPawn = "RMMechMirror1",
	}
}

function RMMechMirrorAtk1:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+DIR_VECTORS[i])
	end
	return ret
end

function RMMechMirrorAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local backdir = GetDirection(p1 - p2)
			
	local target = GetProjectileEnd(p1,p1 + DIR_VECTORS[dir])  
	local damage = SpaceDamage(target, self.Damage, dir)
	
	ret:AddQueuedProjectile(damage, "effects/shot_mechtank", NO_DELAY)
	local target2 = GetProjectileEnd(p1,p1 + DIR_VECTORS[backdir])

	if target2 ~= p1 then
		damage = SpaceDamage(target2, self.Damage, backdir)
		ret:AddQueuedProjectile(damage, "effects/shot_mechtank")
	end
		
	return ret
end

RMMechMirrorAtk2 = RMMechMirrorAtk1:new{
	Class = "Enemy",
	Name = "Janus Cannon",
	Description = "Fire two projectiles in opposite directions.",
	Icon = "weapons/brute_mirror.png",
	Sound = "/general/combat/explode_small",
	Damage = 3,
	Push = 1,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/mirror_shot",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(4,2),
		Target = Point(1,2),
		CustomPawn = "RMMechMirror1",
	}
}



RMIceGenerator = Skill:new{
	Class = "Enemy",
	Name = "Ice Generator",
	Description = "Freeze yourself and nearby tiles.",
	Icon = "weapons/brute_mirror.png",
	Sound = "/general/combat/explode_small",
	LaunchSound = "/weapons/mirror_shot",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	ScoreBuilding = -10,
	ScoreFriendly = 5,
	ScoreEnemy = 5,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(4,2),
		Target = Point(1,2),
		CustomPawn = "RMMechMirror1",
	}
}

function RMIceGenerator:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function RMIceGenerator:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p1, 3))
	for k = 1, #targets do
		local freeze = SpaceDamage(targets[k])
		freeze.iFrozen = 1
		ret:AddQueuedDamage(freeze)
	end
	return ret
end

function RMIceGenerator:GetTargetScore(p1,p2)
	local targets = extract_table(general_DiamondTarget(p1, 3))
	local score = self.ScoreFriendly	--self-freeze is good
	for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if Board:IsBuilding(targets[k]) then 
			score = score + self.ScoreBuilding
		elseif pawn and pawn:GetTeam() == TEAM_ENEMY and not pawn:IsQueued() and not pawn:IsDead() then 
			score = score - self.ScoreFriendly	--we want them to act first, then get frozen
		elseif pawn and pawn:GetTeam() == TEAM_PLAYER and not pawn:IsDead() then
			score = score + self.ScoreEnemy
		end
	end
	return score
end



RMMechDispersalAtk1 = Skill:new{ 
	Class = "Enemy",
	Name = "Thermal Disperser",
	Description = "Damage up to two or more tiles in a line and push tiles to the left and right of damaged tiles.",
	Icon = "advanced/weapons/Prime_Flamespreader.png",
	Explosion = "",
	PathSize = 2,
	Damage = 1,
	Fire = 0,
	Push = 1,
	LaunchSound = "/weapons/flamespreader",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		CustomPawn = "RMMechDispersal1",
	},
}

function RMMechDispersalAtk1:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) then break end
		end
	end
	return ret
end
				
function RMMechDispersalAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	
	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[direction]*i
		local adj1 = curr + DIR_VECTORS[(direction+1)%4]
		local adj2 = curr + DIR_VECTORS[(direction-1)%4]
		local damage = SpaceDamage(curr,self.Damage)
		damage.iFire = self.Fire
		if i == distance then 	
			damage.sAnimation = "flamethrower"..distance.."_"..direction 
		end
		ret:AddQueuedDamage(damage)
		--Push left and right of area affected
		local damagepush = SpaceDamage(adj1,0,(direction+1)%4)
		damagepush.sAnimation = "airpush_"..((direction+1)%4)
		ret:AddScript(string.format("Board:SetDangerous(%s)", adj1:GetString()))
		ret:AddQueuedDamage(damagepush)
		damagepush = SpaceDamage(adj2,0,(direction-1)%4)
		damagepush.sAnimation = "airpush_"..((direction-1)%4)
		ret:AddScript(string.format("Board:SetDangerous(%s)", adj2:GetString()))
		--otherwise Vek will move into the push tile and get pushed
		ret:AddQueuedDamage(damagepush)
		ret:AddQueuedBounce(p1 + DIR_VECTORS[direction]*i,2)
	end
	return ret
end	

function RMMechDispersalAtk1:GetTargetScore(p1, p2)
	local dist = p1:Manhattan(p2)
	local dir = GetDirection(p2-p1)
	local score = 0
	for i = 1, dist do
		local curr = p1 + DIR_VECTORS[dir] * i
		if Board:IsBuilding(curr) then score = score + 5 end
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER then score = score + 5
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then score = score - 5
		if Board:GetPawn(curr + DIR_VECTORS[(dir+1)%4]) and not Board:GetPawn(curr + DIR_VECTORS[(dir+1)%4]):IsGuarding() and
		(Board:GetPawn(curr + DIR_VECTORS[(dir+1)%4] * 2) and Board:GetPawn(curr + DIR_VECTORS[(dir+1)%4] * 2):GetTeam() == TEAM_PLAYER) or 
		Board:IsBuilding(curr + DIR_VECTORS[(dir+1)%4] * 2) then
			score = score + 5 end
		end
		if Board:GetPawn(curr + DIR_VECTORS[(dir-1)%4]) and not Board:GetPawn(curr + DIR_VECTORS[(dir-1)%4]):IsGuarding() and
		(Board:GetPawn(curr + DIR_VECTORS[(dir-1)%4] * 2) and Board:GetPawn(curr + DIR_VECTORS[(dir-1)%4] * 2):GetTeam() == TEAM_PLAYER) or 
		Board:IsBuilding(curr + DIR_VECTORS[(dir-1)%4] * 2) then
			score = score + 5 end
		end
	end
	return score
end

RMMechDispersalAtk2 = RMMechDispersalAtk1:new{ 
	Class = "Enemy",
	Name = "Thermal Disperser",
	Description = "Damage up to two or more tiles in a line and push tiles to the left and right of damaged tiles.",
	Icon = "advanced/weapons/Prime_Flamespreader.png",
	Explosion = "",
	PathSize = 4,
	Damage = 1,
	Fire = 1,
	Push = 1,
	LaunchSound = "/weapons/flamespreader",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		CustomPawn = "RMMechDispersal1",
	},
}

RMRepairDrop = Skill:new{ 
	Class = "Enemy",
	Name = "Repair Drop",
	Description = "Heals all Rogue Mechs to full health. Single use.",
	Icon = "advanced/weapons/Prime_Flamespreader.png",
	LaunchSound = "/weapons/flamespreader",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		CustomPawn = "RMMechDispersal1",
	},
}

function RMRepairDrop:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function RMRepairDrop:GetSkillEffect(p1, p2)
	local mission = GetCurrentMission()
	local ret = SkillEffect()
	if Board:GetPawn(mission.Target1) then
		ret:AddAirstrike(Board:GetPawn(mission.Target1):GetSpace(),"units/mission/drone_1.png")
		ret:AddDamage(SpaceDamage(Board:GetPawn(mission.Target1):GetSpace(),-10))
	end
	if Board:GetPawn(mission.Target2) then
		ret:AddAirstrike(Board:GetPawn(mission.Target2):GetSpace(),"units/mission/drone_1.png")
		ret:AddDamage(SpaceDamage(Board:GetPawn(mission.Target2):GetSpace(),-10))
	end
	if Board:GetPawn(mission.Target3) then
		ret:AddAirstrike(Board:GetPawn(mission.Target3):GetSpace(),"units/mission/drone_1.png")
		ret:AddDamage(SpaceDamage(Board:GetPawn(mission.Target3):GetSpace(),-10))
	end
	return ret
end	


function RMRepairDrop:GetTargetScore(p1, p2)
	local mission = GetCurrentMission()
	local RM1 = Board:GetPawn(mission.Target1)
	local RM2 = Board:GetPawn(mission.Target2)
	local RM3 = Board:GetPawn(mission.Target3)
	local score = 0
	if RM1 then
		if RM1:IsDead() then 
			score = score + 10 
		elseif RM1:IsDamaged() then 
			score = score + RM1:GetMaxHealth() - RM1:GetHealth()
		end
	end
	if RM2 then
		if RM2:IsDead() then 
			score = score + 10 
		elseif RM2:IsDamaged() then 
			score = score + RM2:GetMaxHealth() - RM2:GetHealth()
		end
	end
	if RM3 then
		if RM3:IsDead() then 
			score = score + 10 
		elseif RM3:IsDamaged() then 
			score = score + RM3:GetMaxHealth() - RM3:GetHealth()
		end
	end
	return score
end




RMMechBulkAtk1 = Skill:new{
	Class = "Enemy",
	Name = "Ricochet Rocket",
	Description = "Bounce a projectile off one target to hit another, pushing each.",
	Icon = "weapons/brute_mirror.png",
	Sound = "/general/combat/explode_small",
	Damage = 1,
	Push = 1,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/mirror_shot",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(4,2),
		Target = Point(1,2),
		CustomPawn = "RMMechBulk1",
	}
}

SkillEffect["AddQueuedProjectileFromLoc"] = function(self, origin, damage, graphics, delay) -- add our own queued projectile that can start from anywhere
	local fx = SkillEffect()
	fx["AddProjectile"](fx, origin, damage, graphics, delay)
	self.q_effect:AppendAll(fx.effect)
end

function RMMechBulkAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1, p1 + DIR_VECTORS[dir])  

	local damage = SpaceDamage(target, self.Damage, dir)
	ret:AddQueuedProjectile(damage, "effects/shot_mechtank", PROJ_DELAY)
	local target2 = GetProjectileEnd(target, target + DIR_VECTORS[(dir+1)%4])

	if target2 and target2 ~= target then
		local damage2 = SpaceDamage(target2, self.Damage, (dir+1)%4)
		ret:AddQueuedProjectileFromLoc(target, damage2, "effects/shot_mechtank", NO_DELAY)
	end
	ret:AddQueuedDamage(SpaceDamage(p1, 1))
	return ret
end

RMMechBulkAtk2 = RMMechBulkAtk1:new{
	Class = "Enemy",
	Name = "Ricochet Rocket",
	Description = "Bounce a projectile off one target to hit another, pushing each.",
	Icon = "weapons/brute_mirror.png",
	Sound = "/general/combat/explode_small",
	Damage = 2,
	Push = 1,
	PathSize = INT_MAX,
	LaunchSound = "/weapons/mirror_shot",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(4,2),
		Target = Point(1,2),
		CustomPawn = "RMMechBulk1",
	}
}



RMEMRailgun = TankDefault:new{  
	Class = "Enemy",
	Name = "EM Railgun",
	Description = "Pierces through killed enemies and destroyed buildings.",
	Icon = "advanced/weapons/Brute_KO_Combo.png",
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	KOSound = "/weapons/brute_ko_combo",
	ProjectileArt = "effects/shot_quickfire",
	Exploart = "explopush1_",
	ExploKO = "ExploAir2",
	PowerCost = 0,
	Damage = 2,
	OnKill = "Brute_KO_Combo_OnKill",
	Limited = 1,
	Upgrades = 4,
	UpgradeCost = {1,1},
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Enemy1= Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
		CustomEnemy = "Digger1",
		CustomPawn = "RMMechBulk1",
	},
}

function RMEMRailgun:GetTargetArea(point)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do
		local curr = Point(point + DIR_VECTORS[dir])
		ret:push_back(curr)
	end
		
	return ret
end

function RMEMRailgun:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local last_origin = p1
	local curr = p1 + DIR_VECTORS[direction]
			
	while true do
		local target = curr
		if not Board:IsBlocked(curr,PATH_PROJECTILE) and Board:IsValid(curr + DIR_VECTORS[direction]) then
			target = GetProjectileEnd(curr,curr + DIR_VECTORS[direction],PATH_PROJECTILE)
		end
		
		local damage = SpaceDamage(target, self.Damage)
		damage.bKO_Effect = Board:IsDeadly(damage,Pawn) or Board:IsBuilding(target)
		
		local animation = damage.bKO_Effect and self.ExploKO or self.Exploart..direction
		
		ret:AddQueuedProjectileFromLoc(last_origin, damage, self.ProjectileArt, FULL_DELAY)
		ret:AddQueuedAnimation(damage.loc,animation,ANIM_NO_DELAY)
		if not damage.bKO_Effect then break end
		
		-- ret:AddSound(self.KOSound)
		last_origin = target
		curr = target + DIR_VECTORS[direction]
	end
	
	return ret	
end



RMMechTrimissileAtk1 = ArtilleryDefault:new{
	Name = "Tri-Rocket",
	Description = "Damage and push 3 tiles in a line.",
	Class = "Enemy",
	Icon = "advanced/weapons/Ranged_Crack.png",
	Explosion = "",
	Damage = 1,
	LaunchSound = "/weapons/ranged_crack",
	ImpactSound = "",
	--ImpactSound = "/weapons/ranged_crack",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(2,2),
		CustomPawn = "RMMechTrimissile1",
	},
}		

function RMMechTrimissileAtk1:GetSkillEffect(p1, p2)	
	local ret = SkillEffect()
	
	local dir = GetDirection(p2 - p1)
	
	ret:AddQueuedBounce(p1, 3)
	 
	local damage = SpaceDamage(p2 + DIR_VECTORS[dir], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	damage.bHidePath = true
	damage.sSound = "impact/generic/explosion_multiple"
	ret:AddQueuedArtillery(damage,"effects/shotup_tricrack.png", NO_DELAY)
	ret:AddQueuedDelay(0.15)
	
	damage = SpaceDamage(p2, self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	damage.bHidePath = false
	ret:AddQueuedArtillery(damage,"effects/shotup_tricrack.png", NO_DELAY)
	ret:AddQueuedDelay(0.15)
	
	damage = SpaceDamage(p2 - DIR_VECTORS[dir], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	damage.bHidePath = true
	ret:AddQueuedArtillery(damage,"effects/shotup_tricrack.png", NO_DELAY)
	ret:AddQueuedDelay(0.5)
	ret:AddQueuedBounce(p2+DIR_VECTORS[dir], 2)
	ret:AddQueuedBounce(p2, 2)
	ret:AddQueuedBounce(p2-DIR_VECTORS[dir], 2)
	return ret
end		

RMMechTrimissileAtk2 = RMMechTrimissileAtk1:new{
	Name = "Tri-Rocket",
	Description = "Damage and push 3 tiles in a line.",
	Class = "Enemy",
	Icon = "advanced/weapons/Ranged_Crack.png",
	Explosion = "",
	Damage = 2,
	LaunchSound = "/weapons/ranged_crack",
	ImpactSound = "",
	--ImpactSound = "/weapons/ranged_crack",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(2,2),
		--Enemy3 = Point(1,1),
		CustomPawn = "RMMechTrimissile1",
	},
}	

RMHeavyArtillery = ArtilleryDefault:new{
	Name = "Heavy Artillery",
	Description = "Powerful attack that damages a large area.",
	Class = "Enemy",
	Icon = "weapons/ranged_wide.png",
	Rarity = 1,
	Explosion = "ExploArt2",
	Damage = 2,
	SelfDamage = 0,
	Push = 0,--TOOLTIP INFO
	BuildingDamage = true,
	Cost = "med",
	BounceAmount = 2,
	PowerCost = 0, --AE Change
	Limited = 1,
	LaunchSound = "/weapons/wide_shot",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Target = Point(2,1),
		CustomPawn = "RMMechTrimissile1",
	}
}		

function RMHeavyArtillery:GetSkillEffect(p1, p2)	
	local ret = SkillEffect()
	
	ret:AddQueuedBounce(p1, 1)
	local damage = SpaceDamage(p2,self.Damage)
	if not self.BuildingDamage and Board:IsBuilding(p2) then	
		damage.iDamage = 0
	end
	ret:AddQueuedArtillery(damage,"effects/shot_artimech.png", NO_DELAY)
	
	for i = DIR_START, DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[i],  self.Damage)
		damage.bHidePath = true
		ret:AddQueuedArtillery(damage,"effects/shot_artimech.png", NO_DELAY)--AddDamage(damage)
	end
	ret:AddDelay(0.7)
	ret:AddQueuedBounce(p2, self.BounceAmount)
	for i = DIR_START, DIR_END do  -- NOT IDEAL....
		ret:AddQueuedBounce(p2 + DIR_VECTORS[i], self.BounceAmount)
	end
	return ret
end		



RMMechNeedleAtk1 = Skill:new{
	Name = "Reverse Thrusters",
	Description = "Smoke and deal damage to a tile while dashing away.",
	Class = "Enemy",
	Icon = "advanced/weapons/Brute_KickBack.png",
	Range = 2,
	SelfDamage = 1,
	AnimDelay = 0.2,
	ScoreFriendlyDamage = -2,	--deals self-damage a lot
	BombSound = "/impact/generic/explosion",
	LaunchSound = "/weapons/bomb_strafe",
	ImpactSound = "/impact/generic/explosion",
	TipDamageCustom = "Brute_KickBack_DamageTip",
	TipImage = {
		Unit = Point(2,1),
		Enemy = Point(2,0),
		Target = Point(2,0),
		Building = Point(2,3),
		CustomPawn = "RMMechNeedle1",
	},
}

function RMMechNeedleAtk1:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if not Board:IsBlocked(point + DIR_VECTORS[(i+2)%4], PATH_PROJECTILE) then ret:push_back(curr) end
	end
	return ret
end

function RMMechNeedleAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local backdir = GetDirection(p1 - p2)
	local move = PointList()
	move:push_back(p1)
	local curr = p1 + DIR_VECTORS[backdir]
	while p1:Manhattan(curr) <= self.Range and not Board:IsBlocked(curr + DIR_VECTORS[backdir], PATH_PROJECTILE) do
		move:push_back(curr)
		curr = curr + DIR_VECTORS[backdir]
	end
	move:push_back(curr)
	local distance = p1:Manhattan(curr)
	
	ret:AddQueuedBounce(p2,3)
	local damage = SpaceDamage(p2, distance)
	damage.iSmoke = 1
	damage.sSound = self.BombSound
	--damage.sAnimation = self.AttackAnimation
	ret:AddQueuedDamage(damage)
	
	damage = SpaceDamage(p1,self.SelfDamage)
	damage.sAnimation = "explopush2_"..backdir
	ret:AddQueuedDamage(damage)  -- Damage self 1
	
	ret:AddQueuedCharge(move, FULL_DELAY)
	-- if p1:Manhattan(curr) < self.Range and Board:IsBlocked(curr + DIR_VECTORS[dir], PATH_PROJECTILE) then 
		-- local damageMelee = SpaceDamage(curr + DIR_VECTORS[backdir], 1)
		-- damageMelee.bHide = true
		-- ret:AddQueuedMelee(curr, damageMelee)
		-- local selfDamage = SpaceDamage(curr, 1)
		-- selfDamage.bHide = true
		-- ret:AddQueuedDamage(selfDamage)
		-- weaponPreview:AddDamage(SpaceDamage(curr, 0, backdir))
	-- end
	return ret
end

RMMechNeedleAtk2 = RMMechNeedleAtk1:new{
	Name = "Reverse Thrusters",
	Description = "Smoke and deal damage to a tile while dashing away.",
	Class = "Enemy",
	Icon = "advanced/weapons/Brute_KickBack.png",
	Range = 4,
	SelfDamage = 1,
	AnimDelay = 0.2,
	Smoke = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = {1,3},
	BombSound = "/impact/generic/explosion",
	LaunchSound = "/weapons/bomb_strafe",
	ImpactSound = "/impact/generic/explosion",
	TipDamageCustom = "Brute_KickBack_DamageTip",
	TipImage = {
		Unit = Point(2,1),
		Enemy = Point(2,0),
		Target = Point(2,2),
		Building = Point(2,3),
		CustomPawn = "RMMechNeedle1",
	},
}


RMAstraBombs = Skill:new{
	Name = "Astra Bombs",
	Description = "Leap over any distance dropping a bomb on each tile you pass.",
	Class = "Brute",
	Icon = "weapons/brute_jetmech.png",
	Rarity = 3,
	AttackAnimation = "ExploRaining1",
	Sound = "/general/combat/stun_explode",
	MinMove = 2,
	Range = 8,
	Damage = 3,
	AnimDelay = 0.2,
	LaunchSound = "/weapons/bomb_strafe",
	BombSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,1),
		CustomPawn = "RMMechNeedle1",
	}
}

function RMAstraBombs:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = self.MinMove, self.Range do
			if not Board:IsBlocked(DIR_VECTORS[i]*k + point, PATH_PROJECTILE) then
				ret:push_back(DIR_VECTORS[i]*k + point)
			end
		end
	end
	
	return ret
end

function RMAstraBombs:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	
	local distance = p1:Manhattan(p2)
	
	ret:AddBounce(p1,2)
	if distance == 1 then
		ret:AddQueuedCharge(move, 0.5)--small delay between move and the damage, attempting to make the damage appear when jet is overhead
	else
		ret:AddQueuedCharge(move, 0.25)
	end
		
	for k = 1, (self.Range-1) do
		
		if p1 + DIR_VECTORS[dir]*k == p2 then break end
		
		local damage = SpaceDamage(p1 + DIR_VECTORS[dir]*k, self.Damage)
		damage.sAnimation = self.AttackAnimation
		damage.sSound = self.BombSound
		
		if k ~= 1 then ret:AddDelay(self.AnimDelay) end
		
		ret:AddDamage(damage)
		
		ret:AddBounce(p1 + DIR_VECTORS[dir]*k,3)
	end
	
	return ret
end




RMMechMinerAtk1 = Deployable:new{
	Name = "Bomb Dispenser",
	Description = "Launch a Walking Bomb. Unused bombs dismantle after the enemy turn.",
	Deployed = "RMBombling",
	Icon = "advanced/weapons/Ranged_DeployBomb.png",
	Projectile = "advanced/effects/shotup_bombling.png",
	Class = "Ranged",
	PowerCost = 0,
	DeployCount = 1,
	Limited = 0,
	LaunchSound = "/weapons/bombling_throw",
	ImpactSound = "/impact/generic/bombling_land",
	ScoreNothing = 5,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,0),
		Enemy2 = Point(3,1),
		CustomPawn = "RMMechMiner1",
	},
}

function RMMechMinerAtk1:GetTargetArea(point)	
	local ret = PointList()	
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if not (Board:IsBlocked(curr, PATH_GROUND) or Board:IsFire(curr)) then ret:push_back(curr) end
		end
	end
	return ret
end		

function RMMechMinerAtk1:GetSkillEffect(p1, p2)	
	local ret = SkillEffect()	
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2)
	damage.sPawn = self.Deployed
	ret:AddBounce(p1, 2)
	local delay = PROJ_DELAY
	if self.DeployCount == 2 then delay = NO_DELAY end
	ret:AddArtillery(damage,self.Projectile, delay)
	if self.DeployCount == 2 and not Board:IsBlocked(p2 + DIR_VECTORS[dir], PATH_PROJECTILE) then
		damage.loc = p2 + DIR_VECTORS[dir]
		ret:AddArtillery(damage,self.Projectile, PROJ_DELAY)
	end
	ret:AddBounce(p2, 3)
	if self.DeployCount == 2 and not Board:IsBlocked(p2 + DIR_VECTORS[dir], PATH_PROJECTILE) then ret:AddBounce(p2 + DIR_VECTORS[dir], 3) end
	return ret
end		

RMMechMinerAtk2 = RMMechMinerAtk1:new{
	Name = "Bomb Dispenser",
	Description = "Launch a Walking Bomb. Unused bombs dismantle after the enemy turn.",
	Deployed = "RMBombling",
	Icon = "advanced/weapons/Ranged_DeployBomb.png",
	Projectile = "advanced/effects/shotup_bombling.png",
	Class = "Ranged",
	PowerCost = 0,
	DeployCount = 2,
	Limited = 0,
	LaunchSound = "/weapons/bombling_throw",
	ImpactSound = "/impact/generic/bombling_land",
	ScoreNothing = 5,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,0),
		Enemy2 = Point(3,1),
		CustomPawn = "RMMechMiner1",
	},
}

RMBombling = Pawn:new{
	Name = "Bombling",
	Health = 1,
	MoveSpeed = 3,
	Image = "RMBombling",
	-- TempUnit = true,
	SkillList = { "RMBomblingAtk" },
	SoundLocation = "/mech/distance/bombling/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_METAL,
	Corpse = false,
	Minor = true,
	Portrait = "enemy/pilot",
}
RMBomblingAtk = Skill:new{
	Damage = 1,
	LaunchSound = "/weapons/shrapnel",
	Icon = "weapons/support_destruct.png",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,2),
		Target = Point(2,2),
		CustomPawn = "DeployUnit_Bomby",
	--	Building1 = Point(2,3),
	}
}
function RMBomblingAtk:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for i = DIR_START, DIR_END do
		ret:push_back(p1 + DIR_VECTORS[i])
	end
	return ret
end
function RMBomblingAtk:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddQueuedDamage(SpaceDamage(p1, DAMAGE_DEATH))
	for i = DIR_START, DIR_END do
		local damage = SpaceDamage(p1 + DIR_VECTORS[i], 1)
		damage.sAnimation = "exploout1_"..i
		ret:AddQueuedDamage(damage)
	end
	return ret
end


RMRainingDeath = LineArtillery:new{
	ArtillerySize = 7,
	Class = "Enemy",
	UpShot = "effects/shotup_ignite_fireball.png",
	Damage = 2,
	LineDamage = 1,
	Explosion = "",
	LaunchSound = "/weapons/raining_volley",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(2,0),
		Target = Point(2,0),
		Building = Point(2,1),
		CustomPawn = "RMMechMiner1",
	}
}

function RMRainingDeath:GetTargetArea(point)	
	local ret = PointList()	
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end		

function RMRainingDeath:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
		
	local damage = SpaceDamage(p2,self.Damage)
	damage.sAnimation = "ExploArt2"
	ret:AddQueuedArtillery(damage, self.UpShot, 0.1) --NO_DELAY
	
	local target = p1 + DIR_VECTORS[dir]
	while Board:IsValid(target) and target ~= p2 do 
		damage = SpaceDamage(target,self.LineDamage)
		damage.fDelay = 0.25
		damage.sAnimation = "ExploRainingB"
		damage.sSound = "/weapons/raining_volley_tile"
		ret:AddQueuedDamage(damage)
		target = target + DIR_VECTORS[dir]
	end
	
	return ret
end


RMMechElecAtk1 = Skill:new{
	Name = "Electric Whip",
	Description = "Chain damage through adjacent targets.",
	Class = "Enemy",
	Explosion = "",
	LaunchSound = "/weapons/electric_whip",
	Icon = "weapons/prime_lightning.png",
	PathSize = 1,
	Damage = 2,
	FriendlyDamage = true,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,1),
		CustomPawn = "RMMechElec1",
	}
}

function RMMechElecAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,self.Damage)
	local hash = function(point) return point.x + point.y*10 end
	local explored = {[hash(p1)] = true}
	local todo = {p2}
	local origin = { [hash(p2)] = p1 }
	
	if Board:IsPawnSpace(p2) or Board:IsBuilding(p2) then
		ret:AddQueuedAnimation(p1,"Lightning_Hit")
	end
	
	while #todo ~= 0 do
		local current = pop_back(todo)
		
		if not explored[hash(current)] then
			explored[hash(current)] = true
			
			if Board:IsPawnSpace(current) or Board:IsBuilding(current) then
			
				local direction = GetDirection(current - origin[hash(current)])
				damage.sAnimation = "Lightning_Attack_"..direction
				damage.loc = current
				damage.iDamage = self.Damage
				
				if not self.FriendlyDamage and Board:IsPawnTeam(current, TEAM_ENEMY) then
					damage.iDamage = DAMAGE_ZERO
				end
				
				ret:AddQueuedDamage(damage)
				ret:AddQueuedAnimation(current,"Lightning_Hit")
				
				for i = DIR_START, DIR_END do
					local neighbor = current + DIR_VECTORS[i]
					if not explored[hash(neighbor)] then
						todo[#todo + 1] = neighbor
						origin[hash(neighbor)] = current
					end
				end
			end		
		end
	end

	return ret
end	

RMMechElecAtk2 = RMMechElecAtk1:new{
	Name = "Electric Whip",
	Description = "Chain damage through adjacent targets.",
	Class = "Enemy",
	Explosion = "",
	LaunchSound = "/weapons/electric_whip",
	Icon = "weapons/prime_lightning.png",
	PathSize = 1,
	Damage = 3,
	FriendlyDamage = false,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,1),
		CustomPawn = "RMMechElec1",
	}
}


RMWindTorrent = Skill:new {
	Name = "Wind Torrent",
	Description = "Push all units in a single direction.",
	Damage = 0,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "RMMechElec1",
	}
}

function RMWindTorrent:GetTargetArea(point)
	ret = PointList()
	ret:push_back(point)
	return ret
end

function RMWindTorrent:GetSkillEffect(p1, p2)
	local ret = SkillEffect()	
	for i = 0, 7 do
		for j = 0, 7 do
			local curr = Point(i, j)
			if Board:GetPawn(curr) then ret:AddQueuedDamage(SpaceDamage(curr, 0, GetTurnCount())) end
			--this makes it a semi-random direction
		end
	end
	return ret
end

function RMWindTorrent:GetTargetScore(p1, p2)
	return 10
end
