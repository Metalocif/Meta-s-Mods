local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/spider.png", path .."img/weapons/spider.png")
modApi:appendAsset("img/weapons/spiderling.png", path .."img/weapons/spiderling.png")
modApi:appendAsset("img/effects/technospiderwebitem.png", path .."img/effects/technospiderwebitem.png")
modApi:appendAsset("img/achievements/WellLaidWeb.png", path .."img/achievements/WellLaidWeb.png")


meta_spider=Skill:new{
	Name="Predating Mandibles",
	Class="TechnoVek",
	Description="Damages a target. Spawns a spiderling on kill. It is boosted if the target was gunked or gooey (Blobs, goos, and sludges are gooey). Can be used on empty tiles to lay a spiderling egg.",
	Icon="weapons/spider.png",
	Damage=2,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={1,3},
	UpgradeList={"Webs","+2 Damage"},
	OnKill = "Spawn a spiderling",
	LaunchSound = "/enemy/scorpion_1/attack",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "Meta_TechnoSpider",
		CustomEnemy = "Scarab1",
	}
}
meta_spider_A = meta_spider:new{UpgradeDescription = "Adds webs on adjacent tiles. Stepping on a web causes Techno-Spiders, allied spiderlings, and arachnoids to opportunistically attack the pawn.", WebAdjacent=true}
meta_spider_B = meta_spider:new{UpgradeDescription = "Deals 2 more damage.", Damage = 4}
meta_spider_AB = meta_spider:new{WebAdjacent=true,Damage = 4}

local achievements = {
	Meta_WellLaidWeb = modApi.achievements:add{
		id = "Meta_WellLaidWeb",
		name = "Well-Laid Web",
		tip = "Use the Techno-Firefly's fully upgraded weapon when it is fully levelled and powered.",
		img = path.."img/achievements/WellLaidWeb.png",
		squad = "Meta_SecretSquad4",
	}, 
}

function completeWellLaidWeb()
	if not achievements.Meta_WellLaidWeb:isComplete() then achievements.Meta_WellLaidWeb:addProgress{ complete = true } end
end

function meta_spider:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[dir])
	end
	if self.WebAdjacent then ret:push_back(point) end
	return ret
end

local GooeyPawns = {
	--all my Blobs
	"Meta_nestedgoo", "Meta_pylongoo", "Meta_shapeshifter", "Meta_sludgegoo", "Meta_spikygoo", "Meta_splittinggoo", 
	"Meta_TitanicGooBoss",	
	--Omega Vek
	"OmegaBlob2",
	--Unitsquare's Secret squad
	"X_Blob",
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

function meta_spider:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local boost = false
	local damage = SpaceDamage(p2, self.Damage)
	if Board:IsBlocked(p2, PATH_PROJECTILE) then 
		damage.sAnimation = "SwipeClaw2" 
	else 
		damage.iDamage = 0
		damage.sPawn = "meta_SpiderEgg"
	end
	if self.WebAdjacent then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if not (Board:IsBlocked(curr, PATH_GROUND) or Board:IsFire(curr) or Board:GetItem(curr) ~= "" or curr == p2) then
				ret:AddScript(string.format("Board:SetItem(%s, %q)", curr:GetString(), "TechnoWebItem"))
			end
		end
	end
	if p1 ~= p2 then
		local spawn = ""
		if Board:GetPawn(p2) then spawn = "meta_Spiderling" end
		if Board:GetPawn(p2) and (Status.GetStatus(Board:GetPawn(p2):GetId(), "Gunk") or IsGooey(Board:GetPawn(p2):GetType())) then boost = true end
		ret:AddMelee(p1, damage)
		ret:AddScript(string.format([[
		local userID = %s;
		local p2 = %s;
		local spider = PAWN_FACTORY:CreatePawn(%q)
		spider:SetBoosted(%s)
		spider:SetOwner(userID)
		if Board:IsTipImage() then
			Board:AddPawn(spider, p2) 
		else
			modApi:runLater(function() 
				if not Board:IsBlocked(p2, PATH_GROUND) then 
					Board:AddPawn(spider, p2) 
				end 
			end)
		end]], Board:GetPawn(p1):GetId(), p2:GetString(), spawn, tostring(boost)))
	end
	return ret	
end

merge_table(TILE_TOOLTIPS, { TechnoWeb_Text = {"Techno-Spider Web", "Triggers attacks of opportunity from adjacent spiders and spiderlings."} } )

local webdamage = SpaceDamage(0)
TechnoWebItem = { Image = "effects/technospiderwebitem.png", Damage = webdamage, Tooltip = "TechnoWeb_Text", Icon = "effects/technospiderwebitem.png", UsedImage = ""}
Location["effects/technospiderwebitem.png"] = Point(-20,0)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
	ret = SkillEffect()
	local achievementCounter = 0
    if removed_item == "TechnoWebItem" then
        local pawn = Board:GetPawn(loc)
        if pawn then
			local damage = SpaceDamage(loc)
			Board:DamageSpace(damage)
			for i = DIR_START, DIR_END do
				local curr = loc + DIR_VECTORS[i]
				local hunter = Board:GetPawn(curr)
				if hunter and hunter:GetType()=="Meta_TechnoSpider" then
					ret:AddMelee(curr, SpaceDamage(loc, 2))
					achievementCounter = achievementCounter+1
				elseif hunter and (hunter:GetType() == "meta_Spiderling" or hunter:GetType() == "SpiderlingZ" or string.match(hunter:GetType(), "DeployUnit_Aracnoid")) then
					ret:AddMelee(curr, SpaceDamage(loc, 1))
					achievementCounter = achievementCounter+1
				end
			end
			Board:AddEffect(ret)
        end
		if achievementCounter >= 2 then completeWellLaidWeb() end
    end
	
end)


