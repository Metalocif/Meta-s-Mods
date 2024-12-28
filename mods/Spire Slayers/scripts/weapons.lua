
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- add assets from our mod so the game can find them.
modApi:appendAsset("img/weapons/BladeDance.png", path .."img/weapons/BladeDance.png")
-- modApi:appendAsset("img/effects/shot_shiv_R.png", path .."img/effects/shot_shiv_R.png")
-- modApi:appendAsset("img/effects/shot_shiv_U.png", path .."img/effects/shot_shiv_U.png")

StS_BladeDance = Skill:new{
	Name = "Blade Dance",
	Class = "",
	Icon = "weapons/BladeDance.png",
	Description = "Fires three damaging projectiles.",
	Projectile = "effects/shot_shiv",
	Damage = 1,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Limited = 1,
	Range = 1,--TOOLTIP HELPER
	Upgrades = 0,
}

function StS_BladeDance:GetSkillEffect(p1, p2, remainingShots)
	local ret = SkillEffect()
	local target = GetProjectileEnd(p1,p2)
	local damage = SpaceDamage(target, self.Damage)
	remainingShots = remainingShots or 3
	damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
	ret:AddProjectile(p1, damage, self.Projectile, NO_DELAY)
	ret:AddDelay(0.15)
	if remainingShots > 1 then
		remainingShots = remainingShots - 1
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], "StS_BladeDance", p1:GetString(), p2:GetString(), remainingShots))
	end
	return ret
end	
