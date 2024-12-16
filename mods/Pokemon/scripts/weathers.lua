
---------------------------------------------------------------------
-- Weathers v1.0 - code library
---------------------------------------------------------------------
-- A library that adds weather effects to the game. Weapons and pilot skills can apply weathers, some missions will have weathers going on at the start.
-- Adds some extra variety in some missions.
-- Weapons can also check whether a specific weather is running for extra effects.

-- See the wiki: https://github.com/Metalocif/Meta-s-Mods/wiki

local path = mod_loader.mods[modApi.currentMod].resourcePath
local customEmitter = require(mod_loader.mods.meta_mods.scriptPath.."libs/customEmitter")
local status = require(mod_loader.mods.meta_mods.scriptPath .."libs/status")
Weathers = {}

modApi:appendAsset("img/libs/weather/sun.png", path .."img/weather/sun.png")
ANIMS.WeatherSun = Animation:new{ Image = "libs/weather/sun.png",PosX = -35, PosY = -20, NumFrames = 1, Time = 1, Loop = true}

Emitter_Sandstorm_1 = Emitter_Wind_0:new{ timer = 1, x = -60, y = 0, angle = 40, burst_count = 50, max_particles = 150, min_alpha = 0.2, max_alpha = 0.3, layer = LAYER_FRONT, fade_in = true,}
Emitter_Sandstorm_2 = Emitter_Sandstorm_1:new{ burst_count = 100, max_particles = 300 } 
Emitter_Sandstorm_3 = Emitter_Sandstorm_1:new{ burst_count = 150, max_particles = 450 } 
Emitter_Sandstorm_4 = Emitter_Sandstorm_1:new{ burst_count = 200, max_particles = 600 } 
Emitter_Sandstorm_5 = Emitter_Sandstorm_1:new{ burst_count = 250, max_particles = 750 } 

Emitter_Sandstorm_Small_1 = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,x = -10, burst_count = 5, max_particles = 30, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}
Emitter_Sandstorm_Small_2 = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,x = -10, burst_count = 10, max_particles = 60, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}
Emitter_Sandstorm_Small_3 = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,x = -10, burst_count = 15, max_particles = 90, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}
Emitter_Sandstorm_Small_4 = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,x = -10, burst_count = 20, max_particles = 120, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}
Emitter_Sandstorm_Small_5 = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,x = -10, burst_count = 25, max_particles = 150, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}


Emitter_Hail_1 = Emitter_Wind_0:new{ image = "combat/tiles_grass/particle.png", timer = 1, x = -60, y = 0, angle = 90, burst_count = 100, max_particles = 300, min_alpha = 0.7, max_alpha = 0.8, layer = LAYER_BACK, fade_in = true, gravity = true, random_rot = true,speed=8, lifespan = 1}
Emitter_Hail_2 = Emitter_Hail_1:new{ burst_count = 200, max_particles = 600 } 
Emitter_Hail_3 = Emitter_Hail_1:new{ burst_count = 300, max_particles = 900 } 
Emitter_Hail_4 = Emitter_Hail_1:new{ burst_count = 400, max_particles = 1200 } 
Emitter_Hail_5 = Emitter_Hail_1:new{ burst_count = 500, max_particles = 1500 } 

Emitter_Hail_Small_1 = Emitter_Hail_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -7,burst_count = 3, max_particles = 20,speed=7, lifespan = 0.3}
Emitter_Hail_Small_2 = Emitter_Hail_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -7,burst_count = 6, max_particles = 40,speed=7, lifespan = 0.3}
Emitter_Hail_Small_3 = Emitter_Hail_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -7,burst_count = 9, max_particles = 60,speed=7, lifespan = 0.3}
Emitter_Hail_Small_4 = Emitter_Hail_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -7,burst_count = 12, max_particles = 80,speed=7, lifespan = 0.3}
Emitter_Hail_Small_5 = Emitter_Hail_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -7,burst_count = 15, max_particles = 100,speed=7, lifespan = 0.3}


Emitter_Fog_1 = Emitter_Wind_0:new{ image = "effects/smoke/art_smoke.png", timer = 1, x = -60, y = 0, angle = 50, burst_count = 50, max_particles = 150, min_alpha = 0.03, max_alpha = 0.1, layer = LAYER_FRONT, fade_in = true, random_rot = true,speed=6, lifespan = 2}
Emitter_Fog_2 = Emitter_Fog_1:new{ burst_count = 100, max_particles = 300 } 
Emitter_Fog_3 = Emitter_Fog_1:new{ burst_count = 150, max_particles = 450 } 
Emitter_Fog_4 = Emitter_Fog_1:new{ burst_count = 200, max_particles = 600 } 
Emitter_Fog_5 = Emitter_Fog_1:new{ burst_count = 250, max_particles = 750 } 

