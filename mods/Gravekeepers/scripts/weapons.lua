modApi:appendAssets("img/weapons/", "img/weapons/")
modApi:appendAssets("img/effects/", "img/effects/")

Location["effects/laserbanshee_hit.png"] = Point(-12,3)
Location["effects/laserbanshee_R.png"] = Point(-12,3)
Location["effects/laserbanshee_R1.png"] = Point(-12,3)
Location["effects/laserbanshee_R2.png"] = Point(-12,3)
Location["effects/laserbanshee_start.png"] = Point(-12,3)
Location["effects/laserbanshee_U.png"] = Point(-12,3)
Location["effects/laserbanshee_U1.png"] = Point(-12,3)
Location["effects/laserbanshee_U2.png"] = Point(-12,3)

Gravekeepers_Banshee = Skill:new{
	Name = "Wailing Laser",
	Description = "Damages everything in a line, stopping on mountains and buildings. Will not damage friendly targets.",
	Class = "Brute",
	Icon = "weapons/Banshee.png",
	LaserArt = "effects/laserbanshee",
	LaunchSound = "/weapons/burst_beam",
	Push = false,
	Damage = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 2, 2 },
	UpgradeList = { "Pierce", "Push" },
	ZoneTargeting = ZONE_DIR,
	PushFriendly = true,  -- pushed (but never damaged) so the whole line shifts together

	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Friendly = Point(2,2),
		Building = Point(2,1),
		Enemy2 = Point(2,0),
		Target = Point(2,3),
	}
}

function Gravekeepers_Banshee:IsBlocker(point)
	return Board:GetTerrain(point) == TERRAIN_MOUNTAIN or Board:IsBuilding(point)
end

function Gravekeepers_Banshee:IsFriendly(point)
	if Board:IsBuilding(point) then return true end
	return Board:IsPawnSpace(point) and Board:GetPawnTeam(point) == TEAM_PLAYER
end

-- Every tile the beam reaches, nearest first. Without Pierce the line
-- ends on (and includes) the first mountain/building.
function Gravekeepers_Banshee:GetBeamLine(p1, dir)
	local line = {}
	local curr = p1 + DIR_VECTORS[dir]

	while Board:IsValid(curr) do
		line[#line + 1] = curr
		if not self.Pierce and self:IsBlocker(curr) then break end
		curr = curr + DIR_VECTORS[dir]
	end

	return line
end

function Gravekeepers_Banshee:GetTargetArea(point)
	local ret = PointList()

	for dir = DIR_START, DIR_END do
		for _, curr in ipairs(self:GetBeamLine(point, dir)) do
			ret:push_back(curr)
		end
	end

	return ret
end

function Gravekeepers_Banshee:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local line = self:GetBeamLine(p1, dir)
	if #line == 0 then return ret end
	local user = Board:GetPawn(p1)
	if not user then return ret end
	if user:GetType() == "Mech_Banshee" then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_banshee_chargeup"))
		ret:AddDelay(1.2)
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), "mech_bansheea"))
	end
	-- Beam visual: runs to the blocker, or off the edge of the board
	local last = line[#line]
	local beamEnd = last
	if self.Pierce or not self:IsBlocker(last) then
		beamEnd = last + DIR_VECTORS[dir]
	end
	ret:AddProjectile(SpaceDamage(beamEnd, 0), self.LaserArt)
	local first, final, step = 1, #line, 1
	if self.Push then first, final, step = #line, 1, -1 end

	for i = first, final, step do
		local curr = line[i]

		-- Buildings are friendly: never damaged, nothing to push
		if not Board:IsBuilding(curr) then
			local friendly = self:IsFriendly(curr)
			local pushes = self.Push and (self.PushFriendly or not friendly)

			if not friendly or pushes then
				local damage = SpaceDamage(curr, friendly and 0 or self.Damage)
				if pushes then damage.iPush = dir end

				if Board:IsPawnSpace(curr) then ret:AddDelay(0.1) end
				ret:AddDamage(damage)
			end
		end
	end

	return ret
end

Gravekeepers_Banshee_A = Gravekeepers_Banshee:new{
	Pierce = true,
	UpgradeDescription = "Goes through mountains and buildings. With both upgrades, also increases damage by 1.",
}

Gravekeepers_Banshee_B = Gravekeepers_Banshee:new{
	UpgradeDescription = "Pushes all units hit. With both upgrades, also increases damage by 1.",
	Push = true,
	LaunchSound = "/weapons/push_beam",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Friendly = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,3),
	}
}

