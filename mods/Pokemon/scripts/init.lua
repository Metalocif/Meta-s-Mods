local description = "Adds several Pokemon squads to the game. Gotta catch 'em all!"
local mod = {
	id = "Meta_Pokemon",
	name = "Pokemon",
	version = "1.6.2",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
	},
	modApiVersion = "2.9.3",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	local options = mod_loader.currentModContent[mod.id].options
	if options["PokemonCustomSquadName"] then 
		modApi:setText("SquadName_Filler", options["PokemonCustomSquadName"].value)
		-- if options["PokemonCustomSquadName"].value ~= "Time Travellers" then
			modApi:setText("Closing_Dead_9", "The Pokemon wiped them out!")
			modApi:setText("Opening_10", "The Pokemon have landed!")
			modApi:setText("Opening_11", "#corp sent Pokemon!")
			modApi:setText("Opening_17", "The Pokemon!")
			modApi:setText("Opening_23", "The Pokemon are here!")
		-- end
	end
	require(mod_loader.mods.meta_mods.scriptPath.."libs/saveData")
	require(mod_loader.mods.meta_mods.scriptPath.."libs/boardEvents")
	require(mod_loader.mods.meta_mods.scriptPath.."libs/multishot")
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."items")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."bosses")
	require(self.scriptPath .."tileset")
	
	require(self.scriptPath .."missions/mission_mewtwo")
	require(self.scriptPath .."missions/mission_mewtwo_dialog")
	require(self.scriptPath .."missions/mission_deoxys")
	require(self.scriptPath .."missions/mission_deoxys_dialog")
	require(self.scriptPath .."missions/mission_darkrai")
	require(self.scriptPath .."missions/mission_darkrai_dialog")
	modApi:appendAssets("img/strategy/mission/", "img/strategy/mission/", "")
	modApi:appendAssets("img/strategy/mission/small/", "img/strategy/mission/small/", "")
	self.modApiExt = require(self.scriptPath .."modApiExt/modApiExt")
	self.modApiExt:init()
	self.missions = require(self.scriptPath .."missions/init")
	self.missions:init(self)
	local ml = easyEdit.missionList:get("archive")
	ml:addMission("Mission_Poke_Celebi", true)
	ml:addMission("Mission_Poke_Shaymin", true)
	ml:addMission("Mission_Poke_Xerneas", true)
	ml = easyEdit.missionList:get("detritus")
	ml.addMission(ml._default , "Mission_Poke_Deoxys", true)
	ml.addMission(ml._default , "Mission_Poke_Mewtwo", true)
	ml.addMission(ml._default , "Mission_Poke_Darkrai", true)
	modApi:addModsInitializedHook(function()
		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
			local result = oldGetStartingSquad(choice, ...)

			if choice == 0 then
				local copy = {}
				for i, v in pairs(result) do
					copy[#copy+1] = v
				end
				table.insert(copy, "Poke_ArmoredMewtwo")
				table.insert(copy, "Poke_Arceus")

				return copy
			end

			return result
		end
	end)
end

local function isMission()
	local mission = GetCurrentMission()

	return true
		and Game ~= nil
		and GAME ~= nil
		and mission ~= nil
		and mission ~= Mission_Test
end

function mod:load( options, version)
	self.modApiExt:load(self, options, version)
	self.missions:load(self, options, version)
	if options["PokemonCustomSquadName"] then 
		modApi:setText("SquadName_Filler", options["PokemonCustomSquadName"].value)
		-- if options["PokemonCustomSquadName"].value ~= "Time Travellers" then
			modApi:setText("Closing_Dead_9", "The Pokemon wiped them out!")
			modApi:setText("Opening_10", "The Pokemon have landed!")
			modApi:setText("Opening_11", "#corp sent Pokemon!")
			modApi:setText("Opening_17", "The Pokemon!")
			modApi:setText("Opening_23", "The Pokemon are here!")
		-- end
	end
	modApi:addSquad(
		{"Pokemon Team","Poke_Abra", "Poke_Dratini", "Poke_Mew", id = "Poke_Squad"}, 
		"Pokemon Team", "A team of Pokemon.", 	--my wife's favorites
		self.resourcePath .. "img/mod_icon.png")
	if modApi.achievements:isComplete(mod.id,"Poke_ArticunoCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_ZapdosCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_MoltresCapture") then 

		modApi:addSquad(
		{"Legendary Birds","Poke_Articuno", "Poke_Zapdos", "Poke_Moltres", id = "Poke_BirdSquad"}, 
		"Legendary Birds", "The three legendary birds of Kanto.", 
		self.resourcePath .. "img/birds_icon.png")
	end
	if modApi.achievements:isComplete(mod.id,"Poke_MewtwoCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_DeoxysCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_DarkraiCapture") then 

		modApi:addSquad(
		{"Dark Minds","Poke_Mewtwo", "Poke_Deoxys", "Poke_Darkrai", id = "Poke_EvilSquad"}, 
		"Dark Minds", "These ruthless Pokemon will crush the Vek.", 
		self.resourcePath .. "img/evil_icon.png")
	end
	if modApi.achievements:isComplete(mod.id,"Poke_CelebiCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_ShayminCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_XerneasCapture") then 

		modApi:addSquad(
		{"Nature's Guardians","Poke_Celebi", "Poke_Shaymin", "Poke_Xerneas", id = "Poke_NatureSquad"}, 
		"Nature's Guardians", "Protectors of nature, these Pokemon will heal the planet.", 
		self.resourcePath .. "img/nature_icon.png")
	end
	-- if modApi.achievements:isComplete(mod.id,"Poke_DialgaCapture") and 
	   -- modApi.achievements:isComplete(mod.id,"Poke_PalkiaCapture") and 
	   -- modApi.achievements:isComplete(mod.id,"Poke_GiratinaCapture") then 

		modApi:addSquad(
		{"Dragons of Myth","Poke_Dialga", "Poke_Palkia", "Poke_Giratina", id = "Poke_MythSquad"}, 
		"Dragons of Myth", "The dragons who rule over the universe.", 
		self.resourcePath .. "img/redchain_icon.png")
	-- end
	modApi:addSquad(
	{"Earth's Champions","Poke_Beldum", "Poke_Larvitar", "Poke_Gible", id = "Poke_EarthChampions"}, 
	"Earth's Champions", "Some of the greatest Pokemon trainers, banded together to stop the Vek threat.", 
	self.resourcePath .. "img/champions_icon.png")
	modApi:addSquad(
	{"Adaptive Beasts","Poke_Scyther", "Poke_Eevee", "Poke_Ralts", id = "Poke_AdaptiveBeasts"}, 
	"Adaptive Beasts", "Trainers that privilege adaptation over all; they train Pokemon that have variable potentials.", 
	self.resourcePath .. "img/chaos_icon.png")
		
	modApi:addMissionEndHook(function()		--revive dead pawns, do evolution stuff
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		if GAME.BranchingEvos == nil then GAME.BranchingEvos = {1, 1, 1} end
		--we have branching evos which lists names, branching evo level which tracks when it happens, and branching evo tables
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			if pawn then
				local pilotLevel = GameData.current["pilot"..id].level
				local branch = GAME.BranchingEvos[id+1]
				if pawn:IsDead() then												--don't evolve if you were dead
					Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -1))
				elseif pilotLevel > 0 then											--check whether we should consider evolving
					if _G[pawn:GetType()].HasEvolutions and 							--check it's a Pokemon that should evolve
					   _G[pawn:GetType()].HasEvolutions[pilotLevel] and 				--check whether it evolves at this level, it's {true, true} for Abra/Dratini
					   GAME.Poke_Evolutions[id+1] < pilotLevel then						--hasn't evolved already
						LOG(pawn:GetType().." is evolving!")
						Game:TriggerSound("/ui/map/flyin_rewards")
						if _G[pawn:GetType()].EvoNames and _G[pawn:GetType()].EvoNames[branch] and _G[pawn:GetType()].EvoNames[branch][pilotLevel] then
							Board:AddAlert(pawn:GetSpace(), _G[pawn:GetType()].EvoNames[branch][pilotLevel].." is evolving into ".._G[pawn:GetType()].EvoNames[branch][pilotLevel+1].."!")
						end
						local doneChecking = false
						repeat	--super ugly but ItB's version of Lua does not have Goto and it didn't work without this code.
							doneChecking = not doneChecking
							pawn = Game:GetPawn(id)
							for i = 1, pawn:GetWeaponCount() do								--remove weapon
								if pawn:GetWeaponCount() < i then break end
								local weapon = pawn:GetWeaponBaseType(i)
								if weapon and weapon == _G[pawn:GetType()].EvoForget[pilotLevel] then 
									pawn:RemoveWeapon(i) 
									i=i+1
									LOG("Forgot "..weapon..".") 
									doneChecking = false
								elseif weapon then
									--figure out whether this mech is supposed to have that weapon at all, as otherwise we can't add new weapons
									local isOwnWeapon = false
									for j = 1, #_G[pawn:GetType()].SkillList do
										if weapon == _G[pawn:GetType()].SkillList[j] then isOwnWeapon = true end
										--if it's natively on the pawn...
									end
									for j = 1, #_G[pawn:GetType()].EvoLearn[branch] do
										for k = 1, #_G[pawn:GetType()].EvoLearn[branch][j] do
											if weapon == _G[pawn:GetType()].EvoLearn[branch][j][k] then isOwnWeapon = true end
											--...or it's learnt on level-up, don't remove it
										end
									end
									if not isOwnWeapon then
										pawn:RemoveWeapon(i)
										i=i+1
										Game:AddWeapon(weapon)
										LOG("Moved "..weapon..", a non-Pokemon weapon, back to inventory.")
										doneChecking = false
									end
								end
							end
						until doneChecking	
						for i = 1, #_G[pawn:GetType()].EvoLearn[branch][pilotLevel] do						
						--add all weapons learnt on evolution
							local weapon = _G[pawn:GetType()].EvoLearn[branch][pilotLevel][i]
							pawn:AddWeapon(weapon)
							LOG(pawn:GetType().." learnt the move "..weapon.."!")
						end		
						
						Game:TriggerSound("/ui/map/flyin_rewards")
						Board:Ping(pawn:GetSpace(), GL_Color(255, 255, 150))
						-- if _G[pawn:GetType()].EvoGraphics and _G[pawn:GetType()].EvoGraphics[branch][pilotLevel] ~= "" then --update graphics
							-- pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[branch][pilotLevel])
						-- end 
					end
					GAME.Poke_Evolutions[id+1] = pilotLevel			
					--remember it evolved so we don't do it again
					--we set this separately from evolution so that evoless Pokemon can get stuff with levels anyway
				end
			end
		end
    end)
	modApi:addMissionStartHook(function()	--need to reassign graphics at mission start since the game forgets otherwise
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		if GAME.BranchingEvos == nil or #GAME.BranchingEvos < 3 then 	--prepare branching evos in first since the menu doesn't pause the game at mission end before evolution
			GAME.BranchingEvos = {}
			for id = 0, 2 do
				if GAME.BranchingEvos[id+1] == nil then
					local pawn = Game:GetPawn(id)
					if _G[pawn:GetType()].BranchingEvos ~= nil then
						if #_G[pawn:GetType()].BranchingEvos == 2 then
							sdlext.showAlertDialog(
								"Choose your ".._G[pawn:GetType()].EvoNames[1][1].."'s future evolution!",
								"Choose whether your ".._G[pawn:GetType()].EvoNames[1][1].." will evolve into ".._G[pawn:GetType()].BranchingEvos[1].." or ".._G[pawn:GetType()].BranchingEvos[2]..".",
								function(buttonIndex) GAME.BranchingEvos[id+1] = buttonIndex end, 700, 400, _G[pawn:GetType()].BranchingEvos[1], _G[pawn:GetType()].BranchingEvos[2]
							)
						elseif #_G[pawn:GetType()].BranchingEvos == 8 then
							sdlext.showAlertDialog(
								"Choose your ".._G[pawn:GetType()].EvoNames[1][1].."'s future evolution!",
								"Choose whether your ".._G[pawn:GetType()].EvoNames[1][1].." will evolve into "..
								table.concat(_G[pawn:GetType()].BranchingEvos, ", ", 1, #_G[pawn:GetType()].BranchingEvos - 1)..", or ".._G[pawn:GetType()].BranchingEvos[#_G[pawn:GetType()].BranchingEvos]..".",
								-- this reads as "Vaporeon, Jolteon, Flareon, Espeon, ..., or Sylveon": we have a special separator for the last one.
								function(buttonIndex) GAME.BranchingEvos[id+1] = buttonIndex end, 1250, 400, _G[pawn:GetType()].BranchingEvos[1], _G[pawn:GetType()].BranchingEvos[2], _G[pawn:GetType()].BranchingEvos[3], _G[pawn:GetType()].BranchingEvos[4], _G[pawn:GetType()].BranchingEvos[5], _G[pawn:GetType()].BranchingEvos[6], _G[pawn:GetType()].BranchingEvos[7], _G[pawn:GetType()].BranchingEvos[8]
								--super ugly but AFAICT this function does not accept a table as its last argument
							)
						end
					elseif _G[pawn:GetType()].MegaEvos ~= nil and #_G[pawn:GetType()].MegaEvos > 1 then
						sdlext.showAlertDialog(
							"Choose your ".._G[pawn:GetType()].Name.."'s Mega Evolution!",
							"Choose whether your ".._G[pawn:GetType()].Name.." will Mega Evolve into ".._G[pawn:GetType()].MegaEvoNames[1].." or ".._G[pawn:GetType()].MegaEvoNames[2]..".",
							function(buttonIndex) GAME.BranchingEvos[id+1] = buttonIndex end, 700, 400, _G[pawn:GetType()].MegaEvoNames[1], _G[pawn:GetType()].MegaEvoNames[2]
						)
					else
						GAME.BranchingEvos[id+1] = 1
					end
				end
			end
		end
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			local evo = GAME.Poke_Evolutions[id + 1]
			local branch = GAME.BranchingEvos[id + 1]
			if _G[pawn:GetType()].HasEvolutions ~= nil and evo > 0 and _G[pawn:GetType()].EvoGraphics ~= nil then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[branch][evo]) end
			if _G[pawn:GetType()].BecomeFlyingAtLevel ~= nil and _G[pawn:GetType()].BecomeFlyingAtLevel[branch] and _G[pawn:GetType()].BecomeFlyingAtLevel[branch] <= evo then pawn:SetFlying(true) end
			if _G[pawn:GetType()].LoseFlyingAtLevel ~= nil and _G[pawn:GetType()].LoseFlyingAtLevel[branch] <= evo then pawn:SetFlying(false) end
			-- if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
			if _G[pawn:GetType()].KeepAdding ~= nil and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
				pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
			end
        end
    end)
	modApi:addPostLoadGameHook(function()
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		if GAME.BranchingEvos == nil then GAME.BranchingEvos = {1, 1, 1} end
		--We are not immediately in a mission after resetting turn, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			for id = 0,2 do
				local pawn = Game:GetPawn(id)
				local evo = GAME.Poke_Evolutions[id + 1]
				local branch = GAME.BranchingEvos[id + 1]
				if _G[pawn:GetType()].HasEvolutions and evo > 0 and _G[pawn:GetType()].EvoGraphics then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[branch][evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel[branch] and _G[pawn:GetType()].BecomeFlyingAtLevel[branch] <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].LoseFlyingAtLevel and _G[pawn:GetType()].LoseFlyingAtLevel[branch] <= evo then pawn:SetFlying(false) end
				-- if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
				if GetCurrentMission().MegaEvolved == id then
					pawn:SetCustomAnim(_G[pawn:GetType()].MegaEvos[branch])
					pawn:AddWeapon(_G[pawn:GetType()].MegaEvoMoves[branch])
				end
			end
		end)
    end)
	modApi:addMissionNextPhaseCreatedHook(function()
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		if GAME.BranchingEvos == nil then GAME.BranchingEvos = {1, 1, 1} end
		--We are not immediately in a mission after falling into the Volcanic Cave, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			for id = 0, 2 do
				local pawn = Game:GetPawn(id)
				local evo = GAME.Poke_Evolutions[id + 1]
				local branch = GAME.BranchingEvos[id + 1]
				if _G[pawn:GetType()].HasEvolutions and evo > 0 and _G[pawn:GetType()].EvoGraphics ~= nil then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[branch][evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel[branch] <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].LoseFlyingAtLevel and _G[pawn:GetType()].LoseFlyingAtLevel[branch] <= evo then pawn:SetFlying(false) end
				-- if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
				if GetCurrentMission().MegaEvolved == id then
					pawn:SetCustomAnim(_G[pawn:GetType()].MegaEvos[branch])
					pawn:AddWeapon(_G[pawn:GetType()].MegaEvoMoves[branch])
				end
			end
		end)
    end)
	modApi:addNextTurnHook(function()
		local mission = GetCurrentMission()
		for id = 0, 2 do
			local pawn = Board:GetPawn(id)
			local pilotLevel = GameData.current["pilot"..id].level
			local branch = GAME.BranchingEvos[id + 1]
			if pawn and pawn:IsDead() and not mission.MegaEvolved and _G[pawn:GetType()].MegaEvos ~= nil and pilotLevel == 2 and Game:GetTeamTurn() == TEAM_PLAYER then
				Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -10))
				local rainbowColors = {COLOR_RED, COLOR_GREEN, COLOR_BLUE}
				for i = 1, 10 do
					Board:Ping(pawn:GetSpace(), rainbowColors[(i%3)+1])
					local delay = SkillEffect()
					delay:AddDelay(0.1)
					Board:AddEffect(delay)
				end
				pawn:SetCustomAnim(_G[pawn:GetType()].MegaEvos[branch])
				pawn:AddWeapon(_G[pawn:GetType()].MegaEvoMoves[branch])
				mission.MegaEvolved = id	--max once per mission, even if more than one can mega evolve
			end
		
		end
	end)
	modApi.events.onPawnSelectedForDeployment:subscribe(function(pawnId)
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		if GAME.BranchingEvos == nil then GAME.BranchingEvos = {1, 1, 1} end
		if options["PokemonDeployment"] and options["PokemonDeployment"].enabled then
			local pilotLevel = GameData.current["pilot"..pawnId].level
			local branch = GAME.BranchingEvos[pawnId+1]
			if _G[Board:GetPawn(pawnId):GetType()].EvoNames ~= nil and branch ~= nil then
				LOG(_G[Board:GetPawn(pawnId):GetType()].EvoNames[branch][pilotLevel+1])
				Board:AddAlert(Point(1, 1), _G[Board:GetPawn(pawnId):GetType()].EvoNames[branch][pilotLevel+1])
			else
				Board:AddAlert(Point(1, 1), Board:GetPawn(pawnId):GetMechName())
			end
		end
	end)
end

local function init(self)
	meta_missions_modApiExt = require(self.scriptPath.."modApiExt/modApiExt"):init()
end

function mod:metadata()
	modApi:addGenerationOption(
		"PokemonDeployment",
		"Display name on deployment",
		"Pick whether to display the name of the Pokemon you are currently deploying.",
		{ enabled = false }
	)
	modApi:addGenerationOption(
		"PokemonCustomSquadName",
		"Change the name of the Custom Squad",
		"Pick a name to give the Custom Squad, instead of the default 'Time Travellers'.",
		{ values = {"Time Travellers", "Pokemon Team", "Pocket Monsters", "Pokemon Trainers", "Legendary Pokemon"} }
	)
end

return mod
