OmegaSilkwormAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Webbing Lash",
	Description = "Attacks forward while webbing behind and sideways.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/scorpion_soldier_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		-- CustomPawn = "OmegaMosquito2"
	}
}

function OmegaSilkwormAtk2:GetTargetScore(p1, p2)
	local ret = Skill.GetTargetScore(self, p1, p2)
	local dir = GetDirection(p2-p1)
	local oldret = ret
	for i = 1, 3 do
		local target = p1+DIR_VECTORS[(dir+i)%4]
		local pawn = Board:GetPawn(target)
		if (pawn and pawn:GetTeam() == TEAM_PLAYER and pawn:GetMoveSpeed() > 0 and not pawn:IsDead()) then
			ret = ret + 3
		end
	end
	return ret
end

function OmegaSilkwormAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	local dir = GetDirection(p2-p1)
	ret:AddQueuedMelee(p1, damage)
	ret:AddGrapple(p1,p1+DIR_VECTORS[(dir+1)%4],"hold")
	ret:AddGrapple(p1,p1+DIR_VECTORS[(dir+2)%4],"hold")
	ret:AddGrapple(p1,p1+DIR_VECTORS[(dir+3)%4],"hold")
	return ret
end	

OmegaSilkwormAtkB = OmegaSilkwormAtk2:new{Damage=4,Class = "Enemy",Name = "Webbing Whip",}
