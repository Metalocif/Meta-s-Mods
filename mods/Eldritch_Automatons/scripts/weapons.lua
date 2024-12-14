local path = mod_loader.mods[modApi.currentMod].resourcePath
local artilleryArc = require(mod_loader.mods.meta_mods.scriptPath .."libs/artilleryArc")
local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath .."libs/weaponPreview")
modApi:appendAsset("img/weapons/EldritchTentacles.png", path .."img/weapons/EldritchTentacles.png")
modApi:appendAsset("img/weapons/TentacularServant.png", path .."img/weapons/TentacularServant.png")
modApi:appendAsset("img/weapons/MindDomination.png", path .."img/weapons/MindDomination.png")

modApi:appendAsset("img/effects/coiledTentacle.png", path.."img/effects/coiledTentacle.png")
modApi:appendAsset("img/units/player/tentaclehelper.png", path.."img/units/player/tentaclehelper.png")
modApi:appendAsset("img/units/player/tentaclehelpera.png", path.."img/units/player/tentaclehelpera.png")
modApi:appendAsset("img/units/player/tentaclehelperw.png", path.."img/units/player/tentaclehelperw.png")
modApi:appendAsset("img/units/player/tentaclehelper_death.png", path.."img/units/player/tentaclehelper_death.png")
ANIMS.EldritchTentacle = ANIMS.MechUnit:new{ Image = "units/player/tentaclehelper.png", PosX = -15, PosY = 15, Height=1}
ANIMS.EldritchTentaclea = ANIMS.MechUnit:new{ Image = "units/player/tentaclehelpera.png", PosX = -15, PosY = 15, NumFrames = 6, Height=1 }
ANIMS.EldritchTentaclew = ANIMS.MechUnit:new{ Image = "units/player/tentaclehelperw.png", PosX = -15, PosY = 15, NumFrames = 1, Height=1 }
ANIMS.EldritchTentacled = ANIMS.MechUnit:new{ Image = "units/player/tentaclehelper_death.png", PosX = -15, PosY = 15, NumFrames = 5, Time = 0.14, Loop = false, Height=1 }

--might be better to have a mission table listing all tentacles in order of spawn, removing their ID via death effect
-- that way we have a specific order to make them attack in, like Vek, and player can kill new ones when Octopus is insane

local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

local achievements = {
	Meta_ComeWithMe = modApi.achievements:add{
		id = "Meta_ComeWithMe",
		name = "Come with me",
		tip = "Use Eldritch Tentacles to move at least 3 tiles, then grab an allied pawn at least 3 tiles.",
		img = path.."img/achievements/ComeWithMe.png",
		squad = "Meta_Eldritch",
	}, 
	Meta_TogetherInMadness = modApi.achievements:add{
		id = "Meta_TogetherInMadness",
		name = "Together in Madness",
		tip = "Have this mech's action turn at least two mechs fully insane.",
		img = path.."img/achievements/TogetherInMadness.png",
		squad = "Meta_Eldritch",
	},
	Meta_ArmyOfTheDeep = modApi.achievements:add{
		id = "Meta_ArmyOfTheDeep",
		name = "Army of the Deep",
		tip = "Have 5 Tentacles on the board at the same time.",
		img = path.."img/achievements/ArmyOfTheDeep.png",
		squad = "Meta_Eldritch",
	},
	Meta_EldritchSecret = modApi.achievements:add{
		id = "Meta_EldritchSecret",
		name = "Eldritch Mechs Secret Reward",
		tip = "Complete all 3 Eldritch Mechs achievements.",
		img = path.."img/achievements/secret.png",
		squad = "Meta_Eldritch",
		global = "Secret Rewards",
		secret = true,
		objective = {
			aa = true,
			bb = true,
			cc = true,
			reward = "?|Secret Pilot"}
	}
}

function completeComeWithMe()
	if not achievements.Meta_ComeWithMe:isComplete() then achievements.Meta_ComeWithMe:addProgress{ complete = true } achievements.Meta_EldritchSecret:addProgress{ aa = true } end
	if achievements.Meta_ArmyOfTheDeep:isComplete() and achievements.Meta_TogetherInMadness:isComplete() and achievements.Meta_ComeWithMe:isComplete() then	
		achievements.Meta_EldritchSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_Eldritch","Meta_EldritchSecret",true)
	end
