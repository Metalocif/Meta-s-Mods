local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/effects/bite_0.png", path .."img/effects/bite_0.png")
modApi:appendAsset("img/effects/bite_1.png", path .."img/effects/bite_1.png")
modApi:appendAsset("img/effects/bite_2.png", path .."img/effects/bite_2.png")
modApi:appendAsset("img/effects/bite_3.png", path .."img/effects/bite_3.png")
modApi:appendAsset("img/weapons/Hydra.png", path .."img/weapons/Hydra.png")

local a = ANIMS

a.bite_0 = a.explopunch1_0:new{ Image = "effects/bite_0.png", NumFrames = 5, PosX = -19, PosY = -5 }
a.bite_1 = a.explopunch1_1:new{ Image = "effects/bite_1.png", NumFrames = 5, PosX = -14, PosY = -2,  }
a.bite_2 = a.explopunch1_2:new{ Image = "effects/bite_2.png", NumFrames = 5, PosX = -10, PosY = -2,  }
a.bite_3 = a.explopunch1_3:new{ Image = "effects/bite_3.png", NumFrames = 5, PosX = -7, PosY = -5 }

Meta_HydraWeapon = Skill:new{  
	Name = "Triple Strike",
	Class = "TechnoVek",
	Icon = "weapons/Hydra.png",
	Description = "Melee: bite the front three tiles, applying A.C.I.D., fire, and pull. Ranged: fire projectiles with the same effect; if the path to their target is blocked, they will be fired as artillery.",
	Rarity = 3,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Versatility",  "+2 Damage"  },
	UpgradeCost = { 1 , 3 },
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Meta_Hydra",
	}
}

function Meta_HydraWeapon:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, 8 do
			ret:push_back(DIR_VECTORS[i]*k + point)
		end
	end
	return ret
end

function Meta_HydraWeapon:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2-p1)
	ret:push_back(DIR_VECTORS[(dir+1)%4] + p2)
	ret:push_back(DIR_VECTORS[(dir-1)%4] + p2)
	ret:push_back(p2)
	return ret
end

function Meta_HydraWeapon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	
	local damage1 = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.Damage)
	local damage2 = SpaceDamage(p2, self.Damage)
	local damage3 = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.Damage)
	
	local target1 = GetProjectileEnd(p1 + DIR_VECTORS[(dir-1)%4], p2 + DIR_VECTORS[(dir-1)%4])
	local target2 = GetProjectileEnd(p1, p2)
	local target3 = GetProjectileEnd(p1 + DIR_VECTORS[(dir+1)%4], p2 + DIR_VECTORS[(dir+1)%4])

	damage1.iAcid = 1 damage1.sAnimation = "ExploAcid1"
	damage2.iFire = 1 damage2.sAnimation = "explo_fire1"
	damage3.iPush = (dir + 2)%4 damage3.sAnimation = "ExploFirefly1"

	if p1:Manhattan(p2) == 1 then
		damage1.sAnimation = "bite_"..dir
		damage2.sAnimation = "bite_"..dir
		damage3.sAnimation = "bite_"..dir
		ret:AddDamage(damage1)
		ret:AddDamage(damage2)
		ret:AddDamage(damage3)
		ret:AddMelee(p1, SpaceDamage(p2))
	else
		if p1:Manhattan(target1) >= p1:Manhattan(damage1.loc) then	--projectile
			damage1.loc = target1
			ret:AddProjectile(p1 + DIR_VECTORS[(dir-1)%4], damage1, "effects/shot_firefly2", NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage1, "effects/shotup_ant2.png", NO_DELAY)
		end
		if p1:Manhattan(target2) >= p1:Manhattan(damage2.loc) then	--projectile
			damage2.loc = target2
			ret:AddProjectile(p1, damage2, "effects/shot_mechtank", NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage2, "effects/shotup_ignite_fireball.png", NO_DELAY)
		end
		if p1:Manhattan(target3) >= p1:Manhattan(damage3.loc) then	--projectile
			damage3.loc = target3
			ret:AddProjectile(p1 + DIR_VECTORS[(dir+1)%4], damage3, "effects/shot_firefly1", NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage3, "effects/shotup_ant1.png", NO_DELAY)
		end
	end
	return ret
end	


