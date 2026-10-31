local artilleryArc = require(mod_loader.mods.meta_mods.scriptPath.."libs/artilleryArc")
local weaponArmed = require(mod_loader.mods.meta_mods.scriptPath.."libs/weaponArmed")

OmegaAntlionAtk2 = Skill:new{
	PathSize = 1,
	Damage = 2,
	Range = 1,
	Name = "Tectonic Pincers",
	Description = "Strikes an adjacent tile. If it is empty, damage all tiles adjacent to it except the user's.",
	Class = "Enemy",
	LaunchSound = "",
	SoundBase = "/enemy/mosquito_1",
	ArtilleryHeight = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		-- CustomPawn = "OmegaMosquito2"
	}
}

SkillEffect["New_AddQueuedArtillery"] = function(self, origin, damage, graphics, delay) -- add our own queued artillery that can start from anywhere
	local fx = SkillEffect()
	fx["AddArtillery"](fx, origin, damage, graphics, delay)
	self.q_effect:AppendAll(fx.effect)
end


function OmegaAntlionAtk2:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	ret:AddQueuedMelee(p1, damage)
	ret:AddQueuedBounce(p2, 3)
	ret:AddQueuedEmitter(p2, "Emitter_Dust")
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then
		for i = DIR_START, DIR_END do
			if p2+DIR_VECTORS[i] ~= p1 then 
				ret:New_AddQueuedArtillery(p2, SpaceDamage(p2+DIR_VECTORS[i], self.Damage), "effects/shotup_antlionrock"..math.random(1, 5)..".png",NO_DELAY)
			end
		end
		for j = 1, 20 do
			for i = DIR_START, DIR_END do
				if p2+DIR_VECTORS[i] ~= p1 then 
					local decoDamage = SpaceDamage(p2+DIR_VECTORS[i])
					decoDamage.bHide = true
					ret:New_AddQueuedArtillery(p2, decoDamage, "effects/shotup_antlionrock"..math.random(1, 5)..".png",NO_DELAY)
				end
			end
			ret:AddDelay(0.1)
		end
	end
	return ret
end	

OmegaAntlionAtkB = OmegaAntlionAtk2:new{Damage=3,Class = "Enemy",Name = "Shattering Pincers",}