end

function completeTogetherInMadness()
	if not achievements.Meta_TogetherInMadness:isComplete() then achievements.Meta_TogetherInMadness:addProgress{ complete = true }  achievements.Meta_EldritchSecret:addProgress{ bb = true } end
	if achievements.Meta_ArmyOfTheDeep:isComplete() and achievements.Meta_TogetherInMadness:isComplete() and achievements.Meta_ComeWithMe:isComplete() then	
		achievements.Meta_EldritchSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_Eldritch","Meta_EldritchSecret",true)
	end
end

function completeArmyOfTheDeep()
	if not achievements.Meta_ArmyOfTheDeep:isComplete() then achievements.Meta_ArmyOfTheDeep:addProgress{ complete = true } achievements.Meta_EldritchSecret:addProgress{ cc = true }  end
	if achievements.Meta_ArmyOfTheDeep:isComplete() and achievements.Meta_TogetherInMadness:isComplete() and achievements.Meta_ComeWithMe:isComplete() then	
		achievements.Meta_EldritchSecret:addProgress{ reward = true }
		modApi.achievements:trigger("Meta_Eldritch","Meta_EldritchSecret",true)
	end
end

function Pilot_AbdulAlhazred_Meta:IsEnabled()
  return achievements.Meta_EldritchSecret:isComplete() 
end


Meta_EldritchTentacles = Skill:new{  
	Name = "Eldritch Tentacles",
	Class = "Prime",
	Icon = "weapons/EldritchTentacles.png",
	Description = "Grab two remote targets. Induce Insanity in adjacent pilots. Insane: +1 damage, but will damage buildings.",
	Rarity = 3,
	Damage = 1,
	ZoneTargeting = ZONE_DIR,
	TwoClick = true,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "Doom",  "+1 Damage"  },
	UpgradeCost = { 2 , 2 },
	Self = "Meta_EldritchTentacles",
	UsesInsanity = true,
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Second_Target=Point(2,1),
		Second_Click=Point(2,1),
		Water = Point(2,0),
		CustomPawn = "Mech_Tentacular",
	}
}

Meta_EldritchTentacles_A = Meta_EldritchTentacles:new{UpgradeDescription = "Melee hits inflict Doomed. Doomed pawns take damage every turn and turn their tile into lava on death.",Doomed=true,Self = "Meta_EldritchTentacles_A",}
Meta_EldritchTentacles_B = Meta_EldritchTentacles:new{UpgradeDescription = "Deals 1 more damage.",Damage=2,Self = "Meta_EldritchTentacles_B",}
Meta_EldritchTentacles_AB = Meta_EldritchTentacles:new{Doomed = true,Damage=2,Self = "Meta_EldritchTentacles_AB",}

function Meta_EldritchTentacles:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local target = GetProjectileEnd(point, point+DIR_VECTORS[dir])
		if Board:IsValid(target) then
			for i = 1, point:Manhattan(target) do
				ret:push_back(point + DIR_VECTORS[dir] * i)
			end
		end
	end
	return ret
end

function Meta_EldritchTentacles:GetSkillEffect(p1,p2,boosted)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1, p1+DIR_VECTORS[direction])
	local isMelee = p1:Manhattan(target) == 1
	local damageAmount = self.Damage
	local isInsane = Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") >= 5
	local mission = GetCurrentMission()
	if isInsane then damageAmount = damageAmount + 1 end
	if boosted then damageAmount = damageAmount + 1 end
	if not Board:IsValid(target) then return ret end
	local damage = SpaceDamage(target)
	damage.bHidePath = true
	ret:AddProjectile(p1,damage,"effects/shot_grapple",PROJ_DELAY)
	
	if Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() then	-- If it's a pawn
		ret:AddCharge(Board:GetSimplePath(target, p1 + DIR_VECTORS[direction]), FULL_DELAY)
		if not Board:IsPawnTeam(target, TEAM_PLAYER) then
			if isMelee and self.Doomed then ret:AddScript(string.format("Status.ApplyDoomed(%s)", Board:GetPawn(target):GetId())) end
			ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[direction],damageAmount))
		elseif p1:Manhattan(target)>3 then 
			mission.flag2 = true 
		end
	elseif Board:IsBlocked(target, Pawn:GetPathProf()) then     --If it's an obstruction
		if p1:Manhattan(target)>3 then mission.flag1 = true end
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)	
		if isInsane or (Board:IsPawnSpace(target) and not Board:IsPawnTeam(target, TEAM_PLAYER)) then
			if isMelee and self.Doomed and Board:IsPawnSpace(target) then ret:AddScript(string.format("Status.ApplyDoomed(%s)", Board:GetPawn(target):GetId())) end
			ret:AddDamage(SpaceDamage(target,damageAmount))
		end
	end
		
	return ret
