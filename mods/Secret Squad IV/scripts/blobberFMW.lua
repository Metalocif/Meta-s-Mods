local this = {}
local path = mod_loader.mods[modApi.currentMod].scriptPath
local resources = mod_loader.mods[modApi.currentMod].resourcePath
local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath .."libs/weaponPreview")
modApi:appendAsset("img/achievements/GreatestGoo.png", resources .."img/achievements/GreatestGoo.png")



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


local achievements = {
	Meta_GreatestGoo = modApi.achievements:add{
		id = "Meta_GreatestGoo",
		name = "Greatest Goo",
		tip = "Have a goo eat enough nutritious gunk to become the greatest goo, dealing at least 5 damage with its attack.",
		img = resources.."img/achievements/GreatestGoo.png",
		squad = "Meta_SecretSquad4",
	}, 
}

function completeGreatestGoo()
	if not achievements.Meta_GreatestGoo:isComplete() then achievements.Meta_GreatestGoo:addProgress{ complete = true } end
end



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
	local queueP2
	if p1:Manhattan(p2) > 1 and (p1.x == p2.x or p1.y == p2.y) then 
		damage.sPawn = "meta_blob"
		queueP2 = true
	elseif p1:Manhattan(p2) > 1 then
		damage.sPawn = "meta_sludge"
	else
		damage.sPawn = "meta_goo"
	end
	ret:AddArtillery(p1, damage, "effects/shotup_blobber2.png", FULL_DELAY)
	if queueP2 then ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", p2:GetString(), p2:GetString())) end

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
	-- Neutral = true,
	IgnoreSmoke = true,
	IsPortrait = false,
	Image = "blob",
	ImageOffset = 1,
	SkillList = { "meta_BlobAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	IsDeathEffect = true,
	OnAppliedGunk = Status.HealFromGunk,
}
AddPawn("meta_blob")  

function meta_blob:GetDeathEffect(point)
	local ret = SkillEffect()
	Board:SetItem(point, "Meta_BlobGunk")
	return ret
end

