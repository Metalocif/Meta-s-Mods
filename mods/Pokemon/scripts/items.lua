local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath

modApi:appendAsset("img/effects/item_seedflare.png", resourcePath.."img/effects/item_seedflare.png")
modApi:appendAsset("img/effects/item_gracidea.png", resourcePath.."img/effects/item_gracidea.png")
modApi:appendAsset("img/effects/item_stealthrocks.png", resourcePath.."img/effects/item_stealthrocks.png")
modApi:appendAsset("img/effects/item_shadow.png", resourcePath.."img/effects/item_shadow.png")
for i = 1,4 do
modApi:appendAsset("img/effects/item_rubble"..i..".png", resourcePath.."img/effects/item_rubble"..i..".png")
end
modApi:appendAsset("img/effects/item_rubble_crushed.png", resourcePath.."img/effects/item_rubble_crushed.png")

merge_table(TILE_TOOLTIPS, { Poke_SeedFlare_Text = {"Seed Flare", "Deals 3 Damage to units that move onto it."},
						     Poke_Gracidea_Text = {"Gracidea", "Boosts units that move onto it."},
							 Poke_StealthRock_Text = {"Stealth Rocks", "Deals 1 damage to units that move onto it, doubled against flying units."},
							 Poke_Shadow_Text = {"Shadow", "Blinds pawns that step on it."}, 
							 Poke_TimeRune_Text = {"Runes", "When a mech performs an action on this tile, it will be able to act again. Limited-use weapons will also be reloaded."}
						   })	

-- local rubbledamage = SpaceDamage(0)
-- rubbledamage.sSound = "/support/rock/death"

Poke_SeedFlareItem = { Image = "effects/item_seedflare.png", Damage = SpaceDamage(3), Tooltip = "Poke_SeedFlare_Text", Icon = "effects/item_seedflare.png", UsedImage = ""}
Location["effects/item_seedflare.png"] = Point(-10,10)
Poke_Gracidea = { Image = "effects/item_gracidea.png", Damage = SpaceDamage(0), Tooltip = "Poke_Gracidea_Text", Icon = "effects/item_gracidea.png", UsedImage = ""}
Location["effects/item_gracidea.png"] = Point(-10,10)
Poke_StealthRock = { Image = "effects/item_stealthrocks.png", Damage = SpaceDamage(0), Tooltip = "Poke_StealthRock_Text", Icon = "effects/item_stealthrocks.png", UsedImage = ""}
Location["effects/item_stealthrocks.png"] = Point(-15,0)
Poke_DarkTendrilsItem = { Image = "effects/item_shadow.png", Damage = SpaceDamage(0), Tooltip = "Poke_Shadow_Text", Icon = "effects/item_shadow.png", UsedImage = ""}
Location["effects/item_shadow.png"] = Point(-27,2)
Poke_Rubble1 = { Image = "effects/item_rubble1.png", Damage = rubbledamage, Tooltip = "", Icon = "effects/item_rubble1.png", UsedImage = "effects/item_rubble_crushed.png"}
Poke_Rubble2 = { Image = "effects/item_rubble2.png", Damage = rubbledamage, Tooltip = "", Icon = "effects/item_rubble2.png", UsedImage = "effects/item_rubble_crushed.png"}
Poke_Rubble3 = { Image = "effects/item_rubble3.png", Damage = rubbledamage, Tooltip = "", Icon = "effects/item_rubble3.png", UsedImage = "effects/item_rubble_crushed.png"}
Poke_Rubble4 = { Image = "effects/item_rubble4.png", Damage = rubbledamage, Tooltip = "", Icon = "effects/item_rubble4.png", UsedImage = "effects/item_rubble_crushed.png"}
Location["effects/item_rubble1.png"] = Point(-28,-3)
Location["effects/item_rubble2.png"] = Point(-28,-3)
Location["effects/item_rubble3.png"] = Point(-28,-3)
Location["effects/item_rubble4.png"] = Point(-28,-3)
Location["effects/item_rubble_crushed.png"] = Point(-28,-3)
Poke_TimeRune = { Image = "", Damage = SpaceDamage(0), Tooltip = "Poke_TimeRune_Text", Icon = "", UsedImage = ""}
--a trick to give a description to terrain 17; if you know how to give it a proper tooltip let me know
Poke_FutureSightItem1 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem2 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem3 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem4 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem5 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem6 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
Poke_FutureSightItem7 = { Image = "", Damage = SpaceDamage(0), Tooltip = "", Icon = "", UsedImage = ""}
--no graphics/text because they should only appear during the enemy turn anyway
--I create more than needed in case other mods increase/reduce weapon damage


BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
    local pawn = Board:GetPawn(loc)
	if removed_item == "Poke_Gracidea" then
        if pawn and pawn:GetTeam() == TEAM_PLAYER then
			local gracidea_damage = SpaceDamage(loc)
			gracidea_damage.sScript = "Board:GetPawn("..loc:GetString().."):SetBoosted(true)"
			Board:DamageSpace(gracidea_damage)
        end
    elseif removed_item == "Poke_StealthRock" then
		if pawn then
			local rockDamage = SpaceDamage(loc, 1)
			if pawn:IsFlying() then rockDamage.iDamage = 2 end
			Board:DamageSpace(rockDamage)
		end
	elseif removed_item == "Poke_TimeRune" and Board:GetTerrain(loc) ~= TERRAIN_HOLE and Board:GetTerrain(loc) ~= TERRAIN_WATER then
		Board:SetTerrain(loc, TERRAIN_ROAD)
	elseif string.sub(removed_item, 1, -2) == "Poke_FutureSightItem" then 
		if pawn and Game:GetTeamTurn() == TEAM_ENEMY then 
			local damage = SpaceDamage(loc, tonumber(string.sub(removed_item, -1)))
			damage.sAnimation = "confusionAnim"
			Board:DamageSpace(damage) 
		end
	elseif removed_item == "Poke_DarkTendrilsItem" then
		if pawn then
			Status.ApplyBlind(pawn:GetId())
			--recalc best attack target/cancel attack if target is too far away	(either p2 or all instances of spacedamage)
			if pawn:IsQueued() then
				if loc:Manhattan(pawn:GetQueuedTarget()) > 2 then pawn:ClearQueued() Board:AddAlert(loc, "Blinded!") end
				local fx = _G[pawn:GetQueuedWeapon()]:GetSkillEffect(loc, pawn:GetQueuedTarget())
				for i = 1, fx.q_effect:size() do
					local targetLoc = fx.q_effect:index(i).loc
					if targetLoc:Manhattan(loc) > 2 then pawn:ClearQueued() Board:AddAlert(loc, "Blinded!") end
				end
			end
		end
	end
end)