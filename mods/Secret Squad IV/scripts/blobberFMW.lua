local this = {}
local path = mod_loader.mods[modApi.currentMod].scriptPath
local resources = mod_loader.mods[modApi.currentMod].resourcePath
local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath .."libs/weaponPreview")


modApi:appendAsset("img/weapons/blobber.png", resources .."img/weapons/blobber.png")
modApi:appendAsset("img/weapons/goo.png", resources .."img/weapons/goo.png")

modApi:appendAsset("img/effects/gooshove_D.png", resources.."img/effects/gooshove_D.png")
modApi:appendAsset("img/effects/gooshove_U.png", resources.."img/effects/gooshove_U.png")
modApi:appendAsset("img/effects/gooshove_R.png", resources.."img/effects/gooshove_R.png")
modApi:appendAsset("img/effects/gooshove_L.png", resources.."img/effects/gooshove_L.png")
local a = ANIMS
a.gooShove_0 = Animation:new{Image = "effects/gooshove_U.png",NumFrames = 5,Time = 0.1,PosX = -20,PosY = 12}
a.gooShove_1 = a.gooShove_0:new{Image = "effects/gooshove_R.png",PosX = -23,PosY = -2}
a.gooShove_2 = a.gooShove_0:new{Image = "effects/gooshove_D.png",PosX = -6,PosY = -3}
a.gooShove_3 = a.gooShove_0:new{Image = "effects/gooshove_L.png",PosX = -6,PosY = 12}


meta_blobber = Skill:new{
	Name = "Goo Morphosis",
	Description = "Deploys a unit at a ranged location. Its type depends on the location.",
	Class = "TechnoVek",
	Icon = "weapons/blobber.png",
	SoundBase = "/enemy/blobber_1",
	Upgrades = 1,
	UpgradeCost = { 3 },
	UpgradeList={"+1 Deploy"},
	--TipImage
	TipImage = {
		Unit = Point(2, 3),
		Enemy = Point(2, 2),
		Enemy2 = Point(2, 0),
		Enemy3 = Point(1, 2),
		Target = Point(2, 1),
		Building = Point(3, 2),
		CustomPawn = "Meta_TechnoBlobber",
	}
}

meta_blobber_A = meta_blobber:new{UpgradeDescription = "Can deploy two units at once.", TwoClick = true}

function meta_blobber:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if not Board:IsBlocked(curr, PATH_GROUND) then ret:push_back(curr) end
		end
		for i = DIR_START, DIR_END do
			local curr = point + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4] 
			if not Board:IsBlocked(curr, PATH_GROUND) then ret:push_back(curr) end
		end
	end	
	return ret
end

function meta_blobber:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	if p1:Manhattan(p2) > 1 and (p1.x == p2.x or p1.y == p2.y) then 
		damage.sPawn = "meta_blob"
	elseif p1:Manhattan(p2) > 1 then
		damage.sPawn = "meta_sludge"
	else
		damage.sPawn = "meta_goo"
	end
	ret:AddArtillery(p1, damage, "effects/shotup_blobber2.png", PROJ_DELAY)
	return ret
end

function meta_blobber:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = p1 + DIR_VECTORS[i] * j
			if curr ~= p2 and not Board:IsBlocked(curr, PATH_GROUND) then ret:push_back(curr) end
		end
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4] 
			if curr ~= p2 and not Board:IsBlocked(curr, PATH_GROUND) then ret:push_back(curr) end
		end
	end	
	return ret
end

function meta_blobber:GetFinalEffect(p1, p2, p3)
    local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	local queueP2, queueP3
	if p1:Manhattan(p2) > 1 and (p1.x == p2.x or p1.y == p2.y) then 
		damage.sPawn = "meta_blob"
		queueP2 = true
	elseif p1:Manhattan(p2) > 1 then
		damage.sPawn = "meta_sludge"
	else
		damage.sPawn = "meta_goo"
	end
	--should do an artillery height thing + bHidePath to just poop out a goo instead of throwing it
	ret:AddArtillery(p1, damage, "effects/shotup_blobber2.png", NO_DELAY)
	damage.loc = p3
	if p1:Manhattan(p3) > 1 and (p1.x == p3.x or p1.y == p3.y) then 
		damage.sPawn = "meta_blob"
		queueP3 = true
	elseif p1:Manhattan(p3) > 1 then
		damage.sPawn = "meta_sludge"
	else
		damage.sPawn = "meta_goo"
	end
	ret:AddArtillery(p1, damage, "effects/shotup_blobber2.png", FULL_DELAY)
	if queueP2 then ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", p2:GetString(), p2:GetString())) end
	if queueP3 then ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", p3:GetString(), p3:GetString())) end
    return ret
end