meta_BlobAtk1 = Skill:new{
	Name = "Volatile Guts",
	Description = "Explode, damaging adjacent tiles for 2 damage. Chains off gunk.",
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
	local hash = function(point) return point.x + point.y*10 end
	local explored = {[hash(p1)] = true}
	local todo = {}
	local origin = {  }
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		todo[#todo+1] = curr
		origin[hash(curr)] = p1
	end
	while #todo ~= 0 do
		local current = pop_back(todo)
		if not explored[hash(current)] then
			explored[hash(current)] = true
			local pawn = Board:GetPawn(current)
			local damage = SpaceDamage(current, self.Damage)
			damage.sAnimation = "exploout2_"..GetDirection(current - origin[hash(current)])
			ret:AddQueuedDamage(damage)
			if Board:GetItem(current) == "Meta_BlobGunk" or (pawn and Status.GetStatus(pawn:GetId(), "Gunk")) then
				for i = DIR_START, DIR_END do
					local curr = current + DIR_VECTORS[i]
					todo[#todo+1] = curr
					origin[hash(curr)] = current
				end
				ret:AddQueuedScript(string.format("Board:RemoveItem(%s)", current:GetString()))
				if pawn then ret:AddQueuedScript(string.format("Status.RemoveStatus(%s, %q)", pawn:GetId(), "Gunk")) end
			end
		end
	end
	ret:AddQueuedDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end


meta_sludge = {
	Name = "Sludge",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Minor = true,
	Image = "meta_sludge",			
	SkillList = { "meta_SludgeAtk1" },
	SoundLocation = "/enemy/goo_boss/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,	
	Portrait = "enemy/BlobBoss",
	OnAppliedGunk = Status.HealFromGunk,
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
	ret:AddDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end

function levelUpGoo(gooId)
	local goo = Board:GetPawn(gooId)
	local evolveInto
	if not goo then return end
	local p1 = goo:GetSpace()
	local hadMoved = goo:IsMovementSpent() or not goo:IsActive()
	local wasGrappledFrom = {}
	if goo:IsGrappled() then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:IsQueued() then
				local fx = _G[pawn:GetQueuedWeapon()]:GetSkillEffect(pawn:GetSpace(), pawn:GetQueuedTarget())
				for _, spaceDamage in ipairs(extract_table(fx.effect)) do
					if spaceDamage:GetGrappleTarget() == p1 then wasGrappledFrom[i] = true end
				end
			end
		end	
	end
	if goo:GetType() == "meta_goo" then
		evolveInto = "meta_goo2"
	elseif goo:GetType() == "meta_goo2" then
		evolveInto = "meta_goo3"
	else
		Status.ApplyGunk(gooId)
		modApi:runLater(function() goo:FireWeapon(p1, 1) end)
		return
	end
	local unit = PAWN_FACTORY:CreatePawn(evolveInto)
	unit:SetOwner(goo:GetOwner())
	unit:SetMovementSpent(hadMoved)
	Board:RemovePawn(goo)
	Board:AddPawn(unit, p1)
	local fx = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if wasGrappledFrom[i] then fx:AddGrapple(curr, p1, "hold") end
	end
	Board:AddEffect(fx)
	modApi:runLater(function() unit:FireWeapon(p1, 1) end)
	--this bit is to resume eating adjacent gunk all at once
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
	Portrait = "enemy/BlobBoss",
	OnAppliedGunk = levelUpGoo,
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
		if Board:GetItem(curr) == "Meta_BlobGunk" then foundGunk = true end
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
			if (Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk")) or Board:GetItem(curr) == "Meta_BlobGunk" then 
				local preview = SpaceDamage(p1)
				preview.sPawn = "meta_goo2"
				weaponPreview:AddDamage(preview)
				if Board:GetItem(curr) == "Meta_BlobGunk" then
					ret:AddScript(string.format("Board:RemoveItem(%s)", curr:GetString()))
				else
					ret:AddScript(string.format("Status.RemoveStatus(Board:GetPawn(%s):GetId(), %q)", curr:GetString(), "Gunk"))
				end
				ret:AddScript(string.format("levelUpGoo(%s)", Board:GetPawn(p1):GetId()))
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
	Portrait = "enemy/BlobBoss",
	OnAppliedGunk = levelUpGoo,
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
		if Board:GetItem(curr) == "Meta_BlobGunk" then foundGunk = true end
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
			if (Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk")) or Board:GetItem(curr) == "Meta_BlobGunk" then 
				local preview = SpaceDamage(p1)
				preview.sPawn = "meta_goo2"
				weaponPreview:AddDamage(preview)
				if Board:GetItem(curr) == "Meta_BlobGunk" then
					ret:AddScript(string.format("Board:RemoveItem(%s)", curr:GetString()))
				else
					ret:AddScript(string.format("Status.RemoveStatus(Board:GetPawn(%s):GetId(), %q)", curr:GetString(), "Gunk"))
				end
				ret:AddScript(string.format("levelUpGoo(%s)", Board:GetPawn(p1):GetId()))
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
	Portrait = "enemy/BlobBoss",
	OnAppliedGunk = Status.HealFromGunk,
}
AddPawn("meta_goo3")  

meta_gooAtk3 = Skill:new{
	Name = "Goo Crush",
	Description = "Pushes and damages an adjacent unit. When adjacent to gunk, can self-target to eat the gunk, empowering the user.",
	Class = "TechnoVek",
	Icon = "weapons/goo.png",
	PathSize = 1, 
	Damage = 3,
	MinDamage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "meta_goo3"
	}
}

function meta_gooAtk3:GetTargetArea(point)
	local ret = PointList()
	local foundGunk
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then foundGunk = true end
		if Board:GetItem(curr) == "Meta_BlobGunk" then foundGunk = true end
		ret:push_back(curr)
	end
	if foundGunk then ret:push_back(point) end
	return ret
end

function meta_gooAtk3:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local HP = Board:GetPawn(p1):GetHealth()
	if p1 == p2 then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if (Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk")) or Board:GetItem(curr) == "Meta_BlobGunk" then 
				if Board:GetItem(curr) == "Meta_BlobGunk" then
					ret:AddScript(string.format("Board:RemoveItem(%s)", curr:GetString()))
				else
					ret:AddScript(string.format("Status.RemoveStatus(Board:GetPawn(%s):GetId(), %q)", curr:GetString(), "Gunk"))
				end
				ret:AddScript(string.format("levelUpGoo(%s)", Board:GetPawn(p1):GetId()))
				ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", Board:GetPawn(p1):GetId()))
				return ret
			end
		end
	end
	ret:AddMelee(p1, SpaceDamage(p2, HP, GetDirection(p2-p1)))
	if HP >= 5 then ret:AddScript("completeGreatestGoo()") end
	return ret
end

return this