Gravekeepers_Banshee_AB = Gravekeepers_Banshee_B:new{
	Pierce = true,
	Damage = 2,
}

Gravekeepers_Wraith = Skill:new{
	Name = "Ghastly Rush",
	Description = "Dash any distance in a line. Pushes the tile behind its starting position. Applies A.C.I.D. on units the user passes through.",
	Class = "Science",
	Icon = "weapons/Wraith.png",
	LaunchSound = "/weapons/charge",
	Damage = 0,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 1, 3 },
	UpgradeList = { "Phase", "Side Push" },
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),  
		Enemy2 = Point(2,3), 
		Target = Point(2,0),
	}
}

function Gravekeepers_Wraith:GetTargetArea(point)
	local ret = PointList()
	local profile = Pawn and Pawn:GetPathProf() or PATH_GROUND

	for dir = DIR_START, DIR_END do
		for k = 1, 8 do
			local curr = point + DIR_VECTORS[dir] * k

			if not Board:IsValid(curr) then break end
			if (Board:GetTerrain(point) == TERRAIN_MOUNTAIN or Board:IsBuilding(point)) and not self.PassSolid then break end
			if not Board:IsBlocked(curr, profile) then ret:push_back(curr) end
		end
	end

	return ret
end

function Gravekeepers_Wraith:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	local back = (dir + 2) % 4
	local right, left = (dir + 1) % 4, (dir + 3) % 4

	local behind = p1 - DIR_VECTORS[dir]
	if Board:IsValid(behind) then
		local kick = SpaceDamage(behind, 0, back)
		kick.sAnimation = "exploout0_" .. back
		ret:AddDamage(kick)
	end

	local path = PointList()
	for i = 0, distance do
		path:push_back(p1 + DIR_VECTORS[dir] * i)
	end
	ret:AddCharge(path, NO_DELAY)

	for i = 0, distance do
		local curr = p1 + DIR_VECTORS[dir] * i
		ret:AddDelay(0.06)
		ret:AddBounce(curr, -3)

		if i > 0 and i < distance and Board:IsPawnSpace(curr) then
			local acid = SpaceDamage(curr, 0)
			acid.iAcid = 1
			ret:AddDamage(acid)
		end

		if self.SidePush then
			for _, side in ipairs({ right, left }) do
				local tile = curr + DIR_VECTORS[side]
				if Board:IsValid(tile) then
					local shove = SpaceDamage(tile, 0, side)
					shove.sAnimation = "exploout0_" .. side
					ret:AddDamage(shove)
				end
			end
		end
	end

	return ret
end

Gravekeepers_Wraith_A = Gravekeepers_Wraith:new{
	UpgradeDescription = "Passes through mountains and buildings.",
	PassSolid = true,
	TipImage = {
		Unit = Point(2,3),
		Mountain = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,0),
	}
}

Gravekeepers_Wraith_B = Gravekeepers_Wraith:new{
	UpgradeDescription = "Pushes units away during the dash.",
	SidePush = true,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(1,2),
		Enemy2 = Point(3,1),
		Target = Point(2,0),
	}
}

Gravekeepers_Wraith_AB = Gravekeepers_Wraith:new{
	PassSolid = true,
	SidePush = true,
	TipImage = {
		Unit = Point(2,3),
		Mountain = Point(2,2),
		Enemy = Point(1,2),
		Enemy2 = Point(3,1),
		Target = Point(2,0),
	}
}

Gravekeepers_Reaper = Skill:new{
	Name = "Lethal Edge",
	Description = "Damages an adjacent unit, or deals more damage and pulls if there is 1 tile of distance between the user and target.",
	Class = "Prime",
	Icon = "weapons/Reaper.png",
	LaunchSound = "/weapons/sword",
	MinDamage = 1,      -- range 1
	Damage = 2,  
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 2, 3 },
	UpgradeList = { "+1 Range", "+2 Max Damage" },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Target = Point(2,2),
	}
}