end

local function GetSubsequentLocation(p1,p2)
	local firstTarget = GetProjectileEnd(p1, p1+DIR_VECTORS[GetDirection(p2-p1)])
	if Board:IsValid(firstTarget) and (Board:IsPawnSpace(firstTarget) and Board:GetPawn(firstTarget):IsGuarding()) or Board:GetTerrain(firstTarget) == TERRAIN_MOUNTAIN or Board:GetTerrain(firstTarget) == TERRAIN_BUILDING then
		return firstTarget - DIR_VECTORS[GetDirection(p2-p1)]
	else
		return p1
	end
end

function Meta_EldritchTentacles:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	p1 = GetSubsequentLocation(p1,p2)
	for dir = DIR_START, DIR_END do
		local target = GetProjectileEnd(p1, p1+DIR_VECTORS[dir])
		if target == p1 then target = GetProjectileEnd(target, target+DIR_VECTORS[dir]) end
		if Board:IsValid(target) then
			for i = 1, p1:Manhattan(target) do
				ret:push_back(p1 + DIR_VECTORS[dir] * i)
			end
		end
	end
	return ret
end

function Meta_EldritchTentacles:GetFinalEffect(p1, p2, p3)
	local user = Board:GetPawn(p1)
	local isBoosted = user:IsBoosted() or user:GetPersonality() == "Arrogant"
	local loc = GetSubsequentLocation(p1,p2)
	local ret = Meta_EldritchTentacles:GetSkillEffect(p1,p2,isBoosted)
	local target1 = GetProjectileEnd(p1, p1+DIR_VECTORS[GetDirection(p2-p1)])
	local target2 = GetProjectileEnd(loc, loc+DIR_VECTORS[GetDirection(p3-loc)])
	local damageAmount = self.Damage
	local isInsane = Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") >= 5
	local mission = GetCurrentMission()
	local multishotMark = target1 == target2 and Board:GetPawn(target1) and Board:GetPawn(target1):GetTeam() ~= TEAM_PLAYER
	if isInsane then damageAmount = damageAmount + 1 end

	--induce insanity
	for i = DIR_START, DIR_END do
		local curr = loc + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetPersonality() ~= "Artificial" then ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", pawn:GetId())) end
	end
	local mission = GetCurrentMission()
	ret:AddScript(string.format("Board:AddEffect(_G[%q]:GetSkillEffect(%s,%s))", self.Self, loc:GetString(), p3:GetString(), isBoosted))
	if options.Meta_EldritchSelfInsanity and options.Meta_EldritchSelfInsanity.enabled then ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", user:GetId())) end

	local damage = SpaceDamage(target2, damageAmount)
	if Board:GetPawn(target2) and not Board:GetPawn(target2):IsGuarding() then damage.loc = loc+DIR_VECTORS[GetDirection(p3-loc)] end
	if Board:GetPawn(target2) and Board:GetPawn(target2):IsGuarding() then damage.loc = GetProjectileEnd(loc, loc+DIR_VECTORS[GetDirection(p3-loc)]) end
	if multishotMark then damage.sImageMark = MultishotLib:getImageMark(damageAmount, 2, loc, damage.loc) end
	if isInsane or (Board:GetPawn(target2) and Board:GetPawn(target2):GetTeam() ~= TEAM_PLAYER) then weaponPreview:AddDamage(damage) end
	if isInsane then ret:AddScript(string.format("Status.ApplyInsanity(%s, -5)", user:GetId())) end
	if mission.flag1 and mission.flag2 then ret:AddScript("completeComeWithMe()") end
	return ret
