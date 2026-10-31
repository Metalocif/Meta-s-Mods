local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
-- modApi:appendAsset("img/effects/stinger_R.png", resourcePath.."img/effects/stinger_R.png")
-- modApi:appendAsset("img/effects/stinger_U.png", resourcePath.."img/effects/stinger_U.png")

OmegaThunderbugAtk2 = Skill:new{
	Damage = 2,
	Range = 2,
	Name = "Keraunic Prongs",
	Description = "Calls lightning down upon three evenly spaced tiles in a row.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,0),
		Building = Point(2,2),
		Target = Point(2,2),
		-- CustomPawn = "OmegaMosquito2"
	}
}

function OmegaThunderbugAtk2:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i]*2)
	end
	return ret
end	

function OmegaThunderbugAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	for i = 2, 6, 2 do
		local damage = SpaceDamage(p2 + DIR_VECTORS[dir] * i, self.Damage)
		damage.sAnimation = "LightningBoltBig"
		damage.sSound = "/props/lightning_strike"
		damage.iShocked = 1
		ret:AddQueuedDamage(damage)
		ret:AddDelay(0.3)
	end
	return ret
end

OmegaThunderbugAtkB = OmegaThunderbugAtk2:new{Damage=4, Class = "Enemy",Name = "Jovian Prongs",}