function SpiderEggHatch(id)
	local unit = PAWN_FACTORY:CreatePawn("meta_Spiderling")
	local p1 = Board:GetPawn(id):GetSpace()
	if Board:GetPawn(p1) then 
		local wasFrozen = Board:GetPawn(p1):IsFrozen()
		unit:SetOwner(Board:GetPawn(p1):GetOwner())
		Board:GetPawn(p1):Kill(false) 
		Board:AddPawn(unit,p1) 
		if wasFrozen then unit:SetFrozen(true, true) end
	end
end

meta_SpiderEgg ={
	Name = "Spider Egg",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 0,
	Image = "webling_egg1",
	Minor = true,
	Neutral = true,
	IgnoreSmoke = true,
	IsPortrait = false,
	DefaultTeam = TEAM_PLAYER,
	SkillList = { "meta_Hatch1" },
	SoundLocation = "/enemy/spiderling_egg/",
	ImpactMaterial = IMPACT_FLESH,
	OnAppliedGunk = SpiderEggHatch,
}
	
AddPawn("meta_SpiderEgg")

meta_Hatch1 = SelfTarget:new{ 
	Name = "Hatch",
	Description = "Hatch into a spiderling. Hatches instantly when applied Gunk.",
	Class = "TechnoVek",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "WebbEgg1",
	}
}

function meta_Hatch1:GetTargetScore(p)
	return 10
end

function meta_Hatch1:GetTargetArea(p)
	ret = PointList()
	ret:push_back(p)
	return ret
end

function meta_Hatch1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	ret:AddScript(string.format([[
	modApi:conditionalHook(
	function()
		return Game:GetTeamTurn() == TEAM_PLAYER
	end,
	function()
		local unit = PAWN_FACTORY:CreatePawn(%q)
		local p1 = %s
		unit:SetActive(false)
		if Board:GetPawn(p1) then 
			unit:SetOwner(Board:GetPawn(p1):GetOwner())
			Board:GetPawn(p1):Kill(false) 
			Board:AddPawn(unit,p1) 
		end
	end)]], "meta_Spiderling", p1:GetString()))	
	--dirty hack because if it spawns on enemy turn the game queues it as though it were an enemy???
	--for some reason just spawning a thing and doing SetActive(false) does not help
	return ret
end

meta_Spiderling = {
	Name = "Spiderling",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Image = "Meta_spiderling",
	SkillList = { "meta_SpiderlingAtk1" },
	SoundLocation = "/enemy/spiderling_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Portrait = "enemy/Spider1"
}
AddPawn("meta_Spiderling")  

meta_SpiderlingAtk1 = Skill:new{
	Name = "Tiny Mandibles",
	Description = "Weak 1 damage attack against a single adjacent target.",
	Class = "TechnoVek",
	Icon = "weapons/spiderling.png",
	PathSize = 1, 
	Damage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Spiderling1"
	}
}

function meta_SpiderlingAtk1:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,self.Damage)
	ret:AddMelee(p1,damage)
	return ret
end