OmegaMantisAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Goring Claws",
	Description = "Strikes targets on both sides of the user.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		-- CustomPawn = "OmegaMosquito2"
	}
}

function OmegaMantisAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage1 = SpaceDamage(p2, self.Damage)
	local damage2 = SpaceDamage(p1+DIR_VECTORS[(GetDirection(p2 - p1)+2)%4], self.Damage)
	damage1.sAnimation = "Swipe2Claw1"
	damage2.sAnimation = "Swipe2Claw1"
	ret:AddQueuedMelee(p1, damage1)
	ret:AddQueuedMelee(p1, damage2)
	return ret
end	

OmegaMantisAtkB = OmegaMantisAtk2:new{Damage=4,Class = "Enemy",Name = "Tearing Claws",}