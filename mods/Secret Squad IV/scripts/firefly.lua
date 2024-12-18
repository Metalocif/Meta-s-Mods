local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local saveData = require(mod_loader.mods.meta_mods.scriptPath.."libs/saveData")
modApi:appendAsset("img/weapons/firefly.png", path .."img/weapons/firefly.png")
modApi:appendAsset("img/achievements/PerfectlyUltimateGreatFirefly.png", path .."img/achievements/PerfectlyUltimateGreatFirefly.png")

meta_firefly=TankDefault:new{
	Name="Spitting Thorax",
	Class="TechnoVek",
	Description="Fire a pushing projectile that applies Gunk. Will not damage allied gooey pawns.",
	Icon="weapons/firefly.png",
	Damage=1,
	PathSize=8,
	Shots = 1,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={3,3},
	UpgradeList={"+1 Shot","+1 Shot"},
	Self = "meta_firefly",
	LaunchSound = "/enemy/firefly_1/attack",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Meta_TechnoFirefly",
	}
}
meta_firefly_A = meta_firefly:new{UpgradeDescription = "Fires one more projectile.", Shots = 2, Self = "meta_firefly_A",}
meta_firefly_B = meta_firefly:new{UpgradeDescription = "Fires one more projectile.", Shots = 2, Self = "meta_firefly_B",}
meta_firefly_AB = meta_firefly:new{Shots = 3, Self = "meta_firefly_AB",}

local achievements = {
	Meta_PerfectlyUltimateGreatFirefly = modApi.achievements:add{
		id = "Meta_PerfectlyUltimateGreatFirefly",
		name = "Perfectly Ultimate Great Firefly",
		tip = "Use the Techno-Firefly's fully upgraded weapon when it is fully levelled and powered.",
		img = path.."img/achievements/PerfectlyUltimateGreatFirefly.png",
		squad = "Meta_SecretSquad4",
	}, 
}

function completePerfectlyUltimateGreatFirefly()
	if not achievements.Meta_PerfectlyUltimateGreatFirefly:isComplete() then achievements.Meta_PerfectlyUltimateGreatFirefly:addProgress{ complete = true } end
end


local GooeyPawns = {
	--all my Blobs
	"Meta_nestedgoo", "Meta_pylongoo", "Meta_shapeshifter", "Meta_sludgegoo", "Meta_spikygoo", "Meta_splittinggoo", 
	"Meta_TitanicGooBoss",	
	--Omega Vek
	"OmegaBlob2",
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

function meta_firefly:GetSkillEffect(p1, p2, remainingShots)
	local ret = SkillEffect()
	local userID = Board:GetPawn(p1):GetId()
	local target = GetProjectileEnd(p1,p2)
	local direction = GetDirection(p2-p1)
	remainingShots = remainingShots or self.Shots
	
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "ExploFirefly2"
	damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
	local pawn = Board:GetPawn(target)
	if pawn then damage.sScript = string.format("Status.ApplyGunk(%s)", pawn:GetId()) end
	if pawn and IsGooey(pawn:GetType()) and pawn:GetTeam() == TEAM_PLAYER then damage.iDamage = 0 end
	ret:AddProjectile(p1, damage, "effects/shot_firefly2", NO_DELAY)
	ret:AddDelay(0.15)
	if remainingShots > 1 then
		remainingShots = remainingShots - 1
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
	end
	
	-- Achievement
	if saveData ~= nil then
		local reactorTable = saveData.getPawnKey(userID, "reactor")
		if reactorTable ~= nil then
			local reactors = reactorTable["iNormalPower"] + reactorTable["iUsedPower"] + reactorTable["iBonusPower"] + reactorTable["iUsedBonus"]
			if reactors >= 10 and self.Shots >= 3 and GameData ~= nil and GameData.current["pilot"..userID] ~= nil and GameData.current["pilot"..userID].level == 2 then
				ret:AddScript("completePerfectlyUltimateGreatFirefly()")
			end
		end
	end
	
	return ret
end	