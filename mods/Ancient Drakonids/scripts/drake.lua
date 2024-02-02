local path = mod_loader.mods[modApi.currentMod].resourcePath
local artilleryArc = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/artilleryArc")
local weaponPreview = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/weaponPreview")
modApi:appendAsset("img/weapons/Drake.png", path .."img/weapons/Drake.png")


Meta_DrakeWeapon = Skill:new{  
	Name = "Dragonflight",
	Class = "TechnoVek",
	Icon = "weapons/Drake.png",
	Description = "Melee: grab an enemy and fly with it. Ranged: fly to a tile, spewing fire on all tiles along the way.",
	Rarity = 3,
	Damage = 1,
	Range = 2,
	ZoneTargeting = ZONE_DIR,
	TwoClick = true,
	ArtilleryHeight = 35,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Impact",  "+2 Range"  },
	UpgradeCost = { 2 , 2 },
	Impact = false,
	Crush = false,
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Second_Target=Point(2,1),
		Second_Click=Point(2,1),
		Water = Point(2,0),
		CustomPawn = "Meta_Drake",
	}
}

function Meta_DrakeWeapon:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, self.Range + 1 do
			local curr = DIR_VECTORS[dir]*i + point
			if i > 1 and not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
			local canMoveTarget = false
			for j = 2, self.Range + 1 do
				local curr = DIR_VECTORS[dir]*j + point
				if not Board:IsBlocked(curr, PATH_PROJECTILE) and
				   Board:IsValid(curr + DIR_VECTORS[dir]) and 
				   not Board:IsBlocked(curr + DIR_VECTORS[dir], PATH_PROJECTILE) then canMoveTarget = true end
			end
			--checking we won't have an empty second target area
			if i == 1 and Board:GetPawn(curr) and not Board:GetPawn(curr):IsGuarding() and canMoveTarget then ret:push_back(curr) end
		end
	end
	return ret
end

function Meta_DrakeWeapon:IsTwoClickException(p1,p2)
	return p1:Manhattan(p2) > 1 or (Board:GetPawn(p2) and Board:GetPawn(p2):IsGuarding())
end

function Meta_DrakeWeapon:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2-p1)
	for i = 2, self.Range + 1 do
		local curr = DIR_VECTORS[dir]*i + p1
		if not Board:IsBlocked(curr, PATH_PROJECTILE) and
		   Board:IsValid(curr + DIR_VECTORS[dir]) and 
		   not Board:IsBlocked(curr + DIR_VECTORS[dir], PATH_PROJECTILE) then ret:push_back(curr) end
	end
	return ret
end

function Meta_DrakeWeapon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local dist = p1:Manhattan(p2)
	local toCrush = Board:GetPawn(p2)
	if dist == 1 then
		ret:AddDamage(SpaceDamage(p2, self.Damage))	--just for preview, this happens in GetFinalEffect
	else
		local move = PointList()
		move:push_back(p1)
		move:push_back(p2)
		ret:AddLeap(move, 0.25)
		for i = 1, dist-1 do
			local damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i, self.Damage)
			damage.sAnimation = "ExploRaining1"
			damage.sSound = "/impact/generic/explosion"
			damage.iFire = 1
			if i ~= 1 then ret:AddDelay(0.2) end
			if i == dist-1 and self.Impact then damage.bHide = true end
			--we make the push from the impact upgrade apply fire for previews
			--we need this one to happen normally for the animations during the flight
			ret:AddDamage(damage)
			ret:AddBounce(p1 + DIR_VECTORS[dir]*i,3)
		end
		ret:AddDelay(-1)
		if self.Impact then
			for i = DIR_START, DIR_END do
				local curr = p2 + DIR_VECTORS[i]
				local damage = SpaceDamage(curr, 0, i)
				if i == (dir+2)%4 then damage.bHide = true end
				ret:AddDamage(damage)
			end
			local previewDamage = SpaceDamage(p2 + DIR_VECTORS[(dir+2)%4], 1, (dir+2)%4)
			previewDamage.iFire = 1
			weaponPreview:AddDamage(previewDamage)
		end
		
	end
	
	return ret
end	

function Meta_DrakeWeapon:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local toCrush = Board:GetPawn(p3)
	local dist = p1:Manhattan(p3)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p3)
	ret:AddLeap(move, NO_DELAY)
	move = PointList()
	move:push_back(p2)
	move:push_back(p3+DIR_VECTORS[dir])
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBounce(p3,5)
	ret:AddBounce(p3 + DIR_VECTORS[dir],5)
	if self.Impact then
		for i = DIR_START, DIR_END do
			local damage = SpaceDamage(p3 + DIR_VECTORS[i], 0, i)
			if i == dir then damage.iDamage = 1 damage.iPush = DIR_NONE end
			if i ~= (dir+2)%4 or dist > 2 then ret:AddDamage(damage) end
		end
	else
		ret:AddDamage(SpaceDamage(p3 + DIR_VECTORS[dir], 1))
	end
	return ret
end	

Meta_DrakeWeapon_A = Meta_DrakeWeapon:new{
	UpgradeDescription = "Pushes adjacent tiles on landing.",
	Impact = true,
}

Meta_DrakeWeapon_B = Meta_DrakeWeapon:new{
	UpgradeDescription = "Can target tiles up to 4 tiles away.",
	Range = 4,
}

Meta_DrakeWeapon_AB = Meta_DrakeWeapon:new{
	Impact = true,
	Range = 4,
}