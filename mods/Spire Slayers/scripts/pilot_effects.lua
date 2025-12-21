local path = mod_loader.mods[modApi.currentMod].resourcePath

local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")

modApi:appendAsset("img/effects/lightningorb.png", path.."img/effects/lightningorb.png")
modApi:appendAsset("img/effects/frostorb.png", path.."img/effects/frostorb.png")
modApi:appendAsset("img/effects/darkorb.png", path.."img/effects/darkorb.png")
modApi:appendAsset("img/effects/plasmaorb.png", path.."img/effects/plasmaorb.png")
modApi:appendAsset("img/effects/wisdom.png", path.."img/effects/wisdom.png")
modApi:appendAsset("img/effects/blasphemy.png", path.."img/effects/blasphemy.png")

ANIMS.LightningOrb = Animation:new{ Image = "effects/lightningorb.png", PosX = 0, PosY = 0, NumFrames = 4, Time = 0.3, Loop = true, Frames = {0,1,2,3,2,1}}
ANIMS.FrostOrb = Animation:new{ Image = "effects/frostorb.png", PosX = 0, PosY = 0, NumFrames = 4, Time = 0.3, Loop = true, Frames = {0,1,2,3,2,1}}
ANIMS.DarkOrb = Animation:new{ Image = "effects/darkorb.png", PosX = 0, PosY = 0, NumFrames = 4, Time = 0.3, Loop = true, Frames = {0,1,2,3,2,1}}
ANIMS.PlasmaOrb = Animation:new{ Image = "effects/plasmaorb.png", PosX = 0, PosY = 0, NumFrames = 4, Time = 0.3, Loop = true, Frames = {0,1,2,3,2,1}}

ANIMS.WisdomStance = Animation:new{ Image = "effects/wisdom.png", PosX = -10, PosY = -30, NumFrames = 1, Time = 1, Loop = true}
ANIMS.BlasphemyStance = Animation:new{ Image = "effects/blasphemy.png", PosX = -10, PosY = -5, NumFrames = 4, Time = 0.5, Loop = true}

local function IroncladRegen(mission)
	if Game:GetTeamTurn() ~= TEAM_PLAYER then return end
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSIroncladSkill") and not pawn:IsDead() then Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -1)) end
	end
end

local function IroncladFire(mission, pawn, damageTaken)
	if pawn and pawn:IsAbility("StSIroncladSkill") and damageTaken > 0 and not pawn:IsDead() then
		for i = DIR_START, DIR_END do
			local damage = SpaceDamage(pawn:GetSpace() + DIR_VECTORS[i])
			damage.iFire = 1
			Board:DamageSpace(damage)
		end
	end
end

