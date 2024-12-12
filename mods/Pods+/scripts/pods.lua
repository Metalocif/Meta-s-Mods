local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options

-- It is possible to have only a weapon, probably only a pilot as well
-- two cores work
-- weapon + pilot is visually buggy but fine
-- pilot + pilot does not work, it's just a pilot, same with weapon+weapon
--money works (gives N reputation) but has no image, title, or text; IDs are TipText_[nothing] so we can't use modApi:addText

-- 1core, 2core, 1core2money, pilot, weapon, pilotweapon, 5money, pilot1core, weapon1core

local FirstPodCards = {
	{ cores = 1 }, options.Meta_FirstPodOneCore.value,
	{ cores = 2 }, options.Meta_FirstPodTwoCores.value,
	{ weapon = "random", cores = 1 }, options.Meta_FirstPodWeaponCore.value,
	{ pilot = "random", cores = 1 }, options.Meta_FirstPodPilotCore.value,    
	{ weapon = "random", pilot = "random" }, options.Meta_FirstPodWeaponPilot.value,    
	{ cores = 1, money = 2 }, options.Meta_FirstPodOneCoreTwoRep.value, 
	{ weapon = "random" }, options.Meta_FirstPodWeapon.value,
	{ pilot = "random" }, options.Meta_FirstPodPilot.value,   	
	{ money = 5 }, options.Meta_FirstPodFiveRep.value, 
} 
local SecondPodCards = {
	{ cores = 1 }, options.Meta_SecondPodOneCore.value,
	{ cores = 2 }, options.Meta_SecondPodTwoCores.value,
	{ weapon = "random", cores = 1 }, options.Meta_SecondPodWeaponCore.value,
	{ pilot = "random", cores = 1 }, options.Meta_SecondPodPilotCore.value,    
	{ weapon = "random", pilot = "random" }, options.Meta_SecondPodWeaponPilot.value,    
	{ cores = 1, money = 2 }, options.Meta_SecondPodOneCoreTwoRep.value, 
	{ weapon = "random" }, options.Meta_SecondPodWeapon.value,
	{ pilot = "random" }, options.Meta_SecondPodPilot.value,   	
	{ money = 5 }, options.Meta_SecondPodFiveRep.value,  
} 

local function createFirstPodDeck()
    GAME.FirstPodDeck = {}
	for i = 1, #FirstPodCards, 2 do
		local maxCount = tonumber(FirstPodCards[i+1]) or 0
		for count = 1, maxCount do
			GAME.FirstPodDeck[#GAME.FirstPodDeck+1] = FirstPodCards[i]
		end		
	end
end

local function createSecondPodDeck()
    GAME.SecondPodDeck = {}
	for i = 1, #SecondPodCards, 2 do
		local maxCount = tonumber(SecondPodCards[i+1]) or 0
		for count = 1, maxCount do
			GAME.SecondPodDeck[#GAME.SecondPodDeck+1] = SecondPodCards[i]
		end		
	end
end

function getPodList(sector)
	local podCount = 1
	if sector == 1 then podCount = 1 end 
	if sector == 2 then podCount = 2 end
	if sector == 3 then podCount = 2 end
	
	pods = {}
	GAME.FirstPodDeck = GAME.FirstPodDeck or {}
	GAME.SecondPodDeck = GAME.SecondPodDeck or {}
	
	if #GAME.FirstPodDeck == 0 then createFirstPodDeck() end
	if #GAME.SecondPodDeck == 0 then createSecondPodDeck() end
	-- GAME.PodDeck = {}
	-- merge_table(GAME.PodDeck, GAME.FirstPodDeck)
	-- merge_table(GAME.PodDeck, GAME.SecondPodDeck)
	-- LOG("Decks count: "..#GAME.FirstPodDeck..", "..#GAME.SecondPodDeck)
	-- pods[1] = CreateEffect({ weapon = "random", pilot = "random" })

	pods[1] = CreateEffect(random_removal(GAME.FirstPodDeck))
	for i = 2, podCount do
		pods[i] = CreateEffect(random_removal(GAME.SecondPodDeck))
	end
	return pods
end