-- create tileset
local tileset = easyEdit.tileset:add("Pillars", "grass")

tileset.name = "Spear Pillars" -- Name of tileset

local path = mod_loader.mods[modApi.currentMod].resourcePath
-- modApi:appendAsset("img/advanced/combat/looper_on.png", path .."img/advanced/combat/looper_on.png")
-- modApi:appendAsset("img/advanced/combat/looper_off.png", path .."img/advanced/combat/looper_off.png")
-- modApi:appendAsset("img/advanced/combat/looper_ready.png", path .."img/advanced/combat/looper_ready.png")
modApi:appendAsset("img/combat/looper_on.png", path .."img/combat/looper_on.png")
modApi:appendAsset("img/combat/looper_off.png", path .."img/combat/looper_off.png")
modApi:appendAsset("img/combat/looper_ready.png", path .."img/combat/looper_ready.png")
-- modApi:appendAsset("img/advanced/combat/tile_looper.png", path .."img/advanced/combat/tile_looper.png")

tileset.tileLoc = { ["mountain_0"] = Point(-28, -32), ["mountain_0_broken"] = Point(-28, -32), ["mountain_explode"] = Point(-28, -42),
					-- ["mountain_1"] = Point(-28, -24), ["mountain_1_broken"] = Point(-28, -24),
					["forest_0"] = Point(-28, -13), ["forest_0_front"] = Point(-28, -13),
				  }
--default offset is (-28, 1)
--this part must be set before appendAssets, since appendAssets will give the game your offsets based on the contents of tileLoc when called

-- appends all assets in the path relative to mod's resource path
tileset:appendAssets("img/combat/tiles_Pillars/")

-- display name of the climate in game, displays on island select screen
tileset:setClimate("Clear")

-- percentage chance of a mission having rain
tileset:setRainChance(0)
tileset:setCrackChance(5)

-- percentage chance that a regular ground tile gets changed to the following
tileset:setEnvironmentChance{
	[TERRAIN_ACID] = 0,
	[TERRAIN_FOREST] = 0,
	[TERRAIN_SAND] = 0,
	[TERRAIN_ICE] = 0,
}


-- set custom tooltip text for various tile types
tileset:setTileTooltip{
	tile = "forest",
	title = "Shrubs",
	text = "If damaged, lights on Fire."
}
tileset:setTileTooltip{
	tile = "forest_fire",
	title = "Shrub Fire",
	text = "Lights units on Fire. This fire was started when Shrubs were damaged."
}
tileset:setTileTooltip{
	tile = "mountain",
	title = "Shrubs",
	text = "If damaged, lights on Fire."
}

tileset:setTileTooltip{
	tile = "mountain",
	title = "Pillar",
	text = "Blocks movement and projectiles. Damage twice to destroy."
}

tileset:setTileTooltip{
	tile = "damaged_mountain",
	title = "Damaged Pillar",
	text = "Blocks movement and projectiles. One hit will destroy it."
}

tileset:setTileTooltip{
	tile = "mnt_rubble",
	title = "Crumbled Pillar",
	text = "No special effect."
}