local function SilentGainBladeDance(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSSilentSkill") then
			if pawn:GetWeaponCount() < 2 then
				pawn:AddWeapon("StS_BladeDance")
			else
				mission.SilentIsToxic = true
			end
		end
	end
end

local function SilentToxin(mission)
	if not mission.SilentIsToxic then return end
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSSilentSkill") and not pawn:IsDead() then
			for dir = DIR_START, DIR_END do
				local curr = pawn:GetSpace() + DIR_VECTORS[dir]
				local enemy = Board:GetPawn(curr)
				if enemy and enemy:GetTeam() == TEAM_ENEMY and not enemy:IsDead() then Status.ApplyToxin(enemy:GetId()) end
			end
		end
	end
end

local function SilentLoseBladeDance(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSSilentSkill") then
			for j = 1, pawn:GetWeaponCount() do
				if pawn:GetWeaponType(j) == "StS_BladeDance" then pawn:RemoveWeapon(j) break end
			end
		end
	end
end

local function DefectStartWithLightningOrb()
	GAME.StSDefectOrb = "Lightning"
end

local function DefectRetrieveOrb(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSDefectSkill") then
			if GAME.StSDefectOrb == "Lightning" then
				customAnim:add(pawn:GetId(), "LightningOrb")
			elseif GAME.StSDefectOrb == "Frost" then
				customAnim:add(pawn:GetId(), "FrostOrb")
			elseif GAME.StSDefectOrb == "Dark" then
				customAnim:add(pawn:GetId(), "DarkOrb")
			elseif GAME.StSDefectOrb == "Plasma" then
				customAnim:add(pawn:GetId(), "PlasmaOrb")
			end
		end
	end
end

local function DefectOrbPassivesPlayerTurn(mission)
	if Game:GetTeamTurn() ~= TEAM_PLAYER then return end
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSDefectSkill") and not pawn:IsDead() then
			if GAME.StSDefectOrb == "Dark" then
				for dir = DIR_START, DIR_END do
					local curr = pawn:GetSpace() + DIR_VECTORS[dir]
					local enemy = Board:GetPawn(curr)
					if enemy then Status.ApplyBlind(enemy:GetId()) end
				end
				GAME.StSDefectDarkOrbTurns = GAME.StSDefectDarkOrbTurns or 0
				GAME.StSDefectDarkOrbTurns = GAME.StSDefectDarkOrbTurns + 1
			elseif GAME.StSDefectOrb == "Plasma" then
				pawn:AddMoveBonus(1)
			end
		end
	end
end

local function DefectOrbPassivesEnemyTurn(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSDefectSkill") and not pawn:IsDead() then
			if GAME.StSDefectOrb == "Lightning" then
				for dir = DIR_START, DIR_END do
					local curr = pawn:GetSpace() + DIR_VECTORS[dir]
					local enemy = Board:GetPawn(curr)
					local damage = SpaceDamage(curr, 1)
					damage.sAnimation = "LightningBolt"..math.random(0, 1)
					damage.sSound = "/props/lightning_strike"
					if enemy then Board:DamageSpace(damage) end
				end
			elseif GAME.StSDefectOrb == "Frost" then
				for dir = DIR_START, DIR_END do
					local curr = pawn:GetSpace() + DIR_VECTORS[dir]
					local enemy = Board:GetPawn(curr)
					if enemy then Status.ApplyChill(enemy:GetId()) end
					local effect = SkillEffect()
					effect:AddSound("/weapons/blizzard")
					effect.iOwner = ENV_EFFECT
					Board:AddEffect(effect)	
				end
			end
		end
	end
end

local function WatcherStartInWisdom(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSWatcherSkill") then 
			customAnim:add(pawn:GetId(), "WisdomStance")
		end
	end
end

local function WatcherBlasphemy(mission)
	if Game:GetTeamTurn() ~= TEAM_PLAYER then return end
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("StSWatcherSkill") and customAnim:get(i, "BlasphemyStance") and not pawn:IsDead() then 
			if not pawn:IsBoosted() then pawn:ApplyDamage(SpaceDamage(pawn:GetSpace(), 1)) end
			pawn:SetBoosted(true)
		end
	end
end

--check Defect skill is powered by using IsAbility (not GetAbility)

local function EVENT_onModsLoaded()
	-- Ironclad: heal 1/turn, fire adjacents when damaged
	modApi:addNextTurnHook(IroncladRegen)
	modapiext:addPawnDamagedHook(IroncladFire)
	
	-- Silent: gain a weapon if empty slots, otherwise apply toxin on adjacent
	modApi:addMissionStartHook(SilentGainBladeDance)
	modApi:addPreEnvironmentHook(SilentToxin)
	modApi:addMissionEndHook(SilentLoseBladeDance)
	
	-- Defect: rotate between 4 passives, rotating triggers stuff
	modApi:addPostStartGameHook(DefectStartWithLightningOrb)
	modApi:addMissionStartHook(DefectRetrieveOrb)
	modApi:addNextTurnHook(DefectOrbPassivesPlayerTurn)
	modApi:addPreEnvironmentHook(DefectOrbPassivesEnemyTurn)
	--actives are handled by the replaceRepair weapon
	
	-- Watcher: rotate between two modes
	--wisdom is handled by the replaceRepair weapon
	modApi:addMissionStartHook(WatcherStartInWisdom)
	modApi:addNextTurnHook(WatcherBlasphemy)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)