function Gravekeepers_Reaper:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for k = 1, 2 do
			local curr = point + DIR_VECTORS[dir] * k
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
		end
	end

	if self.Range3 then
		local offsets = {Point(3, 0), Point(0, 3), Point(-3, 0), Point(0, -3),
						 Point(2, 1), Point(1, 2), Point(-2, 1), Point(1, -2),
						 Point(2, -1), Point(-1, 2), Point(-2, -1), Point(-1, -2)}
		for _, offset in ipairs(offsets) do
			local curr = point + offset
			if Board:IsValid(curr) then ret:push_back(curr) end
		end
	end

	return ret
end


function Gravekeepers_Reaper:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dist = p1:Manhattan(p2)
	local dir = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage)
	if dist == 2 then
		damage.iPush = (dir+2)%4
	elseif dist == 3 and (p1.x == p2.x or p1.y == p2.y) then
		damage.iPush = dir
	elseif dist == 3 then
		local p3 = p1 + DIR_VECTORS[dir] * 2
		damage.iPush = GetDirection(p2-p3)
	elseif dist == 1 then
		damage.iDamage = self.MinDamage
	end
	local emitterAmount = damage.iDamage
	if Board:GetPawn(p1) and Board:GetPawn(p1):IsBoosted() then emitterAmount = emitterAmount + 1 end
	local start1 = p2 + DIR_VECTORS[DIR_DOWN]
	local end1 = p2 + DIR_VECTORS[DIR_UP]
	local start2 = p2 + DIR_VECTORS[DIR_RIGHT]
	local end2 = p2 + DIR_VECTORS[DIR_LEFT]
	if not Board:IsValid(start1) then start1 = p2 end
	if not Board:IsValid(end1) then end1 = p2 end
	if not Board:IsValid(start2) then start2 = p2 end
	if not Board:IsValid(end2) then end2 = p2 end
	ret:AddProjectile(start1, SpaceDamage(end1), "effects/reaperslash", NO_DELAY)
	ret:AddProjectile(start2, SpaceDamage(end2), "effects/reaperslash", NO_DELAY)
	if dist == 1 then
		ret:AddMelee(p1, damage)
	else
		ret:AddDamage(damage)
	end

	return ret
end

Gravekeepers_Reaper_A = Gravekeepers_Reaper:new{
	UpgradeDescription = "Can target tiles at a distance of 3.",
	Range3 = true,
	TipImage = {
		Unit = Point(1,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}

Gravekeepers_Reaper_B = Gravekeepers_Reaper:new{
	UpgradeDescription = "Deals 2 more damage against distant targets.",
	Damage = 4,
}

Gravekeepers_Reaper_AB = Gravekeepers_Reaper_A:new{
	Damage = 4,
}


Gravekeepers_Passive=PassiveSkill:new{
	Name="Limbo",
	Class="",
	Passive="Gravekeepers_Passive",		--doesn't do anything, just there so other mods can tell it's a passive
	Description="Mechs can move through obstacles and into mountains and buildings.",
	Upgrades=1,
	UpgradeList={"Heal on kill"},
	UpgradeCost={2},
	Icon = "weapons/Passive.png",
	TipImage = {
		Unit = Point(1,1),
		Enemy = Point(2,2),
		Mountain = Point(1,1),
		CustomEnemy = "Leaper1",
	}
}
Gravekeepers_Passive_A=Gravekeepers_Passive:new{UpgradeDescription="Mechs heal when they kill an enemy."}


local function EVENT_onModsLoaded()
	modapiext:addPawnKilledHook(function(mission, pawn)		--explode
		if not mission then return end
		if not pawn then return end
		local flag
		for i = 0, 2 do
			if Board:GetPawn(i) then
				local weapons = Board:GetPawn(i):GetPoweredWeaponTypes()
				if weapons[1] == "Gravekeepers_Passive_A" or weapons[2] == "Gravekeepers_Passive_A" then 
					flag = true 
					break
				end
			end
		end
		if flag and Pawn and Pawn:IsMech() then Board:DamageSpace(SpaceDamage(Pawn:GetSpace(), -1)) end
	end)
end
modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


modApi:addWeaponDrop("Gravekeepers_Banshee")
modApi:addWeaponDrop("Gravekeepers_Wraith")
modApi:addWeaponDrop("Gravekeepers_Reaper")
modApi:addWeaponDrop("Gravekeepers_Passive")