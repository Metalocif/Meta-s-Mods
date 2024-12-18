local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath .."libs/weaponPreview")
local saveData = require(mod_loader.mods.meta_mods.scriptPath.."libs/saveData")
modApi:appendAsset("img/weapons/firefly.png", path .."img/weapons/firefly.png")
modApi:appendAsset("img/achievements/PerfectlyUltimateGreatFirefly.png", path .."img/achievements/PerfectlyUltimateGreatFirefly.png")

meta_firefly=TankDefault:new{
	Name="Spitting Thorax",
	Class="TechnoVek",
	Description="Fire a pushing projectile that applies Gunk. Will not damage allied gooey pawns.",
	Icon="weapons/firefly.png",
	Damage=1,
	PathSize=8,
	Shots = 1,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={3,3},
	UpgradeList={"+1 Shot","+1 Shot"},
	Self = "meta_firefly",
	LaunchSound = "/enemy/firefly_1/attack",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Meta_TechnoFirefly",
	}
}
meta_firefly_A = meta_firefly:new{UpgradeDescription = "Fires one more projectile.", Shots = 2, Self = "meta_firefly_A",}
meta_firefly_B = meta_firefly:new{UpgradeDescription = "Fires one more projectile.", Shots = 2, Self = "meta_firefly_B",}
meta_firefly_AB = meta_firefly:new{Shots = 3, Self = "meta_firefly_AB",}

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


local GooeyPawns = {
	--all my Blobs
	"Meta_nestedgoo", "Meta_pylongoo", "Meta_shapeshifter", "Meta_sludgegoo", "Meta_spikygoo", "Meta_splittinggoo", 
	"Meta_TitanicGooBoss",	
	--Cyborg Weapons deployables
	"CyborgWeapons_Deployable_MediumOoze", "CyborgWeapons_Deployable_SmallOoze",	
	--vanilla
	"BlobBoss",
	"Blob1", "Blob2", "BlobB",
	--SS4 Blobber's Spawns
	"meta_blob", "meta_goo", "meta_sludge"
}

local function IsGooey(pawnType)
	for _, gooType in ipairs(GooeyPawns) do
		if string.match(pawnType, gooType) or string.match(gooType, pawnType) then return true end 
	end
	return false
end

function meta_firefly:GetSkillEffect(p1, p2, remainingShots)
	local ret = SkillEffect()
	local userID = Board:GetPawn(p1):GetId()
	local target = GetProjectileEnd(p1,p2)
	local direction = GetDirection(p2-p1)
	remainingShots = remainingShots or self.Shots
	
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "ExploFirefly2"
	damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
	local pawn = Board:GetPawn(target)
	if pawn then damage.sScript = string.format("Status.ApplyGunk(%s)", pawn:GetId()) end
	if pawn and IsGooey(pawn:GetType()) then damage.iDamage = 0 end
	ret:AddProjectile(p1, damage, "effects/shot_firefly2", NO_DELAY)
	ret:AddDelay(0.15)
	if remainingShots > 1 then
		remainingShots = remainingShots - 1
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
	end
	
	-- Achievement
	if saveData ~= nil then
		LOG("save data")
		local reactorTable = saveData.getPawnKey(userID, "reactor")
		if reactorTable ~= nil then
			LOG("reactorTable")
			local reactors = reactorTable["iNormalPower"] + reactorTable["iUsedPower"] + reactorTable["iBonusPower"] + reactorTable["iUsedBonus"]
			LOG(reactors)
			if reactors >= 10 and self.Shots >= 3 and GameData ~= nil and GameData.current["pilot"..userID] ~= nil and GameData.current["pilot"..userID].level == 2 then
				ret:AddScript("completePerfectlyUltimateGreatFirefly()")
			end
		end
	end
	
	return ret
end	

-- function meta_firefly:Shoot(origin,direction)
	-- local ret = SkillEffect()
	-- local target = GetProjectileEnd(origin, origin+DIR_VECTORS[direction])
	-- local damage = SpaceDamage(target, self.Damage)
	-- local pawn = Board:GetPawn(target)
	-- local isLast = true
	-- if pawn then
		-- if Status.GetStatus(pawn:GetId(), "Gunk") then isLast = false else damage.iPush = direction end		--because we won't pierce so it's the last target
		-- if IsGooey(pawn:GetType()) then damage.iDamage = 0 end
	-- end
	-- local delay = PROJ_DELAY
	-- if isLast then damage.sAnimation = "ExploFirefly2" delay = FULL_DELAY end
	-- ret:AddProjectile(origin, damage, "effects/shot_firefly2", delay)
	-- return ret
