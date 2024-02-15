local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/effects/shotup_wyvern.png", path .."img/effects/shotup_wyvern.png")
modApi:appendAsset("img/effects/shot_wyvern_R.png", path .."img/effects/shot_wyvern_R.png")
modApi:appendAsset("img/effects/shot_wyvern_U.png", path .."img/effects/shot_wyvern_U.png")
modApi:appendAsset("img/weapons/Wyvern.png", path .."img/weapons/Wyvern.png")
local weaponPreview = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/weaponPreview")

Meta_WyvernWeapon = Skill:new{  
	Name = "Voracious Hunger",
	Class = "TechnoVek",
	Icon = "weapons/Wyvern.png",
	Description = "Melee: chomp a target, adding damage dealt to stomach contents. Can chomp allies for 1 damage as a free action. Ranged: Regurgitate pushing artillery projectiles, spending stomach contents. On an empty stomach, can fire once, causing self-damage. Self-target to expend all stomach contents as a multishot attack.",
	Rarity = 3,
	Damage = 2,
	MinDamage = 1,
	TwoClick = true,
	ZoneTargeting = ZONE_DIR,
	Self = "Meta_WyvernWeapon",
	ProjectileArt = "effects/shotup_wyvern.png",
	Projectile = "effects/shot_wyvern",
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Damage",  "+1 Damage"  },
	UpgradeCost = { 2 , 3 },
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
		Second_Target=Point(2,1),
		Second_Click=Point(2,1),
		Water = Point(2,0),
		CustomPawn = "Meta_Wyvern"
	}
}

function Meta_WyvernWeapon:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, 8 do
			ret:push_back(DIR_VECTORS[i]*k + point)
		end
	end
	return ret
end

function Meta_WyvernWeapon:IsTwoClickException(p1, p2)
	local mission = GetCurrentMission()
	if mission.WyvernStomach == nil then mission.WyvernStomach = 0 end
	return p1:Manhattan(p2) == 1 or mission.WyvernStomach <= 1
end

function Meta_WyvernWeapon:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local dir = GetDirection(p2-p1)
	local dist = p1:Manhattan(p2)
	local stomach = 0
	if GetCurrentMission() then stomach = GetCurrentMission().WyvernStomach end
	for i = math.max(-(stomach-1), -dist + 2), (stomach-1) do
		ret:push_back(p2 + DIR_VECTORS[dir] * i)
	end
	for i = -math.floor((stomach-1)/2), math.floor((stomach-1)/2) do
		ret:push_back(p2 + DIR_VECTORS[(dir+1)%4] * i)
	end
	ret:push_back(p1)	--target a tile, then the wyvern, to multishoot projectiles instead
	return ret
end
	
function Meta_WyvernWeapon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local mission = GetCurrentMission()
	if not mission then 	--tipImage stuff
		local damage = SpaceDamage(p1+DIR_VECTORS[dir], self.Damage)
		damage.sAnimation = "bite_"..dir
		ret:AddDamage(damage) 
		ret:AddDelay(1)
		damage = SpaceDamage(p2, self.MinDamage, dir)
		damage.bHide = true
		ret:AddArtillery(p1, damage, self.ProjectileArt, PROJ_DELAY)
		ret:AddDelay(1)
		return ret 
	end
	
	if mission.WyvernStomach == nil then mission.WyvernStomach = 0 end
	
	local dist = p1:Manhattan(p2)
	if dist == 1 then
		local damage = SpaceDamage(p2, self.Damage)
		if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == Board:GetPawn(p1):GetTeam() then 
			damage.iDamage = 0 
			damage.sScript = string.format("Board:DamageSpace(SpaceDamage(%s, 1))", p2:GetString())
			weaponPreview:AddDamage(SpaceDamage(p2, 1))
		end
		damage.sAnimation = "bite_"..dir
		ret:AddMelee(p1, damage)
		local amount = math.max(damage.iDamage, 1)
		if Board:GetPawn(p2) and not IsTestMechScenario() then
			local toBoost = false
			if Board:GetPawn(p1):IsBoosted() then 
				if Board:GetPawn(p2):GetTeam() == Board:GetPawn(p1):GetTeam() then toBoost = true end
				amount = amount + 1
			end
			if Board:GetPawn(p2):IsArmor() and not Board:GetPawn(p2):IsAcid() then amount = amount - 1 end
			if Board:GetPawn(p2):IsAcid() then amount = amount * 2 end
			if Board:GetPawn(p2):IsFrozen() then amount = 0 end
			amount = math.min(amount, Board:GetPawn(p2):GetHealth())
			ret:AddScript("GetCurrentMission().WyvernStomach = GetCurrentMission().WyvernStomach + "..amount)
			if Board:GetPawn(p2):GetTeam() == Board:GetPawn(p1):GetTeam() then
				ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)",Board:GetPawn(p1):GetId()))
				if toBoost then ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString())) end
				--we do all this so we can munch allies without consuming boost from Opener
			end
		end
	else
		ret:AddSound("/enemy/blobber_1/death")
		local damage = SpaceDamage(p2, self.MinDamage, dir)
		damage.sAnimation = "ExploAcid1"
		ret:AddArtillery(p1, damage, self.ProjectileArt, PROJ_DELAY)
		if mission.WyvernStomach == 0 then 
			ret:AddDamage(SpaceDamage(p1, 1)) 
		else
			ret:AddScript("GetCurrentMission().WyvernStomach = GetCurrentMission().WyvernStomach - 1")
		end
	end
	return ret