end	





Meta_EldritchInsanity = Skill:new{  
	Name = "Eldritch Insanity",
	Class = "Science",
	Icon = "weapons/MindDomination.png",
	Description = "Force a target Vek to retarget its currently queued attack. Induce Insanity in adjacent pilots. Insane: force all Vek to retarget their currently queued attack randomly.",
	Rarity = 3,
	Damage = 0,
	ZoneTargeting = ZONE_DIR,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Range = 1,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "+2 Range",  "Madness"  },
	UpgradeCost = { 1 , 1 },
	UsesInsanity = true,
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Mech_Worm",
	}
}

function Meta_EldritchInsanity:GetTargetArea(point)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(point, self.Range))
	if Status.GetStatus(Board:GetPawn(point):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(point):GetId(), "Insanity") >= 5 then ret:push_back(point) return ret end
	for k = 1, #targets do	
		local pawn = Board:GetPawn(targets[k])
		if pawn and pawn:IsQueued() then ret:push_back(targets[k]) end
	end
	if self.Madness then ret:push_back(point) end
	return ret
end


function Meta_EldritchInsanity:IsTwoClickException(p1, p2)
	--if self-targeted, it's a special mode
	if p1 == p2 then return true end
	--if insane, we affect all Vek, so no need for a second target
	return Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") >= 5
end
	

function Meta_EldritchInsanity:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local pawn = Board:GetPawn(p2)
	if not pawn or not pawn:IsQueued() then return ret end
	local targetArea = _G[pawn:GetQueuedWeapon()]:GetTargetArea(p2)
	for _, point in ipairs(extract_table(targetArea)) do
		ret:push_back(point)
	end
	return ret
end

function Meta_EldritchInsanity:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local user = Board:GetPawn(p1)
	if Board:GetSize() == Point(6,6) then
		Board:GetPawn(Point(2, 2)):FireWeapon(Point(2, 3), 1)
		Board:GetPawn(Point(2, 2)):FireWeapon(Point(3, 2), 1)
		return ret
	end
	local achievementCounter = 0
	if Status.GetStatus(user:GetId(), "Insanity") and Status.GetStatus(user:GetId(), "Insanity") >= 5 then
	--if mad, all enemies retarget "randomly"
		local enemies = Board:GetPawns(TEAM_ENEMY)
		for _, i in ipairs(extract_table(enemies)) do
			local pawn = Board:GetPawn(i)
			if pawn:IsQueued() then
				local targetArea = extract_table(_G[pawn:GetQueuedWeapon()]:GetTargetArea(pawn:GetSpace()))
				local targetAreaPick = (i + Game:GetTurnCount()) % #targetArea + 1
				--deterministic formula so it persists through reset turns
				local newTarget = targetArea[targetAreaPick]
				ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, Board:GetPawn(%s):GetQueuedWeaponId())", i, newTarget:GetString(), i))
			end
		end
		--induce insanity
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:GetPersonality() ~= "Artificial" then
				if Status.GetStatus(pawn:GetId(), "Insanity") and Status.GetStatus(pawn:GetId(), "Insanity") == 4 then achievementCounter = achievementCounter+1 end
				ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", pawn:GetId()))
			end
		end
		--remove Insanity
		ret:AddScript(string.format("Status.ApplyInsanity(%s, -5)", user:GetId()))
	elseif p1 == p2 then
		--means we have the Madness upgrade, induce insanity as a free action
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:GetPersonality() ~= "Artificial" then
				if Status.GetStatus(pawn:GetId(), "Insanity") and Status.GetStatus(pawn:GetId(), "Insanity") == 4 then achievementCounter = achievementCounter+1 end
				ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", pawn:GetId()))
			end
			if pawn and pawn:GetTeam() == TEAM_ENEMY then
				ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)",pawn:GetId()))
			end
		end
		if Board:GetPawn(p1):GetPersonality() ~= "Artificial" then
			if Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") == 4 then achievementCounter = achievementCounter+1 end
			ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", Board:GetPawn(p1):GetId()))
		end
		local mission = GetCurrentMission()
		if mission then
			if not mission.LastMadnessTurn then mission.LastQuickspitTurn = -1 end
			if mission.LastMadnessTurn ~= Game:GetTurnCount() then
				ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", Board:GetPawn(p1):GetId()))
			end
			ret:AddScript("GetCurrentMission().LastMadnessTurn = Game:GetTurnCount()")
			
		end        
	else
		--do mark to preview the final two-click effect
		local mark = SpaceDamage(p2)
		mark.sImageMark = "combat/icons/icon_mind_glow.png"
		ret:AddDamage(mark)
	end
	if achievementCounter >= 2 then ret:AddScript("completeTogetherInMadness()") end
	return ret