Emitter_Fog_Small_1 = Emitter_Fog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = 0,burst_count = 3, max_particles = 20,speed=4, lifespan = 0.6}
Emitter_Fog_Small_2 = Emitter_Fog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = 0,burst_count = 6, max_particles = 40,speed=4, lifespan = 0.6}
Emitter_Fog_Small_3 = Emitter_Fog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = 0,burst_count = 9, max_particles = 60,speed=4, lifespan = 0.6}
Emitter_Fog_Small_4 = Emitter_Fog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = 0,burst_count = 12, max_particles = 80,speed=4, lifespan = 0.6}
Emitter_Fog_Small_5 = Emitter_Fog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = 0,burst_count = 15, max_particles = 100,speed=4, lifespan = 0.6}


Emitter_Smog_1 = Emitter_Wind_0:new{ image = "effects/smoke/acid_smoke.png", timer = 1, x = -60, y = 0, angle = 50, burst_count = 50, max_particles = 150, min_alpha = 0.1, max_alpha = 0.2, layer = LAYER_FRONT, fade_in = true, random_rot = true,speed=6, lifespan = 2}
Emitter_Smog_2 = Emitter_Smog_1:new{ burst_count = 100, max_particles = 300 } 
Emitter_Smog_3 = Emitter_Smog_1:new{ burst_count = 150, max_particles = 450 } 
Emitter_Smog_4 = Emitter_Smog_1:new{ burst_count = 200, max_particles = 600 } 
Emitter_Smog_5 = Emitter_Smog_1:new{ burst_count = 250, max_particles = 750 } 

Emitter_Smog_Small_1 = Emitter_Smog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -5,burst_count = 3, max_particles = 20,speed=4, lifespan = 0.6}
Emitter_Smog_Small_2 = Emitter_Smog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -5,burst_count = 6, max_particles = 40,speed=4, lifespan = 0.6}
Emitter_Smog_Small_3 = Emitter_Smog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -5,burst_count = 9, max_particles = 60,speed=4, lifespan = 0.6}
Emitter_Smog_Small_4 = Emitter_Smog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -5,burst_count = 12, max_particles = 80,speed=4, lifespan = 0.6}
Emitter_Smog_Small_5 = Emitter_Smog_1:new{ variance_x = 20,variance_y = 14,x = 0, y = -5,burst_count = 15, max_particles = 100,speed=4, lifespan = 0.6}



local function SetWeatherOverwriter(BoardClass, board)
    local SetWeatherVanilla = board.SetWeather
    BoardClass.SetWeather = function(self, intensity, weather, loc1, loc2, timer)
        -- Assert.Equals("userdata", type(self), "Argument #0")
        local result
        if timer == -1 and intensity > 0 then
			if weather == RAIN_NORMAL then 
				result = "Rain"
			elseif weather == RAIN_ACID then
				result = "Acid Rain"
			elseif weather == RAIN_SNOW then
				result = "Snow"
			else
				LOG("Weird weather found in "..GetCurrentMission().Id..", ping @Metalocif on the Discord.")
			end
		elseif timer == 0 then
			result = "" --correctly notice when weathers are turned off by vanilla causes
		end
		if result ~= nil and GetCurrentMission() then 
			GetCurrentMission().Weather = result
			GetCurrentMission().WeatherLoc1 = loc1
			GetCurrentMission().WeatherLoc2 = loc2
		end
        return SetWeatherVanilla(self, intensity, weather, loc1, loc2, timer)
    end
end

