local path = mod_loader.mods[modApi.currentMod].resourcePath

local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")

local MonHunWeapons = MonHunWeapons or {}




local function MonHunCorpsifyBoss(mission, pawn)
	if not mission then return end
	if not pawn then return end
	local OK
	for i = 0, 2 do
		local mech = Board:GetPawn(i)
		if mech and mech:IsAbility("MonHunSkill") then OK = true break end
	end
	if not OK then return end
	LOG("found hunter, killed a "..pawn:GetType())
	if _G[pawn:GetType()].Tier ~= TIER_BOSS then return end
	LOG("so tasty!")
	pawn:SetCorpse(true)
end

local function MonHunCarveBoss(mission)
	MonHunWeapons.FireflyBoss = "MonsterHunter_FireflyGL"
	MonHunWeapons.BeetleBoss = "MonsterHunter_BeetleL"
	MonHunWeapons.ScorpionBoss = "MonsterHunter_ScorpionSNS"
	MonHunWeapons.HornetBoss = "MonsterHunter_HornetBG"
	MonHunWeapons.TumblebugBoss = "MonsterHunter_TumblebugH"
	MonHunWeapons.PsionBoss = "MonsterHunter_PsionIG"
	MonHunWeapons.SpiderBoss = "MonsterHunter_SpiderIG"
	MonHunWeapons.BouncerBoss = "MonsterHunter_BouncerGS"
	MonHunWeapons.ScarabBoss = "MonsterHunter_ScarabHH"
	MonHunWeapons.CentipedeBoss = "MonsterHunter_CentipedeLS"
	MonHunWeapons.CrabBoss = "MonsterHunter_CrabB"
	MonHunWeapons.StarfishBoss = "MonsterHunter_StarfishDB"
	MonHunWeapons.MosquitoBoss = "MonsterHunter_MosquitoGL"
	MonHunWeapons.ScarabBoss = "MonsterHunter_ScarabBG"
	MonHunWeapons.BlobBoss = "MonsterHunter_GooHH"
	MonHunWeapons.Meta_TitanicGooBoss = "MonsterHunter_GooHH"
	MonHunWeapons.BlobBoss = "MonsterHunter_GooHH"
	MonHunWeapons.PlasmodiaBoss = "MonsterHunter_PlasmodiaSA"
	MonHunWeapons.GastropodBoss = "MonsterHunter_GastropodCB"
	
	MonHunWeapons.Meta_RockBoss = "MonsterHunter_RockHH"
	MonHunWeapons.Meta_RathalosBoss = "MonsterHunter_RathalosGS"
	
	MonHunWeapons.lmn_WyrmBoss = "MonsterHunter_WyrmIG"
	MonHunWeapons.lmn_CrusherBoss = "MonsterHunter_CrusherGS"
	MonHunWeapons.lmn_SwarmerBoss = "MonsterHunter_SwarmerDB"
	MonHunWeapons.lmn_SpitterBoss = "MonsterHunter_SpitterLS"
	MonHunWeapons.lmn_RoachBoss = "MonsterHunter_RoachSNS"
	
	for i = 0, 2 do
		local pawn = Board:GetPawn(i)
		if pawn and pawn:IsAbility("MonHunSkill") and not pawn:IsDead() then
			for dir = DIR_START, DIR_END do
				local corpse = Board:GetPawn(pawn:GetSpace() + DIR_VECTORS[dir])
				if corpse and corpse:IsDead() and _G[corpse:GetType()].Tier == TIER_BOSS then
					local weaponType = MonHunWeapons[corpse:GetType()]
					if weaponType and _G[weaponType] ~= nil then 
						Game:AddWeapon(weaponType) 
						Board:AddAlert(pawn:GetSpace() + DIR_VECTORS[dir], "Carved a ".._G[weaponType].Name.."!")
					else
						Game:AddWeapon("MonsterHunter_Trophy") 
						Board:AddAlert(pawn:GetSpace() + DIR_VECTORS[dir], "Carved a trophy.")
					end
				end
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modapiext:addPawnKilledHook(MonHunCorpsifyBoss)
	modApi:addMissionEndHook(MonHunCarveBoss)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)