OmegaCockroachAtk2 = LineArtillery:new{   
	ArtillerySize = 5,
	Name = "Organ Delivery",
	Description = "Damage the shooter to launch an artillery attack on two tiles in orthogonal directions.",
	Explosion = "ExploArt1",
	Damage = 2,
	SelfDamage = 1,
	Class = "Enemy",
	Icon = "weapons/enemy_crab1.png",
	ImpactSound = "/impact/generic/explosion",
	Projectile = "effects/shotup_ant2.png",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(1,0),
		Building = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "OmegaDNT_Cockroach2"
	}
}

function OmegaCockroachAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local dist = p1:Manhattan(p2)
	local p3 = p1 + DIR_VECTORS[(direction+1)%4] * dist
	ret:AddQueuedArtillery(SpaceDamage(p2, self.Damage),self.Projectile, NO_DELAY)
	if Board:IsValid(p3) then ret:AddQueuedArtillery(SpaceDamage(p3, self.Damage),self.Projectile, NO_DELAY) end
	ret:AddQueuedDamage(SpaceDamage(p1, self.SelfDamage))
	return ret
end

OmegaCockroachAtkB = OmegaCockroachAtk2:new{Damage=3,Class = "Enemy",Name = "Organ Lunge",}

local function OmegaCockroachRevival(mission,effect)
	if Game:GetTeamTurn() ~= TEAM_PLAYER then return end
	local enemies = extract_table(Board:GetPawns(TEAM_ENEMY))
	for _, id in pairs(enemies) do
		local pawn = Board:GetPawn(id)
		if pawn:GetType() == "OmegaDNT_Cockroach2" and pawn:IsDead() and not pawn:IsFrozen() then
			if pawn:IsFire() or Board:GetTerrain(pawn:GetSpace()) == TERRAIN_WATER or Board:GetTerrain(pawn:GetSpace()) == TERRAIN_HOLE then 
				pawn:SetCorpse(false)
			else
				Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -1))
				pawn:SetHealth(1)
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addNextTurnHook(OmegaCockroachRevival)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