end	

function Meta_EldritchInsanity:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	if Board:GetSize() == Point(6,6) then
		Board:GetPawn(Point(2, 2)):FireWeapon(Point(2, 3), 1)
		Board:GetPawn(Point(2, 2)):FireWeapon(Point(3, 2), 1)
		return ret
	end
	local pawn = Board:GetPawn(p2)
	local achievementCounter = 0
	local mark = SpaceDamage(p2)
	if (p3.x == p2.x or p3.y == p2.y) and p3 ~= p2 then
		local dir2 = GetDirection(p3-p2)
		local arrows = {"arrow_off_up.png", "arrow_off_right.png", "arrow_off_down.png", "arrow_off_left.png",}
		mark.sImageMark = "combat/"..arrows[dir2+1]
		ret:AddDamage(mark)
	end
	ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, Board:GetPawn(%s):GetQueuedWeaponId())", pawn:GetId(), p3:GetString(), pawn:GetId()))
	--induce insanity
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetPersonality() ~= "Artificial" then
			if Status.GetStatus(pawn:GetId(), "Insanity") and Status.GetStatus(pawn:GetId(), "Insanity") == 4 then achievementCounter = achievementCounter+1 end
			ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", pawn:GetId()))
		end
	end
	if options.Meta_EldritchSelfInsanity and options.Meta_EldritchSelfInsanity.enabled then ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", user:GetId())) end
	if achievementCounter >= 2 then ret:AddScript("completeTogetherInMadness()") end
	return ret
end	



Meta_EldritchInsanity_A = Meta_EldritchInsanity:new{UpgradeDescription = "Can target units up to 3 tiles away.",Range=3}
Meta_EldritchInsanity_B = Meta_EldritchInsanity:new{UpgradeDescription = "Once per turn, can self-target to boost adjacent Vek and apply Insanity to self and adjacent pilots.",Madness=true,}
Meta_EldritchInsanity_AB = Meta_EldritchInsanity:new{Range = 3,Madness=true}





Meta_TentacularServant = Skill:new{  
	Name = "Tentacular Servant",
	Class = "Ranged",
	Icon = "weapons/TentacularServant.png",
	Description = "Deploy a tentacle at a ranged location, then cause all tentacles to attack and push in a direction. Induce Insanity in adjacent pilots. Insane: deploy two tentacles, then cause all tentacles to attack in all directions.",
	Rarity = 3,
	Damage = 1,
	TwoClick = true,
	ZoneTargeting = ZONE_DIR,
	ImpactSound = "/impact/dynamic/enemy_projectile",
	Push = 1,
	PowerCost = 0,
	Spawn = "EldritchTentacle",
	Self = "Meta_TentacularServant",
	UsesInsanity = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage",  "+3 Health"  },
	UpgradeCost = { 2 , 2 },
	TipImage = {
		Unit = Point(2,3),
		Second_Origin=Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
		Second_Target=Point(2,1),
		Second_Click=Point(2,1),
		Water = Point(2,0),
		CustomPawn = "Mech_Octopus"
	}
}

function Meta_TentacularServant:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 2, 8 do
			if not Board:IsBlocked(DIR_VECTORS[i]*k + point, PATH_MASSIVE) then ret:push_back(DIR_VECTORS[i]*k + point) end
		end
	end
	return ret
end