end	

function Meta_WyvernWeapon:GetFinalEffect(p1, p2, p3, remainingShots)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local dir2 = GetDirection(p2-p3)
	local mission = GetCurrentMission()
	if mission.WyvernStomach == nil then mission.WyvernStomach = 0 end	--should not be the case at this point
	
	if p3 == p1 then	--we do multishot projectiles instead of artillery at several tiles
		if remainingShots == nil then  remainingShots = mission.WyvernStomach end
		local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
		local damage = SpaceDamage(target, self.MinDamage)
		damage.sAnimation = "ExploAcid1"
		damage.sImageMark = MultishotLib:getImageMark(self.MinDamage, remainingShots, p1, target)
		ret:AddSound("/enemy/blobber_1/death")
		ret:AddProjectile(p1, damage, self.Projectile, NO_DELAY)
		ret:AddDelay(0.15)
		if remainingShots > 1 then
			remainingShots = remainingShots - 1
			ret:AddScript(string.format([=[
				local fx = SkillEffect();
				fx:AddScript([[
					Board:AddEffect(_G[%q]:GetFinalEffect(%s, %s, %s, %s));
				]]);
				Board:AddEffect(fx);
			]=], self.Self, p1:GetString(), p2:GetString(), p3:GetString(), remainingShots))
		end
		if not IsTestMechScenario() then ret:AddScript("GetCurrentMission().WyvernStomach = 0") end
		return ret
	elseif dir2 == (dir+1)%4 or dir2 == (dir-1)%4 then
		local dist1 = p1:Manhattan(p2)
		local dist2 = p2:Manhattan(p3)
		for i = -dist2, dist2 do
			local curr = p2 + DIR_VECTORS[dir2] * i
			local damage = SpaceDamage(curr, self.MinDamage, dir)
			damage.sAnimation = "ExploAcid1"
			ret:AddSound("/enemy/blobber_1/death")
			ret:AddArtillery(p1, damage, self.ProjectileArt, 0.05)
		end
		if not IsTestMechScenario() then ret:AddScript("GetCurrentMission().WyvernStomach = GetCurrentMission().WyvernStomach - "..dist2*2 + 1) end
	else
		--do multi-artillery normally
		local dist1 = p1:Manhattan(p2)
		local dist2 = p1:Manhattan(p3)
		if dist2 > dist1 then
			for i = dist2, dist1, -1 do
				local curr = p1 + DIR_VECTORS[dir] * i
				local damage = SpaceDamage(curr, self.MinDamage, dir)
				damage.sAnimation = "ExploAcid1"
				ret:AddSound("/enemy/blobber_1/death")
				ret:AddArtillery(p1, damage, self.ProjectileArt, 0.15)
			end
		elseif dist2 < dist1 then
			for i = dist2, dist1, 1 do
				local curr = p1 + DIR_VECTORS[dir] * i
				local damage = SpaceDamage(curr, self.MinDamage, dir)
				damage.sAnimation = "ExploAcid1"
				ret:AddSound("/enemy/blobber_1/death")
				ret:AddArtillery(p1, damage, self.ProjectileArt, 0.15)
			end
		else
			local damage = SpaceDamage(p2, self.MinDamage, dir)
			damage.sAnimation = "ExploAcid1"
			ret:AddSound("/enemy/blobber_1/death")
			ret:AddArtillery(p1, damage, self.ProjectileArt, 0.15)
		end
		if not IsTestMechScenario() then ret:AddScript("GetCurrentMission().WyvernStomach = GetCurrentMission().WyvernStomach - "..dist2 + 1) end
	end
	return ret
end	


Meta_WyvernWeapon_A = Meta_WyvernWeapon:new{
	UpgradeDescription = "Increases damage by 1.",
	Damage = 3,
	MinDamage = 2,
	Self = "Meta_WyvernWeapon_A",
}

Meta_WyvernWeapon_B = Meta_WyvernWeapon:new{
	UpgradeDescription = "Increases damage by 1.",
	Damage = 3,
	MinDamage = 2,
	Self = "Meta_WyvernWeapon_B",
}

Meta_WyvernWeapon_AB = Meta_WyvernWeapon:new{
	Damage = 4,
	MinDamage = 3,
	Self = "Meta_WyvernWeapon_AB",
}