-- end


--beautiful baby but a bit buggy

-- function meta_firefly:GetSkillEffect(p1, p2, remainingShots)
	-- local ret = SkillEffect()
	-- local direction = GetDirection(p2-p1)
	-- local target = p1 + DIR_VECTORS[direction]
	-- local isBackwards = p1:Manhattan(p2) == 2
	-- for i = 1, 8 do
		-- local pawn = Board:GetPawn(target)
		-- if Board:IsBlocked(target, PATH_PROJECTILE) and not (pawn and Status.GetStatus(pawn:GetId(), "Gunk")) then break end
		-- if not Board:IsValid(target + DIR_VECTORS[direction]) then break end
		-- target = target + DIR_VECTORS[direction]
	-- end
	-- local damage = SpaceDamage(target, self.Damage, direction)
	-- damage.sAnimation = "ExploFirefly2"
	-- if Board:GetPawn(target) then
		-- if IsGooey(Board:GetPawn(target):GetType()) then damage.iDamage = DAMAGE_ZERO end
		-- if self.Gunk then damage.sScript = string.format("Status.ApplyGunk(%s)", Board:GetPawn(target):GetId()) end
		-- if Board:GetPawn(target + DIR_VECTORS[direction]) and self.Shots == 2 and not isBackwards then 
			-- local extra_damage_event = SpaceDamage(target + DIR_VECTORS[direction])
			-- extra_damage_event.iPush = 230
			-- weaponPreview:AddDamage(extra_damage_event)
		-- end	
	-- end
	-- remainingShots = remainingShots or self.Shots
	-- if self.Shots == 2 and not isBackwards then damage.sImageMark = MultishotLib:getImageMark(1, 2, p1, target) end
	-- ret:AddProjectile(p1, damage, "effects/shot_firefly2", NO_DELAY)
	-- ret:AddDelay(0.2)
	-- for i = 1, p1:Manhattan(target) do
		-- local curr = p1 + DIR_VECTORS[direction] * i
		-- local pawn = Board:GetPawn(curr)
		-- if pawn then
			-- local midwayDamage = SpaceDamage(curr, self.Damage)
			-- midwayDamage.sAnimation = "ExploFirefly2"
			-- if self.Gunk then ret:AddScript(string.format("Status.ApplyGunk(%s)", pawn:GetId())) end
			-- if IsGooey(pawn:GetType()) then midwayDamage.iDamage = 0 end
			-- ret:AddDamage(midwayDamage)
		-- end
		-- ret:AddDelay(0.1)
	-- end
	-- if remainingShots > 1 then
		-- remainingShots = remainingShots - 1
		-- if isBackwards then p2 = p1 - DIR_VECTORS[direction] end
		-- if p1 ~= p2 and Board:IsValid(p2) then 
			-- ret:AddScript(string.format([=[
				-- local fx = SkillEffect();
				-- fx:AddScript([[
					-- Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
				-- ]]);
				-- Board:AddEffect(fx);
			-- ]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
		-- end
	-- end
	-- if self.Shots == 2 and isBackwards then
		-- local target = p1 + DIR_VECTORS[direction]
		-- for i = 1, 8 do
			-- local pawn = Board:GetPawn(target)
			-- if Board:IsBlocked(target, PATH_PROJECTILE) and not (pawn and Status.GetStatus(pawn:GetId(), "Gunk")) then break end
			-- if not Board:IsValid(target + DIR_VECTORS[direction]) then break end
			-- target = target + DIR_VECTORS[direction]
		-- end
		-- local damage = SpaceDamage(target, self.Damage, direction)
		-- if Board:GetPawn(target) and IsGooey(Board:GetPawn(target):GetType()) then damage.iDamage = DAMAGE_ZERO end
		-- weaponPreview:AddDamage(damage)
		-- for i = 1, p1:Manhattan(target) do
			-- local curr = p1 + DIR_VECTORS[direction] * i
			-- local pawn = Board:GetPawn(curr)
			-- if pawn then
				-- local midwayDamage = SpaceDamage(curr, self.Damage)
				-- if IsGooey(pawn:GetType()) then midwayDamage.iDamage = 0 end
				-- weaponPreview:AddDamage(midwayDamage)
			-- end
		-- end
	-- end
	-- return ret
-- end	


-- function meta_firefly:GetSkillEffect(p1,p2)
	-- local ret = SkillEffect()
	
	-- local direction = GetDirection(p2-p1)
	-- local new_damage_list = DamageList()
	-- local pierce
	
	-- for i = 1, self.Shots do
		-- local origin = p1
		-- local target = GetProjectileEnd(p1, p2)
		
		-- repeat
			-- local pawn = Board:GetPawn(target)
			-- pierce = false
			-- if pawn and Status.GetStatus(pawn:GetId(), "Gunk") then pierce = true end
			-- for _, spaceDamage in ipairs(extract_table(meta_firefly:Shoot(origin, direction).effect)) do
				-- new_damage_list:push_back(spaceDamage)
			-- end
			-- origin = target
			-- target = GetProjectileEnd(target, target+DIR_VECTORS[direction])
		-- until not pierce
		-- if p1:Manhattan(p2) == 2 then	--reverse direction for second Shot
			-- direction = (direction + 2) % 4
			-- p2 = p1 + DIR_VECTORS[direction]
			-- if p1 == p2 or not Board:IsValid(p2) then break end
		-- end
	-- end
	-- ret.effect = new_damage_list
	-- return ret
-- end









--previous version of the weapon below. Buggy and confusing.

-- function meta_firefly:GetTargetArea(point)
	-- local ret = PointList()
	-- local damageAmount = self.Damage 
	-- if Board:GetPawn(point):IsBoosted() then damageAmount = damageAmount + 1 end
	-- for dir = DIR_START, DIR_END do
		-- local pawnsHit = 0
		-- for i = 1, 8 do
			-- local curr = point + DIR_VECTORS[dir] * i
			-- if not Board:IsValid(curr) then break end
			-- if Board:GetPawn(curr) and not Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk") then pawnsHit = pawnsHit + 1 end
			-- ret:push_back(curr)
			-- if pawnsHit > damageAmount then break end
			
			-- if Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:GetTerrain(curr) == TERRAIN_BUILDING then break end
		-- end
	-- end
	-- return ret
-- end

-- function meta_firefly:GetSkillEffect(p1,p2)
	-- local ret = SkillEffect()
	-- local userID = Board:GetPawn(p1):GetId()
	-- local direction = GetDirection(p2 - p1)
	-- local distance = math.max(p1:Manhattan(GetProjectileEnd(p1, p2)), p1:Manhattan(p2))
	-- local remainingDamage = self.Damage + 1		--because we always subtract 1?	
	-- local last_origin = p1
	-- local dealDamageTo = {}
	-- ret:AddSound(self.LaunchSound)
	-- for i = distance, 1, -1 do
		-- local check = p1 + DIR_VECTORS[direction] * i
		-- if Board:GetPawn(check) and not Status.GetStatus(Board:GetPawn(check):GetId(), "Gunk") then 
			-- remainingDamage = remainingDamage - 1 
			-- dealDamageTo[#dealDamageTo+1] = check
		-- end
		-- if #dealDamageTo == 0 and (Board:GetTerrain(check) == TERRAIN_MOUNTAIN or Board:GetTerrain(check) == TERRAIN_BUILDING) then dealDamageTo[1] = check end
	-- end
	-- if #dealDamageTo == 0 then return ret end
	-- local damage = SpaceDamage(dealDamageTo[1], remainingDamage, direction)
	-- ret:AddProjectile(p1, damage, "effects/shot_firefly2", NO_DELAY)
	-- ret:AddDelay(0.2 + distance*0.1)
	-- for i = 1, distance - 1 do
		-- local curr = p1 + DIR_VECTORS[direction] * i
		-- if Board:GetPawn(curr) and curr ~= dealDamageTo[1] then ret:AddDamage(SpaceDamage(curr, remainingDamage, direction)) end
	-- end
		
	-- if saveData ~= nil then
		-- local reactorTable = saveData.getPawnKey(userID, "reactor")
		-- if reactorTable ~= nil then
			-- local reactors = reactorTable["iNormalPower"] + reactorTable["iUsedPower"] + reactorTable["iBonusPower"] + reactorTable["iUsedBonus"]
			-- if reactors >= 10 and self.Damage >= 3 and GameData ~= nil and GameData.current["pilot"..userID] ~= nil and GameData.current["pilot"..userID].level == 2 then
				-- ret:AddScript("completePerfectlyUltimateGreatFirefly()")
			-- end
		-- end
	-- end
	-- return ret	
-- end