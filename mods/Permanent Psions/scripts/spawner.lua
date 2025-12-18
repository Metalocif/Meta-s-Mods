local mod = modApi:getCurrentMod()

-- local function HOOK_PostStartGame()
	-- for name, maxCount in ipairs(Spawner.max_pawns) do
		-- if string.find(name, "Jelly") then Spawner.max_pawns.name = 0 LOG("blocked "..name) end
	-- end
-- end

-- oldGetSpawner = Mission:GetSpawner()
-- function Mission:GetSpawner()
	-- if self.Spawner == nil then self:CreateSpawner() end
	-- for name, maxCount in ipairs(self.Spawner.max_pawns) do
		-- if string.find(name, "Jelly") then self.Spawner.max_pawns.name = 0 LOG("blocked "..name) end
	-- end
    -- return self.Spawner
-- end



function Spawner:NextPawn(pawn_tables)
	pawn_tables = pawn_tables or GAME:GetSpawnList(self.spawn_island)
	self.pawn_counts = self.pawn_counts or {}
	local counts = ""
    for i,v in pairs(self.pawn_counts) do
        counts = counts..i.." = "..v.." "
    end
	---initialize values
	if self.curr_weakRatio == nil then
		self.curr_weakRatio = {0,0}
		self.curr_upgradeRatio = {0,0}
		self.upgrade_streak = 0
		self.used_bosses = 0
	end
	
	if self.curr_weakRatio[2] == 0 then 
		self.curr_weakRatio[1] = self.num_weak
		self.curr_weakRatio[2] = 5		
	end
	
	if self.curr_upgradeRatio[2] == 0 then 
		self.curr_upgradeRatio[1] = self.num_upgrades
		self.curr_upgradeRatio[2] = 5		
	end
			
	local newPawn = ""
	local level = 1
	local upgrade = 0
	
	if random_int(self.curr_weakRatio[2]) < self.curr_weakRatio[1] then
		newPawn = self:SelectPawn(pawn_tables, true)
		self.curr_weakRatio[1] = self.curr_weakRatio[1] - 1	
	else
		newPawn = self:SelectPawn(pawn_tables,false)
	end
		
	local maxLvl = self.max_level[newPawn] or 2
	
	--this is an attempt to normalize 'streaks' to make sure it's a more consistent distribution of upgraded enemies
	--if non-upgraded choices are available, and you've had a streak of "num_upgrades-1" then break it up.
	local break_streak = self.curr_upgradeRatio[1] ~= self.curr_upgradeRatio[2] and self.upgrade_streak >= math.max(1,(self.num_upgrades - 1))
	
	if random_int(self.curr_upgradeRatio[2]) < self.curr_upgradeRatio[1] and maxLvl ~= 1 and not break_streak then
		level = 2
		self.curr_upgradeRatio[1] = self.curr_upgradeRatio[1] - 1
		self.upgrade_streak = self.upgrade_streak + 1
	else
		self.upgrade_streak = 0
	end
	
	self.curr_upgradeRatio[2] = self.curr_upgradeRatio[2] - 1
	self.curr_weakRatio[2] = self.curr_weakRatio[2] - 1
	
	
	if string.find(newPawn, "Jelly") then return Spawner:NextPawn(pawn_tables) end
	
	
	self:ModifyCount(newPawn,1)
	
	--force downgrade if the tier 2 units are getting out of hand
	if self:CountLivingUpgrades() >= self.upgrade_max then
		level = 1
	end
	
	self.used_bosses = self.used_bosses or 0
	self.num_bosses = self.num_bosses or 0
	
	if level == 2 and self.used_bosses < self.num_bosses then
		local chance = math.max(3 - self.num_bosses, 1)
		if BossesList[newPawn.."Boss"] and random_bool(chance) and newPawn ~= "Spider" then
			level = "Boss"
			self.used_bosses = self.used_bosses + 1
		end
	end
	self.num_spawns = self.num_spawns + 1
	
	return newPawn..level
end


local function HOOK_VekSpawnAdded(mission, spawnData)
	local mission = GetCurrentMission()
	LOG(spawnData.type)
	if string.find(spawnData.type, "Jelly") then
		LOG("Permanent Psions cancelled a psion spawn.")
		mission:RemoveSpawnPoint(spawnData.location)
		modApi:runLater(function()
			mission:SpawnPawn(spawnData.location, mission:GetSpawner():NextPawn(nil, true))
		end)
		local fx = SkillEffect()
		fx:AddDelay(0.1)
		Board:AddEffect(fx)
	end
end

local function HOOK_MissionStart(mission)
	local options = mod_loader.currentModContent[mod.id].options
	if options["PermanentPsion"] then Board:AddPawn(options["PermanentPsion"].value, Point(0,0)) Board:GetPawn(Point(0,0)):SetSpace(Point(-157,-197)) end
	if options["PermanentPsion_Vextra"] then mission[options["PermanentPsion_Vextra"].value] = true end
	--tricks Vextra logic into thinking the psion is present
end

local function EVENT_onModsLoaded()
	local options = mod_loader.currentModContent[mod.id].options
	modApi:addMissionStartHook(HOOK_MissionStart)
	-- modApi:addVekSpawnAddedHook(HOOK_VekSpawnAdded)	
	modApi:addPreEnvironmentHook(function(mission)	
		for i = 0, 2 do
			if options["PermanentPsion_Tyrant"] and Board:GetTurn() > 0 and Board:GetPawn(i) then
				local damage = SpaceDamage(Board:GetPawn(i):GetSpace(), 1)
				damage.sAnimation = "PsionAttack_Back"
				Board:AddAnimation(Board:GetPawn(i):GetSpace(), "PsionAttack_Front", ANIM_NO_DELAY)
				if Board:GetTerrain(Board:GetPawn(i):GetSpace()) == TERRAIN_WATER and Board:IsAcid(Board:GetPawn(i):GetSpace()) then
					Board:AddAnimation(Board:GetPawn(i):GetSpace(), "Splash_acid", ANIM_NO_DELAY)
				elseif Board:IsTerrain(Board:GetPawn(i):GetSpace(),TERRAIN_LAVA) then
					Board:AddAnimation(Board:GetPawn(i):GetSpace(), "Splash_lava", ANIM_NO_DELAY)
				elseif Board:GetTerrain(Board:GetPawn(i):GetSpace()) == TERRAIN_WATER then
					Board:AddAnimation(Board:GetPawn(i):GetSpace(), "Splash", ANIM_NO_DELAY)
				end
				Board:GetPawn(i):ApplyDamage(damage)
			end
		end
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)