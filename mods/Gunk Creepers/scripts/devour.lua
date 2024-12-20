

local init = function(mod, replaceRepair)
	modApi:appendAsset("img/weapons/devour_weapon.png",mod.resourcePath.."img/weapons/devour_weapon.png")
	replaceRepair:ForPilot("DjinnDevour", "Djinn_Devour", {"Devour", "Consume an adjacent Vek with 1 HP - or building - as a free action to heal 1 HP and clear status effects."}, mod.resourcePath .."/img/weapons/devour_weapon.png")
end


local load = function()
end

Djinn_Devour = Skill:new{
    Name = "Devour",
    Description = "Consume an adjacent Vek with 1 HP - or building - as a free action to heal 1 HP and clear status effects. Gunk makes enemies with 2 HP edible.", 
    Damage = DAMAGE_DEATH,
	Heal = 1, 
	AcidHeal = 2, 
	PunchDamage = 1, 
    ImpactSound = "/impact/dynamic/enemy_projectile",
    TipImage = {
        Unit = Point(2,1),
        Enemy = Point(2,2),
        Target = Point(2,2),
		CustomEnemy = "Leaper1",
    }
}

function Djinn_Devour:GetTargetArea(point) 
    local ret = PointList()
    
    if Board:GetPawn(point):IsFrozen() then
        ret:push_back(point)
    end
    
    for dir = DIR_START, DIR_END do
        local curr = point + DIR_VECTORS[dir]
		if Board:IsBuilding(curr) then
			ret:push_back(curr)
        elseif Board:IsValid(curr) and Board:IsPawnSpace(curr) and (Board:GetPawn(curr):GetHealth() == 1 or (Board:GetPawn(curr):GetHealth() == 2 and Status.GetStatus(Board:GetPawn(curr):GetId(), "Gunk"))) then
            ret:push_back(curr)
        end
    end
    
    return ret 
end


function Djinn_Devour:GetSkillEffect(p1,p2)
    local ret = SkillEffect()
    
    if p1 == p2 then
        local damage = SpaceDamage(p1,0)
        damage.iFrozen = EFFECT_REMOVE
        ret:AddDamage(damage)
    else
		ret:AddDelay(0.3)
		local damageHeal = SpaceDamage(p1, -self.Heal)  
		damageHeal.iFire = EFFECT_REMOVE	
		damageHeal.iAcid = EFFECT_REMOVE
		damageHeal.iFrozen = EFFECT_REMOVE
		ret:AddDamage(damageHeal)
		
		
        local damage = SpaceDamage(p2, self.Damage) 
		ret:AddMelee(p1, damage)
        damage.sAnimation = "ExploFirefly1" 
        damage.sSound = "/impact/dynamic/enemy_projectile"    
        ret:AddDamage(damage)
            
        ret:AddDelay(0.3)
        ret:AddScript([[
            local self = Point(]].. p1:GetString() .. [[)
            Board:GetPawn(self):SetActive(true)
            Game:TriggerSound("/ui/map/flyin_rewards");
            Board:Ping(self, GL_Color(255, 255, 255));
        ]])
		
		
    end
    
    return ret
end

return{
	init = init,
	load = load
}

