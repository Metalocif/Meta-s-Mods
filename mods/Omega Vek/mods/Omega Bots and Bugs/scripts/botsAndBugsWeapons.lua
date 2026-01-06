local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/effects/shotup_spine.png", resourcePath.."img/effects/shotup_spine.png")

--Blobberling uses the Alpha version's weapon.

OmegaCrusherAtk2 = Skill:new{
	Name = "Tzar Blades",
	Description = "Slash 3 tiles in a row, pushing targets hit.",
	Icon = "weapons/lmn_crusher.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 3,
	Push = 1,
	LaunchSound = "",
	SoundBase = "/enemy/burrower_1/",
	TipImage = {
		CustomPawn = "OmegaCrusher2",
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(1,1),
		Target = Point(2,1),
	}
}

function OmegaCrusherAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end

	local dir = GetDirection(p2 - p1)
	local dir_perp = (dir + 1) % 4
	local vec = DIR_VECTORS[dir]
	local vec_perp = DIR_VECTORS[dir_perp]

	ret:AddQueuedAnimation(p2, "lmn_explo_crusher_kaizerA_".. dir)
	ret:AddQueuedAnimation(p2, "lmn_explo_crusher_kaizerB_".. dir)

	local d = SpaceDamage(p2, self.Damage, dir)
	d.sSound = "/weapons/sword"
	ret:AddQueuedDamage(d)
	d.loc = p2 + vec_perp
	ret:AddQueuedDamage(d)
	d.loc = p2 - vec_perp
	ret:AddQueuedDamage(d)

	return ret
end



OmegaFloaterAtk2 = SelfTarget:new{
	Name = "Overlord's Yoke",
	Description = "Heal allies in a 2 tiles radius.",
	Icon = "weapons/lmn_floater.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 0,
	TipImage = {
		CustomPawn = "OmegaFloater2",
		Unit = Point(2,2),
		FriendlyDamaged1 = Point(2,1),
		FriendlyDamaged2 = Point(2,4),
		FriendlyDamaged3 = Point(3,4),
		FriendlyDamaged4 = Point(1,1),
	}
}

function OmegaFloaterAtk2:GetTargetScore(p1, p2)
	local score = 0
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	local targets = extract_table(general_DiamondTarget(p1, 2))
	for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:GetTeam() == TEAM_ENEMY then
			if pawn:IsDead() then 
				score = score + 10
			elseif pawn:IsDamaged() or pawn:IsFrozen() then 
				score = score + 5
			end
		end
	end
	return score
end

function OmegaFloaterAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	local targets = extract_table(general_DiamondTarget(p1, 2))
	for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:GetTeam() == TEAM_ENEMY then ret:AddDamage(SpaceDamage(targets[k], -1)) end
	end
	return ret
end


OmegaRoachAtk2 = Skill:new{
	Name = "Deadly Spines",
	Description = "Fires spines around itself.",
	Icon = "weapons/lmn_roach.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 2,
	TipImage = {
		CustomPawn = "OmegaRoach2",
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Building1 = Point(0,3),
		Building2 = Point(4,3),
	}
}

function OmegaRoachAtk2:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	return ret
end

function OmegaRoachAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i] * 2
		ret:AddQueuedArtillery(SpaceDamage(curr, self.Damage), "effects/shotup_spine.png", NO_DELAY)
	end
	return ret
end


OmegaSpitterAtk2 = Skill:new{
	Name = "Hunter Killer",
	Description = "Apply A.C.I.D. to all adjacent tiles, preparing to slice one for 2 damage.",
	Icon = "weapons/lmn_spitter.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 2,
	TipImage = {
		CustomPawn = "OmegaSpitter2",
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}

function OmegaSpitterAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	if not pawn then return ret end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local acidDamage = SpaceDamage(curr)
		acidDamage.iAcid = EFFECT_CREATE
		ret:AddDamage(acidDamage)
	end
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "SwipeClaw1"
	ret:AddQueuedMelee(p1, damage)
	return ret
end

--Omega Swarmer uses the Alpha's weapon.

OmegaWyrmAtk2 = Skill:new{
	Name = "Seeking Wurm",
	Description = "Point blank shot that redirects towards an adjacent target if it doesn't connect. Will prioritize units over buildings.",
	Icon = "weapons/lmn_spitter.png",
	Class = "Enemy",
	PathSize = 1,
	Damage = 2,
	TipImage = {
		CustomPawn = "OmegaWyrm2",
		Unit = Point(2,2),
		Enemy = Point(1,0),
		Target = Point(2,0),
	}
}

SkillEffect["New_AddQueuedProjectile"] = function(self, origin, damage, graphics, delay) -- add our own queued projectile that can start from anywhere
	local fx = SkillEffect()
	fx["AddProjectile"](fx, origin, damage, graphics, delay)
	self.q_effect:AppendAll(fx.effect)
end

function OmegaWyrmAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local direction = GetDirection(p2-p1)
	if not pawn then return ret end
	local target = p2
	local secondTarget
	if not Board:IsBlocked(target, PATH_PROJECTILE) then target = p2 + DIR_VECTORS[direction] end
	if not Board:IsBlocked(target, PATH_PROJECTILE) then
		for i = DIR_START, DIR_END do
			local curr = target + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER then
				secondTarget = curr
				break
			end
		end
		if not secondTarget then
			for i = DIR_START, DIR_END do
				local curr = target + DIR_VECTORS[i]
				if Board:GetTerrain(curr) == TERRAIN_BUILDING then
					secondTarget = curr
					break
				end
			end
		end
	end
	if not secondTarget then 
		ret:AddQueuedProjectile(SpaceDamage(target, self.Damage), "effects/shot_firefly2")
	else
		ret:AddQueuedProjectile(SpaceDamage(target), "effects/shot_firefly2")
		ret:New_AddQueuedProjectile(target, SpaceDamage(secondTarget, self.Damage), "effects/shot_firefly2", PROJ_DELAY)
	end
	return ret
end