function Meta_HydraWeapon:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local isMelee = p1:Manhattan(p2) == 1
	local offset = 0
	if GetDirection(p3-p2) == (dir+1)%4 then offset = 1 end
	if GetDirection(p3-p2) == (dir-1)%4 then offset = -1 end
	
	local damage1 = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.Damage)
	local damage2 = SpaceDamage(p2, self.Damage)
	local damage3 = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.Damage)
	local shotup1, shotup2, shotup3, shot1, shot2, shot3
	
	local target1 = GetProjectileEnd(p1 + DIR_VECTORS[(dir-1)%4], p2 + DIR_VECTORS[(dir-1)%4])
	local target2 = GetProjectileEnd(p1, p2)
	local target3 = GetProjectileEnd(p1 + DIR_VECTORS[(dir+1)%4], p2 + DIR_VECTORS[(dir+1)%4])
	
	if offset == 0 then
		damage1.iAcid = 1 shotup1 = "effects/shotup_ant2.png" shot1 = "effects/shot_firefly2" damage1.sAnimation = "ExploAcid1"
		damage2.iFire = 1 shotup2 = "effects/shotup_ignite_fireball.png" shot2 = "effects/shot_mechtank" damage2.sAnimation = "explo_fire1"
		damage3.iPush = (dir + 2)%4 shotup3 = "effects/shotup_ant1.png" shot3 = "effects/shot_firefly1" damage3.sAnimation = "ExploFirefly1"
	elseif offset == -1 then
		damage1.iFire = 1 shotup1 = "effects/shotup_ignite_fireball.png" shot1 = "effects/shot_mechtank" damage1.sAnimation = "explo_fire1"
		damage2.iPush = (dir + 2)%4 shotup2 = "effects/shotup_ant1.png" shot2 = "effects/shot_firefly1" damage2.sAnimation = "ExploFirefly1"
		damage3.iAcid = 1 shotup3 = "effects/shotup_ant2.png" shot3 = "effects/shot_firefly2" damage3.sAnimation = "ExploAcid1"
	elseif offset == 1 then
		damage1.iPush = (dir + 2)%4 shotup1 = "effects/shotup_ant1.png" shot1 = "effects/shot_firefly1" damage1.sAnimation = "ExploFirefly1"
		damage2.iAcid = 1 shotup2 = "effects/shotup_ant2.png" shot2 = "effects/shot_firefly2" damage2.sAnimation = "ExploAcid1"
		damage3.iFire = 1 shotup3 = "effects/shotup_ignite_fireball.png" shot3 = "effects/shot_mechtank" damage3.sAnimation = "explo_fire1"
	end
	if isMelee then
		damage1.sAnimation = "bite_"..dir
		damage2.sAnimation = "bite_"..dir
		damage3.sAnimation = "bite_"..dir
		ret:AddDamage(damage1)
		ret:AddDamage(damage2)
		ret:AddDamage(damage3)
		ret:AddMelee(p1, SpaceDamage(p2))
	else
		if p1:Manhattan(target1) >= p1:Manhattan(damage1.loc) then	--projectile
			damage1.loc = target1
			ret:AddProjectile(p1 + DIR_VECTORS[(dir-1)%4], damage1, shot1, NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage1, shotup1, NO_DELAY)
		end
		if p1:Manhattan(target2) >= p1:Manhattan(damage2.loc) then	--projectile
			damage2.loc = target2
			ret:AddProjectile(p1, damage2, shot2, NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage2, shotup2, NO_DELAY)
		end
		if p1:Manhattan(target3) >= p1:Manhattan(damage3.loc) then	--projectile
			damage3.loc = target3
			ret:AddProjectile(p1 + DIR_VECTORS[(dir+1)%4], damage3, shot3, NO_DELAY)
		else														--artillery
			ret:AddArtillery(p1, damage3, shotup3, NO_DELAY)
		end
	end
	return ret
end	



Meta_HydraWeapon_A = Meta_HydraWeapon:new{
	UpgradeDescription = "Effects can be applied to different targets.",
	TwoClick = true,
}

Meta_HydraWeapon_B = Meta_HydraWeapon:new{
	UpgradeDescription = "Increases damage by 2.",
	Damage = 3,
}

Meta_HydraWeapon_AB = Meta_HydraWeapon:new{
	Damage = 3,
	TwoClick = true,
}