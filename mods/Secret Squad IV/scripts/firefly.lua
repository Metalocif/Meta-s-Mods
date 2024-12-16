local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/firefly.png", path .."img/weapons/firefly.png")
modApi:appendAsset("img/achievements/PerfectlyUltimateGreatFirefly.png", path .."img/achievements/PerfectlyUltimateGreatFirefly.png")

meta_firefly=TankDefault:new{
	Name="Spitting Thorax",
	Class="TechnoVek",
	Description="Damages and pushes a target. Can sacrifice damage to pierce through more targets.",
	Icon="weapons/firefly.png",
	Damage=1,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={2,3},
	UpgradeList={"+1 Damage","+1 Damage"},
	
	LaunchSound = "/enemy/firefly_1/attack",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Meta_TechnoFirefly",
	}
}
meta_firefly_A = meta_firefly:new{UpgradeDescription = "Deals 1 more damage.", Damage = 2}
meta_firefly_B = meta_firefly:new{UpgradeDescription = "Deals 1 more damage.", Damage = 2}
meta_firefly_AB = meta_firefly:new{Damage = 3}

local achievements = {
	Meta_PerfectlyUltimateGreatFirefly = modApi.achievements:add{
		id = "Meta_PerfectlyUltimateGreatFirefly",
		name = "Perfectly Ultimate Great Firefly",
		tip = "Use the Techno-Firefly's fully upgraded weapon when it is fully levelled and powered.",
		img = path.."img/achievements/PerfectlyUltimateGreatFirefly.png",
		squad = "Meta_SecretSquad4",
	}, 
}

function completePerfectlyUltimateGreatFirefly()
	if not achievements.Meta_PerfectlyUltimateGreatFirefly:isComplete() then achievements.Meta_PerfectlyUltimateGreatFirefly:addProgress{ complete = true } end
end

function meta_firefly:GetTargetArea(point)
	local ret = PointList()
	local damageAmount = self.Damage 
	if Board:GetPawn(point):IsBoosted() then damageAmount = damageAmount + 1 end
	for dir = DIR_START, DIR_END do
		local pawnsHit = 0
		for i = 1, 8 do
			local curr = point + DIR_VECTORS[dir] * i
			if not Board:IsValid(curr) then break end
			if Board:GetPawn(curr) and not Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then pawnsHit = pawnsHit + 1 end
			ret:push_back(curr)
			if pawnsHit > damageAmount then break end
			
			if Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:GetTerrain(curr) == TERRAIN_BUILDING then break end
		end
	end
	return ret
end

function meta_firefly:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local userID = Board:GetPawn(p1):GetId()
	local direction = GetDirection(p2 - p1)
	local distance = math.max(p1:Manhattan(GetProjectileEnd(p1, p2)), p1:Manhattan(p2))
	local remainingDamage = self.Damage + 1		--because we always subtract 1?	
	local last_origin = p1
	local dealDamageTo = {}
	ret:AddSound(self.LaunchSound)
	for i = distance, 1, -1 do
		local check = p1 + DIR_VECTORS[direction] * i
		if Board:GetPawn(check) and not Status.GetStatus(Board:GetPawn(check):GetId(), "Gunk") then 
			remainingDamage = remainingDamage - 1 
			dealDamageTo[#dealDamageTo+1] = check
		end
		if #dealDamageTo == 0 and (Board:GetTerrain(check) == TERRAIN_MOUNTAIN or Board:GetTerrain(check) == TERRAIN_BUILDING) then dealDamageTo[1] = check end
	end
	if #dealDamageTo == 0 then return ret end
	local damage = SpaceDamage(dealDamageTo[1], remainingDamage, direction)
	ret:AddProjectile(p1, damage, "effects/shot_firefly2", NO_DELAY)
	ret:AddDelay(0.2 + distance*0.1)
	for i = 1, distance - 1 do
		local curr = p1 + DIR_VECTORS[direction] * i
		if Board:GetPawn(curr) and curr ~= dealDamageTo[1] then ret:AddDamage(SpaceDamage(curr, remainingDamage, direction)) end
	end
		
	if saveData ~= nil then
		local reactorTable = saveData.getPawnKey(userID, "reactor")
		if reactorTable ~= nil then
			local reactors = reactorTable["iNormalPower"] + reactorTable["iUsedPower"] + reactorTable["iBonusPower"] + reactorTable["iUsedBonus"]
			if reactors >= 10 and self.Damage >= 3 and GameData ~= nil and GameData.current["pilot"..userID] ~= nil and GameData.current["pilot"..userID].level == 2 then
				ret:AddScript("completePerfectlyUltimateGreatFirefly()")
			end
		end
	end
	return ret	
end