function Weathers.AddWeather(weather, intensity, startLoc, endLoc)
	mission = GetCurrentMission()
	if not mission then return end
	intensity = intensity or 1
	startLoc = startLoc or Point(0, 0)
	endLoc = endLoc or Point(8, 8)
	local isGlobal = endLoc == Point(8, 8)
	if weather ~= "Rain" and weather ~= "Sandstorm" and weather ~= "Sun" and weather ~= "Acid Rain" and weather ~= "Snow" and weather ~= "Hail" and weather ~= "Fog" and weather ~= "Smog" then 
		LOG("Incorrect weather type used in AddWeather, must be Rain/Sandstorm/Sun/Acid Rain/Snow/Hail/Fog/Smog.") 
		return
	end
	--remove custom emitters for all kinds of weathers
	for i = 1, 5 do
		customEmitter:Rem(mission, Point(3,3), "Emitter_Sandstorm_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Hail_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Fog_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Smog_"..i)
	end
	for _, p in ipairs(Board) do
		customEmitter:Rem(mission, p, "Emitter_Sandstorm_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Hail_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Fog_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Smog_Small_1")
	end
	CustomAnim:rem(Point(0,0), "WeatherSun")
	if weather == "Rain" then
		Board:SetWeather(intensity, RAIN_NORMAL, startLoc, endLoc, -1)
	elseif weather == "Acid Rain" then
		Board:SetWeather(intensity, RAIN_ACID, startLoc, endLoc, -1)
	elseif weather == "Snow" then
		Board:SetWeather(intensity, RAIN_ACID, startLoc, endLoc, -1)
	elseif weather == "Sandstorm" then
		Board:SetWeather(0, RAIN_NORMAL, Point(0,0), Point(8,8), 0)	--stops the weather
		if isGlobal then 
			customEmitter:Add(mission, Point(3,3), "Emitter_"..weather.."_"..(math.min(intensity, 5)))
		else
			for i=0,startLoc:Manhattan(endLoc)/2 do
				customEmitter:Add(mission, startLoc + Point(0,1) * i, "Emitter_"..weather.."_Small_1")
			end
		end
	elseif weather == "Hail" or weather == "Fog" or weather == "Smog" then
		Board:SetWeather(0, RAIN_NORMAL, Point(0,0), Point(8,8), 0)	--stops the weather
		if isGlobal then 
			customEmitter:Add(mission, Point(3,3), "Emitter_"..weather.."_"..(math.min(intensity, 5)))
		else
			for i=0,startLoc:Manhattan(endLoc)/2 do
				for j=0,startLoc:Manhattan(endLoc)/2 do
					customEmitter:Add(mission, startLoc + Point(0,1) * i + Point(1,0) * j, "Emitter_"..weather.."_Small_1")
				end
			end
		end
	elseif weather == "Sun" then
		Board:SetWeather(0, RAIN_NORMAL, Point(0,0), Point(8,8), 0)	--stops the weather
		CustomAnim:add(Point(0,0), "WeatherSun")
	end
	mission.Weather = weather
	mission.WeatherLoc1 = startLoc
	mission.WeatherLoc2 = endLoc
end

function Weathers.ClearWeather()
	mission = GetCurrentMission()
	if not mission then return end
	for i = 1, 5 do
		customEmitter:Rem(mission, Point(3,3), "Emitter_Sandstorm_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Hail_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Fog_"..i)
		customEmitter:Rem(mission, Point(3,3), "Emitter_Smog_"..i)
	end
	for _, p in ipairs(Board) do
		customEmitter:Rem(mission, p, "Emitter_Sandstorm_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Hail_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Fog_Small_1")
		customEmitter:Rem(mission, p, "Emitter_Smog_Small_1")
	end
	CustomAnim:rem(Point(0,0), "WeatherSun")
	Board:SetWeather(0, RAIN_NORMAL, Point(0,0), Point(8,8), 0)	--stops the weather
	mission.Weather = ""
	mission.WeatherLoc1 = nil
	mission.WeatherLoc2 = nil
end

local function SunDamage(mission, pawn, isFire)
	if mission and mission.Weather == "Sun" and isFire then
		modApi:conditionalHook(function()
			return true and not Board:IsBusy()
		end, 
		function()
			local amount = 1
			local isAcid = pawn:IsAcid()
			pawn:SetAcid(false, false)
			if pawn:IsArmor() then amount = 2 end
			pawn:ApplyDamage(SpaceDamage(pawn:GetSpace(), amount))
			pawn:SetAcid(isAcid, false)
			Board:Ping(pawn:GetSpace(), COLOR_RED)
		end)
	end
end