function Meta_TentacularServant:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") >= 5 then 
		for i = DIR_START, DIR_END do
			for k = 2, 8 do
				if not Board:IsBlocked(DIR_VECTORS[i]*k + p1, PATH_MASSIVE) then ret:push_back(DIR_VECTORS[i]*k + p1) end
			end
		end
	else
		for i = DIR_START, DIR_END do
			ret:push_back(DIR_VECTORS[i] + p2)
		end
	end
	return ret
end
	
function Meta_TentacularServant:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	damage.sPawn = self.Spawn
	ret:AddArtillery(damage, "coiledTentacle.png")
	return ret
end	

function Meta_TentacularServant:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	local dir = GetDirection(p3-p2)
	damage.sPawn = self.Spawn
	-- if GetCurrentMission().EldritchTentaclesIDs == nil then GetCurrentMission().EldritchTentaclesIDs = {} end
	local isInsane = Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") and Status.GetStatus(Board:GetPawn(p1):GetId(), "Insanity") >= 5
	if isInsane then 
		damage.loc = p3 
		ret:AddArtillery(damage, "effects/coiledTentacle.png", NO_DELAY)
		-- ret:AddScript(string.format([[
		-- local unit = PAWN_FACTORY:CreatePawn(%q);
		-- GetCurrentMission().EldritchTentaclesIDs[unit:GetId()] = #GetCurrentMission().EldritchTentaclesIDs;
		-- Board:AddPawn(unit,%s)]], self.Spawn, p3:GetString()))
		damage.loc = p2
		--remove Insanity
		ret:AddScript(string.format("Status.ApplyInsanity(%s, -5)", Board:GetPawn(p1):GetId()))
	end
	-- ret:AddScript(string.format([[
	-- local unit = PAWN_FACTORY:CreatePawn(%q);
	-- GetCurrentMission().EldritchTentaclesIDs[unit:GetId()] = #GetCurrentMission().EldritchTentaclesIDs;
	-- Board:AddPawn(unit,%s)]], self.Spawn, p2:GetString()))
	ret:AddArtillery(damage, "effects/coiledTentacle.png", FULL_DELAY)
	
	if isInsane then
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			weaponPreview:AddDamage(SpaceDamage(p2+DIR_VECTORS[i], self.Damage, i))
			curr2 = p3 + DIR_VECTORS[i]
			weaponPreview:AddDamage(SpaceDamage(p3+DIR_VECTORS[i], self.Damage, i))
		end
	else
		weaponPreview:AddDamage(SpaceDamage(p2+DIR_VECTORS[dir], self.Damage, dir))
	end
	for i = 0, 7 do
		for j = 0, 7 do
			local point = Point(i,j)
			local pawn = Board:GetPawn(point)
			if pawn and (pawn:GetType() == "EldritchTentacle" or pawn:GetType() == "EldritchTentacle2") then
				if isInsane then 
					for k = DIR_START, DIR_END do
						weaponPreview:AddDamage(SpaceDamage(point+DIR_VECTORS[k], self.Damage, k))
					end
				else
					weaponPreview:AddDamage(SpaceDamage(point+DIR_VECTORS[dir], self.Damage, dir))
				end
			end
		end
	end
	ret:AddScript(string.format([=[
		local fx = SkillEffect();
		fx:AddScript([[
			Board:AddEffect(_G[%q]:TentacleAttack(%s, %s));
		]]);
		Board:AddEffect(fx);
	]=], self.Self, dir, tostring(isInsane)))
	--induce insanity
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetPersonality() ~= "Artificial" then
			ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", pawn:GetId()))
		end
	end
	if options.Meta_EldritchSelfInsanity and options.Meta_EldritchSelfInsanity.enabled then ret:AddScript(string.format("Status.ApplyInsanity(%s, 1)", Board:GetPawn(p1):GetId())) end
	return ret
end	

