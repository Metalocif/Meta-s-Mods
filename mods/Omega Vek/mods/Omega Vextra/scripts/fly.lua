
OmegaFlyAtk2 = Skill:new{
	PathSize = 1,
	Damage = 3,
	Range = 1,
	Name = "Draining Proboscis",
	Description = "Drain life from its target.",
	Class = "Enemy",
	Webbing = false,
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaFly2"
	}
}

function OmegaFlyAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local p3 = GetProjectileEnd(p1,p2)
	
	local damage = SpaceDamage(p2,self.Damage)
	damage.iAcid = self.Acid
	ret:AddQueuedMelee(p1, damage)
	local heal = SpaceDamage(p1,-self.Damage)
	
	ret:DNT_AddQueuedProjectile(p2,SpaceDamage(p1),"effects/shot_firefly2",NO_DELAY)
	ret:AddQueuedDelay(p1:Manhattan(p2)*0.1)
	if Board:IsPawnSpace(p2) or Board:IsPowered(p2) then
		ret:AddQueuedDamage(heal)
	end

	return ret
end	

OmegaFlyAtkB = OmegaFlyAtk2:new{Damage=5,Class = "Enemy",Name = "Devouring Proboscis",}