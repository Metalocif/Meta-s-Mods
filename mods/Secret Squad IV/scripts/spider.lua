local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/spider.png", path .."img/weapons/spider.png")
modApi:appendAsset("img/weapons/spiderling.png", path .."img/weapons/spiderling.png")


meta_spider=Skill:new{
	Name="Predating Mandibles",
	Class="TechnoVek",
	Description="Damages a target. Spawns a spiderling egg on kill. It hatches instantly if the target was gunked or gooey (Blobs, goos, and sludges are gooey).",
	Icon="weapons/spider.png",
	Damage=2,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={2,3},
	UpgradeList={"Webs","+2 Damage"},
	OnKill = "Spawn an egg",
	LaunchSound = "/enemy/scorpion_1/attack",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Meta_TechnoSpider",
	}
}
meta_spider_A = meta_spider:new{UpgradeDescription = "Adds Deadly Webs on adjacent tiles. Stepping on a Deadly Web causes Techno-Spiders, allied spiderlings, and arachnoids to opportunistically attack the pawn.", WebAdjacent=true}
meta_spider_B = meta_spider:new{UpgradeDescription = "Deals 2 more damage.", Damage = 4}
meta_spider_AB = meta_spider:new{Damage = 4}

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
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "SwipeClaw2"
	if self.WebAdjacent then
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if not (Board:IsBlocked(curr, PATH_GROUND) or Board:IsFire(curr) or Board:GetItem(curr) or curr == p2) then
				ret:AddScript(string.format("Board:SetItem(%q, %s)", "Meta_TechnoSpiderWeb", curr:GetString()))
			end
		end
	end
	if p1 ~= p2 then
		local spawn = "meta_SpiderEgg"
		if Board:GetPawn(p2) and (Status.GetStatus(Board:GetPawn(p2):GetId(), "Gunk") or IsGooey(Board:GetPawn(p2):GetType())) then spawn = "meta_Spiderling" end
		ret:AddMelee(p1, damage)
		ret:AddScript(string.format("modApi:runLater(function() if not Board:IsBlocked(%s, PATH_GROUND) then Board:SpawnPawn(%q, %s) end end)", p2:GetString(), spawn, p2:GetString()))
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
				elseif hunter and (hunter:GetType() == "meta_Spiderling" or string.match(hunter:GetType(), "DeployUnit_Aracnoid")) then
					ret:AddMelee(curr, SpaceDamage(loc, 1))
				end
			end
			Board:AddEffect(ret)
        end
    end
	if achievementCounter >= 3 then
	
	end
end)



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
}
	
AddPawn("meta_SpiderEgg")

meta_Hatch1 = SelfTarget:new{ 
	Class = "",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "WebbEgg1",
	}
}

function meta_Hatch1:GetTargetScore(p)
	return 10
end

function meta_Hatch1:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p1,DAMAGE_DEATH)
	damage.sPawn = "meta_Spiderling"
	ret:AddDamage(damage)
	return ret
end

meta_Spiderling = {
	Name = "Spiderling",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Minor = true,
	Image = "spiderling",
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