local function EVENT_onModsLoaded()
	modapiext:addPawnIsFireHook(SunDamage)
	modApi:addPreEnvironmentHook(function(mission)
		if mission.Weather == nil or mission.Weather == "" then return end
		if mission.Weather == "Sun" then
			for _, p in ipairs(Board) do
				local pawn = Board:GetPawn(p)
				if pawn and pawn:IsFrozen() then pawn:SetFrozen(false) end
				Status.RemoveStatus(pawn:GetId(), "Wet")
				if Board:IsFrozen(p) then Board:SetFrozen(false) end
				if Board:GetTerrain(p) == TERRAIN_ICE then Board:SetTerrain(p, TERRAIN_WATER) end
				if pawn and _G[pawn:GetType()].FunctionInWeatherSun ~= nil then _G[pawn:GetType()].FunctionInWeatherSun(pawn:GetId()) end
			end
			return
		end
		local X1, Y1, X2, Y2 = mission.WeatherLoc1.x, mission.WeatherLoc1.y, math.min(mission.WeatherLoc2.x,7), math.min(mission.WeatherLoc2.y,7)
		for i = X1, X2 do
			for j = Y1, Y2 do
				local pawn = Board:GetPawn(Point(i,j))
				if mission.Weather == "Sandstorm" then
					local isImmune = false
					if pawn then
						if _G[pawn:GetType()].ImpactMaterial == IMPACT_ROCK or _G[pawn:GetType()].ImpactMaterial == IMPACT_METAL then
							isImmune = true
						elseif pawn:IsPlayer() and not pawn:IsMech() then
							isImmune = true		--otherwise the bomb gets damaged, airplanes in Meridia, stuff like that
						elseif _G[pawn:GetType()].SandstormImmune ~= nil and type(_G[pawn:GetType()].SandstormImmune) == "boolean" and _G[pawn:GetType()].SandstormImmune then 
							isImmune = true
						elseif _G[pawn:GetType()].SandstormImmune ~= nil and type(_G[pawn:GetType()].SandstormImmune) == "table" and (pawn:GetId() == 0 or pawn:GetId() == 1 or pawn:GetId() == 2) then
						   -- this bit is just for Pokemon branching evolutions
						   local branch = GAME.BranchingEvos[pawn:GetId()+1]
						   local level = GameData.current["pilot"..pawn:GetId()].level
						   if _G[pawn:GetType()].SandstormImmune[branch][level+1] then isImmune = true end
						end
						if not isImmune then Board:DamageSpace(SpaceDamage(Point(i,j), 1)) end
					end
				elseif mission.Weather == "Rain" or mission.Weather == "Acid Rain" then
					if Board:IsFire(Point(i,j)) or (pawn and pawn:IsFire()) then
						Board:SetSmoke(Point(i,j), true, false)
					end
					if pawn then Status.RemoveStatus(pawn:GetId(), "Dry") end
				elseif mission.Weather == "Snow" then
					if pawn and (not pawn:IsFire()) and not CustomAnim:get(pawn:GetId(), "StatusChill") then
						Status.ApplyChill(pawn:GetId())
					end
				elseif mission.Weather == "Hail" then
					if pawn and CustomAnim:get(pawn:GetId(), "StatusChill") and not (pawn:IsFire() or pawn:IsShield()) then Status.ApplyChill(pawn:GetId()) end
				elseif mission.Weather == "Fog" then
					if pawn and pawn:GetTeam() == TEAM_ENEMY and not pawn:IsShield() then Status.ApplyBlind(pawn:GetId(), 1, true) end
				elseif mission.Weather == "Smog" then
					if pawn and pawn:GetTeam() ~= TEAM_BOTS and not pawn:IsShield() then 
						Status.ApplyToxin(pawn:GetId())
					end
				end
				if pawn and _G[pawn:GetType()]["FunctionInWeather"..mission.Weather] ~= nil then _G[pawn:GetType()]["FunctionInWeather"..mission.Weather](pawn:GetId()) end
			end
		end
	end)
	modApi:addMissionStartHook(function(mission)
		local tileset = modApi:getCurrentTileset()
		local weather
		if math.random() <= getRainChance(tileset) / 100 then
			if tileset == "snow" then weather = RAIN_SNOW
			elseif tileset == "acid" then weather = RAIN_ACID
			else weather = RAIN_NORMAL
			end
		end
		if weather then Board:SetWeather(2, weather, Point(0,0), Point(8,8), -1) end
	end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

-- local function onModsInitialized()
	-- Weathers = Weathers or {}
	-- Weathers.AddWeather = AddWeather
	-- Weathers.ClearWeather = ClearWeather
-- end

modApi.events.onBoardClassInitialized:subscribe(SetWeatherOverwriter)
-- modApi.events.onModsInitialized:subscribe(onModsInitialized)

-- return Weathers