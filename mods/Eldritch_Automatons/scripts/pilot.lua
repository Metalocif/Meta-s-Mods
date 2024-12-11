-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- read out other files and add what they return to variables.
local tooltips = require(path .."scripts/libs/tooltip")
local personalities = require(path .."scripts/libs/personality")
local dialog = require(path .."scripts/dialog")

local pilot = {
	Id = "Pilot_AbdulAlhazred_Meta",					-- id must be unique. Used to link to art assets.
	Personality = "AbdulAlhazred",	-- must match the id for a personality you have added to the game.
	Name = "Abdul Alhazred",
	Rarity = 1,
	Voice = "/voice/ralph",					-- audio. look in pilots.lua for more alternatives.
	Skill = "ForbiddenKnowledge",
}

-- add pilot to the game.
CreatePilot(pilot)

-- add assets - notice how the name is identical to pilot.Id
modApi:appendAsset("img/portraits/pilots/Pilot_AbdulAlhazred_Meta.png", path .."img/portraits/pilots/Pilot_AbdulAlhazred_Meta.png")
modApi:appendAsset("img/portraits/pilots/Pilot_AbdulAlhazred_Meta_2.png", path .."img/portraits/pilots/Pilot_AbdulAlhazred_Meta_2.png")
modApi:appendAsset("img/portraits/pilots/Pilot_AbdulAlhazred_Meta_blink.png", path .."img/portraits/pilots/Pilot_AbdulAlhazred_Meta_blink.png")

-- add ability tooltip - notice how the name is the same as pilot.Skill
tooltips.Add("ForbiddenKnowledge",
	PilotSkill("Forbidden Truth",
		"Adjacent pilots lose 1 sanity at the start of every turn. Boosts pilots when they go Insane."))

-- add personality.
local personality = personalities:new{ Label = "AbdulAlhazred" }

-- add dialog to personality.
personality:AddDialog(dialog)

-- add personality to game - notice how the id is the same as pilot.Personality
Personality["AbdulAlhazred"] = personality



local function AbdulAlhazredInsanityRemoval(mission)
	local foundAbdul
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:GetPersonality() == "AbdulAlhazred" then foundAbdul = true break end 
	end
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and Status.GetStatus(i, "Insanity") and Status.GetStatus(i, "Insanity") >= 5 then 
			local stayInsane = false
			for j = 1, pawn:GetWeaponCount() do
				if _G[pawn:GetWeaponType(j)].UsesInsanity then stayInsane = true end
			end
			if not stayInsane then Status.ApplyInsanity(i, -5) end
		end 
	end
end

local function AbdulAlhazredInsanity(mission)
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:GetPersonality() == "AbdulAlhazred" then 
			for dir = DIR_START, DIR_END do
				local curr = pawn:GetSpace() + DIR_VECTORS[dir]
				if Board:GetPawn(curr) and Board:GetPawn(curr):IsMech() then Status.ApplyInsanity(Board:GetPawn(curr):GetId()) end
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addPreEnvironmentHook(AbdulAlhazredInsanityRemoval)
	modApi:addNextTurnHook(AbdulAlhazredInsanity)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)


local function onPawnAnimationAdded(pawnId, animId, suffix)		--status lib hook, kind of
    if animId == "StatusInsanity5" then 
		for i = 0, 2 do
			local pawn = Board:GetPawn(i)
			if pawn and pawn:GetPersonality() == "AbdulAlhazred" and not pawn:IsDead() then Board:GetPawn(pawnId):SetBoosted(true) end
		end
	end
end

CustomAnim.events.onPawnAnimationAdded:subscribe(onPawnAnimationAdded)