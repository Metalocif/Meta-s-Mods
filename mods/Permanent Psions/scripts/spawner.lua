local mod = modApi:getCurrentMod()

local old_Spawner_NextPawn = Spawner.NextPawn
function Spawner:NextPawn(pawn_tables)
	local ret = old_Spawner_NextPawn(self, pawn_tables)
	if string.find(ret, "Jelly") then return Spawner:NextPawn(pawn_tables) end
	return ret
end

local function HOOK_MissionStart(mission)
	local options = mod_loader.currentModContent[mod.id].options
	if options["PermanentPsion"] and options["PermanentPsion"] ~= "" then 
		Board:AddPawn(options["PermanentPsion"].value, Point(0,0)) 
		Board:GetPawn(Point(0,0)):SetSpace(Point(-157,-197)) 
	end
	if options["PermanentPsion_Vextra"] and options["PermanentPsion_Vextra"] ~= "" then
		if options["PermanentPsion_Vextra"].value ~= "DNT_Winter1" then	--winter psion stores a list of points
			mission[options["PermanentPsion_Vextra"].value] = true 
		else
			mission[options["PermanentPsion_Vextra"].value] = {} 
		end
	end
	--tricks Vextra logic into thinking the psion is present
end

local function EVENT_onModsLoaded()
	local options = mod_loader.currentModContent[mod.id].options
	modApi:addMissionStartHook(HOOK_MissionStart)
	modApi:addPreEnvironmentHook(function(mission)	
		for i = 0, 2 do
			if options["PermanentPsion_Tyrant"] == true and Board:GetTurn() > 0 and Board:GetPawn(i) then
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