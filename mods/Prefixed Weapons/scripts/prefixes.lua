local mod = modApi:getCurrentMod()

local function getWeaponKey(id, key)
	Assert.Equals("string", type(id), "ID must be a string")
	Assert.Equals("string", type(key), "Key must be a string")
	local textId = id .. "_" .. key
	if IsLocalizedText(textId) then
		return GetLocalizedText(textId)
	end
	return _G[id] and _G[id][key] or id
end

-- modApi:appendAsset("img/weapons/modifier.png", path .."img/weapons/modifier.png")

function IsNotFreezing(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iFrozen == 1 then return false end
		end
	end
	return true
end

function IsNotCracking(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iCrack == 1 then return false end
		end
	end
	return true
end

function IsNotShielding(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iShield == 1 then return false end
		end
	end
	return true
end

function IsDamaging(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iDamage > 0 and curr_space_damage.iDamage ~= DAMAGE_ZERO then return true end
		end
	end
	return false
end

function IsPushing(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iPush ~= 0 then return true end
		end
	end
	return false
end

function IsArtillery(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage:GetType() == 1 then return true end
		end
	end
	return false
end

function IsProjectile(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	local foundProjectile = false
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage:GetType() == 2 then foundProjectile = true end
			if curr_space_damage.loc.x ~= 4 and curr_space_damage.loc.y ~= 4 then return false end
		end
	end
	return foundProjectile
end

function IsMelee(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	local foundProjectile = false
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			-- if curr_space_damage:GetType() == 3 then return true end
			if curr_space_damage.loc:Manhattan(p1) > 1 then return false end
		end
	end
	return true
end

function IsImmobile(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage:IsMovement() then return false end
			if curr_space_damage.loc == p1 and curr_space_damage.iPush ~= DIR_NONE then return false end
		end
	end
	return true
end

function IsColinear(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.loc.x ~= 4 and curr_space_damage.loc.y ~= 4 then return false end
		end
	end
	return true
end

function IsNotSelfTarget(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		if p2 ~= p1 then return true end
	end
	return false
end

function CanRecoil(id)
	return IsImmobile(id) and IsColinear(id) and IsNotSelfTarget(id)
end

function CanReckless(id)
	return IsDamaging(id) and _G[id].SelfDamage == 0
end

function CanDoubled(id)
	return IsArtillery(id) and IsColinear(id)
end

function CanBerserk(id)
	return IsImmobile(id) and IsMelee(id) and IsNotSelfTarget(id)
end

function CanPushing(id)
	return IsColinear(id) and not IsPushing(id)
end

function CanShield(id)
	local p1 = Point(4,4)
	local targetArea = _G[id]:GetTargetArea(p1)
	for _, p2 in ipairs(extract_table(targetArea)) do
		fx = _G[id]:GetSkillEffect(p1,p2)
		for i = 1, fx.effect:size() do
			local curr_space_damage = fx.effect:index(i)
			if curr_space_damage.iShield == 1 then return false end
		end
	end
	return true
end

function FreezingWeaponSE(self,p1,p2)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.loc ~= p1 and curr_space_damage.iDamage > 0 and curr_space_damage ~= DAMAGE_ZERO then
			curr_space_damage.iDamage = 0
			curr_space_damage.iFrozen = 1
			curr_space_damage.iFire = 0
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	return ret
end

function CrackingWeaponSE(self,p1,p2)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.iDamage > 0 and curr_space_damage ~= DAMAGE_ZERO then
			curr_space_damage.iCrack = 1
			-- new_damage_list:AddBurst(curr_space_damage.loc, "Emitter_Crack_Start2", DIR_NONE)
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	return ret
end

function OverclockedWeaponSE(self,p1,p2)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.iDamage > 0 and curr_space_damage.iDamage ~= DAMAGE_ZERO and curr_space_damage.iDamage ~= DAMAGE_DEATH then
			curr_space_damage.iDamage = curr_space_damage.iDamage + 1
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	return ret
end

function JanusWeaponSE(self,p1,p2)
	local ret = SkillEffect()
	local dist = p1:Manhattan(p2)
	local revDir = GetDirection(p1-p2)
	local target = p1
	repeat
		target = target + DIR_VECTORS[revDir]
	until target:Manhattan(p1) == dist or not Board:IsValid(target + DIR_VECTORS[revDir])
	if Board:GetPawn(p1) then	--otherwise we get errors on moving/death
		local fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
		local revFx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,target) 
		ret.q_effect:AppendAll(fx.q_effect)
		ret.q_effect:AppendAll(revFx.q_effect)
		ret.effect:AppendAll(fx.effect)
		ret.effect:AppendAll(revFx.effect)
	end
	return ret
end

function RecoilingWeaponSE(self,p1,p2)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local dir = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p1, 0, (dir+2)%4))
	return ret
end

function RecklessWeaponSE(self,p1,p2)
	local user = Board:GetPawn(p1)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.iDamage > 0 and curr_space_damage.iDamage ~= DAMAGE_ZERO and curr_space_damage.iDamage ~= DAMAGE_DEATH then
			curr_space_damage.iDamage = curr_space_damage.iDamage + 1
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	ret:AddDamage(SpaceDamage(user:GetSpace(), 1))
	return ret
end

function DoubledWeaponSE(self,p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	if Board:GetPawn(p1) then
		local fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
		local doubledFx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2 + DIR_VECTORS[dir]) 
		ret.q_effect:AppendAll(fx.q_effect)
		ret.q_effect:AppendAll(doubledFx.q_effect)
		ret.effect:AppendAll(fx.effect)
		ret.effect:AppendAll(doubledFx.effect)
	end
	return ret
end

function BerserkWeaponSE(self,p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	if Board:GetPawn(p1) then	--otherwise we get errors on moving/death
		local fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
		local rot1fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p1+DIR_VECTORS[(dir+1)%4]) 
		local rot2fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p1+DIR_VECTORS[(dir+2)%4]) 
		local rot3fx = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p1+DIR_VECTORS[(dir+3)%4]) 
		ret.q_effect:AppendAll(fx.q_effect)
		ret.q_effect:AppendAll(rot1fx.q_effect)
		ret.q_effect:AppendAll(rot2fx.q_effect)
		ret.q_effect:AppendAll(rot3fx.q_effect)
		ret.effect:AppendAll(fx.effect)
		ret.effect:AppendAll(rot1fx.effect)
		ret.effect:AppendAll(rot2fx.effect)
		ret.effect:AppendAll(rot3fx.effect)
	end
	return ret
end

function PushingWeaponSE(self,p1,p2)
	local user = Board:GetPawn(p1)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.loc ~= p1 then
			curr_space_damage.iPush = GetDirection(curr_space_damage.loc - p1)
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	return ret
end

function ShieldingWeaponSE(self,p1,p2)
	local user = Board:GetPawn(p1)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.iDamage > 0 and curr_space_damage.iDamage ~= DAMAGE_ZERO and curr_space_damage.iDamage ~= DAMAGE_DEATH then
			curr_space_damage.iDamage = curr_space_damage.iDamage + 1
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	local shield = SpaceDamage(user:GetSpace())
	shield.iShield = 1
	ret:AddDamage(shield)
	return ret
end

function KamikazeWeaponSE(self,p1,p2)
	local user = Board:GetPawn(p1)
	local ret = _G[self.OriginalUpgrade]:GetSkillEffect(p1,p2)
	local new_damage_list = DamageList()
	for i = 1, ret.effect:size() do
		local curr_space_damage = ret.effect:index(i)
		if curr_space_damage.iDamage > 0 and curr_space_damage.iDamage ~= DAMAGE_ZERO and curr_space_damage.iDamage ~= DAMAGE_DEATH then
			curr_space_damage.iDamage = curr_space_damage.iDamage * 2
		end
		new_damage_list:push_back(curr_space_damage)
	end
	ret.effect = new_damage_list
	ret:AddDamage(SpaceDamage(user:GetSpace(), DAMAGE_DEATH))
	return ret
end

--THE STUFF BELOW GENERATES WEAPONS--

function EVENT_onModsLoaded()
	for id, enabled in pairs(modApi.weaponDeck) do
		local weapon = _G[id]
		if weapon and weapon.Original == nil and weapon.Passive == "" and not weapon.TwoClick then
			local upgrades = {"", "_A", "_B", "_AB"}
			modApi:addWeaponDrop("Freezing"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then --and _G[id.."_AB"].TwoClick == nil then
				--my code doesn't work with two click weapons because I only alter the SkillEffect
					_G["Freezing"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = 0,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
						Explosion = "ExplIce1",UpShot = "effects/shotup_ice.png",ProjectileArt = "effects/shot_tankice",	--cosmetic
					}
					_G["Freezing"..id..upgrade].GetName = function(self) return "Freezing "..getWeaponKey(self.Original, "Name") end
					_G["Freezing"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nFreezes instead of damaging." end
					_G["Freezing"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Freezing"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Freezing"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Freezing"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Freezing"..id..upgrade].GetSkillEffect = FreezingWeaponSE
					_G["Freezing"..id..upgrade].IsValid = IsNotFreezing
					setmetatable(_G["Freezing"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Freezing"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			-- if Weapon_Texts[id.."_Upgrade1"] ~= nil then modApi:setText("Freezing"..id.."_Upgrade1", "Test value") end
			-- if Weapon_Texts[id.."_Upgrade1"] ~= nil then 
				-- modApi.modLoaderDictionary["Freezing"..id.."_Upgrade1"] = _G[id].UpgradeList[1]
			-- end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Freezing"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Overclocked"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Overclocked"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage + 1,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Overclocked"..id..upgrade].GetName = function(self) return "Overclocked "..getWeaponKey(self.Original, "Name") end
					_G["Overclocked"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description") end
					_G["Overclocked"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Overclocked"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Overclocked"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Overclocked"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Overclocked"..id..upgrade].GetSkillEffect = OverclockedWeaponSE
					_G["Overclocked"..id..upgrade].IsValid = IsDamaging
					setmetatable(_G["Overclocked"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Overclocked"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Overclocked"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Cracking"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Cracking"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Cracking"..id..upgrade].GetName = function(self) return "Cracking "..getWeaponKey(self.Original, "Name") end
					_G["Cracking"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nCracks all damaged tiles." end
					_G["Cracking"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Cracking"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Cracking"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Cracking"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Cracking"..id..upgrade].GetSkillEffect = CrackingWeaponSE
					_G["Cracking"..id..upgrade].IsValid = IsNotCracking
					setmetatable(_G["Cracking"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Cracking"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Cracking"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Janus"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Janus"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Janus"..id..upgrade].GetName = function(self) return "Janus "..getWeaponKey(self.Original, "Name") end
					_G["Janus"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nAlso fires in the opposite direction." end
					_G["Janus"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Janus"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Janus"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Janus"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Janus"..id..upgrade].GetSkillEffect = JanusWeaponSE
					_G["Janus"..id..upgrade].IsValid = IsProjectile
					setmetatable(_G["Janus"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Janus"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Janus"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Recoiling"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Recoiling"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost,
						Rarity = 4,
					}
					_G["Recoiling"..id..upgrade].GetName = function(self) return "Recoiling "..getWeaponKey(self.Original, "Name") end
					_G["Recoiling"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nHas knockback." end
					_G["Recoiling"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Recoiling"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Recoiling"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Recoiling"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Recoiling"..id..upgrade].GetSkillEffect = RecoilingWeaponSE
					_G["Recoiling"..id..upgrade].IsValid = CanRecoil	--immobile + not self-target + colinear
					setmetatable(_G["Recoiling"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Recoiling"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Recoiling"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Reckless"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Reckless"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage + 1,
						SelfDamage = 1,
						PowerCost = _G[id..upgrade].PowerCost,
						Rarity = 4,
					}
					_G["Reckless"..id..upgrade].GetName = function(self) return "Reckless "..getWeaponKey(self.Original, "Name") end
					_G["Reckless"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nAlso damages the user." end
					_G["Reckless"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Reckless"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Reckless"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Reckless"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Reckless"..id..upgrade].GetSkillEffect = RecklessWeaponSE
					_G["Reckless"..id..upgrade].IsValid = CanReckless	--no self-damage + has damage
					setmetatable(_G["Reckless"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Reckless"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Reckless"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Doubled"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Doubled"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Doubled"..id..upgrade].GetName = function(self) return "Doubled "..getWeaponKey(self.Original, "Name") end
					_G["Doubled"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nAlso fires at the next tile in a line." end
					_G["Doubled"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Doubled"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Doubled"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Doubled"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Doubled"..id..upgrade].GetSkillEffect = DoubledWeaponSE
					_G["Doubled"..id..upgrade].IsValid = CanDoubled	--no self-damage + has damage
					setmetatable(_G["Doubled"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Doubled"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Doubled"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Berserk"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Berserk"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Berserk"..id..upgrade].GetName = function(self) return "Berserk "..getWeaponKey(self.Original, "Name") end
					_G["Berserk"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nHits all adjacent tiles." end
					_G["Berserk"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Berserk"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Berserk"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Berserk"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Berserk"..id..upgrade].GetSkillEffect = BerserkWeaponSE
					_G["Berserk"..id..upgrade].IsValid = CanBerserk	--melee + not self-target
					setmetatable(_G["Berserk"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Berserk"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Berserk"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			
			modApi:addWeaponDrop("Pushing"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Pushing"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost + 1,
						Rarity = 4,
					}
					_G["Pushing"..id..upgrade].GetName = function(self) return "Pushing "..getWeaponKey(self.Original, "Name") end
					_G["Pushing"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nPushes all damaged tiles." end
					_G["Pushing"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Pushing"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Pushing"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Pushing"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Pushing"..id..upgrade].GetSkillEffect = PushingWeaponSE
					_G["Pushing"..id..upgrade].IsValid = CanPushing
					setmetatable(_G["Pushing"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Pushing"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Pushing"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			modApi:addWeaponDrop("Shielding"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Shielding"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage,
						PowerCost = _G[id..upgrade].PowerCost,
						Rarity = 4,
					}
					_G["Shielding"..id..upgrade].GetName = function(self) return "Shielding "..getWeaponKey(self.Original, "Name") end
					_G["Shielding"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nAlso shields the user." end
					_G["Shielding"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Shielding"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Shielding"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Shielding"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Shielding"..id..upgrade].GetSkillEffect = ShieldingWeaponSE
					_G["Shielding"..id..upgrade].IsValid = IsNotShielding
					setmetatable(_G["Shielding"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then Weapon_Texts["Shielding"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then Weapon_Texts["Shielding"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] end
			
			modApi:addWeaponDrop("Kamikaze"..id)
			for _, upgrade in ipairs(upgrades) do
				if _G[id..upgrade] ~= nil then
					_G["Kamikaze"..id..upgrade] = _G[id..upgrade]:new{
						Original = id,
						OriginalUpgrade = id..upgrade,
						UpgradeCost = _G[id..upgrade].UpgradeCost,
						Damage = _G[id..upgrade].Damage * 2,
						SelfDamage = DAMAGE_DEATH,
						PowerCost = _G[id..upgrade].PowerCost,
						Rarity = 4,
					}
					_G["Kamikaze"..id..upgrade].GetName = function(self) return "Kamikaze "..getWeaponKey(self.Original, "Name") end
					_G["Kamikaze"..id..upgrade].GetDescription = function(self) return getWeaponKey(self.Original, "Description").."\nAlso kills the user." end
					_G["Kamikaze"..id..upgrade].GetUpgrades = function(self) return _G[self.Original].Upgrades end
					_G["Kamikaze"..id..upgrade].GetIcon = function(self) return _G[self.Original].Icon end
					_G["Kamikaze"..id..upgrade].GetClass = function(self) return _G[self.Original].Class end
					_G["Kamikaze"..id..upgrade].GetUpgradeDescription = function(self) return getWeaponKey(self.OriginalUpgrade, "UpgradeDescription") end
					_G["Kamikaze"..id..upgrade].GetSkillEffect = KamikazeWeaponSE
					_G["Kamikaze"..id..upgrade].IsValid = CanReckless
					setmetatable(_G["Kamikaze"..id..upgrade], {__index = _G[id..upgrade]})
				end
			end
			if Weapon_Texts[id.."_Upgrade1"] ~= nil then 
				Weapon_Texts["Kamikaze"..id.."_Upgrade1"] = Weapon_Texts[id.."_Upgrade1"] 
			end
			if Weapon_Texts[id.."_Upgrade2"] ~= nil then 
				Weapon_Texts["Kamikaze"..id.."_Upgrade2"] = Weapon_Texts[id.."_Upgrade2"] 
			end
			
			
			
			LOG("added prefixed versions of "..id)
		end
		
	end
	
	--remove all invalid weapons from pools as soon as Board exists; can't check earlier because Board is nil then
	modApi:conditionalHook(function()
		return Board ~= nil and Pawn ~= nil
	end, 
	function()
		for id, enabled in pairs(modApi.weaponDeck) do
			local weapon = _G[id]
			if weapon and weapon.Original ~= nil then
				LOG("checking "..id)
				if not weapon.IsValid(weapon.Original) then modApi:addWeaponDrop(id, false) LOG("removed "..id) end	--with false, this prevents from dropping
			end
		end
	end)
	return "done"
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)