meta_blob = {
	Name = "Blob",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Neutral = true,
	IgnoreSmoke = true,
	IsPortrait = false,
	Image = "blob",
	ImageOffset = 1,
	SkillList = { "meta_BlobAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	IsDeathEffect = true,
}
AddPawn("meta_blob")  

function meta_blob:GetDeathEffect(point)
	local ret = SkillEffect()
	Board:SetItem(point, "Meta_BlobGunk")
	return ret
end

meta_BlobAtk1 = Skill:new{
	Name = "Volatile Guts",
	Description = "Explode, killing itself and damaging adjacent tiles for 2 damage.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = 2,
	SelfDamage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "meta_blob"
	}
}

function meta_BlobAtk1:GetTargetScore(p1, p2)
	return 100
end

function meta_BlobAtk1:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function meta_BlobAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, 2)
		damage.sAnimation = "exploout2_"..i
		ret:AddQueuedDamage(damage)
	end
	ret:AddQueuedDamage(SpaceDamage(p1, 1))
	return ret
end


meta_sludge = {
	Name = "Sludge",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Image = "meta_sludge",			
	SkillList = { "meta_SludgeAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	Portrait = "enemy/BlobBoss"		
}
AddPawn("meta_sludge")  

meta_SludgeAtk1 = Skill:new{
	Name = "Goo Scramble",
	Description = "Pushes all adjacent units clockwise.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = 0,
	SelfDamage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "meta_sludge"
	}
}

function meta_SludgeAtk1:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function meta_SludgeAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, 0, (i+1)%4)
		damage.sAnimation = "gooShove_"..i
		if Board:GetPawn(curr) then damage.sScript = string.format("Status.ApplyGunk(%s)", Board:GetPawn(curr):GetId()) end
		ret:AddDamage(damage)
	end
	return ret
end


meta_goo = {
	Name = "Goo",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Image = "slimeb3",
	SkillList = { "meta_gooAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	Portrait = "enemy/BlobBoss"		
}
AddPawn("meta_goo")  

meta_gooAtk1 = Skill:new{
	Name = "Goo Slam",
	Description = "Pushes an adjacent unit. When adjacent to gunk, can self-target to eat the gunk, empowering the user.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = 0,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "meta_goo"
	}
}

function meta_gooAtk1:GetTargetArea(point)
	local ret = PointList()
	local foundGunk
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then foundGunk = true end
		-- if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then foundGunk = true end
		--if board has gunk item, also fine
		ret:push_back(curr)
	end
	if foundGunk then ret:push_back(point) end
	return ret
end

function meta_gooAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if p1 == p2 then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then 
				local preview = SpaceDamage(p1)
				preview.sPawn = "meta_goo2"
				weaponPreview:AddDamage(preview)
				ret:AddScript(string.format("Status.RemoveStatus(Board:GetPawn(%s):GetId(), %q)", curr:GetString(), "Gunk"))
				ret:AddScript(string.format("Board:RemovePawn(Board:GetPawn(%s))", p1:GetString()))
				ret:AddScript(string.format("Board:AddPawn(%q, %s)", "meta_goo2", p1:GetString()))
				return ret
			end
		end
	end
	ret:AddMelee(p1, SpaceDamage(p2, 0, GetDirection(p2-p1)))
	return ret
end


meta_goo2 = {
	Name = "Goo",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Image = "slimeb2",
	SkillList = { "meta_gooAtk2" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	Portrait = "enemy/BlobBoss"		
}
AddPawn("meta_goo2")  

meta_gooAtk2 = Skill:new{
	Name = "Goo Crush",
	Description = "Pushes and damages an adjacent unit. When adjacent to gunk, can self-target to eat the gunk, empowering the user.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "meta_goo2"
	}
}

function meta_gooAtk2:GetTargetArea(point)
	local ret = PointList()
	local foundGunk
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then foundGunk = true end
		-- if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then foundGunk = true end
		--if board has gunk item, also fine
		ret:push_back(curr)
	end
	if foundGunk then ret:push_back(point) end
	return ret
end

function meta_gooAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if p1 == p2 then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then 
				local preview = SpaceDamage(p1)
				preview.sPawn = "meta_goo3"
				weaponPreview:AddDamage(preview)
				ret:AddScript(string.format("Status.RemoveStatus(Board:GetPawn(%s):GetId(), %q)", curr:GetString(), "Gunk"))
				ret:AddScript(string.format("Board:RemovePawn(Board:GetPawn(%s))", p1:GetString()))
				ret:AddScript(string.format("Board:AddPawn(%q, %s)", "meta_goo3", p1:GetString()))
				return ret
			end
		end
	end
	ret:AddMelee(p1, SpaceDamage(p2, 1, GetDirection(p2-p1)))
	return ret
end


meta_goo3 = {
	Name = "Goo",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Image = "slimeb",
	SkillList = { "meta_gooAtk3" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	Portrait = "enemy/BlobBoss"		
}
AddPawn("meta_goo3")  

meta_gooAtk3 = Skill:new{
	Name = "Goo Crush",
	Description = "Kills an adjacent unit.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = DAMAGE_DEATH,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "meta_goo3"
	}
}

function meta_gooAtk3:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		ret:push_back(curr)
	end
	return ret
end

function meta_gooAtk3:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddMelee(p1, SpaceDamage(p2, DAMAGE_DEATH))
	return ret
end

return this