function Meta_TentacularServant:TentacleAttack(dir, isInsane)
	local ret = SkillEffect()
	-- LOG(#GetCurrentMission().EldritchTentaclesIDs.." tentacles.")
	-- table.sort(GetCurrentMission().EldritchTentaclesIDs)
	local tentacleCounter = 0
	-- for id, _ in ipairs(GetCurrentMission().EldritchTentaclesIDs) do
		-- local pawn = Board:GetPawn(id)
		-- if pawn and (pawn:GetType() == "EldritchTentacle" or pawn:GetType() == "EldritchTentacle2") then
			-- tentacleCounter = tentacleCounter + 1
			-- if isInsane then 
				-- for k = DIR_START, DIR_END do
					-- ret:AddMelee(point, SpaceDamage(point+DIR_VECTORS[k], self.Damage, k))
				-- end
			-- else
				-- ret:AddMelee(point, SpaceDamage(point+DIR_VECTORS[dir], self.Damage, dir))
			-- end
		-- end
	-- end
	for i = 0, 7 do
		for j = 0, 7 do
			local point = Point(i,j)
			local pawn = Board:GetPawn(point)
			if pawn and (pawn:GetType() == "EldritchTentacle" or pawn:GetType() == "EldritchTentacle2") then
				tentacleCounter = tentacleCounter + 1
				if isInsane then 
					for k = DIR_START, DIR_END do
						ret:AddMelee(point, SpaceDamage(point+DIR_VECTORS[k], self.Damage, k))
					end
				else
					ret:AddMelee(point, SpaceDamage(point+DIR_VECTORS[dir], self.Damage, dir))
				end
			end
		end
	end

	if tentacleCounter >= 5 then ret:AddScript("completeArmyOfTheDeep()") end


	return ret
end

EldritchTentacle = Pawn:new{
	Name = "Tentacle",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	Massive = true,
	Pushable = false,
	IsPortrait = false,
	Image = "EldritchTentacle",
	SoundLocation = "/support/vek_egg/",
	SkillList = { },
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- IsDeathEffect = true,
	-- GetDeathEffect = EldritchTentacleDE,
	-- Corpse = true,
}
AddPawn("EldritchTentacle") 
EldritchTentacle2 = Pawn:new{
	Name = "Tentacle",
	Health = 4,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	Massive = true,
	Pushable = false,
	IsPortrait = false,
	Image = "EldritchTentacle",
	SoundLocation = "/support/vek_egg/",
	SkillList = { },
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- IsDeathEffect = true,
	-- GetDeathEffect = EldritchTentacleDE,
	-- Corpse = true,
}
AddPawn("EldritchTentacle2")

Meta_TentacularServant_A = Meta_TentacularServant:new{UpgradeDescription = "Increases damage by 1.",Damage = 2,Self = "Meta_TentacularServant_A",}
Meta_TentacularServant_B = Meta_TentacularServant:new{UpgradeDescription = "Increases tentacle health by 3.",Spawn = "EldritchTentacle2",Self = "Meta_TentacularServant_B",}
Meta_TentacularServant_AB = Meta_TentacularServant:new{Damage = 2,Spawn = "EldritchTentacle2",Self = "Meta_TentacularServant_AB",}

-- local function EldritchTentacleDE(pawn, point)
	-- local ret = SkillEffect()
	-- local mission = GetCurrentMission()
	-- if not mission then return ret end
	-- if mission.EldritchTentaclesIDs == nil then mission.EldritchTentaclesIDs = {} end
	-- mission.EldritchTentaclesIDs[id] = nil
	-- pawn:SetCorpse(false)
-- end

local function TentacleTeamSwitch(mission)
	LOG("tentacles are turning coats")
	for i = 0, 7 do
		for j = 0, 7 do
			local pawn = Board:GetPawn(Point(i,j))
			if pawn and (pawn:GetType() == "EldritchTentacle" or pawn:GetType() == "EldritchTentacle2") then
				LOG("found tentacle")
				if pawn:GetTeam() == TEAM_PLAYER and Game:GetTeamTurn() == TEAM_ENEMY then 
					LOG("set to team none")
					pawn:SetTeam(TEAM_NONE)
				elseif pawn:GetTeam() == TEAM_NONE and Game:GetTeamTurn() == TEAM_PLAYER then 
					LOG("set to team player")
					pawn:SetTeam(TEAM_PLAYER)
				end
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addNextTurnHook(TentacleTeamSwitch)
end
modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)