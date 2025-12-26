local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
local artilleryArc = require(mod_loader.mods.meta_mods.scriptPath.."libs/artilleryArc")
local weaponArmed = require(mod_loader.mods.meta_mods.scriptPath.."libs/weaponArmed")
-- local weaponPreview = require(mod_loader.mods.meta_mods.scriptPath.."libs/weaponPreview")
local customAnim = require(mod_loader.mods.meta_mods.scriptPath.."libs/customAnim")
require(mod_loader.mods[modApi.currentMod].scriptPath.."weathers")
require(mod_loader.mods.meta_mods.scriptPath.."libs/status")

local files = {
    "Pound.png",
	"Protect.png",
	"Twister.png",
	"Psywave.png",
	"Slam.png",
	"Confusion.png",
	"Kinesis.png",
	"DragonRage.png",
	"Psychic.png",
	"MindOverMatter.png",
	"Fly.png",
	"HyperBeam.png",
	"IcyWind.png",
	"Shockwave.png",
	"HeatWave.png",
	"Blizzard.png",
	"Thunder.png",
	"FireBlast.png",
	"Psystrike.png",
	"VanishingStrikes.png",
	"ShatteredPsyche.png",
	"ShadowBall.png",
	"DarkPulse.png",
	"Hypnosis.png",
	"DarkVoid.png",
	"FormChange.png",
	"CosmicPower.png",
	"PsychoBoost.png",
	"TimeTravel.png",
	"NaturePower.png",
	"Bloom.png",
	"SeedFlare.png",
	"PetalBlizzard.png",
	"Moonblast.png",
	"EternalLife.png",
	"Reflect.png",
	"Teleport.png",
	"TakeDown.png",
	"ZenHeadbutt.png",
	"MetalClaw.png",
	"MeteorMash.png",
	"Bite.png",
	"Crunch.png",
	"Earthquake.png",
	"DracoMeteor.png",
	"RockThrow.png",
	"RockSlide.png",
	"StoneEdge.png",
	"Sandstorm.png",
	"QuickAttack.png",
	"ZippyZap.png",
	"BouncyBubble.png",
	"SizzlySlide.png",
	"GlitzyGlow.png",
	"BaddyBad.png",
	"SappySeed.png",
	"FreezyFrost.png",
	"SparklySwirl.png",
	"Synchronize.png",
	"PsychoCut.png",
	"FutureSight.png",
	"LightOfRuin.png",
	"SacredSword.png",
	"FuryCutter.png",
	"BulletPunch.png",
	"StoneAxe.png",
	"XScissor.png",
	"ConfuseRay.png",
	"DarkTendrils.png",
	"ShadowForce.png",
	"FlashCannon.png",
	"Warpstrike.png",
	"RoarOfTime.png",
	"SpatialRift.png",
	"Unmake.png",
	"Wither.png",
	"Judgment.png",
	"Wormhole.png",
	"Trample.png",
	"PsychicTerror.png",
	"ScorchingSands.png",
	"DragonTail.png",
	"MountainHurl.png",
	"Present.png"
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/weapons/"..file, resourcePath.."img/weapons/"..file)
end

modApi:appendAsset("img/effects/confusion.png", resourcePath.."img/effects/confusion.png")
modApi:appendAsset("img/effects/psywave_R.png", resourcePath.."img/effects/psywave_R.png")
modApi:appendAsset("img/effects/psywave_U.png", resourcePath.."img/effects/psywave_U.png")
modApi:appendAsset("img/effects/shotup_dragonrage.png", resourcePath.."img/effects/shotup_dragonrage.png")
modApi:appendAsset("img/effects/shotup_psystrike.png", resourcePath.."img/effects/shotup_psystrike.png")
modApi:appendAsset("img/effects/twister.png", resourcePath.."img/effects/twister.png")
modApi:appendAsset("img/effects/darkpulse.png", resourcePath.."img/effects/darkpulse.png")
modApi:appendAsset("img/effects/explo_viridian.png", resourcePath.."img/effects/explo_viridian.png")
modApi:appendAsset("img/effects/explo_gold.png", resourcePath.."img/effects/explo_gold.png")
modApi:appendAsset("img/effects/moonblastanim.png", resourcePath.."img/effects/moonblastanim.png")
modApi:appendAsset("img/effects/petalblizzardanim.png", resourcePath.."img/effects/petalblizzardanim.png")
modApi:appendAsset("img/effects/clockanim.png", resourcePath.."img/effects/clockanim.png")

modApi:appendAsset("img/effects/alienwhip0_D.png", resourcePath.."img/effects/alienwhip0_D.png")
modApi:appendAsset("img/effects/alienwhip0_L.png", resourcePath.."img/effects/alienwhip0_L.png")
modApi:appendAsset("img/effects/alienwhip0_R.png", resourcePath.."img/effects/alienwhip0_R.png")
modApi:appendAsset("img/effects/alienwhip0_U.png", resourcePath.."img/effects/alienwhip0_U.png")
modApi:appendAsset("img/effects/alienwhip1_D.png", resourcePath.."img/effects/alienwhip1_D.png")
modApi:appendAsset("img/effects/alienwhip1_L.png", resourcePath.."img/effects/alienwhip1_L.png")
modApi:appendAsset("img/effects/alienwhip1_R.png", resourcePath.."img/effects/alienwhip1_R.png")
modApi:appendAsset("img/effects/alienwhip1_U.png", resourcePath.."img/effects/alienwhip1_U.png")
modApi:appendAsset("img/effects/alienwhip2_D.png", resourcePath.."img/effects/alienwhip2_D.png")
modApi:appendAsset("img/effects/alienwhip2_L.png", resourcePath.."img/effects/alienwhip2_L.png")
modApi:appendAsset("img/effects/alienwhip2_R.png", resourcePath.."img/effects/alienwhip2_R.png")
modApi:appendAsset("img/effects/alienwhip2_U.png", resourcePath.."img/effects/alienwhip2_U.png")
modApi:appendAsset("img/effects/alienwhip3_D.png", resourcePath.."img/effects/alienwhip3_D.png")
modApi:appendAsset("img/effects/alienwhip3_L.png", resourcePath.."img/effects/alienwhip3_L.png")
modApi:appendAsset("img/effects/alienwhip3_R.png", resourcePath.."img/effects/alienwhip3_R.png")
modApi:appendAsset("img/effects/alienwhip3_U.png", resourcePath.."img/effects/alienwhip3_U.png")

modApi:appendAsset("img/effects/bite_0.png", resourcePath .."img/effects/bite_0.png")
modApi:appendAsset("img/effects/bite_1.png", resourcePath .."img/effects/bite_1.png")
modApi:appendAsset("img/effects/bite_2.png", resourcePath .."img/effects/bite_2.png")
modApi:appendAsset("img/effects/bite_3.png", resourcePath .."img/effects/bite_3.png")

modApi:appendAsset("img/effects/psychocut_D.png", resourcePath.."img/effects/psychocut_D.png")
modApi:appendAsset("img/effects/psychocut_L.png", resourcePath.."img/effects/psychocut_L.png")
modApi:appendAsset("img/effects/psychocut_R.png", resourcePath.."img/effects/psychocut_R.png")
modApi:appendAsset("img/effects/psychocut_U.png", resourcePath.."img/effects/psychocut_U.png")

modApi:appendAsset("img/effects/metalclaw_D.png", resourcePath .."img/effects/metalclaw_D.png")
modApi:appendAsset("img/effects/metalclaw_R.png", resourcePath .."img/effects/metalclaw_R.png")

modApi:appendAsset("img/effects/metalpunch1_D.png", resourcePath .."img/effects/metalpunch1_D.png")
modApi:appendAsset("img/effects/metalpunch1_L.png", resourcePath .."img/effects/metalpunch1_L.png")
modApi:appendAsset("img/effects/metalpunch1_R.png", resourcePath .."img/effects/metalpunch1_R.png")
modApi:appendAsset("img/effects/metalpunch1_U.png", resourcePath .."img/effects/metalpunch1_U.png")
modApi:appendAsset("img/effects/metalpunch2_D.png", resourcePath .."img/effects/metalpunch2_D.png")
modApi:appendAsset("img/effects/metalpunch2_L.png", resourcePath .."img/effects/metalpunch2_L.png")
modApi:appendAsset("img/effects/metalpunch2_R.png", resourcePath .."img/effects/metalpunch2_R.png")
modApi:appendAsset("img/effects/metalpunch2_U.png", resourcePath .."img/effects/metalpunch2_U.png")

modApi:appendAsset("img/effects/tendril_D.png", resourcePath.."img/effects/tendril_D.png")
modApi:appendAsset("img/effects/tendril_L.png", resourcePath.."img/effects/tendril_L.png")
modApi:appendAsset("img/effects/tendril_R.png", resourcePath.."img/effects/tendril_R.png")
modApi:appendAsset("img/effects/tendril_U.png", resourcePath.."img/effects/tendril_U.png")


modApi:appendAsset("img/effects/icywind_R.png", resourcePath.."img/effects/icywind_R.png")
modApi:appendAsset("img/effects/icywind_U.png", resourcePath.."img/effects/icywind_U.png")
modApi:appendAsset("img/effects/heatwave_R.png", resourcePath.."img/effects/heatwave_R.png")
modApi:appendAsset("img/effects/heatwave_U.png", resourcePath.."img/effects/heatwave_U.png")
modApi:appendAsset("img/effects/shadowball_R.png", resourcePath.."img/effects/shadowball_R.png")
modApi:appendAsset("img/effects/shadowball_U.png", resourcePath.."img/effects/shadowball_U.png")
modApi:appendAsset("img/effects/naturepower_R.png", resourcePath.."img/effects/naturepower_R.png")
modApi:appendAsset("img/effects/naturepower_U.png", resourcePath.."img/effects/naturepower_U.png")
modApi:appendAsset("img/effects/petal_R.png", resourcePath.."img/effects/petal_R.png")
modApi:appendAsset("img/effects/petal_U.png", resourcePath.."img/effects/petal_U.png")
modApi:appendAsset("img/effects/shotup_seedflare.png", resourcePath.."img/effects/shotup_seedflare.png")
modApi:appendAsset("img/effects/rock.png", resourcePath.."img/effects/rock.png")
modApi:appendAsset("img/effects/stoneedgeline.png", resourcePath.."img/effects/stoneedgeline.png")
modApi:appendAsset("img/effects/sandanim_back.png", resourcePath.."img/effects/sandanim_back.png")
modApi:appendAsset("img/effects/sandanim_front.png", resourcePath.."img/effects/sandanim_front.png")
modApi:appendAsset("img/effects/stoneaxe.png", resourcePath.."img/effects/stoneaxe.png")
modApi:appendAsset("img/effects/glitzyglow.png", resourcePath.."img/effects/glitzyglow.png")
modApi:appendAsset("img/effects/bulletpunch_R.png", resourcePath.."img/effects/bulletpunch_R.png")
modApi:appendAsset("img/effects/bulletpunch_U.png", resourcePath.."img/effects/bulletpunch_U.png")
modApi:appendAsset("img/effects/lightofruin.png", resourcePath.."img/effects/lightofruin.png")
modApi:appendAsset("img/effects/sacredsword.png", resourcePath.."img/effects/sacredsword.png")
modApi:appendAsset("img/effects/DracoMeteor.png", resourcePath.."img/effects/DracoMeteor.png")
modApi:appendAsset("img/units/player/DracoMeteor.png", resourcePath.."img/units/player/DracoMeteor.png")
modApi:appendAsset("img/units/player/DracoMeteor_death.png", resourcePath.."img/units/player/DracoMeteor_death.png")

modApi:appendAsset("img/effects/confuseray_R.png", resourcePath.."img/effects/confuseray_R.png")
modApi:appendAsset("img/effects/confuseray_U.png", resourcePath.."img/effects/confuseray_U.png")
modApi:appendAsset("img/effects/roaroftime.png", resourcePath.."img/effects/roaroftime.png")
modApi:appendAsset("img/effects/SpatialRift.png", resourcePath.."img/effects/SpatialRift.png")

modApi:appendAsset("img/effects/shotup_present.png", resourcePath.."img/effects/shotup_present.png")

local tiles = { "tile_normal.png","tile_electric.png","tile_fairy.png","tile_fire.png","tile_grass.png","tile_ground.png","tile_ice.png","tile_poison.png","tile_water.png", }
for _, tile in ipairs(tiles) do
	modApi:appendAsset("img/effects/".. tile, resourcePath .. "img/effects/" .. tile)
	Location["effects/"..tile] = Point(-27,3)
end

for i = 1, 12 do
modApi:appendAsset("img/effects/wither_"..i..".png", resourcePath.."img/effects/wither_"..i..".png")
end

local effects = {
	"laser_hyperbeam_R.png",
	"laser_hyperbeam_R1.png",
	"laser_hyperbeam_R2.png",
	-- "laser_hyperbeam_start.png",
	"laser_hyperbeam_U.png",
	"laser_hyperbeam_U1.png",
	"laser_hyperbeam_U2.png",
}
for _, effect in ipairs(effects) do
	modApi:appendAsset("img/effects/".. effect, resourcePath .. "img/effects/" .. effect)
	Location["effects/"..effect] = Point(-12,3)
end
local effects = {
	"laser_SpatialRift_R.png",
	"laser_SpatialRift_R1.png",
	"laser_SpatialRift_R2.png",
	-- "laser_SpatialRift_start.png",
	"laser_SpatialRift_U.png",
	"laser_SpatialRift_U1.png",
	"laser_SpatialRift_U2.png",
}
for _, effect in ipairs(effects) do
	modApi:appendAsset("img/effects/".. effect, resourcePath .. "img/effects/" .. effect)
	Location["effects/"..effect] = Point(-12,3)
end
modApi:appendAsset("img/effects/evolution.png", resourcePath.."img/effects/evolution.png")
modApi:appendAsset("img/effects/wormhole.png", resourcePath.."img/effects/wormhole.png")

ANIMS.evolutionAnim = Animation:new{ 	
	Image = "effects/evolution.png",
	PosX = -10, PosY = -5,
	NumFrames = 4,
	Time = 0.2,
	Loop = false,
	Frames = {0, 1, 2, 3, 2, 1, 0}
}

ANIMS.roaroftimeAnim = Animation:new{ 	
	Image = "effects/roaroftime.png",
	PosX = -50, PosY = -40,
	NumFrames = 18,
	Time = 0.1,
	Loop = false,
}
ANIMS.spatialriftAnim = Animation:new{ 	
	Image = "effects/SpatialRift.png",
	PosX = -30, PosY = -30,
	NumFrames = 10,
	Time = 0.1,
	Loop = false,
}

ANIMS.confusionAnim = Animation:new{ 	
	Image = "effects/confusion.png",
	PosX = -10, PosY = -5,
	NumFrames = 8,
	Time = 0.1,
	Loop = false,
}
ANIMS.twisterAnim = Animation:new{ 	
	Image = "effects/twister.png",
	PosX = -10, PosY = -5,
	NumFrames = 5,
	Time = 0.1,
	Loop = false,
}

ANIMS.darkpulseAnim = Animation:new{Image = "effects/darkpulse.png",NumFrames = 8,Time = 0.1,PosX = -32,PosY = -20}
ANIMS.explo_viridian = Animation:new{Image = "effects/explo_viridian.png",NumFrames = 8,Time = 0.06,PosX = -22,PosY = 1}
ANIMS.explo_gold = Animation:new{Image = "effects/explo_gold.png",NumFrames = 8,Time = 0.06,PosX = -12,PosY = 1}
ANIMS.moonblastAnim = Animation:new{
	Image = "effects/moonblastanim.png",
	NumFrames = 3,
	Frames = {2, 1, 0, 0, 0, 0, 1, 2},
	Time = 0.1,
	PosX = -27,
	PosY = -15
}
ANIMS.petalblizzardAnim = Animation:new{Image = "effects/petalblizzardanim.png",NumFrames = 5,Time = 0.1,PosX = -42,PosY = -30}

ANIMS.clockAnim = Animation:new{
	Image = "effects/clockanim.png",
	NumFrames = 12,
	Frames = {0,1,2,3,4,5,6,7,8,9,10,11,0,1,2,3,4,5,6,7,8,9,10,11,1,3,5,7,9,11,2,5,8,11,3,7,11,5,11},
	Time = 0.06,
	PosX = -32,
	PosY = -32
}
ANIMS.clockAnimRev = Animation:new{
	Image = "effects/clockanim.png",
	NumFrames = 12,
	-- Frames = {0,11,10,9,8,7,6,5,4,3,2,1,0,11,10,9,8,7,6,5,4,3,2,1,11,9,7,5,3,1,10,7,4,1,9,5,1,7,1},
	Frames = {0,1,2,3,4,5,6,7,8,9,10,11,0,0,1,1,2,2,3,3,4,4,4,5,5,5,6,6,6,6,7,7,7,7,7,7,7,7,7,6,6,6,6,5,5,5,4,4,4,3,3,2,2,1,1,0,0,11,10,9,8,7,6,5,4,3,2,1,0},
	Time = 0.06,
	PosX = -32,
	PosY = -32
}
ANIMS.wormholeAnim = Animation:new{
	Image = "effects/wormhole.png",
	NumFrames = 8,
	Time = 0.1,
	PosX = -64,
	PosY = -64
}

local a = ANIMS

a.bite_0 = a.explopunch1_0:new{ Image = "effects/bite_0.png", NumFrames = 5, PosX = -19, PosY = -5 }
a.bite_1 = a.explopunch1_1:new{ Image = "effects/bite_1.png", NumFrames = 5, PosX = -14, PosY = -2,  }
a.bite_2 = a.explopunch1_2:new{ Image = "effects/bite_2.png", NumFrames = 5, PosX = -10, PosY = -2,  }
a.bite_3 = a.explopunch1_3:new{ Image = "effects/bite_3.png", NumFrames = 5, PosX = -7, PosY = -5 }

a.metalclawanim_0 = a.explopunch1_0:new{ Image = "effects/metalclaw_D.png", NumFrames = 6, PosX = -19, PosY = -15 }
a.metalclawanim_1 = a.explopunch1_1:new{ Image = "effects/metalclaw_R.png", NumFrames = 6, PosX = -20, PosY = -12 }

a.metalpunch1_0 = a.explopunch1_0:new{ Image = "effects/metalpunch1_U.png", Time = 0.03}
a.metalpunch1_1 = a.explopunch1_1:new{ Image = "effects/metalpunch1_R.png", Time = 0.03}
a.metalpunch1_2 = a.explopunch1_2:new{ Image = "effects/metalpunch1_D.png", Time = 0.03}
a.metalpunch1_3 = a.explopunch1_3:new{ Image = "effects/metalpunch1_L.png", Time = 0.03}

a.metalpunch2_0 = a.explopunch1_0:new{ Image = "effects/metalpunch2_U.png", Time = 0.03}
a.metalpunch2_1 = a.explopunch1_1:new{ Image = "effects/metalpunch2_R.png", Time = 0.03}
a.metalpunch2_2 = a.explopunch1_2:new{ Image = "effects/metalpunch2_D.png", Time = 0.03}
a.metalpunch2_3 = a.explopunch1_3:new{ Image = "effects/metalpunch2_L.png", Time = 0.03}

a.alienwhip0_0 = Animation:new{Image = "effects/alienwhip0_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
a.alienwhip1_0 = Animation:new{Image = "effects/alienwhip1_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
a.alienwhip2_0 = Animation:new{Image = "effects/alienwhip2_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
a.alienwhip3_0 = Animation:new{Image = "effects/alienwhip3_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}

a.alienwhip0_1 = Animation:new{Image = "effects/alienwhip0_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
a.alienwhip1_1 = Animation:new{Image = "effects/alienwhip1_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
a.alienwhip2_1 = Animation:new{Image = "effects/alienwhip2_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
a.alienwhip3_1 = Animation:new{Image = "effects/alienwhip3_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}

a.alienwhip0_2 = Animation:new{Image = "effects/alienwhip0_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
a.alienwhip1_2 = Animation:new{Image = "effects/alienwhip1_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
a.alienwhip2_2 = Animation:new{Image = "effects/alienwhip2_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
a.alienwhip3_2 = Animation:new{Image = "effects/alienwhip3_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}

a.alienwhip0_3 = Animation:new{Image = "effects/alienwhip0_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
a.alienwhip1_3 = Animation:new{Image = "effects/alienwhip1_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
a.alienwhip2_3 = Animation:new{Image = "effects/alienwhip2_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}
a.alienwhip3_3 = Animation:new{Image = "effects/alienwhip3_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}

a.psychocut_0 = Animation:new{Image = "effects/psychocut_U.png",NumFrames = 6,Time = 0.07,PosX = -46,PosY = -7}
a.psychocut_1 = Animation:new{Image = "effects/psychocut_R.png",NumFrames = 6,Time = 0.07,PosX = -42,PosY = -27}
a.psychocut_2 = Animation:new{Image = "effects/psychocut_D.png",NumFrames = 6,Time = 0.07,PosX = -22,PosY = -22}
a.psychocut_3 = Animation:new{Image = "effects/psychocut_L.png",NumFrames = 6,Time = 0.07,PosX = -18,PosY = -8}

a.sacredswordanim_0 = a.explosmash_0:new{Image = "effects/smash_U.png",NumFrames = 13,Time = 0.07,PosX = -35,PosY = -11,Frames={0,1,2}}
a.sacredswordanim_1 = a.explosmash_1:new{Image = "effects/smash_R.png",NumFrames = 13,Time = 0.07,PosX = -24,PosY = -18,Frames={0,1,2}}
a.sacredswordanim_2 = a.explosmash_2:new{Image = "effects/smash_D.png",NumFrames = 13,Time = 0.07,PosX = -22,PosY = -18,Frames={0,1,2}}
a.sacredswordanim_3 = a.explosmash_3:new{Image = "effects/smash_L.png",NumFrames = 13,Time = 0.07,PosX = -22,PosY = -10,Frames={0,1,2}}

a.tendril_0 = Animation:new{Image = "effects/tendril_R.png",NumFrames = 7,Time = 0.1,PosX = -35,PosY = -1,}
a.tendril_1 = Animation:new{Image = "effects/tendril_D.png",NumFrames = 7,Time = 0.1,PosX = -10,PosY = -3}
a.tendril_2 = Animation:new{Image = "effects/tendril_L.png",NumFrames = 7,Time = 0.1,PosX = 0,PosY = -1,}
a.tendril_3 = Animation:new{Image = "effects/tendril_U.png",NumFrames = 7,Time = 0.1,PosX = -6,PosY = 19}



a.sandAnim_front = Animation:new{Image = "effects/sandanim_front.png",NumFrames = 1,Loop=true,Layer = LAYER_FRONT, PosX = -28, PosY = 1}
a.sandAnim_back = Animation:new{Image = "effects/sandanim_back.png",NumFrames = 1,Loop=true,Layer = LAYER_BACK, PosX = -28, PosY = 1}

Poke_Pound = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Pound.png",	
	Rarity = 3,
	Name = "Pound",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 0,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Abra",
	}
}
			
function Poke_Pound:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, 1, direction)
	damage.sAnimation = "explopunch1_"..direction
	ret:AddMelee(p1, damage)
	return ret
end

Poke_Slam = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/Slam.png",	
	Rarity = 3,
	Name = "Slam",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 3,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}

function Poke_Slam:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Slam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	

	return ret
end

Poke_Protect = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Protect.png",	
	Rarity = 3,
	Name = "Protect",
	Description = "Shield a target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Free Action" },
	UpgradeCost = { 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Protect_A=Poke_Protect:new{ UpgradeDescription = "Can be used for free once per turn.", FreeShield = true }


function Poke_Protect:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or Board:IsBuilding(curr) then ret:push_back(curr) end
		end
	end
	return ret
end
	
function Poke_Protect:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local mission = GetCurrentMission()        
	local damage = SpaceDamage(p2)
	if not Board:GetPawn(p1) then return ret end
	damage.iShield = EFFECT_CREATE
	ret:AddDamage(damage)
	if mission and self.FreeShield and not Board:IsTipImage() then
		if not mission.LastProtectTurn then mission.LastProtectTurn = -1 end
		if mission.LastProtectTurn ~= Game:GetTurnCount() then
			ret:AddDelay(0.3)
			ret:AddScript([[modApi:runLater(function() 
				local pos = ]]..p1:GetString()..[[;
				Board:GetPawn(pos):SetActive(true);
				Game:TriggerSound("/ui/map/flyin_rewards");
				Board:Ping(pos, GL_Color(255, 255, 255));
				GetCurrentMission().LastProtectTurn = Game:GetTurnCount();
				end)
			]])
		end
		ret:AddScript("GetCurrentMission().LastProtectTurn = Game:GetTurnCount()")
	end
	
	return ret
end

Poke_Psywave = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Psywave.png",	
	Rarity = 3,
	Name = "Psywave",
	Description = "Send out a psychic projectile. It splits in two when it hits a shield.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Crush Shields" },
	UpgradeCost = { 2, 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Psywave_A=Poke_Psywave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psywave_B=Poke_Psywave:new{ UpgradeDescription = "Damages shielded enemies.", CrushShields = true }
Poke_Psywave_AB=Poke_Psywave:new{ Damage = 3, CrushShields = true }


function Poke_Psywave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Psywave:SplitOnShieldHit(ret, p1, p2, depth)
	if not depth then depth = 0 end
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage)
	local direction = GetDirection(p2-p1)
	local crushShield
	if Board:IsShield(target) then damage.iDamage = 0 end
	if Board:GetPawn(target) and Board:GetPawn(target):IsShield() then
		if self.CrushShields then crushShield = true else damage.iDamage = 0 end
	end
	local delay = NO_DELAY
	if depth == 0 then delay = PROJ_DELAY end
	if crushShield then ret:AddScript(string.format("Board:RemoveShield(%s)", target:GetString())) end
	ret:AddProjectile(p1, damage, "effects/psywave", delay)
	
	if (damage.iDamage == 0 or crushShield) and depth < 3 then 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+1)%4], depth + 1) 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+3)%4], depth + 1) 
		ret:AddDelay(-1)
	end
	return ret
end
	
function Poke_Psywave:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	if Board:GetSize() == Point(6,6) then Board:AddShield(Point(2,2)) end
	-- local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	self:SplitOnShieldHit(ret, p1, p2, 0)
	return ret
end



Poke_DragonRage = LineArtillery:new{
	Class = "TechnoVek",
	Icon = "weapons/DragonRage.png",	
	Rarity = 3,
	Name = "Dragon Rage",
	Description = "Throw a damaging projectile.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_DragonRage_A=Poke_DragonRage:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonRage_B=Poke_DragonRage:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonRage_AB=Poke_DragonRage:new{ Damage = 3 }

function Poke_DragonRage:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploArt1"
	ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", PROJ_DELAY)
	return ret
end
	
Poke_Twister = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Twister.png",	
	Rarity = 3,
	Name = "Twister",
	Description = "Cast a tornado, dealing damage to a target and pushing adjacent tiles clockwise.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Wind Mastery" },
	UpgradeCost = { 2,2 },
	LaunchSound = "/weapons/support_wind",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Twister_A=Poke_Twister:new{ UpgradeDescription = "Increases damage by 1 and damages adjacent tiles.", Damage = 2 }
Poke_Twister_B=Poke_Twister:new{ UpgradeDescription = "Lets you choose whether to push clockwise, counterclockwise, or focus the damage on the center tile and flip it.", TwoClick = true }
Poke_Twister_AB=Poke_Twister:new{ Damage = 2, TwoClick = true }

function Poke_Twister:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end

function Poke_Twister:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	ret:push_back(p2)
	if p1 ~= p2 then
		ret:push_back(p2 + DIR_VECTORS[GetDirection(p2-p1)])
		ret:push_back(p2 + DIR_VECTORS[GetDirection(p1-p2)])
	end
	return ret
end
	
function Poke_Twister:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "twisterAnim"
	damage.sSound = self.LaunchSound
	if Board:IsBuilding(p2) then damage.iDamage = 0 end
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local pushDamage = SpaceDamage(curr, math.max(self.Damage-1, 0), (i+1)%4)
		if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
		ret:AddDamage(pushDamage)
	end
	return ret
end

function Poke_Twister:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "twisterAnim"
	damage.sSound = self.LaunchSound
	if Board:IsBuilding(p2) then damage.iDamage = 0 end
	if p2 == p3 then 
		damage.iDamage = damage.iDamage + 1
		damage.iPush = DIR_FLIP
	else
		local rotation = 1
		if GetDirection(p3-p2) == GetDirection(p2-p1) then rotation = 3 end
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			local pushDamage = SpaceDamage(curr, math.max(self.Damage-1, 0), (i+rotation)%4)
			if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
			ret:AddDamage(pushDamage)
		end
	end
	ret:AddDamage(damage)
	return ret
end

Poke_Confusion = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Confusion.png",	
	Rarity = 3,
	Name = "Confusion",
	Description = "Strike a target with psychic powers, confusing it into changing its attack direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Abra",
	}
}
Poke_Confusion_A=Poke_Confusion:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Confusion_B=Poke_Confusion:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Confusion_AB=Poke_Confusion:new{ Damage = 4 }


function Poke_Confusion:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or 
			(self.HitSides and (Board:GetPawn(curr + DIR_VECTORS[(i + 1)%4]) or Board:GetPawn(curr + DIR_VECTORS[(i + 3)%4]))) then 
				ret:push_back(curr) 
			end
		end
	end
	return ret
end

function Poke_Confusion:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage, DIR_FLIP)
	damage.sAnimation = "confusionAnim"
	ret:AddSafeDamage(damage)
	if self.HitSides then
		damage.loc = p2 + DIR_VECTORS[(direction + 1)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
		damage.loc = p2 + DIR_VECTORS[(direction + 3)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
	end
	return ret
end

Poke_Psychic=Poke_Confusion:new{
	Icon = "weapons/Psychic.png",	
	Rarity = 3,
	Name = "Psychic",
	Description = "Strike several targets with psychic powers, confusing them into changing their attack directions.",
	HitSides = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
}
Poke_Psychic_A=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_B=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_AB=Poke_Psychic:new{ Damage = 4 }


Poke_Fly=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Fly.png",	
	Rarity = 3,
	Name = "Fly",
	Description = "Fly up, then swoop down on a target for massive damage.",
	Push = false,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Global", "Push" },
	UpgradeCost = { 2,2 },
	ZoneTargeting = ZONE_DIR,
	ArtilleryHeight = 50,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(1, 1),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Fly_A=Poke_Fly:new{ UpgradeDescription = "Can target any tile.", Global = true }
Poke_Fly_B=Poke_Fly:new{ UpgradeDescription = "Pushes adjacent tiles, except the target's, on landing.", Push = true }
Poke_Fly_AB=Poke_Fly:new{ Global = true, Push = true }

function Poke_Fly:GetTargetArea(p1)
	local ret = PointList()
	if self.Global then
		for _, tile in ipairs(Board) do
			local unblocked = false
			if Board:IsBlocked(tile, PATH_PROJECTILE) then
				for i = DIR_START, DIR_END do
					local curr = tile + DIR_VECTORS[i]
					if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
				end
				if unblocked then ret:push_back(tile) end
			else
				ret:push_back(tile)
			end
		end
	else
		for dir = DIR_START, DIR_END do
			for i = 1,7 do
				local tile = p1 + DIR_VECTORS[dir]*i
				if Board:IsBlocked(tile, PATH_PROJECTILE) then
					for j = DIR_START, DIR_END do
						local curr = tile + DIR_VECTORS[j]
						if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
					end
					if unblocked then ret:push_back(tile) end
				else
					ret:push_back(tile)
				end
			end
		end
	end
	return ret
end

function Poke_Fly:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	--We only do two click weapon stuff if there is a pawn to strike in the target tile.
	for i = DIR_START,DIR_END do
		--for each tile adjacent to the pawn
		local curr = p2 + DIR_VECTORS[i]
		if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then 
			--if valid and something the user can stand on, we return it
			ret:push_back(curr) 
		end
	end
	
	return ret	
end

function Poke_Fly:IsTwoClickException(p1,p2)
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then return true end	--we only do two click weapon stuff if there is a pawn in p2
	return false
end

function Poke_Fly:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local distance = p1:Manhattan(p2)
	local direction = GetDirection(p2 - p1)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p2,"Emitter_Burst_$tile",DIR_NONE)
	if self.Push and not Board:IsBlocked(p2, PATH_PROJECTILE) then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p2 + DIR_VECTORS[i], 0)
			 dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			ret:AddDamage(dam)
		end
	end
	return ret
end

function Poke_Fly:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p3)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p3,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddDamage(SpaceDamage(p2, self.Damage))
	if self.Push then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p3 + DIR_VECTORS[i], 0)
			dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			if dam.loc ~= p2 then ret:AddDamage(dam) end
		end
	end
	return ret
end

Poke_Kinesis=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Kinesis.png",	
	Rarity = 3,
	Name = "Kinesis",
	Description = "Use psychic powers to shove a target in any direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Fling" },
	UpgradeCost = { 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy = Point(2,2),
		Water = Point(2,1),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
		CustomPawn = "Poke_Abra",
	}
}
Poke_Kinesis_A=Poke_Kinesis:new{ UpgradeDescription = "Can fling targets as far as possible.", Push = 2 }


function Poke_Kinesis:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and not Board:GetPawn(point2):IsGuarding() then ret:push_back(point2) end
		end
	end
	return ret
end

function Poke_Kinesis:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	for i = DIR_START,DIR_END do
		for j = 1, self.Push do
			local curr = p2 + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	
	return ret	
end

function Poke_Kinesis:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p2, 0, direction))
	return ret
end

function Poke_Kinesis:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	local distance = p2:Manhattan(p3)
	if distance == 1 then
		ret:AddDamage(SpaceDamage(p2, 0, direction))
	else
		local target = GetProjectileEnd(p2, p3)
		local hurt = true
		if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
		ret:AddCharge(Board:GetSimplePath(p2, target), FULL_DELAY)
		if hurt then
			ret:AddSafeDamage(SpaceDamage(target, 1))
			ret:AddSafeDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
		end
	end
	return ret
end

Poke_HyperBeam = LaserDefault:new{
	Class = "TechnoVek",
	Icon = "weapons/HyperBeam.png",
	Name = "Hyper Beam",
	Description = "Cast a devastating beam of energy. Completely exhausts the user; they must spend one turn asleep to recuperate.",
	Rarity = 4,
	Explosion = "",
	LaunchSound = "/props/final_bomb_explode",
	Damage = 3,
	PowerCost = 0, --AE Change
	MinDamage = 3,
	FriendlyDamage = true,
	ZoneTargeting = ZONE_DIR,
	LaserArt = "effects/laser_hyperbeam",
	-- LaserArt = "effects/laser1",
	Upgrades = 0,
--	UpgradeList = { "Ally Immune", "+1 Damage" },
	-- UpgradeCost = { 1,3 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
		CustomPawn = "Poke_Dratini",
	}
}
function Poke_HyperBeam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	ret:AddAnimation(p1, "PulseBlast", ANIM_REVERSE)
	ret:AddDelay(1)
	ret:AddScript("Board:StartShake(2)")
	self:AddLaser(ret, target, direction)
	ret:AddDelay(1)
	ret:AddScript(string.format("Status.ApplySleep(%s, 1)", Board:GetPawn(p1):GetId()))
	return ret
end

-------------------
--LEGENDARY BIRDS--
-------------------

Poke_IcyWind = Skill:new{
	Name = "Icy Wind",
	Class = "TechnoVek",
	Icon = "weapons/IcyWind.png",
	PathSize = 8,
	Damage = 1,
	Description = "Deals damage, removes fire, and chills enemies that are not on fire. Pierces through up to one target. Will freeze an already chilled target.",
	ProjectileArt = "effects/icywind",
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "Freeze Buildings", "+2 Damage"  },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Articuno"
	}
}

Poke_IcyWind_A = Poke_IcyWind:new{ UpgradeDescription = "Freezes buildings instead of damaging them.", FreezeBuildings = true, }
Poke_IcyWind_B = Poke_IcyWind:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3, }
Poke_IcyWind_AB = Poke_IcyWind:new{ FreezeBuildings = true, Damage = 3, }

function Poke_IcyWind:GetSkillEffect(p1,p2)	
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	local second_tar = GetProjectileEnd(first_tar,first_tar+DIR_VECTORS[dir],PATH_PROJECTILE)  
		
	if Board:IsValid(second_tar) and second_tar ~= first_tar then
		
		local damage = SpaceDamage(second_tar, self.Damage)
		damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(second_tar) then
			damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s, %s) end)", Board:GetPawn(second_tar):GetId(), tostring(true))
			-- damage.sScript = string.format("Status.ApplyChill(%s, %s)", Board:GetPawn(second_tar):GetId(), tostring(true))
		elseif self.FreezeBuildings and Board:IsBuilding(second_tar) then
			damage.iDamage = 0
			damage.iFrozen = 1
		end
		ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
		
		-- local distance = first_tar:Manhattan(p1)
		-- ret:AddDelay(distance*0.1 + 0.2)
		local first_damage = SpaceDamage(first_tar, self.Damage)
		first_damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(first_tar) then
			first_damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s, %s) end)", Board:GetPawn(first_tar):GetId(), tostring(true))
			-- first_damage.sScript = string.format("Status.ApplyChill(%s, %s)", Board:GetPawn(first_tar):GetId(), tostring(true))
		elseif self.FreezeBuildings and Board:IsBuilding(first_tar) then
			first_damage.iDamage = 0
			first_damage.iFrozen = 1
		end
		ret:AddDamage(first_damage)
	else
		local damage = SpaceDamage(first_tar, self.Damage)
		damage.iFire = EFFECT_REMOVE
		if Board:GetPawn(first_tar) then
			-- damage.sScript = string.format("Status.ApplyChill(%s, %s)", Board:GetPawn(first_tar):GetId(), tostring(true))
			damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s, %s) end)", Board:GetPawn(first_tar):GetId(), tostring(true))
		elseif self.FreezeBuildings and Board:IsBuilding(first_tar) then
			damage.iDamage = 0
			damage.iFrozen = 1
		end
		ret:AddProjectile(damage, self.ProjectileArt)
	end
	return ret
end



Poke_Blizzard = Skill:new{
	Name = "Blizzard",
	Class = "TechnoVek",
	Icon = "weapons/Blizzard.png",
	PathSize = 8,
	Damage = 2,
	Limited = 1,
	Description = "Deals damage and chills every enemy on the map. Will freeze an already chilled target.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Articuno"
	}
}

function Poke_Blizzard:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end


function Poke_Blizzard:GetSkillEffect(p1,p2)		--do chill
	local ret = SkillEffect()
	ret:AddScript("Board:SetWeather(10,"..RAIN_SNOW..",Point(0, 0),Point(8, 8),2)")
	ret:AddDelay(1)
	for _, tile in ipairs(Board) do
		if Board:GetPawn(tile) and Board:GetPawn(tile):GetTeam() == TEAM_ENEMY then
			local damage = SpaceDamage(tile, self.Damage)
			damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s, %s) end)", Board:GetPawn(tile):GetId(), tostring(true))
			ret:AddDamage(damage)
		end
	end
	
	return ret
end



Poke_Shockwave = Skill:new{
	Name = "Shockwave",
	Class = "TechnoVek",
	Icon = "weapons/Shockwave.png",
	PathSize = 8,
	Damage = 1,
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "+1 Damage", "+1 Damage"  },
	Description = "Fires a projectile in all four directions, applying Shocked. Can be focused in a single direction for more damage. Can also steal power from the Grid to boost as a free action.",
	ProjectileArt = "effects/laser_elec",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Zapdos"
	}
}

Poke_Shockwave_A = Poke_Shockwave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2, }

Poke_Shockwave_B = Poke_Shockwave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2, }

Poke_Shockwave_AB = Poke_Shockwave:new{ Damage = 3, }

function Poke_Shockwave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(point + DIR_VECTORS[i] * j)
			if Board:IsBlocked(point + DIR_VECTORS[i] * j, PATH_PROJECTILE) then break end
		end
	end
	ret:push_back(point)
	return ret
end


function Poke_Shockwave:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	if Board:IsBuilding(p2) then
		ret:AddDelay(0.3)
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
		ret:AddScript("Game:ModifyPowerGrid(-1)")
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 255, 200))", p1:GetString()))
		ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p1:GetString()))
	elseif p1 ~= p2 then
		local target = GetProjectileEnd(p1, p2)
		local damage = SpaceDamage(target, self.Damage + 1)
		damage.sAnimation = "LightningBolt0"
		ret:AddSound("/props/lightning_strike")
		ret:AddProjectile(damage, self.ProjectileArt, PROJ_DELAY)
		if Board:GetPawn(target) then ret:AddScript(string.format("Status.ApplyShocked(%s)", Board:GetPawn(target):GetId())) end
	else
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local target = GetProjectileEnd(p1, curr)
			if target ~= p1 then 
				local damage = SpaceDamage(target, self.Damage)
				damage.sAnimation = "LightningBolt0"
				if Board:GetPawn(target) then damage.sScript = string.format("Status.ApplyShocked(%s)", Board:GetPawn(target):GetId()) end
				ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
			end
		end
		ret:AddSound("/props/lightning_strike")
	end
	return ret
end



Poke_Thunder = Skill:new{
	Name = "Thunder",
	Class = "TechnoVek",
	Icon = "weapons/Thunder.png",
	PathSize = 8,
	Damage = 4,
	Limited = 1,
	Description = "Calls down lightning on a single target, applying Shocked. Electricity then chains through adjacent units.",
	ProjectileArt = "effects/laser_elec",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_Zapdos"
	}
}

function Poke_Thunder:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point+ DIR_VECTORS[i] * j)
		end
	end
	return ret
end


function Poke_Thunder:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	local hash = function(point) return point.x + point.y*10 end
	local explored = {[hash(p1)] = true}
	local todo = {p2}
	local origin = { [hash(p2)] = p1 }
	
	while #todo ~= 0 do
		local current = pop_back(todo)
		
		if not explored[hash(current)] then
			explored[hash(current)] = true
			
			if Board:IsPawnSpace(current) or Board:IsBuilding(current) then
			
				local direction = GetDirection(current - origin[hash(current)])
				local damage = SpaceDamage(current,self.Damage)
				damage.sAnimation = "Lightning_Attack_"..direction
				damage.iDamage = Board:IsBuilding(current) and DAMAGE_ZERO or 2
				if current == p2 then 	--hacky but I couldn't figure out how to change this properly
					damage.iDamage = 4 
					damage.sAnimation = "LightningBoltBig"
					if Board:GetPawn(p2) then damage.sScript = string.format("Status.ApplyShocked(%s)", Board:GetPawn(p2):GetId()) end
				end		
				ret:AddDamage(damage)
				
				for i = DIR_START, DIR_END do
					local neighbor = current + DIR_VECTORS[i]
					if not explored[hash(neighbor)] then
						todo[#todo + 1] = neighbor
						origin[hash(neighbor)] = current
					end
				end
			end		
		end
	end
	return ret
end




Poke_HeatWave = Skill:new{
	Name = "Heat Wave",
	Class = "TechnoVek",
	Icon = "weapons/HeatWave.png",
	PathSize = 1,
	Damage = 0,
	Description = "Sends forth three projectiles that push and burn.",
	Upgrades = 2,
	UpgradeCost = {2,3},
	UpgradeList = { "Fan the Flames", "Roaring Fires"  },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,2),
		Building2 = Point(3,3),
		CustomPawn = "Poke_Moltres"
	}
}

Poke_HeatWave_A = Poke_HeatWave:new{ UpgradeDescription = "Damages targets that are already on fire.", Damage = 2, }

Poke_HeatWave_B = Poke_HeatWave:new{ UpgradeDescription = "Damages all units that are on fire and applies Dry to those that are not.", TriggerFires = true, }

Poke_HeatWave_AB = Poke_HeatWave:new{ Damage = 2, TriggerFires = true, }

function Poke_HeatWave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+ DIR_VECTORS[i])
	end
	return ret
end


function Poke_HeatWave:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local offset = DIR_VECTORS[(dir+1)%4]
	for i = -1, 1 do
		local curr = p1 + offset * i
		local target = GetProjectileEnd(curr, p2 + offset * i)
		local damage = SpaceDamage(target, 0, dir)
		damage.iFire = 1
		if Board:IsFire(target) or (Board:GetPawn(target) and Board:GetPawn(target):IsFire()) then damage.iDamage = self.Damage end
		ret:AddProjectile(curr, damage, "effects/heatwave", NO_DELAY)
	end
	if self.TriggerFires then
		for _, tile in ipairs(Board) do	--this should iterate on GetPawns() but I couldn't remember the syntax
			if Board:GetPawn(tile) and not Board:GetPawn(tile):IsIgnoreFire() then 
				if Board:GetPawn(tile):IsFire() then
					ret:AddSafeDamage(SpaceDamage(tile, 1)) 
				else
					ret:AddScript(string.format("Status.ApplyDry(%s)", Board:GetPawn(tile):GetId()))
				end
			end
		end
	end
	return ret
end

Poke_FireBlast = Skill:new{
	Name = "Fire Blast",
	Class = "TechnoVek",
	Icon = "weapons/FireBlast.png",
	PathSize = 8,
	Damage = 3,
	Limited = 1,
	Description = "Fire a devastating fire explosion, pushing and burning adjacent tiles.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,2),
		Building2 = Point(3,3),
		CustomPawn = "Poke_MoltresBoss"
	}
}

function Poke_FireBlast:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point+ DIR_VECTORS[i] * j)
		end
	end
	return ret
end

function Poke_FireBlast:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage)
	damage.iFire = 1
	ret:AddArtillery(damage, "effects/shotup_fireball.png", PROJ_DELAY)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, 0, i)
		damage.iFire = 1
		ret:AddDamage(damage)
	end
	return ret
end




Poke_ShadowBall=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ShadowBall.png",	
	Rarity = 3,
	Name = "Shadow Ball",
	Self = "Poke_ShadowBall",
	Description = "Use psychic powers to shove a target in any direction, then fire two shadow projectiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	Shots = 2,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+2 shots", "Fling" },
	UpgradeCost = { 2, 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2,2),
		Second_Click = Point(2,1),
		Second_Origin = Point(2,4),
		-- Second_Target = Point(2,1),
		CustomPawn = "Poke_Mewtwo",
	}
}
Poke_ShadowBall_A=Poke_ShadowBall:new{ Description = "Use psychic powers to shove a target in any direction, then fire four shadow projectiles.", UpgradeDescription = "Fires two extra projectiles.", Shots = 4 }
Poke_ShadowBall_B=Poke_ShadowBall:new{ UpgradeDescription = "Can fling targets as far as possible.", Push = 2 }
Poke_ShadowBall_AB=Poke_ShadowBall:new{ Shots = 4, Push = 2 }

function Poke_ShadowBall:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and not Board:GetPawn(point2):IsGuarding() then ret:push_back(point2) end
		end
	end
	return ret
end

function Poke_ShadowBall:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	for i = DIR_START,DIR_END do
		for j = 1, self.Push do
			local curr = p2 + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	
	return ret	
end

function Poke_ShadowBall:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p2, 0, direction))
	return ret
end

function Poke_ShadowBall:GetFinalEffect(p1, p2, p3, remainingShots)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	if not remainingShots then 
		remainingShots = self.Shots
		if p2:Manhattan(p3) == 1 then
			
			local pushDamage = SpaceDamage(p2, 0, direction)
			pushDamage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, p2)
			ret:AddDamage(pushDamage)
		else
			local target = GetProjectileEnd(p2, p3)
			local hurt = true
			if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
			ret:AddCharge(Board:GetSimplePath(p2, target), FULL_DELAY)
			if hurt then
				local pushDamage = SpaceDamage(target, 1)
				pushDamage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
				ret:AddSafeDamage(pushDamage)
				ret:AddSafeDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
			end
		end
		-- ret:AddDelay(1)
	else
		local target = GetProjectileEnd(p1,p2)
		local damage = SpaceDamage(target, 1)
		damage.sImageMark = MultishotLib:getImageMark(1, remainingShots, p1, target)
		ret:AddProjectile(p1, damage, "effects/shadowball", NO_DELAY)
		ret:AddDelay(0.1 + remainingShots * 0.05)
		remainingShots = remainingShots - 1
	end
	if remainingShots >= 1 then
		
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetFinalEffect(%s, %s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], self.Self, p1:GetString(), p2:GetString(), p3:GetString(), remainingShots))
	end
	return ret
end

Poke_Psystrike=Poke_Confusion:new{		--temp
	Icon = "weapons/Psystrike.png",	
	Rarity = 3,
	Name = "Psystrike",
	Description = "Strike several targets with psychic powers, confusing them into changing their attack directions. Strikes several times and ignores armor.",
	HitSides = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	Damage = 3,
}
Poke_Psystrike_A=Poke_Psystrike:new{ UpgradeDescription = "Increases damage by 1.", Damage = 4 }
Poke_Psystrike_B=Poke_Psystrike:new{ UpgradeDescription = "Increases damage by 1.", Damage = 4 }
Poke_Psystrike_AB=Poke_Psystrike:new{ Damage = 5 }

function Poke_Psystrike:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damageAmount = 1
	local direction = GetDirection(p2-p1)
	for i = -1, 1 do
		local curr = p2 + DIR_VECTORS[(direction+1)%4] * i
		if Board:GetPawn(curr) then
			local damageAmount = 1
			if Board:GetPawn(curr):IsArmor() and not Board:GetPawn(curr):IsAcid() then damageAmount = 2 end
			local damage = SpaceDamage(curr, damageAmount)
			damage.sImageMark = MultishotLib:getImageMark(damageAmount, self.Damage, p1, curr)
			for j = 1, self.Damage do
				if j == self.Damage then damage.iPush = DIR_FLIP end
				ret:AddArtillery(curr + DIR_VECTORS[math.random(0, 3)], damage, "effects/shotup_psystrike.png", NO_DELAY)
				ret:AddDelay(0.05)
			end
		end
		
	end
	return ret
end


Poke_DarkPulse = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/DarkPulse.png",	
	Rarity = 3,
	Name = "Dark Pulse",
	Description = "Damage all surrounding enemies.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Extend Sleep" },
	UpgradeCost = { 2, 2 },
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,3),
		Target = Point(2,3),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Darkrai",
	}
}
Poke_DarkPulse_A=Poke_DarkPulse:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_DarkPulse_B=Poke_DarkPulse:new{ UpgradeDescription = "Sleeping targets will stay asleep for another turn.", ExtendSleep = true }
Poke_DarkPulse_AB=Poke_DarkPulse:new{ Damage = 3, ExtendSleep = true }


function Poke_DarkPulse:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Poke_DarkPulse:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddAnimation(p1, "darkpulseAnim")
	ret:AddDelay(0.2)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		local pawn = Board:GetPawn(curr)
		if pawn then 
			ret:AddDamage(SpaceDamage(curr, self.Damage)) 
			if Status.GetStatus(pawn:GetId(), "Sleep") and self.ExtendSleep then
				ret:AddScript(string.format("Status.ApplySleep(%s, %s, %s)", pawn:GetId(), 1, tostring(true)))
			end
		end
	end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		local pawn = Board:GetPawn(curr)
		if pawn then 
			ret:AddDamage(SpaceDamage(curr, self.Damage)) 
			if Status.GetStatus(pawn:GetId(), "Sleep") and self.ExtendSleep then
				ret:AddScript(string.format("Status.ApplySleep(%s, %s, %s)", pawn:GetId(), 1, tostring(true)))
			end
		end
	end
	return ret
end


Poke_FormChange = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FormChange.png",	
	Rarity = 3,
	Name = "Form Change",
	Description = "Change forms and perform a different attack based on the target. \nSelf: taunt adjacent enemies and gain a shield. \nAdjacent: Strike front tiles several times. \nRanged: pull the target and strike it. \nOtherwise: phase to the location, pushing adjacent tiles.",
	Push = 1,--TOOLTIP HELPER
	MinDamage = 1,
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2, 2 },
	TipImage = {
		Unit = Point(2,1),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,2),
		Water1 = Point(0,2),
		Water2 = Point(4,2),
		Second_Origin = Point(2,1),
		Second_Target = Point(2,4),
		Second_Click = Point(2,4),
		CustomPawn = "Poke_Deoxys",
	}
}
Poke_FormChange_A=Poke_FormChange:new{ UpgradeDescription = "Increases damage by 1.", MinDamage = 2, Damage = 3 }
Poke_FormChange_B=Poke_FormChange:new{ UpgradeDescription = "Increases damage by 1.", MinDamage = 2, Damage = 3 }
Poke_FormChange_AB=Poke_FormChange:new{ MinDamage = 3, Damage = 4 }

function Poke_FormChange:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	
	for i = DIR_START, DIR_END do
		local wasBlocked = false
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if not wasBlocked then ret:push_back(curr) end
			if wasBlocked and not Board:IsBlocked(curr, PATH_PROJECTILE) then ret:push_back(curr) end
			--we want to stop if it's at or past a blocking thing
			if Board:IsBlocked(curr, PATH_PROJECTILE) then wasBlocked = true end
		end
	end
	return ret
end

function Poke_FormChange:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local distance = p1:Manhattan(p2)
	if p1 == p2 then 			--defense form
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysD"))
		local shield = SpaceDamage(p1)
		shield.iShield = 1
		ret:AddDamage(shield)
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			local pawn = Board:GetPawn(curr)
			if pawn and pawn:GetTeam() == TEAM_ENEMY then
				local removeWeb = SpaceDamage(curr, 0, DIR_FLIP)
				removeWeb.bHide = true
				ret:AddDamage(removeWeb)
				ret:AddDamage(removeWeb)	--this flips the pawn twice, deleting webs
				ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, 1)", pawn:GetId(), p1:GetString()))
			end
		end
	elseif distance == 1 then 	--attack form
		local direction = GetDirection(p2-p1)
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysA"))
		local damage = SpaceDamage(p2, 1)
		for i = 1, self.Damage do
			damage.loc = p2 + DIR_VECTORS[(direction+1)%4]
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2 + DIR_VECTORS[(direction+1)%4])
			ret:AddDamage(damage)
			damage.loc = p2 + DIR_VECTORS[(direction-1)%4]
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2 + DIR_VECTORS[(direction-1)%4])
			ret:AddDamage(damage)
			damage.loc = p2
			damage.sImageMark = MultishotLib:getImageMark(1, self.Damage, p1, p2)
			ret:AddAnimation(p2, "alienwhip"..math.random(0, 3).."_"..direction, 1 + math.random(0, 1) + 4)	--either 1 or 5, normal or reverse
			ret:AddMelee(p1, damage)
			ret:AddSound("/enemy/starfish_1/attack")
			ret:AddDelay(0.35 - self.Damage * 0.05)			--makes it go faster when we hit more times
		end
	elseif GetProjectileEnd(p1, p2) == p2 and Board:IsBlocked(p2, PATH_PROJECTILE) then	--normal Form
		local direction = GetDirection(p2-p1)
		local target = GetProjectileEnd(p1, p2)
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Deoxys"))
		
		local damage = SpaceDamage(target)
		damage.bHidePath = true
		ret:AddProjectile(damage,"effects/shot_grapple")
		
		if Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() then	-- If it's a pawn
			ret:AddCharge(Board:GetSimplePath(target, p1 + DIR_VECTORS[direction]), FULL_DELAY)
			if Board:IsPawnTeam(target, TEAM_ENEMY) then
				ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[direction], self.MinDamage))
			end
		elseif Board:IsBlocked(target, PATH_PROJECTILE) then     --If it's an obstruction
			ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)	
			if Board:IsPawnTeam(target, TEAM_ENEMY) then
				ret:AddDamage(SpaceDamage(target, self.MinDamage))
			end
		end
	
	
	else	--speed Form
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_DeoxysS"))
		local dir = GetDirection(p2-p1)
		ret:AddCharge(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
		for i = 0, distance do
			ret:AddDelay(0.06)
			ret:AddBounce(p1 + DIR_VECTORS[dir]*i, -3)
			if i < distance and i > 0 then ret:AddDamage(SpaceDamage(p1 + DIR_VECTORS[dir]*i, 0)) end
			local damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
			damage.sAnimation = "exploout0_"..(dir+1)%4
			ret:AddDamage(damage)
			damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
			damage.sAnimation = "exploout0_"..(dir-1)%4
			ret:AddDamage(damage)
		end
	end
	return ret
end

Poke_Hypnosis=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Hypnosis.png",	
	Rarity = 3,
	Name = "Hypnosis",
	Description = "Use psychic powers to put a target to sleep.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 7,	
	PowerCost = 0, 
	SleepTurns = 1,
	LargeArea = false,
	Upgrades = 1,
	UpgradeList = { "+1 Turn" },
	UpgradeCost = { 1 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Darkrai",
	}
}
Poke_Hypnosis_A=Poke_Hypnosis:new{ UpgradeDescription = "Puts targets to sleep for an extra turn.", SleepTurns = 2 }


function Poke_Hypnosis:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,self.PathSize do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and Board:GetPawn(point2):GetTeam() == TEAM_ENEMY then ret:push_back(point2) end		-- and Board:GetPawn(point2):IsPowered()
		end
	end
	return ret
end


function Poke_Hypnosis:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_ENEMY then
		ret:AddScript(string.format("Status.ApplySleep(%s, %s)", Board:GetPawn(p2):GetId(), self.SleepTurns))
	end
	if self.LargeArea then
		ret:AddAnimation(p2, "darkpulseAnim", ANIM_REVERSE)
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then
				ret:AddScript(string.format("Status.ApplySleep(%s, %s)", Board:GetPawn(curr):GetId(), self.SleepTurns))		
			end
		end
	end
	return ret
end

Poke_DarkVoid=Poke_Hypnosis:new{
	Icon = "weapons/DarkVoid.png",	
	Rarity = 3,
	Name = "Dark Void",
	Description = "Drag all targets in an area into the realm of nightmares.",
	LargeArea = true,
	SleepTurns = 1,
	Upgrades = 1,
	UpgradeList = { "+1 Turn" },
	UpgradeCost = { 2 },
	Damage = 0,
}
Poke_DarkVoid_A=Poke_DarkVoid:new{ UpgradeDescription = "Puts targets to sleep for an extra turn.", SleepTurns = 2 }

function Poke_DarkVoid:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,self.PathSize do
			local point = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point) and Board:GetPawn(point):GetTeam() == TEAM_ENEMY then 
				ret:push_back(point)
			else
				for j = DIR_START, DIR_END do
					local point2 = p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[j]
					if Board:GetPawn(point2) and Board:GetPawn(point2):GetTeam() == TEAM_ENEMY then ret:push_back(point) break end		-- and Board:GetPawn(point2):IsPowered()
				end
			end
		end
	end
	return ret
end

Poke_CosmicPower=SelfTarget:new{
	Class = "TechnoVek",
	Icon = "weapons/CosmicPower.png",	
	Rarity = 3,
	Name = "Cosmic Power",
	Description = "Gains a buff as a free action based on the user's current form.",
	Damage = 0,
	Limited = 1,
}

function Poke_CosmicPower:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	ret:AddDelay(0.3)
	if pawn:GetCustomAnim() == "Poke_DeoxysA" then		--attack form: boost
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysS" then		--speed form: +MS
		ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(%s)", p1:GetString(), pawn:GetMoveSpeed() + 2))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysD" then		--defense form: +max HP
		ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(%s)", p1:GetString(), pawn:GetMaxHealth() + 2))
		ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(%s)", p1:GetString(), pawn:GetHealth() + 2))
	else											--normal form: heal
		ret:AddDamage(SpaceDamage(p1, -2))
	end
	ret:AddScript(string.format("Board:GetPawn(%s):SetActive(true)", p1:GetString()))
	return ret
end

Poke_PsychoBoost=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PsychoBoost.png",	
	Rarity = 3,
	Name = "Psycho Boost",
	Description = "Fire the user's other weapon as a free action, then gains a buff based on the user's current form.",
	Damage = 0,
	Limited = 1,
}

function Poke_PsychoBoost:GetTargetArea(point)
	local pawn = Board:GetPawn(point)
	local index
	if pawn:GetWeaponBaseType(1) == "Poke_PsychoBoost" then index = 2 else index = 1 end
	return _G[pawn:GetWeaponBaseType(index)]:GetTargetArea(point)
end

function Poke_PsychoBoost:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local index
	if pawn:GetWeaponBaseType(1) == "Poke_PsychoBoost" then index = 2 else index = 1 end
	ret.effect:AppendAll(_G[pawn:GetWeaponType(index)]:GetSkillEffect(p1,p2).effect)
	ret:AddDelay(0.3)
	if pawn:GetCustomAnim() == "Poke_DeoxysA" then			--attack form: boost
		ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", pawn:GetId()))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysS" then		--speed form: +MS
		ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(%s)", pawn:GetId(), pawn:GetMoveSpeed() + 2))
	elseif pawn:GetCustomAnim() == "Poke_DeoxysD" then		--defense form: +max HP
		ret:AddScript(string.format("Board:GetPawn(%s):SetMaxHealth(%s)", pawn:GetId(), pawn:GetMaxHealth() + 2))
		ret:AddScript(string.format("Board:GetPawn(%s):SetHealth(%s)", pawn:GetId(), pawn:GetHealth() + 2))
	else													--normal form: heal
		ret:AddDamage(SpaceDamage(p1, -2))
	end
	ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", pawn:GetId()))
	return ret
end







Poke_TimeTravel=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/TimeTravel.png",	
	Rarity = 3,
	Name = "Time Travel",
	Description = "Manipulate the flow of time to bring the end of the current mission closer or farther away.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	SelfDamage = 1,
	PathSize = 1,	
	PowerCost = 0,
	Limited = 1,
	Upgrades = 1,
	UpgradeList = { "+1 Use" },
	UpgradeCost = { 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		CustomPawn = "Poke_Celebi",
	}
}
Poke_TimeTravel_A=Poke_TimeTravel:new{ UpgradeDescription = "Can be used one more time.", Limited = 2 }

function Poke_TimeTravel:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(Point(7, 0))
	ret:push_back(Point(6, 0))
	ret:push_back(Point(7, 1))
	
	ret:push_back(Point(0, 7))
	ret:push_back(Point(1, 7))
	ret:push_back(Point(0, 6))
	return ret
end

function Poke_TimeTravel:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if Board:GetSize() == Point(6,6) then
		ret:AddAnimation(p1, "clockAnim")
	elseif GetCurrentMission() then
		if p2==Point(0, 7) or p2==Point(1, 7) or p2==Point(0, 6) then
			ret:AddScript("GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit + 1")
			ret:AddAnimation(p1, "clockAnimRev")
		else
			ret:AddScript("GetCurrentMission().TurnLimit = GetCurrentMission().TurnLimit - 1")
			ret:AddAnimation(p1, "clockAnim")
		end
		ret:AddSafeDamage(SpaceDamage(p1, self.SelfDamage))
	end
	return ret
end

Poke_NaturePower=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/NaturePower.png",	
	Rarity = 3,
	Name = "Nature Power",
	Description = "Fire a projectile with limited range that increases in power for each forest in its path.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 3,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+2 Range" },
	UpgradeCost = { 1,2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Forest1 = Point(2,3),
		Forest2 = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2, 1),
		CustomPawn = "Poke_Celebi",
	}
}
Poke_NaturePower_A=Poke_NaturePower:new{ UpgradeDescription = "Can be fired at targets up to 4 tiles away.", PathSize = 4 }
Poke_NaturePower_B=Poke_NaturePower:new{ UpgradeDescription = "Can be fired at targets up to 6 tiles away.", PathSize = 6 }
Poke_NaturePower_AB=Poke_NaturePower:new{ PathSize = 7 }

-- function Poke_NaturePower:GetTargetArea(p1)
	-- local ret = PointList()
	-- ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	-- end
	-- return ret
-- end

function Poke_NaturePower:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	-- local target = GetProjectileEnd(p1, p2)
	local dir = GetDirection(p2-p1)
	local curr = p1
	local amount = 1
	repeat
		if Board:GetTerrain(curr) == TERRAIN_FOREST then amount = amount + 1 end
		if not Board:IsValid(curr + DIR_VECTORS[dir]) then break end
		curr = curr + DIR_VECTORS[dir]
	until Board:IsBlocked(curr, PATH_PROJECTILE) or p1:Manhattan(curr) >= self.PathSize
	ret:AddProjectile(SpaceDamage(curr, amount), "effects/naturepower")
	return ret
end



Poke_Bloom=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Bloom.png",	
	Rarity = 3,
	Name = "Bloom",
	Description = "Creates forests in an area, pushing pawns on the edge. Forests already present bloom with Gracidea, which empower allied units.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "Forest's Roots", "Forest's Wrath" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Forest1 = Point(2,3),
		Target = Point(2, 2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		Forest2 = Point(2, 1),
		CustomPawn = "Poke_Shaymin",
	}
}
Poke_Bloom_A=Poke_Bloom:new{ UpgradeDescription = "An enemy on the center tile becomes rooted.", Roots = true }
Poke_Bloom_B=Poke_Bloom:new{ UpgradeDescription = "Damages enemies on forests. Will passively damage rooted enemies with both upgrades enabled.", Damage = 2 }
Poke_Bloom_AB=Poke_Bloom:new{ Roots = true, Damage = 2 }

function Poke_Bloom:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_Bloom:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	if self.Roots and Board:GetPawn(p2) then damage.sScript = string.format("Status.ApplyRooted(%s, %s)", Board:GetPawn(p2):GetId(), self.Damage) end
	if Board:GetTerrain(p2) == TERRAIN_FOREST then 
		if Board:GetPawn(p2) and Board:GetPawn(p2):GetTeam() == TEAM_ENEMY and self.Damage > 0 then 
			ret:AddSafeDamage(SpaceDamage(p2, self.Damage))
		elseif not Board:GetPawn(p2) and Board:GetItem(p2) == "" then
			damage.sItem = "Poke_Gracidea" 
		end
	elseif Board:GetTerrain(p2) == TERRAIN_HOLE or Board:GetTerrain(p2) == TERRAIN_WATER or Board:GetTerrain(p2) == TERRAIN_MOUNTAIN or Board:GetTerrain(p2) == TERRAIN_BUILDING then
	else
		damage.iTerrain = TERRAIN_FOREST
	end
	damage.sAnimation = "explo_viridian"
	ret:AddDamage(damage)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		damage = SpaceDamage(curr, 0, i)
		if Board:GetTerrain(curr) == TERRAIN_FOREST then 
			damage.sItem = "Poke_Gracidea" 
		elseif Board:GetTerrain(curr) == TERRAIN_HOLE or Board:GetTerrain(curr) == TERRAIN_WATER or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:GetTerrain(curr) == TERRAIN_BUILDING then
		else
			damage.iTerrain = TERRAIN_FOREST
		end
		ret:AddDamage(damage)
	end
	return ret
end



Poke_SeedFlare=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SeedFlare.png",	
	Rarity = 3,
	Name = "Seed Flare",
	Description = "Fires a powerful explosive seed at a location. If nothing is there, it will remain on that tile until set off.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 1,
	UpgradeList = { "Burst of Gratitude" },
	UpgradeCost = { 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2, 2),
		Second_Origin = Point(2, 4),
		Second_Target = Point(2, 1),
		CustomPawn = "Poke_Shaymin",
	}
}
Poke_SeedFlare_A=Poke_SeedFlare:new{ UpgradeDescription = "When fired at a Gracidea, will damage all adjacent enemies.", Burst = true }

function Poke_SeedFlare:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_SeedFlare:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	local revDir = GetDirection(p1-p2)
	local doBurst
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then 
		if Board:GetItem(p2) == "Poke_Gracidea" and self.Burst then
			doBurst = true
		else
			damage.sItem = "Poke_SeedFlareItem"
		end
	else 
		damage.iDamage = 3 
		damage.iTerrain = TERRAIN_FOREST
		damage.sSound = "Science_KO_Crack_OnKill"
	end
	ret:AddDamage(SpaceDamage(p1, 0, revDir))		--this is here for opportunities to self-damage to enable Eternal Life
	ret:AddArtillery(p1, damage, "effects/shotup_seedflare.png", PROJ_DELAY)
	if doBurst then 
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i]
			if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then ret:AddDamage(SpaceDamage(curr, 3)) end
		end
	end
	return ret
end

Poke_PetalBlizzard=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PetalBlizzard.png",	
	Rarity = 3,
	Name = "Petal Blizzard",
	Description = "Strikes and pushes all pawns in a two tiles radius in the chosen direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	Range = 2,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+1 Damage" },
	UpgradeCost = { 2, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_Xerneas",
	}
}
Poke_PetalBlizzard_A=Poke_PetalBlizzard:new{ UpgradeDescription = "Affects targets in a three tile radius.", Range = 3 }
Poke_PetalBlizzard_B=Poke_PetalBlizzard:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2 }
Poke_PetalBlizzard_AB=Poke_PetalBlizzard:new{ Range = 3, Damage = 2 }

-- function Poke_PetalBlizzard:GetTargetArea(p1)
	-- local ret = PointList()
	-- ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	-- end
	-- return ret
-- end

function Poke_PetalBlizzard:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	local dir = GetDirection(p2-p1)
	ret:AddAnimation(p1, "petalblizzardAnim")
	for i = self.Range, 1, -1 do
		for k = 1, #targets do
			if p1:Manhattan(targets[k]) == i then
			--we have to hit the furthest tiles first, so we just iterate on the entire area self.Range times
				if math.random(1, self.Range) == 1 then 
					local visual = SpaceDamage(targets[k] + DIR_VECTORS[dir] * math.random(2, 3))
					visual.bHide = true
					ret:AddProjectile(targets[k], visual, "effects/petal", NO_DELAY) 
				end
				if Board:GetPawn(targets[k]) and targets[k] ~= p1 then ret:AddSafeDamage(SpaceDamage(targets[k], self.Damage, dir)) end
			end
		end
		ret:AddDelay(-1)
	end
	return ret
end

Poke_Moonblast=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Moonblast.png",	
	Rarity = 3,
	Name = "Moonblast",
	Description = "Deal damage in an X-shaped zone.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2, 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(3,3),
		Target = Point(1,1),
		Enemy1 = Point(1, 1),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(0, 0),
		Enemy3 = Point(2, 0),
		Enemy3 = Point(0, 2),
		CustomPawn = "Poke_Xerneas",
	}
}
Poke_Moonblast_A=Poke_Moonblast:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3 }
Poke_Moonblast_B=Poke_Moonblast:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3 }
Poke_Moonblast_AB=Poke_Moonblast:new{ Damage = 4 }

function Poke_Moonblast:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir]*j+DIR_VECTORS[(dir+1)%4]*j)
		end
	end
	return ret
end

function Poke_Moonblast:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "moonblastAnim"
	ret:AddDamage(damage)
	for dir = DIR_START, DIR_END do 
		damage.loc = p2+DIR_VECTORS[dir]+DIR_VECTORS[(dir+1)%4]
		ret:AddDamage(damage)
	end
	return ret
end



Poke_EternalLife=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/EternalLife.png",	
	Rarity = 3,
	Name = "Eternal Life",
	Description = "Heals all allies to full life by draining enemies. The effort puts the user to sleep for one turn.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	Range = 2,
	PathSize = 1,
	PowerCost = 0,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_Xerneas",
	}
}

function Poke_EternalLife:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	return ret
end

function Poke_EternalLife:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local enemies = Board:GetPawns(TEAM_ENEMY)
	local allies = Board:GetPawns(TEAM_PLAYER)
	local enemyList = {}
	local allyList = {}
	for _, i in ipairs(extract_table(enemies)) do
		enemyList[#enemyList + 1] = {id = i, hp = Board:GetPawn(i):GetHealth()}
	end
	for _, i in ipairs(extract_table(allies)) do
		if Board:GetPawn(i):IsDamaged() then allyList[#allyList + 1] = {id = i, hp = Board:GetPawn(i):GetMaxHealth() - Board:GetPawn(i):GetHealth()} end
	end
	LOG(#enemyList, #allyList)
	if #enemyList == 0 or #allyList == 0 then return ret end
	while #enemyList > 0 and #allyList > 0 do
		local randAlly = 1 --math.random(#allyList)
		local randEnemy = 1 --math.random(#enemyList)
		local randAllyId = allyList[randAlly].id
		local randEnemyId = enemyList[randEnemy].id
		ret:AddArtillery(Board:GetPawn(randEnemyId):GetSpace(), SpaceDamage(Board:GetPawn(randAllyId):GetSpace(), -1), "effects/shotup_grid.png", NO_DELAY)
		ret:AddSafeDamage(SpaceDamage(Board:GetPawn(randEnemyId):GetSpace(), 1))
		allyList[randAlly].hp = allyList[randAlly].hp - 1
		if allyList[randAlly].hp == 0 then table.remove(allyList, randAlly) end
		enemyList[randEnemy].hp = enemyList[randEnemy].hp - 1
		if Board:GetPawn(randEnemyId):IsAcid() then enemyList[randEnemy].hp = enemyList[randEnemy].hp - 1 end
		if enemyList[randEnemy].hp == 0 then table.remove(enemyList, randEnemy) end
		ret:AddDelay(0.1)
	end
	ret:AddDelay(1)
	ret:AddScript(string.format("Status.ApplySleep(%s, 1)", Board:GetPawn(p1):GetId()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Xerneas_special_sleep"))
	return ret
end



Poke_Reflect=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Reflect.png",	
	Rarity = 3,
	Name = "Reflect",
	Description = "Reflects all queued attacks currently targeting the user.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	Range = 0,
	PathSize = 1,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+2 Range", "+4 Range" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 3),
		CustomPawn = "Poke_ArmoredMewtwo",
	}
}
Poke_Reflect_A=Poke_Reflect:new{ UpgradeDescription = "Can reflect from tiles within a 2 tile radius.", Range = 2 }
Poke_Reflect_B=Poke_Reflect:new{ UpgradeDescription = "Can reflect from tiles within a 4 tile radius.", Range = 4 }
Poke_Reflect_AB=Poke_Reflect:new{ Range = 6 }

function Poke_Reflect:GetTargetArea(p1)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	if self.Range == 0 then
		ret:push_back(p1)
	-- for dir = DIR_START, DIR_END do
		-- ret:push_back(p1+DIR_VECTORS[dir])
	else	
		for _, tile in ipairs(targets) do
			ret:push_back(tile)
		end
	end
	return ret
end

function Poke_Reflect:GetSkillEffect(p1, p2)
	--for each enemy, look at their queued skill, generate a skill effect targeting the same tile, loop on it, if it targets the Reflect tile, reflect
	local ret = SkillEffect()
	ret:AddAnimation(p2, "ExploRepulse1")
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		local pawn = Board:GetPawn(id)		
		if pawn:GetQueuedTarget() ~= Point(-1, -1) then
			local fx = _G[pawn:GetQueuedWeapon()]:GetSkillEffect(pawn:GetSpace(), pawn:GetQueuedTarget())
			for _, spaceDamage in ipairs(extract_table(fx.q_effect)) do
				if spaceDamage.loc == p2 then 
					local reflectDamage = SpaceDamage(pawn:GetSpace(), spaceDamage.iDamage)
					if spaceDamage:GetType() == 2 then			--projectile
						ret:AddProjectile(p2, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetType() == 1 then		--artillery
						ret:AddArtillery(p2, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetMoveType() == 3 then	--melee
						ret:AddDamage(reflectDamage)
					else
						ret:AddDamage(reflectDamage)
					end
					ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", id))
				end
			end
		end
	end
	return ret
end



Poke_Teleport=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Teleport.png",	
	Rarity = 3,
	Name = "Teleport",
	Description = "Teleports a target to another location. Can target buildings to teleport the civilians to safety, evacuating the building fully.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	Range = 3,
	PathSize = 1,
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "+2 Range", "Shunt" },
	UpgradeCost = { 1, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,2),
		Enemy = Point(2, 2),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,0),
		Second_Click = Point(1, 0),
		Water = Point(1,0),
		CustomPawn = "Poke_ArmoredMewtwo",
	}
}
Poke_Teleport_A=Poke_Teleport:new{ UpgradeDescription = "Can teleport targets two tiles further.", Range = 5 }
Poke_Teleport_B=Poke_Teleport:new{ UpgradeDescription = "Can teleport targets into mountains and buildings, killing them, or into pawns, dealing damage to both equal to the lowest health of the two.", Shunt = true }
--inspired by an ability from Fell Seal, great game
Poke_Teleport_AB=Poke_Teleport:new{ Range = 5, Shunt = true }

function Poke_Teleport:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if Board:IsBuilding(curr) or (Board:GetPawn(curr) and not Board:GetPawn(curr):IsGuarding()) then ret:push_back(curr) end
	end
	return ret
end

function Poke_Teleport:IsTwoClickException(p1,p2)
	return Board:IsBuilding(p2)
end

function Poke_Teleport:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if Board:IsBuilding(p2) then return ret end
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	for k = 1, #targets do
		local tile = targets[k]
		if not Board:IsBlocked(tile, PATH_PROJECTILE) or self.Shunt and (Board:GetTerrain(tile) == TERRAIN_MOUNTAIN or Board:GetTerrain(tile) == TERRAIN_BUILDING or Board:GetPawn(tile)) then ret:push_back(tile) end
	end
	return ret
end

function Poke_Teleport:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if Board:IsBuilding(p2) then
		ret:AddScript([[
			local p = ]].. p2:GetString() ..[[;
			Board:SetPopulated(false, p);
			Board:Ping(p, GL_Color(255,255,255,1));
			Game:TriggerSound("/ui/battle/population_points");
		]])
	else
		ret:AddDamage(SpaceDamage(p2))
	end
	return ret
end

function Poke_Teleport:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local moverHp = Board:GetPawn(p2):GetHealth()
	if Board:GetPawn(p2):IsArmor() and not Board:GetPawn(p2):IsAcid() then moverHp = moverHp + 1 end
	local targetHp = 100
	if Board:GetPawn(p3) then targetHp = Board:GetPawn(p3):GetHealth() end
	if Board:GetPawn(p2):IsArmor() and not Board:GetPawn(p2):IsAcid() then targetHp = targetHp + 1 end
	if (Board:GetTerrain(p3) == TERRAIN_MOUNTAIN and Board:GetHealth(p3) == 2) or (Board:GetTerrain(p3) == TERRAIN_BUILDING and Board:GetHealth(p3) > moverHp) then
		--we don't want corpses on the same tile as a mountain/building that will be standing 
		ret:AddScript(string.format("Board:GetPawn(%s):SetCorpse(false)", p2:GetString()))
	end
	ret:AddTeleport(p2, p3, FULL_DELAY)
	if Board:IsBlocked(p3, PATH_PROJECTILE) then 
		local hadShield = false
		local wasFrozen = false
		--make it go through shield and readd, otherwise one pawn survives
		if Board:IsShield(p3) then
			hadShield = true
			Board:SetShield(p3, false, true)
		end
		if Board:IsFrozen(p3) then
			wasFrozen = true
			Board:SetFrozen(p3, false, true)
		end
		ret:AddDamage(SpaceDamage(p3, math.min(moverHp, targetHp))) 
		if hadShield then Board:SetShield(p3, true, true) end
		if wasFrozen then Board:SetFrozen(p3, true, true) end
	end
	return ret
end



Poke_TakeDown = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/TakeDown.png",	
	Rarity = 3,
	Name = "Take Down",
	Description = "Strike a target and push it back, taking damage equal to half the damage dealt, rounded down.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 1,
	PathSize = 4,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_TakeDown:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_TakeDown:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	local amountDealt = self.Damage
	local pawnHit = Board:GetPawn(target)
	if pawnHit then
		if Board:GetPawn(p1):IsBoosted() then amountDealt = amountDealt + 1 end
		if pawnHit:IsAcid() then
			amountDealt = amountDealt * 2
		elseif pawnHit:IsArmor() then
			amountDealt = amountDealt - 1
		end
		amountDealt = math.min(amountDealt, pawnHit:GetHealth())
	else
		amountDealt = 0
	end
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	if doDamage then ret:AddDamage(SpaceDamage(target - DIR_VECTORS[direction], math.floor(amountDealt / 2))) end
	
	return ret
end

Poke_TakeDown_A=Poke_TakeDown:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_TakeDown_B=Poke_TakeDown:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_TakeDown_AB=Poke_TakeDown:new{ Damage = 4 }


Poke_ZenHeadbutt = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/ZenHeadbutt.png",	
	Rarity = 3,
	Name = "Zen Headbutt",
	Description = "Strike a target and push it back, confusing adjacent enemies on both sides of the target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 0,
	PathSize = 7,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,1),
		Enemy3 = Point(3,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_ZenHeadbutt:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_ZenHeadbutt:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	local user = Board:GetPawn(p1)
	local resetAnim
	if user:GetCustomAnim() == "Poke_Metagross" and (p1:Manhattan(p2) > 1 or not Board:IsBlocked(p2, PATH_PROJECTILE)) and not Board:IsTipImage() then
		resetAnim = true
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Metagross_hover"))
	end
	ret:AddAnimation(p1, "ExploRepulseSmall", ANIM_REVERSE)
	ret:AddDelay(0.5)
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then ret:AddDelay(0.06) end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end

		local damage = SpaceDamage(p2 + DIR_VECTORS[(direction+1)%4], 0, DIR_FLIP)
		damage.sAnimation = "confusionAnim"
		ret:AddDamage(damage)
		damage.loc = p2 + DIR_VECTORS[(direction-1)%4]
		ret:AddDamage(damage)
	
	if resetAnim then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", (target - DIR_VECTORS[direction]):GetString(), "Poke_Metagross")) end
	return ret
end

Poke_ZenHeadbutt_A=Poke_ZenHeadbutt:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_ZenHeadbutt_B=Poke_ZenHeadbutt:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_ZenHeadbutt_AB=Poke_ZenHeadbutt:new{ Damage = 4 }


Poke_MetalClaw = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MetalClaw.png",	
	Rarity = 3,
	Name = "Metal Claw",
	Description = "Strike a target two times with sharp claws. Each time this is used, it will strike one more time for the rest of the mission.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Strikes = 2,
	Upgrades = 2,
	UpgradeList = {"+1 Strike", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_MetalClaw:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local strikes = self.Strikes
	if GetCurrentMission() then 
		if not GetCurrentMission().MetalClawUses then GetCurrentMission().MetalClawUses = 0 end
		strikes = self.Strikes + GetCurrentMission().MetalClawUses
	end
	local anim = Board:GetPawn(p1):GetCustomAnim()
	if anim == "Poke_Metang" and not Board:IsTipImage() then 
		-- Board:GetPawn(p1):SetCustomAnim("Poke_Metang_swipe") 
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Metang_swipe"))
	end
	for i = 1, strikes do
		local damage = SpaceDamage(p2, self.Damage)
		damage.sImageMark = MultishotLib:getImageMark(self.Damage, strikes, p1, p2)
		damage.sAnimation = "metalclawanim_"..i%2
		ret:AddMelee(p1, damage)
	end
	if GetCurrentMission() and not Board:IsTipImage() then ret:AddScript("GetCurrentMission().MetalClawUses = "..GetCurrentMission().MetalClawUses + 1) end
	if anim == "Poke_Metang" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), anim)) end
	return ret
end

Poke_MetalClaw_A=Poke_MetalClaw:new{ UpgradeDescription = "Adds one more strike.", Strikes = 3 }
Poke_MetalClaw_B=Poke_MetalClaw:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_MetalClaw_AB=Poke_MetalClaw:new{ Strikes = 3, Damage = 2 }


Poke_MeteorMash = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MeteorMash.png",	
	Rarity = 3,
	Name = "Meteor Mash",
	Description = "Strike a target three times with metal fists. Each time this is used, it will strike one more time for the rest of the mission. Pushes on the final hit. Can also self-target to hit all adjacent tiles once.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Strikes = 3,
	Upgrades = 2,
	UpgradeList = {"+1 Strike", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Beldum",
	}
}

function Poke_MeteorMash:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	ret:push_back(point)
	return ret
end

function Poke_MeteorMash:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	local strikes = self.Strikes
	if GetCurrentMission() then 
		if not GetCurrentMission().MeteorMashUses then GetCurrentMission().MeteorMashUses = 0 end
		strikes = self.Strikes + GetCurrentMission().MeteorMashUses
	end
	if p1 ~= p2 then
		local direction = GetDirection(p2 - p1)
		for i = 1, strikes do
			local damage = SpaceDamage(p2, self.Damage)
			if i == strikes then damage.iPush = direction end
			damage.sAnimation = "metalpunch"..((i%2)+1).."_"..direction
			damage.sImageMark = MultishotLib:getImageMark(self.Damage, strikes, p1, p2)
			ret:AddSound("/weapons/titan_fist")
			ret:AddMelee(p1, damage)
		end
	else
		for dir = DIR_START, DIR_END do
			local damage = SpaceDamage(p1 + DIR_VECTORS[dir], self.Damage, dir)
			damage.sAnimation = "metalpunch1_"..dir
			ret:AddDamage(damage)
		end
	end
	if GetCurrentMission() and not Board:IsTipImage() then ret:AddScript("GetCurrentMission().MeteorMashUses = "..GetCurrentMission().MeteorMashUses + 1) end
	return ret
end

Poke_MeteorMash_A=Poke_MeteorMash:new{ UpgradeDescription = "Adds one more strike.", Strikes = 4 }
Poke_MeteorMash_B=Poke_MeteorMash:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_MeteorMash_AB=Poke_MeteorMash:new{ Strikes = 4, Damage = 2 }


Poke_Bite = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Bite.png",	
	Rarity = 3,
	Name = "Bite",
	Description = "Bite a target with sharp fangs and drag it to an adjacent space.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		-- Second_Origin = Point(2,2),
		-- Second_Target = Point(2,2),
		-- Second_Click = Point(2,2),
		CustomPawn = "Poke_Gible",
	}
}

function Poke_Bite:IsTwoClickException(p1,p2)
	if not Board:GetPawn(p2) then return true end
	if Board:GetPawn(p2):IsGuarding() then return true end
	if #extract_table(self:GetSecondTargetArea(p1,p2)) == 0 then return true end
	return false
end

function Poke_Bite:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local direction = GetDirection(p2 - p1)
	for i = DIR_START, DIR_END do
		if not Board:IsBlocked(p1 + DIR_VECTORS[i], Board:GetPawn(p1):GetPathProf()) and 
		   --not Board:IsBlocked(p2 + DIR_VECTORS[i], PATH_PROJECTILE) and
		   i ~= direction then ret:push_back(p2 + DIR_VECTORS[i]) end
		if i == (direction + 2)%4 and not Board:IsBlocked(p1 - DIR_VECTORS[direction], Board:GetPawn(p1):GetPathProf()) then ret:push_back(p1) end
	end
	return ret
end

function Poke_Bite:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "bite_"..direction
	ret:AddMelee(p1, damage)
	if Board:IsTipImage() then		--kept crashing when done the normal way for some reason
		ret:AddCharge(Board:GetSimplePath(p1, p1 - DIR_VECTORS[direction]), NO_DELAY)
		ret:AddCharge(Board:GetSimplePath(p2, p1), FULL_DELAY)
		ret:AddDelay(2)
	end
	return ret
end

function Poke_Bite:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local direction2 = GetDirection(p3 - p2)
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "bite_"..direction
	if Board:IsBlocked(p2 + DIR_VECTORS[direction2], PATH_PROJECTILE) then 
		damage.iPush = direction2 
		ret:AddCharge(Board:GetSimplePath(p1, p1 + DIR_VECTORS[direction2]), NO_DELAY)
		ret:AddDamage(damage)
	else
		ret:AddMelee(p1, damage)
		ret:AddCharge(Board:GetSimplePath(p1, p1 + DIR_VECTORS[direction2]), NO_DELAY)
		ret:AddCharge(Board:GetSimplePath(p2, p2 + DIR_VECTORS[direction2]), FULL_DELAY)
	end
	return ret
end

Poke_Bite_A=Poke_Bite:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_Bite_B=Poke_Bite:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_Bite_AB=Poke_Bite:new{ Damage = 3 }


Poke_Crunch = Poke_Bite:new{
	Class = "TechnoVek",
	Icon = "weapons/Crunch.png",	
	Rarity = 3,
	Name = "Crunch",
	Description = "Crunch a target with sharp fangs and drag it to an adjacent space.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	SelfDamage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 3},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,1),
		-- Second_Origin = Point(2,1),
		-- Second_Target = Point(2,3),
		-- Second_Click = Point(2, 2),
		CustomPawn = "Poke_Gible",
	}
}

Poke_Crunch_A=Poke_Crunch:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Crunch_B=Poke_Crunch:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Crunch_AB=Poke_Crunch:new{ Damage = 4 }


Poke_Earthquake=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Earthquake.png",	
	Rarity = 3,
	Name = "Earthquake",
	Description = "Damages all non-flying units in an area and flips their attack direction. Turns sand into smoke and breaks cracked tiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 8,	
	PowerCost = 0,
	Range = 1,
	HitBuildings = true,
	Upgrades = 2,
	UpgradeList = { "+1 Area", "Buildings immune" },
	UpgradeCost = { 2, 1 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,0),
		Enemy1 = Point(2,2),
		Enemy2 = Point(1,1),
		Building1 = Point(3,0),
		Building2 = Point(4,0),
		CustomPawn = "Poke_Gible",
		CustomEnemy = "Scorpion2",
	}
}
Poke_Earthquake_A=Poke_Earthquake:new{ UpgradeDescription = "Affects tiles in a larger radius.", Range = 2 }
Poke_Earthquake_B=Poke_Earthquake:new{ UpgradeDescription = "Doesn't affect buildings.", HitBuildings = false }
Poke_Earthquake_AB=Poke_Earthquake:new{ Range = 2, HitBuildings = false }

function Poke_Earthquake:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_Earthquake:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	ret:AddSound("/props/cataclysm")
	ret:AddScript("Board:StartShake(2)")
	for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if (pawn and not pawn:IsFlying()) or (Board:IsBuilding(targets[k]) and self.HitBuildings) or Board:IsCracked(targets[k]) or Board:IsPod(targets[k]) then 
			ret:AddDamage(SpaceDamage(targets[k], self.Damage, DIR_FLIP)) 
		elseif Board:GetTerrain(targets[k]) == TERRAIN_SAND then
			local damage = SpaceDamage(targets[k])
			damage.iSmoke = 1
			damage.iTerrain = TERRAIN_ROAD
			ret:AddDamage(damage)
		else
			ret:AddDamage(SpaceDamage(targets[k], DAMAGE_ZERO))	--for UX, otherwise it's hard to understand the area it hits
		end
		ret:AddBounce(targets[k], 1 + self.Range * 2 - p2:Manhattan(targets[k]))
	end
	return ret
end


Poke_RockThrow=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/RockThrow.png",	
	Rarity = 3,
	Name = "Rock Throw",
	Description = "Throw a rock at a target, pushing it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 1,
	UpgradeList = {"+1 Damage"},
	UpgradeCost = {1},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2, 1),
		CustomPawn = "Poke_Larvitar",
	}
}

Poke_RockThrow_A=Poke_RockThrow:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2 }

function Poke_RockThrow:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p1 + DIR_VECTORS[dir])
	ret:AddProjectile(SpaceDamage(target, self.Damage, dir), "effects/shot_mechrock")
	return ret
end


Poke_RockSlide=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/RockSlide.png",	
	Rarity = 3,
	Name = "Rock Slide",
	Description = "Causes rocks to fall down on the target and two adjacent tiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "Stealth Rocks"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy1 = Point(1, 1),
		Enemy2 = Point(3, 1),
		CustomPawn = "Poke_Larvitar",
	}
}

Poke_RockSlide_A=Poke_RockSlide:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3 }
Poke_RockSlide_B=Poke_RockSlide:new{ UpgradeDescription = "Adds Stealth Rocks to hit tiles that are empty. Stealth Rocks deal 1 damage to units moving onto that tile, doubled against flying units.", StealthRocks = true }
Poke_RockSlide_AB=Poke_RockSlide:new{ Damage = 3, StealthRocks = true }

function Poke_RockSlide:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_RockSlide:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	for i = -1, 1 do
		local curr = p2 + DIR_VECTORS[(dir+1)%4] * i
		local pawn = Board:GetPawn(curr)
		local damage = SpaceDamage(curr, self.Damage)
		if self.StealthRocks and 
		   (not Board:IsBlocked(curr, PATH_PROJECTILE) or 
		   (pawn and Board:IsDeadly(damage, pawn) and Board:GetTerrain(curr) ~= TERRAIN_WATER and Board:GetTerrain(curr) ~= TERRAIN_HOLE)) then 
			if Board:IsTipImage() then
				damage.sItem = "Poke_StealthRock"
			else
				damage.sScript = string.format("modApi:runLater(function() Board:SetItem(%s, %q) end)", curr:GetString(), "Poke_StealthRock")
			end
		end
		ret:AddDropper(damage,"effects/shotdown_rock.png")
	end
	return ret
end


Poke_StoneEdge=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/StoneEdge.png",	
	Rarity = 3,
	Name = "Stone Edge",
	Description = "Strikes three tiles with a powerful blade of stone.",
	Push = 1,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 8,	
	PowerCost = 0,
	Range = 1,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Range", "Stealth Rocks"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy1 = Point(1, 1),
		Enemy2 = Point(3, 1),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,1),
		Second_Click = Point(1,1),
		CustomPawn = "Poke_Larvitar",
	}
}

Poke_StoneEdge_A=Poke_StoneEdge:new{ UpgradeDescription = "Hits up to five tiles.", Range = 2, Description = "Strikes up to five tiles with a powerful blade of stone.", }
Poke_StoneEdge_B=Poke_StoneEdge:new{ UpgradeDescription = "Adds Stealth Rocks to hit tiles that are empty. Stealth Rocks deal 1 damage to units moving onto that tile, doubled against flying units.", StealthRocks = true }
Poke_StoneEdge_AB=Poke_StoneEdge:new{ Range = 2, StealthRocks = true, Description = "Strikes up to five tiles with a powerful blade of stone.", }

Emitter_StoneEdgeRocks = Emitter:new{
	image = "effects/rock.png",
	variance = 35,
	y = -1,
	timer = 1,
	angle = -90,
	rot_speed = 0,
	angle_variance = 0,
	lifespan = 0.15,
	birth_rate = 3,
	speed = 10,
	seed = 4,
	min_alpha = 1,
	max_alpha = 1,
	gravity = false,
	layer = LAYER_FRONT,
}

Emitter_StoneEdgeLines = Emitter:new{
	image = "effects/stoneedgeline.png",
	variance = 0,
	variance_x = 15,
	variance_y = 5,
	timer = 0.5,
	y = 0,
	angle = 0,
	rot_speed = 0,
	angle_variance = 0,
	lifespan = 0.2,
	birth_rate = 2,
	speed = 0.1,
	seed = 4,
	min_alpha = 0.3,
	max_alpha = 0.8,
	gravity = false,
	random_rot = false,
	layer = LAYER_FRONT,
}

function Poke_StoneEdge:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_StoneEdge:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	for i = -1 * self.Range, self.Range do
		local curr = p2 + DIR_VECTORS[(dir+1)%4] * i
		local pawn = Board:GetPawn(curr)
		local damage = SpaceDamage(curr, self.Damage)
		if self.StealthRocks and 
		   (not Board:IsBlocked(curr, PATH_PROJECTILE) or 
		   (pawn and Board:IsDeadly(damage, pawn) and Board:GetTerrain(curr) ~= TERRAIN_WATER and Board:GetTerrain(curr) ~= TERRAIN_HOLE)) then 
			if Board:IsTipImage() then
				damage.sItem = "Poke_StealthRock"
			else
				damage.sScript = string.format("modApi:runLater(function() Board:SetItem(%s, %q) end)", curr:GetString(), "Poke_StealthRock")
			end
		end
		ret:AddDamage(damage)
		ret:AddEmitter(curr, "Emitter_StoneEdgeLines")
		ret:AddEmitter(curr, "Emitter_StoneEdgeRocks")
	end
	return ret
end

function Poke_StoneEdge:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local direction = GetDirection(p2 - p1)
	for i = DIR_START, DIR_END do
		for j = 1, self.Range do
			ret:push_back(p2 + DIR_VECTORS[i] * j)
		end
	end
	return ret
end

function Poke_StoneEdge:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p3-p2)
	local dist = p2:Manhattan(p3)
	for i = -1 * dist, dist do
		local curr = p2 + DIR_VECTORS[dir] * i
		local pawn = Board:GetPawn(curr)
		local damage = SpaceDamage(curr, self.Damage)
		if self.StealthRocks and (not Board:IsBlocked(curr, PATH_PROJECTILE) or (pawn and Board:IsDeadly(damage, pawn))) then 
			if Board:IsTipImage() then
				damage.sItem = "Poke_StealthRock"
			else
				damage.sScript = string.format("modApi:runLater(function() Board:SetItem(%s, %q) end)", curr:GetString(), "Poke_StealthRock")
			end
		end
		ret:AddDamage(damage)
		ret:AddEmitter(curr, "Emitter_StoneEdgeLines")
		ret:AddEmitter(curr, "Emitter_StoneEdgeRocks")
	end
	return ret
end


Poke_Sandstorm=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Sandstorm.png",	
	Rarity = 3,
	Name = "Sandstorm",
	Description = "Creates sand on grounded tiles in a large area.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	
	PowerCost = 0,
	SetWeather = false,
	Range = 2,
	Upgrades = 1,
	UpgradeList = { "Set Weather" },
	UpgradeCost = { 3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2, 2),
		CustomPawn = "Poke_Larvitar",
	}
}
Poke_Sandstorm_A=Poke_Sandstorm:new{ UpgradeDescription = "For the rest of the battle, damages all Vek for 1 HP at the start of the Vek's turn.", SetWeather = true }

-- Emitter_PermaWind_1 = Emitter_Wind_0:new{ timer = -1, x = -60, y = 0, angle = 40, burst_count = 200, max_particles = 600, min_alpha = 0.3, max_alpha = 0.5, layer = LAYER_FRONT}  --right

function Poke_Sandstorm:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_Sandstorm:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	for k = 1, #targets do
		local terrain = Board:GetTerrain(targets[k])
		if terrain == TERRAIN_ROAD or terrain == TERRAIN_FOREST or terrain == TERRAIN_RUBBLE or terrain == TERRAIN_ACID or terrain == TERRAIN_FIRE or terrain == TERRAIN_ICE then
			ret:AddScript(string.format("Board:SetTerrain(%s, %s)", targets[k]:GetString(), TERRAIN_SAND))
		elseif terrain == TERRAIN_MOUNTAIN or terrain == TERRAIN_BUILDING then
			ret:AddScript(string.format("CustomAnim:add(%s, %q)", targets[k]:GetString(), "sandAnim_front"))
			ret:AddScript(string.format("CustomAnim:add(%s, %q)", targets[k]:GetString(), "sandAnim_back"))
		end
	end
	if not self.SetWeather then 
		ret:AddEmitter(Point(3,3), "Emitter_Wind_1")
	elseif not Board:IsTipImage() then
		-- if GetCurrentMission() and (not GetCurrentMission().Weather or not GetCurrentMission().Weather == "Sandstorm") then 
			-- ret:AddEmitter(Point(3,3), "Emitter_PermaWind_1") 
		-- end
		-- ret:AddScript("GetCurrentMission().Weather = \"Sandstorm\"")
		-- ret:AddScript("Board:SetWeather(0,RAIN_ACID,Point(0,0),Point(8,8),-1)")
		-- ret:AddScript("Board:SetWeather(0,RAIN_NORMAL,Point(0,0),Point(8,8),-1)")
		-- ret:AddScript("Board:SetWeather(0,RAIN_SNOW,Point(0,0),Point(8,8),-1)")
		ret:AddScript(string.format("Weathers.AddWeather(%q, %s)", "Sandstorm", 1))
	end
	return ret
end


Poke_QuickAttack=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/QuickAttack.png",	
	Rarity = 3,
	Name = "Quick Attack",
	Description = "Dash or leap at a target, then dart away.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy1 = Point(2,1),
		Enemy2 = Point(2,4),
		-- Second_Origin = Point(2,1),
		Second_Target = Point(2,3),
		Second_Click = Point(2,3),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_QuickAttack_A=Poke_QuickAttack:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_QuickAttack_B=Poke_QuickAttack:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_QuickAttack_AB=Poke_QuickAttack:new{ Damage = 3 }


function Poke_QuickAttack:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			-- if Board:GetPawn(p1+DIR_VECTORS[dir] * j) and not Board:IsBlocked(p1+DIR_VECTORS[dir] * (j-1), PATH_GROUND) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
			if not (Board:IsBlocked(p1+DIR_VECTORS[dir] * j, PATH_PROJECTILE) and Board:IsBlocked(p1+DIR_VECTORS[dir] * (j-1), PATH_PROJECTILE)) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
		end
	end
	return ret
end

function Poke_QuickAttack:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	if Board:IsBlocked(p2, PATH_PROJECTILE) then
		if p1:Manhattan(target) < p1:Manhattan(p2) then
			local move = PointList()
			move:push_back(p1)
			move:push_back(p2 - DIR_VECTORS[dir])
			ret:AddLeap(move, FULL_DELAY)
		else
			ret:AddCharge(Board:GetSimplePath(p1, p2 - DIR_VECTORS[dir]), FULL_DELAY)
		end
		ret:AddDamage(SpaceDamage(p2, self.Damage, dir))
	else
		if p1:Manhattan(target) < p1:Manhattan(p2) then
			local move = PointList()
			move:push_back(p1)
			move:push_back(p2)
			ret:AddLeap(move, FULL_DELAY)
		else
			ret:AddCharge(Board:GetSimplePath(p1, p2), FULL_DELAY)
		end
	end
	
	return ret
end

function Poke_QuickAttack:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local direction = GetDirection(p2 - p1)
	local curr = p2
	ret:push_back(p2)
	repeat
		curr = curr - DIR_VECTORS[direction]
		ret:push_back(curr)
	until (Board:IsBlocked(curr, PATH_MASSIVE) and curr ~= p1) or not Board:IsValid(curr)
	return ret
end

function Poke_QuickAttack:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	
	if not p3 or not Board:IsValid(p3) then p3 = p2 end
	
	local dir2 = GetDirection(p3-p2)
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local moveTo = p2 - DIR_VECTORS[dir]
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then moveTo = p2 end
	if p1:Manhattan(target) < p1:Manhattan(p2) then
		local move = PointList()
		move:push_back(p1)
		move:push_back(moveTo)
		ret:AddLeap(move, FULL_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, moveTo), FULL_DELAY)
	end
	if moveTo ~= p2 then ret:AddDamage(SpaceDamage(p2, self.Damage, dir)) end
	if p2 == p3 then return ret end
	if Board:IsTipImage() then return ret end
	
	ret:AddDelay(0.1)
	if Board:IsBlocked(p3, PATH_PROJECTILE) then
		if moveTo:Manhattan(p3) == 1 and p3 ~= p1 then
			ret:AddMelee(moveTo, SpaceDamage(p3, self.Damage, dir2))
		elseif p3 == p1 then --p1 looks blocked apparently
			ret:AddCharge(Board:GetSimplePath(moveTo, p3), FULL_DELAY)
		else
			ret:AddCharge(Board:GetPath(moveTo, p3 - DIR_VECTORS[dir2], TEAM_PLAYER), FULL_DELAY)
			ret:AddDamage(SpaceDamage(p3, self.Damage, dir2))
		end
	else
		ret:AddCharge(Board:GetPath(moveTo, p3, TEAM_PLAYER), NO_DELAY)
		--GetSimplePath doesn't work if charging past p1 because p1 is still blocked
	end
	return ret
end


Poke_ZippyZap=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ZippyZap.png",	
	Rarity = 3,
	Name = "Zippy Zap",
	Description = "Dash in up to 2 directions, phasing through terrain and units and damaging units. Can hit the same unit twice.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy1 = Point(2,2),
		Enemy1 = Point(2,3),
		-- Second_Origin = Point(2,1),
		Second_Target = Point(2,4),
		Second_Click = Point(2,4),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_ZippyZap_A=Poke_ZippyZap:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_ZippyZap_B=Poke_ZippyZap:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_ZippyZap_AB=Poke_ZippyZap:new{ Damage = 3 }


function Poke_ZippyZap:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			if not Board:IsBlocked(p1+DIR_VECTORS[dir] * j, PATH_GROUND) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
		end
	end
	return ret
end

function Poke_ZippyZap:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddCharge(move, NO_DELAY)
	local temp = p1 + DIR_VECTORS[dir]
	while temp ~= p2 do 
		ret:AddDamage(SpaceDamage(temp, self.Damage))
		temp = temp + DIR_VECTORS[dir]
		if temp ~= p2 then ret:AddDelay(0.06) end
	end
	return ret
end

function Poke_ZippyZap:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	-- ret:push_back(p2)
	for dir = DIR_START, DIR_END do
		for i = 1, 8 do
			local curr = p2 + DIR_VECTORS[dir] * i
			if curr == p1 or not Board:IsBlocked(curr, PATH_MASSIVE) then ret:push_back(curr) end
		end
	end
	return ret
end

function Poke_ZippyZap:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir2 = GetDirection(p3-p2)
	local dir = GetDirection(p2-p1)
	local anim = Board:GetPawn(p1):GetCustomAnim()
	local userId = Board:GetPawn(p1):GetId()
	local tilesHit = {}
	if anim == "Poke_Jolteon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Jolteon_charge_"..dir)) end
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddCharge(move, NO_DELAY)
	local temp = p1 + DIR_VECTORS[dir]
	while temp ~= p2 do
		local damage = SpaceDamage(temp, self.Damage)
		damage.sAnimation = "Lightning_Attack_"..dir
		local pawn = Board:GetPawn(temp)
		ret:AddDamage(damage)
		if pawn and pawn:GetId() ~= userId then ret:AddScript(string.format("Status.ApplyShocked(%s)", pawn:GetId())) end
		tilesHit[temp:GetString()] = true
		temp = temp + DIR_VECTORS[dir]
		if temp ~= p2 then ret:AddDelay(0.06) end
	end
	ret:AddAnimation(p2, "Lightning_Attack_"..dir)
	ret:AddDelay(0.3)
	if anim == "Poke_Jolteon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p2:GetString(), "Poke_Jolteon_charge_"..dir2)) end
	move = PointList()
	move:push_back(p2)
	move:push_back(p3)
	ret:AddCharge(move, NO_DELAY)
	ret:AddAnimation(p2, "Lightning_Attack_"..dir2)
	temp = p2 + DIR_VECTORS[dir2]
	while temp ~= p3 do 
		local damage = SpaceDamage(temp, self.Damage)
		damage.sAnimation = "Lightning_Attack_"..dir2
		if tilesHit[temp:GetString()] then damage.sImageMark = MultishotLib:getImageMark(self.Damage, 2, p3, temp) end
		local pawn = Board:GetPawn(temp)
		ret:AddDamage(damage)
		if pawn and pawn:GetId() ~= userId then ret:AddScript(string.format("Status.ApplyShocked(%s)", pawn:GetId())) end
		temp = temp + DIR_VECTORS[dir2]
		if temp ~= p3 then ret:AddDelay(0.06) end
	end
	ret:AddAnimation(p3, "Lightning_Attack_"..dir2)
	ret:AddDelay(0.3)
	if anim == "Poke_Jolteon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p3:GetString(), anim)) end
	return ret
end


Poke_BouncyBubble=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/BouncyBubble.png",	
	Rarity = 3,
	Name = "Bouncy Bubble",
	Description = "Leap to a tile, splashing adjacent tiles with water, turning fires into smoke and making puddles on empty tiles. Wets pawns. Can leap again if the target is a puddle, water, or wet. Removes fire from the user.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Water = Point(2,1),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,3),
		-- Second_Origin = Point(2,1),
		Second_Target = Point(2,4),
		Second_Click = Point(2,4),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_BouncyBubble_A=Poke_BouncyBubble:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_BouncyBubble_B=Poke_BouncyBubble:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_BouncyBubble_AB=Poke_BouncyBubble:new{ Damage = 3 }


function Poke_BouncyBubble:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			local curr = p1+DIR_VECTORS[dir] * j
			if (Board:GetPawn(curr) and Status.GetStatus(Board:GetPawn(curr):GetId(), "Wet")) or not Board:IsBlocked(curr, PATH_MASSIVE) then ret:push_back(curr) end
		end
	end
	return ret
end

function Poke_BouncyBubble:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local anim = Board:GetPawn(p1):GetCustomAnim()
	if Board:GetPawn(p1):IsFire() then
		local noFire = SpaceDamage(p1)
		noFire.iFire = EFFECT_REMOVE
		ret:AddDamage(noFire)
	end
	if anim == "Poke_Vaporeon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Vaporeon_bubble")) end
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddLeap(move, FULL_DELAY)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage)
		if Board:IsFire(curr) or (Board:GetPawn(curr) and Board:GetPawn(curr):IsFire()) then 
			damage.iSmoke = 1 
		elseif Board:GetPawn(curr) then
			ret:AddScript(string.format("modApi:runLater(function() Status.ApplyWet(%s) end)", Board:GetPawn(curr):GetId()))
		end
		if not Board:IsBlocked(curr, PATH_GROUND) then damage.sItem = "Poke_Puddle" end
		
		ret:AddSafeDamage(damage)
	end
	if anim == "Poke_Vaporeon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p2:GetString(), anim)) end
	return ret
end

function Poke_BouncyBubble:IsTwoClickException(p1, p2)
	return not (Board:GetItem(p2) == "Poke_Puddle" or (Board:GetPawn(p2) and Status.GetStatus(Board:GetPawn(p2):GetId(), "Wet")) or (Board:IsTerrain(p2, TERRAIN_WATER) and not Board:IsTerrain(p2, TERRAIN_ACID) and not Board:IsTerrain(p2, TERRAIN_LAVA)))
end

function Poke_BouncyBubble:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if Board:GetItem(p2) == "Poke_Puddle" or (Board:GetPawn(p2) and Status.GetStatus(Board:GetPawn(p2):GetId(), "Wet")) or (Board:IsTerrain(p2, TERRAIN_WATER) and not Board:IsTerrain(p2, TERRAIN_ACID) and not Board:IsTerrain(p2, TERRAIN_LAVA)) then
		for dir = DIR_START, DIR_END do
			for j = 1, 8 do
				if not Board:IsBlocked(p2+DIR_VECTORS[dir] * j, PATH_MASSIVE) then ret:push_back(p2+DIR_VECTORS[dir] * j) end
			end
		end
	end
	return ret
end

function Poke_BouncyBubble:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local anim = Board:GetPawn(p1):GetCustomAnim()
	local wetPawn = Board:GetPawn(p2)
	if anim == "Poke_Vaporeon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Vaporeon_bubble")) end
	if Board:GetPawn(p1):IsFire() then
		local noFire = SpaceDamage(p1)
		noFire.iFire = EFFECT_REMOVE
		ret:AddDamage(noFire)
	end
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddLeap(move, FULL_DELAY)
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage)
		if Board:IsFire(curr) or (Board:GetPawn(curr) and Board:GetPawn(curr):IsFire()) then 
			damage.iSmoke = 1
		elseif Board:GetPawn(curr) then
			ret:AddScript(string.format("modApi:runLater(function() Status.ApplyWet(%s) end)", Board:GetPawn(curr):GetId()))
		end
		if not Board:IsBlocked(curr, PATH_GROUND) then damage.sItem = "Poke_Puddle" end
		
		ret:AddSafeDamage(damage)
	end
	if not wetPawn then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p2:GetString(), anim))
		ret:AddAnimation(p2, "Splash")
		ret:AddDelay(0.5)
		if anim == "Poke_Vaporeon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p2:GetString(), "Poke_Vaporeon_bubble")) end
	end
	move = PointList()
	move:push_back(p2)
	move:push_back(p3)
	ret:AddLeap(move, FULL_DELAY)
	if wetPawn then ret:AddDamage(SpaceDamage(p2, self.Damage)) end
	for i = DIR_START, DIR_END do
		local curr = p3 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage)
		if Board:IsFire(curr) or (Board:GetPawn(curr) and Board:GetPawn(curr):IsFire()) then 
			damage.iSmoke = 1
		elseif Board:GetPawn(curr) then
			ret:AddScript(string.format("modApi:runLater(function() Status.ApplyWet(%s) end)", Board:GetPawn(curr):GetId()))
		end
		if not Board:IsBlocked(curr, PATH_GROUND) then damage.sItem = "Poke_Puddle" end
		
		ret:AddSafeDamage(damage)
	end
	if anim == "Poke_Vaporeon" then ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p3:GetString(), anim)) end
	return ret
end



Poke_SizzlySlide=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SizzlySlide.png",	
	Rarity = 3,
	Name = "Sizzly Slide",
	Description = "Charge at a target, setting all tiles along the way on fire. If used while on fire, heals 1 and deals 1 more damage.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy1 = Point(2,1),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_SizzlySlide_A=Poke_SizzlySlide:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3, }
Poke_SizzlySlide_B=Poke_SizzlySlide:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3, }
Poke_SizzlySlide_AB=Poke_SizzlySlide:new{ Damage = 4 }

function Poke_SizzlySlide:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, dir)
	damage.iFire = 1
	if Board:GetPawn(p1):IsFire() then 
		damage.iDamage = self.Damage + 1
		ret:AddDamage(SpaceDamage(p1, -1))
	end
	if p1:Manhattan(p2) > 1 then
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[dir]), NO_DELAY)
		local temp = p1 
		while temp ~= target - DIR_VECTORS[dir]  do 
			temp = temp + DIR_VECTORS[dir]
			local fireDamage = SpaceDamage(temp)
			fireDamage.iFire = 1
			if temp ~= target - DIR_VECTORS[dir] then ret:AddDamage(fireDamage) ret:AddDelay(0.06) end
		end
		ret:AddDamage(damage)
	else
		ret:AddMelee(p1, damage)
	end
	return ret
end





Poke_GlitzyGlow=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/GlitzyGlow.png",	
	Rarity = 3,
	Name = "Glitzy Glow",
	Description = "Deal damage to enemies and shield allies in a five tiles area.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Friendly = Point(2,2),
		Building = Point(1,1),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_GlitzyGlow_A=Poke_GlitzyGlow:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_GlitzyGlow_B=Poke_GlitzyGlow:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_GlitzyGlow_AB=Poke_GlitzyGlow:new{ Damage = 3 }

function Poke_GlitzyGlow:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

Emitter_GlitzyGlow = Emitter:new{
	image = "effects/glitzyglow.png",
	variance = 35,
	y = -1,
	timer = 1,
	angle = -45,
	rot_speed = 600,
	angle_variance = 90,
	lifespan = 0.5,
	birth_rate = 0.1,
	speed = 7,
	seed = 4,
	min_alpha = 0.3,
	max_alpha = 0.5,
	gravity = true,
	random_rot = true,
	fade_in = true,
	layer = LAYER_FRONT,
}

function Poke_GlitzyGlow:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2)
	ret:AddArtillery(p1, damage, "effects/glitzyglow.png", PROJ_DELAY)
	ret:AddEmitter(p2, "Emitter_GlitzyGlow")
	local curr = p2
	for i = DIR_START, DIR_NONE do
		damage = SpaceDamage(curr)
		if Board:GetPawn(curr) then
			if Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then damage.iDamage = self.Damage else damage.iShield = 1 end
		elseif Board:IsBuilding(curr) then
			damage.iShield = 1
		end
		ret:AddDamage(damage)
		if i ~= DIR_NONE then curr = p2 + DIR_VECTORS[i] end
	end
	
	return ret
end


Poke_BaddyBad=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/BaddyBad.png",	
	Rarity = 3,
	Name = "Baddy Bad",
	Description = "Leap to a tile, damaging adjacent tiles and reflecting queued enemy attacks targeting it.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "Friendly Immune"},
	UpgradeCost = {2, 1},
	HitFriendly = true,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy1 = Point(2,2),
		CustomPawn = "Poke_Eevee",
		CustomEnemy = "Scorpion2",
	}
}

Poke_BaddyBad_A=Poke_BaddyBad:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_BaddyBad_B=Poke_BaddyBad:new{ UpgradeDescription = "Will not damage time pods, friendly units, and buildings.", HitFriendly = false, }
Poke_BaddyBad_AB=Poke_BaddyBad:new{ Damage = 2, HitFriendly = false, }

function Poke_BaddyBad:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			if not Board:IsBlocked(p1+DIR_VECTORS[dir]*j, PATH_PROJECTILE) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
		end
	end
	return ret
end

function Reflect(point)
	ret = SkillEffect()
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_ENEMY))) do
		local pawn = Board:GetPawn(id)		
		if pawn:GetQueuedTarget() ~= Point(-1, -1) then
			local fx = _G[pawn:GetQueuedWeapon()]:GetSkillEffect(pawn:GetSpace(), pawn:GetQueuedTarget())
			for _, spaceDamage in ipairs(extract_table(fx.q_effect)) do
				if spaceDamage.loc == point then 
					local reflectDamage = SpaceDamage(pawn:GetSpace(), spaceDamage.iDamage)
					if spaceDamage:GetType() == 2 then			--projectile
						ret:AddProjectile(point, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetType() == 1 then		--artillery
						ret:AddArtillery(point, reflectDamage, spaceDamage:GetProjectileArt(), PROJ_DELAY)
					elseif spaceDamage:GetMoveType() == 3 then	--melee
						reflectDamage.sAnimation = spaceDamage.sAnimation
						ret:AddDamage(reflectDamage)
					else
						reflectDamage.sAnimation = spaceDamage.sAnimation
						ret:AddDamage(reflectDamage)
					end
					ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", id))
				end
			end
		end
	end
	Board:AddEffect(ret)
end

function Poke_BaddyBad:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	if Board:IsTipImage() then Board:GetPawn(Point(2,2)):FireWeapon(Point(2,1), 1) end
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddLeap(move, FULL_DELAY)
	
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		if self.HitFriendly or not (Board:IsPod(curr) or Board:IsBuilding(curr) or (Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER)) then
			ret:AddDamage(SpaceDamage(curr, self.Damage))
		end
	end
	ret:AddAnimation(p2, "ExploRepulse1")
	ret:AddDelay(0.1)
	ret:AddScript(string.format("Reflect(%s)",p2:GetString()))
	
	if Board:IsTipImage() then 
		-- Board:GetPawn(Point(2,2)):ClearQueued()
		local damage = SpaceDamage(Point(2,2), 3)
		damage.bHide = true
		ret:AddDamage(damage)
		ret:AddDelay(2)
	end

	return ret
end


Poke_SappySeed=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SappySeed.png",	
	Rarity = 3,
	Name = "Sappy Seed",
	Description = "Apply the Sappy Seed status to hit enemies, leeching 1 HP from them at the beginning of their turn.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy1 = Point(2,1),
		Enemy2 = Point(2,2),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_SappySeed_A=Poke_SappySeed:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_SappySeed_B=Poke_SappySeed:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_SappySeed_AB=Poke_SappySeed:new{ Damage = 3 }

function Poke_SappySeed:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_SappySeed:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2, self.Damage)
	ret:AddArtillery(damage, "effects/shotup_seedflare.png")
	local curr = p2
	if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then 
		ret:AddScript(string.format("Status.ApplyLeechSeed(%s, %s)", Board:GetPawn(curr):GetId(), Board:GetPawn(p1):GetId())) 
	end
	for i = DIR_START, DIR_END do
		curr = p2 + DIR_VECTORS[i]
		damage.loc = curr
		ret:AddDamage(damage)
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_ENEMY then 
			ret:AddScript(string.format("Status.ApplyLeechSeed(%s, %s)", Board:GetPawn(curr):GetId(), Board:GetPawn(p1):GetId())) 
		end
	end
	
	return ret
end


Poke_FreezyFrost=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FreezyFrost.png",	
	Rarity = 3,
	Name = "Freezy Frost",
	Description = "Leap to a tile, damaging and chilling adjacent enemies. Already chilled enemies are frozen instead.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,1),
		Building = Point(3,1),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_FreezyFrost_A=Poke_FreezyFrost:new{ UpgradeDescription = "Freezes hit buildings instead of damaging them.", FreezeBuildings = true, }
Poke_FreezyFrost_B=Poke_FreezyFrost:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_FreezyFrost_AB=Poke_FreezyFrost:new{ FreezeBuildings = true, Damage = 2 }

function Poke_FreezyFrost:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			if not Board:IsBlocked(p1+DIR_VECTORS[dir] * j, PATH_PROJECTILE) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
		end
	end
	return ret
end

function Poke_FreezyFrost:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddLeap(move, FULL_DELAY)
	
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage)
		local pawn = Board:GetPawn(curr)
		damage.iFire = EFFECT_REMOVE
		if pawn then
			damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s, %s) end)", pawn:GetId(), tostring(true))
		end
		if self.FreezeBuildings and Board:IsBuilding(curr) then
			damage.iDamage = 0
			damage.iFrozen = 1
		end
		ret:AddDamage(damage)
	end
	
	return ret
end


Poke_SparklySwirl=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SparklySwirl.png",	
	Rarity = 3,
	Name = "Sparkly Swirl",
	Description = "Leap to a tile, damaging adjacent enemies and pushing clockwise. Allies are healed and cured of all status.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Friendly_Damaged = Point(1,1),
		Enemy1 = Point(3,1),
		CustomPawn = "Poke_Eevee",
	}
}

Poke_SparklySwirl_A=Poke_SparklySwirl:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_SparklySwirl_B=Poke_SparklySwirl:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2, }
Poke_SparklySwirl_AB=Poke_SparklySwirl:new{ Damage = 3 }

function Poke_SparklySwirl:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			if not Board:IsBlocked(p1+DIR_VECTORS[dir] * j, PATH_PROJECTILE) then ret:push_back(p1+DIR_VECTORS[dir] * j) end
		end
	end
	return ret
end

function Poke_SparklySwirl:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddLeap(move, FULL_DELAY)
	
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local damage = SpaceDamage(curr, self.Damage, (i+1)%4)
		local pawn = Board:GetPawn(curr)
		if pawn and pawn:GetTeam() == TEAM_PLAYER then damage.iDamage = -1 * self.Damage end
		ret:AddDamage(damage)
	end
	
	return ret
end



Poke_Synchronize=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Synchronize.png",	
	Rarity = 3,
	Name = "Synchronize",
	Description = "Forces a target to gain all the status effects of another unit. That unit gains the status effects of the target. When targeting two enemies, forces the second target to aim its attack in the same direction as the first.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 8,	
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 0,		--have an upgrade where allies don't gain status effects
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,3),
		Water = Point(2,1),
		Enemy1 = Point(1,1),
		Enemy2 = Point(2,3),
		Second_Origin = Point(2,4),
		Second_Target = Point(1,1),
		Second_Click = Point(1,1),
		CustomPawn = "Poke_Ralts",
	}
}


function Poke_Synchronize:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		if Board:GetPawn(curr) then ret:push_back(curr) end
	end
	return ret
end

function Poke_Synchronize:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p2))
	return ret
end

function Poke_Synchronize:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			local curr = Point(i, j)
			if Board:GetPawn(curr) and curr ~= p2 then ret:push_back(curr) end
		end
	end
	return ret
end

function Poke_Synchronize:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local pawn1 = Board:GetPawn(p2)
	local pawn2 = Board:GetPawn(p3)
	
	--TipImages my beloathed
	if Board:IsTipImage() then 
		if not pawn1 or not pawn2 then return ret end
		pawn2:SetFrozen(true, true)
		pawn1:SetAcid(true, true)
		local freeze = SpaceDamage(p2) 
		freeze.iFrozen = 1 
		local acid = SpaceDamage(p3) 
		acid.iAcid = 1 
		ret:AddDelay(1)
		ret:AddDamage(freeze)
		ret:AddDamage(acid)
		ret:AddDelay(2)
		return ret
	end
	
	--Handle swapping statuses
	local synchro = SpaceDamage(p2)
	if pawn1:IsFire() or pawn2:IsFire() then synchro.iFire = 1 end
	if pawn1:IsAcid() or pawn2:IsAcid() then synchro.iAcid = 1 end
	if pawn1:IsFrozen() or pawn2:IsFrozen() then synchro.iFrozen = 1 end
	
	for _, status in ipairs(Status.List()) do
		if Status.GetStatus(pawn1:GetId(), status) then
			if status == "Rooted" then 
				ret:AddScript(string.format("Status[%q](%s, %s)", "ApplyRooted", pawn2:GetId(), Status.GetStatus(pawn2:GetId(), "Rooted").amount))
			elseif status == "Weaken" then 
				ret:AddScript(string.format("Status[%q](%s, %s)", "ApplyWeaken", pawn2:GetId(), tonumber(string.sub(pawn2:GetWeaponBaseType(1),1,1))))
			elseif status == "Chill" then
				ret:AddScript(string.format("Status[%q](%s)", "ApplyChill", pawn2:GetId()))
			else
				ret:AddScript(string.format("Status[%q](%s, %s)", "Apply"..status, pawn2:GetId(), tostring(Status.GetStatus(pawn2:GetId(), status))))
			end
		end
		if Status.GetStatus(pawn2:GetId(), status) then
			if status == "Rooted" then 
				ret:AddScript(string.format("Status[%q](%s, %s)", "ApplyRooted", pawn1:GetId(), Status.GetStatus(pawn1:GetId(), "Rooted").amount))
			elseif status == "Weaken" then 
				ret:AddScript(string.format("Status[%q](%s, %s)", "ApplyWeaken", pawn1:GetId(), tonumber(string.sub(pawn1:GetWeaponBaseType(1),1,1))))
			elseif status == "Chill" then
				ret:AddScript(string.format("Status[%q](%s)", "ApplyChill", pawn1:GetId()))
			else
				ret:AddScript(string.format("Status[%q](%s, %s)", "Apply"..status, pawn1:GetId(), tostring(Status.GetStatus(pawn1:GetId(), status))))
			end
		end
	end
	ret:AddSafeDamage(synchro)
	synchro.loc = p3
	ret:AddSafeDamage(synchro)
	
	--Swap attack directions
	if pawn1:GetQueuedTarget() ~= Point(-1, -1) and pawn2:GetQueuedTarget() ~= Point(-1, -1) then
		local dir1, dir2, dist1, dist2
		if pawn1:GetQueuedTarget() ~= p2 then 
			dir1 = GetDirection(pawn1:GetQueuedTarget() - p2) 
			dist1 = (pawn1:GetQueuedTarget()):Manhattan(p2)
		end
		if pawn2:GetQueuedTarget() ~= p3 then 
			dir2 = GetDirection(pawn2:GetQueuedTarget() - p3) 
			dist2 = (pawn2:GetQueuedTarget()):Manhattan(p3)
		end
		if dir1 and dir2 then
			local deleteWebs = SpaceDamage(p2, 0, DIR_FLIP)
			deleteWebs.bHide = true
			ret:AddDamage(deleteWebs)
			deleteWebs.loc = p3
			ret:AddDamage(deleteWebs)
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn1:GetId()))
			ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn2:GetId()))
			local target1 = p2 + DIR_VECTORS[dir2] * dist1
			local target2 = p3 + DIR_VECTORS[dir1] * dist2
			
			local arrows = {"arrow_off_up.png", "arrow_off_right.png", "arrow_off_down.png", "arrow_off_left.png",}
			synchro.sImageMark = "combat/"..arrows[dir2+1]
			synchro.loc = p2
			ret:AddDamage(synchro)
			synchro.loc = p3
			synchro.sImageMark = "combat/"..arrows[dir1+1]
			ret:AddDamage(synchro)
			
			ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, %s)", pawn1:GetId(), target1:GetString(), pawn1:GetQueuedWeaponId()))
			ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, %s)", pawn2:GetId(), target2:GetString(), pawn2:GetQueuedWeaponId()))
			if not Board:IsValid(target1) then ret:AddScript(string.format("Board:AddAlert(%s, %q)", p2:GetString(), "Attack Cancelled")) end
			if not Board:IsValid(target2) then ret:AddScript(string.format("Board:AddAlert(%s, %q)", p3:GetString(), "Attack Cancelled")) end
		end
	else
		local deleteWebs = SpaceDamage(p2, 0, DIR_FLIP)
		deleteWebs.bHide = true
		ret:AddDamage(deleteWebs)
		deleteWebs.loc = p3
		ret:AddDamage(deleteWebs)
		ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn1:GetId()))
		ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn2:GetId()))
	end
	return ret
end


Poke_FutureSight = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FutureSight.png",	
	Rarity = 3,
	Name = "Future Sight",
	Description = "Conjure doom at a location, striking it at the start of the enemy turn. Can foretell the Vek that will spawn from a targeted location. If this would hit a tile from which a Vek will spawn, will instead damage the Vek as it spawns.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Ralts",
	}
}
Poke_FutureSight_A=Poke_FutureSight:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_FutureSight_B=Poke_FutureSight:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_FutureSight_AB=Poke_FutureSight:new{ Damage = 4 }

function Poke_FutureSight:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end

function Poke_FutureSight:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage, DIR_FLIP)
	local amount = self.Damage
	if Board:GetPawn(p1) and Board:GetPawn(p1):IsBoosted() then amount = amount + 1 end
	if Board:IsSpawning(p2) then 
		damage = SpaceDamage(p2, DAMAGE_ZERO)
		damage.sItem = "Poke_FutureSightItem"..math.min(amount,5)
		damage.sAnimation = "" 
	end
	damage.sAnimation = "confusionAnim"
	ret:AddQueuedScript(string.format("Board:Ping(%s, GL_Color(255, 0, 255))", p1:GetString()))
	ret:AddQueuedDamage(damage)
	for i = DIR_START, DIR_END do
		if Board:IsSpawning(p2 + DIR_VECTORS[i]) then 
			damage = SpaceDamage(p2 + DIR_VECTORS[i], DAMAGE_ZERO)
			damage.sItem = "Poke_FutureSightItem"..math.min(amount,5)
			damage.sAnimation = "" 
		else 
			damage = SpaceDamage(p2 + DIR_VECTORS[i], self.Damage, DIR_FLIP)
			damage.sAnimation = "confusionAnim" 
		end
		ret:AddQueuedDamage(damage)
	end
	if GetCurrentMission() then
		local spawnData = GetCurrentMission():GetSpawnPointData(p2)
		if Board:IsSpawning(p2) and spawnData and (Pawn:GetWeaponBaseType(1) == "Poke_FutureSight" or Pawn:GetWeaponBaseType(2) == "Poke_FutureSight") then
		--this is because the game recalculates this queued skill effect whenever something changes so the alert keeps popping up otherwise
			Board:AddAlert(p2, _G[spawnData.type].Name) 
		end
	end
	return ret
end


Poke_PsychoCut = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PsychoCut.png",	
	Rarity = 3,
	Name = "Psycho Cut",
	Description = "Slash a location with powerful psychic energy.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Ralts",
	}
}
Poke_PsychoCut_A=Poke_PsychoCut:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_PsychoCut_B=Poke_PsychoCut:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_PsychoCut_AB=Poke_PsychoCut:new{ Damage = 4 }

function Poke_PsychoCut:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage + 1, direction)
	damage.sAnimation = "psychocut_"..direction
	ret:AddDamage(damage)
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+1)%4], self.Damage, direction))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+3)%4], self.Damage, direction))
	return ret
end


Poke_FuryCutter = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FuryCutter.png",	
	Rarity = 3,
	Name = "Fury Cutter",
	Description = "Slash a target twice. If the first hit would kill, the second hit may target a different tile.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Hemorrhage", "+1 Damage" },
	UpgradeCost = { 1, 3 },
	TwoClick = true,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,3),
		Enemy = Point(2,3),
		CustomPawn = "Poke_Scyther",
	}
}
Poke_FuryCutter_A=Poke_FuryCutter:new{ UpgradeDescription = "When an enemy would be healed, it takes damage instead. Removed when set on fire.", Hemorrhage = true }
Poke_FuryCutter_B=Poke_FuryCutter:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_FuryCutter_AB=Poke_FuryCutter:new{ Hemorrhage = true, Damage = 2 }

function Poke_FuryCutter:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	local damagePerHit = self.Damage
	if Board:GetPawn(p1):IsBoosted() then damagePerHit = damagePerHit+1 end
	if Board:GetPawn(p2) and not Board:IsDeadly(SpaceDamage(p2, damagePerHit), Board:GetPawn(p2)) then return ret end 
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if curr ~= p2 then ret:push_back(curr) end
	end
	return ret
end

function Poke_FuryCutter:IsTwoClickException(p1, p2)
	local damagePerHit = self.Damage
	if Board:GetPawn(p1):IsBoosted() then damagePerHit = damagePerHit+1 end
	if not Board:GetPawn(p2) then return false end
	LOG(damagePerHit, Board:GetPawn(p2):GetHealth(), Board:IsDeadly(SpaceDamage(p2, damagePerHit), Board:GetPawn(p1)))
	return not Board:IsDeadly(SpaceDamage(p2, damagePerHit), Board:GetPawn(p1))
end
	
function Poke_FuryCutter:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damagePerHit = self.Damage
	if Board:GetPawn(p1):IsBoosted() then damagePerHit = damagePerHit+1 end
	local damage = SpaceDamage(p2, self.Damage)
	
	-- if Board:GetPawn(p2) and not Board:IsDeadly(SpaceDamage(p2, damagePerHit), Board:GetPawn(p2)) then
		damage.sImageMark = MultishotLib:getImageMark(self.Damage, 2, p1, p2) 
	-- end
	damage.sSound = "/weapons/sword"
	ret:AddAnimation(p2, "Swipe2Claw1", ANIM_NO_DELAY)
	ret:AddMelee(p1, damage)
	if Board:GetPawn(p2) and self.Hemorrhage then damage.sScript = string.format("Status.ApplyHemorrhage(%s)", Board:GetPawn(p2):GetId()) end
	ret:AddMelee(p1, damage)
	return ret
end

function Poke_FuryCutter:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sSound = "/weapons/sword"
	damage.sAnimation = "SwipeClaw1"
	if Board:GetPawn(p2) and self.Hemorrhage then damage.sScript = string.format("Status.ApplyHemorrhage(%s)", Board:GetPawn(p2):GetId()) end
	ret:AddMelee(p1, damage)
	damage.loc = p3
	if Board:GetPawn(p3) and self.Hemorrhage then damage.sScript = string.format("Status.ApplyHemorrhage(%s)", Board:GetPawn(p3):GetId()) end
	ret:AddMelee(p1, damage)
	return ret
end


Poke_XScissor = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/XScissor.png",	
	Rarity = 3,
	Name = "X-Scissor",
	Description = "Strikes tiles in a cross shape.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Hemorrhage", "+1 Damage" },
	UpgradeCost = { 1, 2 },
	LaunchSound = "/weapons/sword",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,3),
		Enemy = Point(2,3),
		CustomPawn = "Poke_Scyther",
	}
}

Poke_XScissor_A=Poke_XScissor:new{ UpgradeDescription = "When an enemy would be healed, it takes damage instead. Removed when set on fire.", Hemorrhage = true }
Poke_XScissor_B=Poke_XScissor:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_XScissor_AB=Poke_XScissor:new{ Damage = 3, Hemorrhage = true }

function Poke_XScissor:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "SwipeClaw2"
	if Board:GetPawn(p2) and self.Hemorrhage then damage.sScript = string.format("Status.ApplyHemorrhage(%s)", Board:GetPawn(p2):GetId()) end
	ret:AddMelee(p1, damage)
	for i = DIR_START, DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4], self.Damage)
		damage.sAnimation = "SwipeClaw2"
		ret:AddDamage(damage)
		if Board:GetPawn(p2) and self.Hemorrhage then ret:AddScript(string.format("Status.ApplyHemorrhage(%s)", Board:GetPawn(p2):GetId())) end
	end
	return ret
end


Poke_BulletPunch = Skill:new{
	Self = "Poke_BulletPunch",
	Class = "TechnoVek",
	Icon = "weapons/BulletPunch.png",	
	Rarity = 3,
	Name = "BulletPunch",
	Description = "Damages and pushes a ranged target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Shot" },
	UpgradeCost = { 2, 3 },
	Shots = 1,
	LaunchSound = "/weapons/phase_shot",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "Poke_Scyther",
	}
}
Poke_BulletPunch_A=Poke_BulletPunch:new{ Self = "Poke_BulletPunch_A",UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_BulletPunch_B=Poke_BulletPunch:new{ Self = "Poke_BulletPunch_B",UpgradeDescription = "Fires a second projectile after the first.", Shots = 2 }
Poke_BulletPunch_AB=Poke_BulletPunch:new{ Self = "Poke_BulletPunch_AB",Damage = 2, Shots = 2 }

function Poke_BulletPunch:GetSkillEffect(p1,p2,remainingShots)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, dir)
	if remainingShots == nil then remainingShots = self.Shots end
	if remainingShots > 1 then damage.sImageMark = MultishotLib:getImageMark(self.Damage, remainingShots, p1, target) end
	ret:AddSound(self.LaunchSound)
	ret:AddProjectile(p1, damage, "effects/bulletpunch", PROJ_DELAY)
	if remainingShots > 1 then
		remainingShots = remainingShots - 1
		ret:AddScript(string.format([=[
			local fx = SkillEffect();
			fx:AddScript([[
				Board:AddEffect(_G[%q]:GetSkillEffect(%s, %s, %s));
			]]);
			Board:AddEffect(fx);
		]=], self.Self, p1:GetString(), p2:GetString(), remainingShots))
	end
	return ret
end




Poke_StoneAxe=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/StoneAxe.png",	
	Rarity = 3,
	Name = "Stone Axe",
	Description = "Throw a stone axe at a target. Creates Stealth Rocks at the location if deadly or empty.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "+1 Damage"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		CustomPawn = "Poke_Scyther",
	}
}

Poke_StoneAxe_A=Poke_StoneAxe:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3, }
Poke_StoneAxe_B=Poke_StoneAxe:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 3, }
Poke_StoneAxe_AB=Poke_StoneAxe:new{ Damage = 4 }

function Poke_StoneAxe:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_StoneAxe:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2, self.Damage)
	if Board:IsTipImage() then damage.sItem = "Poke_StealthRock" end
	ret:AddArtillery(p1, damage, "effects/stoneaxe.png", FULL_DELAY)
	
	if not Board:IsTipImage() then
		if Board:GetPawn(p2) and Board:IsDeadly(damage, Board:GetPawn(p2)) then
			ret:AddDelay(1)
			ret:AddScript(string.format("modApi:runLater(function() Board:SetItem(%s, %q) end)", p2:GetString(), "Poke_StealthRock"))
		elseif not Board:IsBlocked(p2, PATH_PROJECTILE) then 
			ret:AddScript(string.format("modApi:runLater(function() Board:SetItem(%s, %q) end)", p2:GetString(), "Poke_StealthRock"))
		end
	end
	return ret
end


Poke_SacredSword=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/SacredSword.png",	
	Rarity = 3,
	Name = "Sacred Sword",
	Description = "Drains the health of the user and its adjacent allies to 1, then unleash a wave of energy that pierces through units, dealing damage increased by the total health drained. The amount dealt is reduced by the health of units pierced by the shockwave.",
	Push = 1,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 0,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Friendly1 = Point(1,4),
		Friendly2 = Point(3,4),
		Enemy1 = Point(2,3),
		Enemy1 = Point(2,2),
		Enemy1 = Point(2,1),
		Enemy1 = Point(2,0),
		Target = Point(2,1),
		CustomPawn = "Poke_Ralts",
	}
}

function Poke_SacredSword:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

Emitter_SacredSword = Emitter:new{
	image = "effects/sacredsword.png",
	variance = 0,
	variance_x = 15,
	variance_y = 5,
	timer = 0.5,
	x = -5,
	angle = -90,
	rot_speed = 0,
	angle_variance = 0,
	lifespan = 0.5,
	birth_rate = 20,
	speed = 15,
	seed = 4,
	min_alpha = 0.3,
	max_alpha = 0.8,
	gravity = true,
	random_rot = false,
	layer = LAYER_FRONT,
}

function Poke_SacredSword:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local damageAmount = self.Damage
	local pawn = Board:GetPawn(p1)
	local amount = pawn:GetHealth() - 1
	if pawn:IsAcid() then amount = math.floor(amount/2) end
	damageAmount = damageAmount + amount
	if pawn:IsArmor() and not pawn:IsAcid() then amount = amount + 1 end
	ret:AddSafeDamage(SpaceDamage(p1, amount))
	for i = DIR_START, DIR_END do
		local pawn = Board:GetPawn(p1 + DIR_VECTORS[i])
		if pawn and pawn:IsMech() then
			local amount = pawn:GetHealth() - 1
			if pawn:IsAcid() then amount = math.floor(amount/2) end
			damageAmount = damageAmount + amount
			if pawn:IsArmor() and not pawn:IsAcid() then amount = amount + 1 end
			ret:AddSafeDamage(SpaceDamage(p1 + DIR_VECTORS[i], amount))
		end
	end
	ret:AddAnimation(p1, "sacredswordanim_"..dir)
	for i = 1, 7 do
		local curr = p1 + DIR_VECTORS[dir] * i
		ret:AddEmitter(curr, "Emitter_SacredSword")
		ret:AddBounce(curr, math.floor(damageAmount / 2))
		local pawn = Board:GetPawn(curr)
		local damageDealt = 0
		if pawn then
			damageDealt = pawn:GetHealth()
			if pawn:IsAcid() then
				damageDealt = math.floor(damageDealt / 2)
			elseif pawn:IsArmor() then
				damageDealt = damageDealt + 1
			end
		end
		ret:AddDamage(SpaceDamage(curr, damageAmount))
		damageAmount = damageAmount - damageDealt
		curr = curr + DIR_VECTORS[dir]
		if damageAmount <= 0 or Board:GetTerrain(curr) == TERRAIN_BUILDING or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or not Board:IsValid(curr) then break end
		ret:AddDelay(0.07)
	end
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_SacredSword" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_LightOfRuin=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/LightOfRuin.png",	
	Rarity = 3,
	Name = "Light of Ruin",
	Description = "Obliterates everything in a massive area.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = {"+1 Damage", "Stealth Rocks"},
	UpgradeCost = {2, 2},
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,1),
		Enemy1 = Point(1, 1),
		Enemy2 = Point(3, 1),
		Building1 = Point(2,3),
		Building1 = Point(2,0),
		CustomPawn = "Poke_Ralts",
	}
}

function Poke_LightOfRuin:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end

function Poke_LightOfRuin:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, 5)
	ret:AddDropper(damage, "effects/lightofruin.png")
	ret:AddDelay(-1)
	ret:AddBounce(p2, 20)
	
	for i = DIR_START, DIR_END do
		ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[i], 4))
		ret:AddBounce(p2 + DIR_VECTORS[i], 16)
	end
	ret:AddDelay(0.1)
	for i = DIR_START, DIR_END do
		ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4], 3))
		ret:AddBounce(p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4], 12)
	end
	ret:AddDelay(0.1)
	for i = DIR_START, DIR_END do
		ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[i] * 2, 2))
		ret:AddBounce(p2 + DIR_VECTORS[i] * 2, 8)
	end
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_LightOfRuin" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_VanishingStrikes = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/VanishingStrikes.png",
	Description = "Teleports behind every enemy on the board to strike them.",
	Name = "Vanishing Strikes",
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 0,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_VanishingStrikes:GetTargetZone(piOrigin, p)
	local targets = self:GetTargetArea()
	local ret = PointList()
	for i = 1, targets:size() do
		if p == targets:index(i) then
			local start_index = math.floor((i-1) / 4)*4 + 1
			--LOG("Found target. Index = "..i.." Group index starts at "..start_index.."\n")
			for j = start_index, start_index + 3 do
				ret:push_back(targets:index(j))
			end
			return ret
		end
	end
	return ret
end

function Poke_VanishingStrikes:GetTargetArea(point)

	local ret = PointList()
	
	ret:push_back(Point(1,3))
	ret:push_back(Point(1,4))
	ret:push_back(Point(2,3))
	ret:push_back(Point(2,4))
	
	ret:push_back(Point(5,3))
	ret:push_back(Point(5,4))
	ret:push_back(Point(6,3))
	ret:push_back(Point(6,4))
	
	ret:push_back(Point(3,1))
	ret:push_back(Point(3,2))
	ret:push_back(Point(4,1))
	ret:push_back(Point(4,2))
	
	ret:push_back(Point(3,5))
	ret:push_back(Point(3,6))
	ret:push_back(Point(4,5))
	ret:push_back(Point(4,6))
	
	return ret
end
	
function Poke_VanishingStrikes:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = DIR_NONE
	
	if p2.x == 1 or p2.x == 2 then dir = DIR_LEFT
	elseif p2.x == 5 or p2.x == 6 then dir = DIR_RIGHT
	elseif p2.y == 1 or p2.y == 2 then dir = DIR_UP
	elseif p2.y == 5 or p2.y == 6 then dir = DIR_DOWN end
	
	local user = Board:GetPawn(p1)
	
	for i = 0, 7 do
		for j = 0, 7  do
			local point = Point(j,i) -- DIR_LEFT
			if dir == DIR_RIGHT then
				point = Point(7 - j, i)
			elseif dir == DIR_UP then
				point = Point(i,j)
			elseif dir == DIR_DOWN then
				point = Point(i,7-j)
			end
			
			if Board:IsPawnSpace(point) and Board:GetPawn(point):GetTeam() == TEAM_ENEMY then
				ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), Point(point - DIR_VECTORS[dir]):GetString()))
				local damage = SpaceDamage(point, self.Damage, dir)
				damage.sAnimation = "explopunch1_"..dir
				ret:AddMelee(point - DIR_VECTORS[dir], damage)
			end
		end
	end
	ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), p1:GetString()))
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_VanishingStrikes" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_ShatteredPsyche = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ShatteredPsyche.png",
	Description = "Forces every enemy on the board to queue their attacks at the worst possible target.",
	Name = "Shattered Psyche",
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 0,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_ShatteredPsyche:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Skill:GetTargetScoreShatteredPsyche(p1, p2)
	local skillEffect = self:GetSkillEffect(p1,p2)
	local queued_score = self:ScoreListShatteredPsyche(skillEffect.q_effect,true,p1)
	local instant_score = self:ScoreListShatteredPsyche(skillEffect.effect,false,p1)
	if instant_score < -20 then return -100 end
	if skillEffect.q_effect:empty() then return instant_score end
	return queued_score
end

function Skill:ScoreListShatteredPsyche(list, queued, p1)
	local score = 0
	local posScore = 0
	local pawn = Board:GetPawn(p1)
	for i = 1, list:size() do
		local spaceDamage = list:index(i)
		local target = spaceDamage.loc
		local damage = spaceDamage.iDamage 
		local moving = spaceDamage:IsMovement() and spaceDamage:MoveStart() == pawn:GetSpace()
		
		if Board:IsValid(target) or moving then	
			if spaceDamage:IsMovement() then
				posScore = posScore + ScorePositioning(spaceDamage:MoveEnd(), pawn)
			elseif Board:IsPawnSpace(target) and Board:GetPawn(target):IsNonGridStructure() then
				score = score + self.ScoreBuilding
			elseif Board:GetPawnTeam(target) == pawn:GetTeam() and damage > 0 then
				if Board:IsFrozen(target) and not Board:IsTargeted(target) then
					score = score + self.ScoreEnemy
				else
					score = score + self.ScoreFriendlyDamage
				end
			elseif isEnemy(Board:GetPawnTeam(target),pawn:GetTeam()) then
				if Board:GetPawn(target):IsDead() or Board:GetPawn(target):IsTempUnit() then 
					score = self.ScoreNothing
				else
					score = score + self.ScoreEnemy
				end
			elseif Board:IsBuilding(target) and Board:IsPowered(target) and damage > 0 then
				score = score + self.ScoreBuilding
			elseif Board:IsPod(target) and not queued and (damage > 0 or spaceDamage.sPawn ~= "") then
				return 100	--flipped it so they wouldn't hit the pod
			else
				score = score + self.ScoreNothing
			end
		end
	end
	
	--if position is REALLY BAD don't do this (blocking friends, dying, etc.)
	if posScore < -5 then	
		return posScore 
	end
	
	return score
end
	
function Poke_ShatteredPsyche:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local enemies = Board:GetPawns(TEAM_ENEMY)
	for _, id in ipairs(extract_table(enemies)) do
		local worstTarget
		local worstScore = 100
		local pawn = Board:GetPawn(id)
		local pos = pawn:GetSpace()
		local weaponType = pawn:GetQueuedWeapon() or ""
		if pawn and pawn:GetQueuedTarget() ~= Point(-1, -1) and pawn:GetQueuedTarget() ~= pos then
			for _, p2 in ipairs(extract_table(_G[weaponType]:GetTargetArea(pos))) do
				local score = _G[weaponType]:GetTargetScoreShatteredPsyche(pos, p2)
				--had to tweak vanilla GetTargetScore function because it was using Mewtwo as the skill's user when checking for friendly damage
				--ie. hitting mechs was "bad" because they are allies, so enemies would retarged mechs
				if score < worstScore then 
					worstScore = score
					worstTarget = p2
				end
			end
			local preview = SpaceDamage(pos)
			local dir = GetDirection(worstTarget - pos)
			local arrows = {"arrow_off_up.png", "arrow_off_right.png", "arrow_off_down.png", "arrow_off_left.png",}
			preview.sImageMark = "combat/"..arrows[dir+1]
			ret:AddDamage(preview)
			ret:AddScript(string.format("Board:GetPawn(%s):FireWeapon(%s, %s)", id, worstTarget:GetString(), pawn:GetQueuedWeaponId()))
		end
	end
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_ShatteredPsyche" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	if Board:IsTipImage() then ret:AddDelay(2) end
	return ret
end


Poke_MindOverMatter = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MindOverMatter.png",
	Description = "Swaps two terrains anywhere on the board, except buildings.",
	Name = "Mind over Matter",
	Damage = 0,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 0,
	TwoClick = true,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_MindOverMatter:GetTargetArea(point)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			if not Board:IsBuilding(Point(i, j)) then ret:push_back(Point(i,j)) end
		end
	end
	return ret
end

function Poke_MindOverMatter:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			if not (Board:IsBuilding(Point(i, j)) or Point(i,j)==p1 or Board:GetTerrain(Point(i,j)) == Board:GetTerrain(p2)) then ret:push_back(Point(i,j)) end
		end
	end
	return ret
end
	
function Poke_MindOverMatter:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p2, 0))
	return ret
end

function Poke_MindOverMatter:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local terrain1 = Board:GetTerrain(p2)
	local terrain2 = Board:GetTerrain(p3)
	local damage1 = SpaceDamage(p2)
	local damage2 = SpaceDamage(p3)
	damage1.iTerrain = terrain2
	damage2.iTerrain = terrain1
	damage1.sAnimation = "UnitRift"
	damage2.sAnimation = "UnitRift"
	damage1.sImageMark = "advanced/combat/icons/icon_teleport_glow.png"
	damage2.sImageMark = "combat/rift.png"
	if terrain1 == TERRAIN_MOUNTAIN then damage2.iDamage = DAMAGE_DEATH end
	if terrain2 == TERRAIN_MOUNTAIN then damage1.iDamage = DAMAGE_DEATH end
	ret:AddDamage(damage1)
	ret:AddDamage(damage2)
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_MindOverMatter" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_DracoMeteor = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/DracoMeteor.png",
	Description = "Summons a comet from the sky onto a target. The comet remains and boosts dragons every turn.",
	Name = "Draco Meteor",
	Damage = DAMAGE_DEATH,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_DracoMeteor:GetTargetArea(point)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			ret:push_back(Point(i,j))
		end
	end
	return ret
end
	
function Poke_DracoMeteor:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sPawn = "Poke_DracoMeteorRock"
	ret:AddDropper(damage, "effects/DracoMeteor.png")
	ret:AddScript("Board:AddShake(0.5)")
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_DracoMeteor" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_DracoMeteorRock = Pawn:new{
	Name = "Draco Meteor",
	Health = 3,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	IsPortrait = false,
	Image = "Poke_DracoMeteor",
	ImageOffset = 1,
	SoundLocation = "/support/rock/",
	SkillList = { "Poke_DracoMeteor_Boost" },
	DefaultTeam = TEAM_NONE,
	ImpactMaterial = IMPACT_ROCK,
}
AddPawn("Poke_DracoMeteorRock") 

Poke_DracoMeteor_Boost = SelfTarget:new{  
	Name = "Draconic Aura",
	Class = "TechnoVek",
	Icon = "weapons/DracoMeteor.png",
	Description = "Boosts all dragons on the board.",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,3),
		Enemy2 = Point(1,2),
		Enemy3 = Point(3,2),
		Target = Point(2,1),
		CustomPawn = "Poke_DracoMeteorRock",
		CustomEnemy = "Firefly1",
	},
}

function Poke_DracoMeteor_Boost:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for i = 0,7 do
		for j = 0,7 do
			local pawn = Board:GetPawn(Point(i,j))
			if pawn and _G[pawn:GetType()].IsDragon then ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)",pawn:GetId())) end
		end
	end
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_DracoMeteor" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_DragonBreath = LineArtillery:new{
	Class = "TechnoVek",
	Icon = "weapons/DragonRage.png",	
	Rarity = 3,
	Name = "Dragon Rage",
	Description = "Throw a damaging projectile.",
	TwoClick=true,
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "Poke_Dialga",
	}
}
Poke_DragonBreath_A=Poke_DragonBreath:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonBreath_B=Poke_DragonBreath:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_DragonBreath_AB=Poke_DragonBreath:new{ Damage = 3 }

function Poke_DragonBreath:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	for i = DIR_START, DIR_END do
		ret:push_back(p2 + DIR_VECTORS[i])
	end
	ret:push_back(p2)
	return ret
end

function Poke_DragonBreath:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploArt1"
	ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", PROJ_DELAY)
	return ret
end

function Poke_DragonBreath:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	
	damage.sAnimation = "ExploArt1"
	
	if p2 ~= p3 then
		local dir2 = GetDirection(p3 - p2)
		damage.loc = p2 + DIR_VECTORS[dir2]
		ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", NO_DELAY)
		damage.loc = p2 - DIR_VECTORS[dir2]
		ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", NO_DELAY)
	else
		damage.iDamage = damage.iDamage + 1
	end
	damage.loc = p2
	ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", PROJ_DELAY)
	return ret
end

Poke_FlashCannon = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/FlashCannon.png",
	Description = "Strikes a distant target with a bright flash of blinding light.",
	Name = "Flash Cannon",
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	-- Upgrades = 2,
	-- make blind AoE
	-- +damage
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
		CustomPawn = "Poke_Dialga",
	}
}

function Poke_FlashCannon:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
		end
	end
	return ret
end
	
function Poke_FlashCannon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, dir)
	ret:AddSound(self.LaunchSound)
	ret:AddProjectile(p1, damage, "effects/flashcannon", PROJ_DELAY)
	ret:AddAnimation(target, "evolutionAnim")
	if Board:GetPawn(target) then ret:AddScript(string.format("Status.ApplyBlind(%s, 2)", Board:GetPawn(target):GetId())) end
	return ret
end


Poke_RoarOfTime = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/RoarOfTime.png",	
	Rarity = 3,
	Name = "Roar of Time",
	Description = "Damages all other tiles, except buildings and allies. Closer tiles take more damage. The user spends a turn recovering.",
	Push = 1,--TOOLTIP HELPER
	Damage = 5,
	PathSize = 8,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 5),
		Enemy3 = Point(0, 2),
		Building = Point(2,1),
		CustomPawn = "Poke_Dialga",
	}
}

function Poke_RoarOfTime:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Poke_RoarOfTime:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if not Board:GetPawn(p1) then return ret end
	ret:AddAnimation(p1, "roaroftimeAnim")
	ret:AddDelay(2)
	for i = 1, 14 do
		local targets = extract_table(general_DiamondTarget(p1, i))
		for k = 1, #targets do
			if p1:Manhattan(targets[k]) == i then
				if (not Board:IsBlocked(targets[k], PATH_PROJECTILE)) or (Board:GetPawn(targets[k]) and Board:GetPawn(targets[k]):IsEnemy()) then ret:AddDamage(SpaceDamage(targets[k], math.max(self.Damage - i + 1, 1))) end
				ret:AddBounce(targets[k], math.max(10-i, 1))
			end
		end
		ret:AddDelay(0.05)
	end
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_RoarOfTime" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		local image = _G[user:GetType()].Image
		if _G[user:GetType()].EvoGraphics ~= nil then image = _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2] end
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), image))
	end	
	ret:AddScript(string.format("Status.ApplySleep(%s, 1)", Board:GetPawn(p1):GetId()))
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_Warpstrike = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Warpstrike.png",
	Description = "Swaps two adjacent tiles, including units, terrain, and spawns. Strikes units before teleporting them.",
	Name = "Warpstrike",
	Damage = 1,
	Range = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+1 Damage" },
	UpgradeCost = { 1,2 },
	TwoClick = true,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}
Poke_Warpstrike_A=Poke_Warpstrike:new{ UpgradeDescription = "Increases range by 1.", Range = 3 }
Poke_Warpstrike_B=Poke_Warpstrike:new{ UpgradeDescription = "Increases damage by 1.", Damage = 2 }
Poke_Warpstrike_AB=Poke_Warpstrike:new{ Range=3, Damage = 2 }

function Poke_Warpstrike:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = p1+DIR_VECTORS[dir]
		local pawn = Board:GetPawn(curr)
		if not (Board:IsBuilding(curr) or (pawn and pawn:IsGuarding())) then ret:push_back(curr) end
	end
	return ret
end

function Poke_Warpstrike:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	for k = 1, #targets do
		local pawn = Board:GetPawn(targets[k])
		if not (Board:IsBuilding(targets[k]) or (pawn and pawn:IsGuarding()) or (Board:IsSpawning(targets[k]) and Board:IsSpawning(p2))) then ret:push_back(targets[k]) end
	end
	return ret
end
	
function Poke_Warpstrike:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p2, 0))
	return ret
end

function Poke_Warpstrike:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local terrain1 = Board:GetTerrain(p2)
	local terrain2 = Board:GetTerrain(p3)
	local damage1 = SpaceDamage(p2)
	local damage2 = SpaceDamage(p3)
	local pawn1 = Board:GetPawn(p2)
	local pawn2 = Board:GetPawn(p3)
	local dir = GetDirection(p2 - p1)
	damage1.iTerrain = terrain2
	damage2.iTerrain = terrain1
	damage1.sAnimation = "UnitRift"
	damage2.sAnimation = "UnitRift"
	damage1.sImageMark = "combat/rift.png"
	damage2.sImageMark = "combat/rift.png"
	if pawn1 then
		damage1.iDamage = self.Damage
		ret:AddAnimation(p2, "sacredswordanim_"..dir, 1)
	end
	ret:AddDamage(damage1)
	ret:AddDamage(damage2)
	local delay = Board:IsBlocked(p2, PATH_PROJECTILE) and 0 or FULL_DELAY
	ret:AddTeleport(p2,p3, delay)
	if Board:IsSpawning(p2) then
		ret:AddScript(string.format("GetCurrentMission():MoveSpawnPoint(%s, %s)", p2:GetString(), p3:GetString()))
	end
	if Board:IsSpawning(p3) then
		ret:AddScript(string.format("GetCurrentMission():MoveSpawnPoint(%s, %s)", p3:GetString(), p2:GetString()))
	end
	if pawn2 then
		ret:AddTeleport(p3,p2, FULL_DELAY)
	end
	return ret
end


Poke_SpatialRift = LaserDefault:new{
	Class = "TechnoVek",
	Icon = "weapons/SpatialRift.png",
	Name = "Spatial Rift",
	Description = "Cast a devastating beam of energy, swapping the terrain of the first and tiles hit. Completely exhausts the user; they must spend one turn asleep to recuperate.",
	Rarity = 4,
	Explosion = "",
	LaunchSound = "/props/final_bomb_explode",
	Damage = 3,
	PowerCost = 0, --AE Change
	MinDamage = 3,
	FriendlyDamage = true,
	ZoneTargeting = ZONE_DIR,
	LaserArt = "effects/laser_SpatialRift",
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
		CustomPawn = "Poke_Palkia",
	}
}

function Poke_SpatialRift:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		if Board:GetTerrain(p1+DIR_VECTORS[dir]) ~= TERRAIN_BUILDING then
			for j = 1, 8 do
				if Board:GetTerrain(p1+DIR_VECTORS[dir] * j) ~= TERRAIN_BUILDING then
					ret:push_back(p1+DIR_VECTORS[dir] * j)
				end
			end
		end
	end
	return ret
end
	
function Poke_SpatialRift:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	ret:AddAnimation(p1, "spatialriftAnim")
	ret:AddDelay(1)
	ret:AddScript("Board:StartShake(2)")
	self:AddLaser(ret, target, direction)
	local swap1 = SpaceDamage(p2)
	local swap2 = SpaceDamage(p1 + DIR_VECTORS[direction])
	swap1.terrain = Board:GetTerrain(p1 + DIR_VECTORS[direction])
	swap2.terrain = Board:GetTerrain(p2)
	ret:AddDamage(swap1)
	ret:AddDamage(swap2)
	ret:AddDelay(1)
	
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_SpatialRift" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		local image = _G[user:GetType()].Image
		if _G[user:GetType()].EvoGraphics ~= nil then image = _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2] end
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), image))
	end	
	ret:AddScript(string.format("Status.ApplySleep(%s, 1)", Board:GetPawn(p1):GetId()))
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end


Poke_ConfuseRay = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ConfuseRay.png",
	Description = "Confuses a distant target.",
	Name = "Confuse Ray",
	Damage = 0,
	PathSize = 1,
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_ConfuseRay:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			ret:push_back(p1+DIR_VECTORS[dir] * j)
			if Board:IsBlocked(p1+DIR_VECTORS[dir] * j, PATH_PROJECTILE) then break end
		end
	end
	return ret
end
	
function Poke_ConfuseRay:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, DIR_FLIP)
	ret:AddSound(self.LaunchSound)
	ret:AddProjectile(p1, damage, "effects/confuseray", PROJ_DELAY)
	if Board:GetPawn(target) then ret:AddScript(string.format("Status.ApplyConfusion(%s, 2)", Board:GetPawn(target):GetId())) end
	return ret
end


Poke_DarkTendrils = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/DarkTendrils.png",
	Description = "Strike all tiles in a cross, blinding enemies hit. Blinds units hit, making Vek unable to target anything more than two tiles away.",
	Name = "Dark Tendrils",
	Damage = 1,
	PathSize = 1,
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(1,2),
		Enemy2 = Point(3,4),
		Building = Point(3,2),
		Target = Point(2,3),
	}
}

function Poke_DarkTendrils:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	return ret
end
	
function Poke_DarkTendrils:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		local pawn = Board:GetPawn(curr)
		local damage = SpaceDamage(curr, self.Damage)
		damage.sAnimation = "tendril_"..i
		if pawn then 
			damage.sScript = string.format("Status.ApplyBlind(%s)", pawn:GetId())
		elseif not (Board:IsBlocked(curr, PATH_GROUND) or Board:IsFire(curr) or (Board:GetItem(curr) ~= "" and Board:GetItem(curr) ~= "Poke_DarkTendrilsItem")) then
			damage.sItem = "Poke_DarkTendrilsItem"
		end
		--else, add item to tile, define item, make it cancel/recalc weapons?
		ret:AddDamage(damage)
	end
	return ret
end


Poke_ShadowForce = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ShadowForce.png",
	Description = "Creates two shadow clones.",
	Name = "Shadow Force",
	Damage = 0,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TwoClick = true,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
	}
}

function Poke_ShadowForce:GetTargetArea(p1)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			ret:push_back(Point(i,j))
		end 
	end
	return ret
end

function Poke_ShadowForce:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			if p1 ~= Point(i,j) then ret:push_back(Point(i,j)) end
		end 
	end
	return ret
end
	
function Poke_ShadowForce:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p1, 0))
	return ret
end

function Poke_ShadowForce:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	damage.sPawn = "Poke_GiratinaShadow"
	ret:AddDamage(damage)
	damage.loc = p3
	ret:AddDamage(damage)
	return ret
end

Poke_GiratinaShadow = Pawn:new{
	Health = 1,
	MoveSpeed = 3,
	Image = "Poke_GiratinaShadow",
	Class = "TechnoVek",
	Name = "Shadow",
	GhostMovement = true,
	Minor = true,
	Neutral = true,
	IsPortrait = true,
	-- ImageOffset = 2,
	SkillList = { "Poke_ConfuseRay", "Poke_DarkTendrils" },
	-- SoundLocation = "/enemy/digger_1/",
	ImpactMaterial = IMPACT_NONE,
	DefaultTeam = TEAM_PLAYER,
	Flying = true,
}


Poke_Wither = LineArtillery:new{
	Class = "TechnoVek",
	Icon = "weapons/Wither.png",	
	Rarity = 3,
	Name = "Wither",
	Description = "Strike all enemies in an area and weaken them, causing their weapons to permanently deal -1 damage.",
	Damage = 2,
	Weaken = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Weaken" },
	UpgradeCost = { 2,3 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,1),
		Enemy = Point(2,1),
		CustomPawn = "Poke_Dialga",
	}
}
Poke_Wither_A=Poke_Wither:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Wither_B=Poke_Wither:new{ UpgradeDescription = "Weakens their weapons by 2 instead of 1.", Weaken = 2 }
Poke_Wither_AB=Poke_Wither:new{ Damage = 3, Weaken = 2 }


function Poke_Wither:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local curr = p2
	for i = DIR_START, DIR_NONE do
		local damage = SpaceDamage(curr, self.Damage)
		if Board:GetPawn(curr) then
			ret:AddScript(string.format("Status.ApplyWeaken(%s, %s, 0)", Board:GetPawn(curr):GetId(), self.Weaken))
			for j = 1, 20 do
				ret:AddEmitter(curr, "Emitter_Wither_"..math.random(1, 12))
			end
			ret:AddDamage(damage)
		end
		
		if i ~= DIR_NONE then curr = p2 + DIR_VECTORS[i] end
	end
	return ret
end

Emitter_Wither_Base = Emitter:new{
	variance = 0,
	variance_x = 15,
	variance_y = 5,
	timer = 0.5,
	x = -5,
	angle = -90,
	rot_speed = 0,
	angle_variance = 360,
	lifespan = 0.5,
	birth_rate = 20,
	speed = 5,
	seed = 4,
	min_alpha = 0.3,
	max_alpha = 0.8,
	gravity = false,
	random_rot = false,
	layer = LAYER_FRONT,
}
Emitter_Wither_1 = Emitter_Wither_Base:new{ image = "effects/wither_1.png" }
Emitter_Wither_2 = Emitter_Wither_Base:new{ image = "effects/wither_2.png" }
Emitter_Wither_3 = Emitter_Wither_Base:new{ image = "effects/wither_3.png" }
Emitter_Wither_4 = Emitter_Wither_Base:new{ image = "effects/wither_4.png" }
Emitter_Wither_5 = Emitter_Wither_Base:new{ image = "effects/wither_5.png" }
Emitter_Wither_6 = Emitter_Wither_Base:new{ image = "effects/wither_6.png" }
Emitter_Wither_7 = Emitter_Wither_Base:new{ image = "effects/wither_7.png" }
Emitter_Wither_8 = Emitter_Wither_Base:new{ image = "effects/wither_8.png" }
Emitter_Wither_9 = Emitter_Wither_Base:new{ image = "effects/wither_9.png" }
Emitter_Wither_10 = Emitter_Wither_Base:new{ image = "effects/wither_10.png" }
Emitter_Wither_11 = Emitter_Wither_Base:new{ image = "effects/wither_11.png" }
Emitter_Wither_12 = Emitter_Wither_Base:new{ image = "effects/wither_12.png" }



Poke_Judgment = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Judgment.png",
	Description = "Deals damage to every pawn in a large area. Pushes pawns on the same row as Arceus; otherwise, flips the attack direction.",
	Name = "Judgment",
	Damage = 2,
	Range = 3,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "More Types", "More Types" },
	UpgradeCost = { 2,2 },
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
		CustomPawn = "Poke_Arceus",
	}
}
Poke_Judgment_A=Poke_Judgment:new{ UpgradeDescription = "Unlocks the ability to switch between types by self-targeting. Normal: pushes or flips. Fire: applies fire. Ice: applies Chill. Electric: applies Shocked. Poison: applies Toxin.", TwoClick = true, TypesA = true }
Poke_Judgment_B=Poke_Judgment:new{ UpgradeDescription = "Unlocks the ability to switch between types by self-targeting. Normal: pushes or flips. Ground: cracks hit tiles. Grass: applies Rooted. Water: applies Wet. Fairy: heals instead of dealing damage.", TwoClick = true, TypesB = true }
Poke_Judgment_AB=Poke_Judgment:new{ TwoClick = true, TypesA = true, TypesB = true }

function Poke_Judgment:GetTargetArea(p1)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			ret:push_back(Point(i,j))
		end 
	end
	return ret
end

function Poke_Judgment:IsTwoClickException(p1, p2)
	return p1 ~= p2
end

function Poke_Judgment:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	ret:push_back(p1)
	if self.TypesA then
		for i = DIR_START, DIR_END do
			ret:push_back(p1 + DIR_VECTORS[i])
		end
	end
	if self.TypesB then
		for i = DIR_START, DIR_END do
			ret:push_back(p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4])
		end
	end
	return ret
end
	
function Poke_Judgment:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	if p1 == p2 then ret:AddDamage(SpaceDamage(p1)) return ret end
	local targets = extract_table(general_DiamondTarget(p2, self.Range))
	for i = 16, 1, -1 do	--iterate backwards to hit things further away from Arceus first to avoid pushing things into each other
		local willDelay = false
		for k = 1, #targets do
			local pawn = Board:GetPawn(targets[k])
			local damage = SpaceDamage(targets[k], 2)
			damage.sAnimation = "explo_gold"
			if Board:GetPawn(p1):GetCustomAnim() == "Poke_Arceus" or Board:GetPawn(p1):GetCustomAnim() == "" then
				if targets[k].x == p1.x or targets[k].y == p1.y then damage.iPush = GetDirection(targets[k] - p1) else damage.iPush = DIR_FLIP end
			end
			if pawn and p1:Manhattan(targets[k]) == i then -- and targets[k] ~= p1 
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusFire" then damage.iFire = 1 end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusIce" then damage.sScript = string.format("modApi:runLater(function() Status.ApplyChill(%s) end)", pawn:GetId()) end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusElectric" then damage.sScript = string.format("Status.ApplyShocked(%s)", pawn:GetId()) end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusPoison" then damage.sScript = string.format("Status.ApplyToxin(%s)", pawn:GetId()) end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusGround" then damage.iCrack = 1 end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusGrass" then damage.sScript = string.format("Status.ApplyRooted(%s)", pawn:GetId()) end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusWater" then damage.sScript = string.format("modApi:runLater(function() Status.ApplyWet(%s) end)", pawn:GetId()) end
				if Board:GetPawn(p1):GetCustomAnim() == "Poke_ArceusFairy" then damage.iDamage = damage.iDamage * -1 end
				ret:AddDropper(damage, "effects/judgment.png")
				if targets[k].x == p1.x or targets[k].y == p1.y then willDelay = true end
			end
		end
		if willDelay then ret:AddDelay(0.1) end
	end
	return ret
end

function Poke_Judgment:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local userId = Board:GetPawn(p1):GetId()
	if p1 == p2 and (self.TypesA or self.TypesB) then
		local normalMark = SpaceDamage(p1)
		normalMark.sImageMark = "effects/tile_normal.png"
		ret:AddDamage(normalMark)
		if self.TypesA then
			local fireMark = SpaceDamage(p1 + DIR_VECTORS[0])
			fireMark.sImageMark = "effects/tile_fire.png"
			ret:AddDamage(fireMark)
			local iceMark = SpaceDamage(p1 + DIR_VECTORS[1])
			iceMark.sImageMark = "effects/tile_ice.png"
			ret:AddDamage(iceMark)
			local electricMark = SpaceDamage(p1 + DIR_VECTORS[2])
			electricMark.sImageMark = "effects/tile_electric.png"
			ret:AddDamage(electricMark)
			local poisonMark = SpaceDamage(p1 + DIR_VECTORS[3])
			poisonMark.sImageMark = "effects/tile_poison.png"
			ret:AddDamage(poisonMark)
		end
		if self.TypesB then
			local groundMark = SpaceDamage(p1 + DIR_VECTORS[0] + DIR_VECTORS[1])
			groundMark.sImageMark = "effects/tile_ground.png"
			ret:AddDamage(groundMark)
			local grassMark = SpaceDamage(p1 + DIR_VECTORS[1] + DIR_VECTORS[2])
			grassMark.sImageMark = "effects/tile_grass.png"
			ret:AddDamage(grassMark)
			local waterMark = SpaceDamage(p1 + DIR_VECTORS[2] + DIR_VECTORS[3])
			waterMark.sImageMark = "effects/tile_water.png"
			ret:AddDamage(waterMark)
			local fairyMark = SpaceDamage(p1 + DIR_VECTORS[3] + DIR_VECTORS[0])
			fairyMark.sImageMark = "effects/tile_fairy.png"
			ret:AddDamage(fairyMark)
		end
	end
	if p3 == p1 then	--normal
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_Arceus"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 255, 255))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[0] then	--fire
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusFire"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 84, 0))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[1] then	--ice
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusIce"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(91, 255, 255))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[2] then	--electric
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusElectric"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 255, 0))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[3] then	--poison
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusPoison"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(154, 45, 140))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[0] + DIR_VECTORS[1] then	--ground
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusGround"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(180, 110, 25))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[1] + DIR_VECTORS[2] then	--grass
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusGrass"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(0, 255, 0))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[2] + DIR_VECTORS[3] then	--water
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusWater"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(0, 169, 255))", p1:GetString()))
	elseif p3 == p1 + DIR_VECTORS[3] + DIR_VECTORS[0] then	--fairy
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", userId, "Poke_ArceusFairy"))
		ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 140, 215))", p1:GetString()))
	end
	ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetActive(true) end)", userId))
	return ret
end



Poke_Wormhole = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Wormhole.png",
	Description = "Teleports the caster and every surrounding pawn.",
	Name = "Wormhole",
	Range = 3,
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Range", "+1 Range" },
	UpgradeCost = { 2,2 },
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
		CustomPawn = "Poke_Arceus",
	}
}
Poke_Wormhole_A=Poke_Wormhole:new{ UpgradeDescription = "Can teleport one tile further away.", Range = 4 }
Poke_Wormhole_B=Poke_Wormhole:new{ UpgradeDescription = "Can teleport one tile further away.", Range = 4 }
Poke_Wormhole_AB=Poke_Wormhole:new{ Range = 5 }

function Poke_Wormhole:GetTargetArea(p1)
	local ret = PointList()
	local targets = extract_table(general_DiamondTarget(p1, self.Range))
	for k = 1, #targets do	--skip p1
		local flag = true
		if targets[k] == p1 then flag = false end
		if Board:IsBlocked(targets[k], PATH_PROJECTILE) and 
		not (targets[k]:Manhattan(p1) <= 1 and Board:GetPawn(targets[k]) and not Board:GetPawn(targets[k]):IsGuarding()) then 
		--check whether location is blocked, except by a pawn that we would teleport away
			flag = false 
		end
		for i = DIR_START, DIR_END do
			local pawn = Board:GetPawn(p1 + DIR_VECTORS[i])
			if (Board:IsBlocked(targets[k] + DIR_VECTORS[i], PATH_PROJECTILE) and pawn and not pawn:IsGuarding()) and
			not (p1:Manhattan(targets[k] + DIR_VECTORS[i]) <= 1 and Board:GetPawn(targets[k] + DIR_VECTORS[i]) and not Board:GetPawn(targets[k] + DIR_VECTORS[i]):IsGuarding()) then 
				--this means the pawn cannot be teleported for complex reasons
				if targets[k] == p1 + DIR_VECTORS[i] then flag = false end	--because Arceus would overlap that unmoved pawn
			end
		end
		if flag then ret:push_back(targets[k]) end
	end
	return ret
end
	
function Poke_Wormhole:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local away = Point(-33, 0)
	local user = Board:GetPawn(p1)
	local pawn0 = Board:GetPawn(p1 + DIR_VECTORS[0])
	local pawn1 = Board:GetPawn(p1 + DIR_VECTORS[1])
	local pawn2 = Board:GetPawn(p1 + DIR_VECTORS[2])
	local pawn3 = Board:GetPawn(p1 + DIR_VECTORS[3])
	
	if pawn0 then
	if pawn0:IsGuarding() or Board:IsBlocked(p2 + DIR_VECTORS[0], PATH_PROJECTILE) and not
	(p1:Manhattan(p2 + DIR_VECTORS[0]) <= 1 and Board:GetPawn(p2 + DIR_VECTORS[0]) and not Board:GetPawn(p2 + DIR_VECTORS[0]):IsGuarding()) then pawn0 = nil end end
	if pawn1 then
	if pawn1:IsGuarding() or Board:IsBlocked(p2 + DIR_VECTORS[1], PATH_PROJECTILE) and not
	(p1:Manhattan(p2 + DIR_VECTORS[1]) <= 1 and Board:GetPawn(p2 + DIR_VECTORS[1]) and not Board:GetPawn(p2 + DIR_VECTORS[1]):IsGuarding()) then pawn1 = nil end end
	if pawn2 then
	if pawn2:IsGuarding() or Board:IsBlocked(p2 + DIR_VECTORS[2], PATH_PROJECTILE) and not
	(p1:Manhattan(p2 + DIR_VECTORS[2]) <= 1 and Board:GetPawn(p2 + DIR_VECTORS[2]) and not Board:GetPawn(p2 + DIR_VECTORS[2]):IsGuarding()) then pawn2 = nil end end
	if pawn3 then
	if pawn3:IsGuarding() or Board:IsBlocked(p2 + DIR_VECTORS[3], PATH_PROJECTILE) and not
	(p1:Manhattan(p2 + DIR_VECTORS[3]) <= 1 and Board:GetPawn(p2 + DIR_VECTORS[3]) and not Board:GetPawn(p2 + DIR_VECTORS[3]):IsGuarding()) then pawn3 = nil end end
	
	local mark = SpaceDamage(p1)
	mark.sImageMark = "advanced/combat/icons/icon_teleport_glow.png"
	ret:AddDamage(mark)
	if pawn0 then mark.loc = p1 + DIR_VECTORS[0] ret:AddDamage(mark) end
	if pawn1 then mark.loc = p1 + DIR_VECTORS[1] ret:AddDamage(mark) end
	if pawn2 then mark.loc = p1 + DIR_VECTORS[2] ret:AddDamage(mark) end
	if pawn3 then mark.loc = p1 + DIR_VECTORS[3] ret:AddDamage(mark) end
	ret:AddAnimation(p1, "wormholeAnim")
	ret:AddDelay(0.2)
	ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), away:GetString()))
	ret:AddDelay(0.6)
	if pawn0 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn0:GetId(), (away + DIR_VECTORS[0]):GetString())) end
	if pawn1 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn1:GetId(), (away + DIR_VECTORS[1]):GetString())) end
	if pawn2 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn2:GetId(), (away + DIR_VECTORS[2]):GetString())) end
	if pawn3 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn3:GetId(), (away + DIR_VECTORS[3]):GetString())) end
	ret:AddDelay(0.5)
	ret:AddAnimation(p2, "wormholeAnim", ANIM_REVERSE)
	if pawn0 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn0:GetId(), (p2 + DIR_VECTORS[0]):GetString())) end
	if pawn1 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn1:GetId(), (p2 + DIR_VECTORS[1]):GetString())) end
	if pawn2 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn2:GetId(), (p2 + DIR_VECTORS[2]):GetString())) end
	if pawn3 then ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", pawn3:GetId(), (p2 + DIR_VECTORS[3]):GetString())) end
	ret:AddDelay(0.6)
	ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", user:GetId(), p2:GetString()))
	return ret
end



Poke_Unmake = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Unmake.png",
	Description = "Deletes a tile and its contents.",
	Name = "Unmake",
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	Limited = 1,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,2),
		Enemy3 = Point(0,2),
		Mountain = Point(3,1),
		Friendly = Point(1,2),
		Target = Point(3,2),
		CustomPawn = "Poke_Arceus",
	}
}

function Poke_Unmake:GetTargetArea(p1)
	local ret = PointList()
	for i = 0, 7 do
		for j = 0, 7 do
			ret:push_back(Point(i,j))
		end 
	end
	return ret
end

function Poke_Unmake:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, DAMAGE_DEATH)
	damage.iTerrain = TERRAIN_HOLE
	ret:AddDamage(damage)
	return ret
end


Poke_Trample=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Trample.png",	
	Rarity = 3,
	Name = "Trample",
	Description = "Dash to a location, crushing everything along the way.",
	Damage = 3,
	Crack = 0,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	Push = false,
	UpgradeList = { "Push Adjacent", "Crack" },
	UpgradeCost = { 2, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,5),
		Target = Point(2,1),
		Enemy = Point(2, 2),
		Mountain = Point(2,3),
		Building = Point(2,4),
		CustomPawn = "Poke_Metanitar",
	}
}
Poke_Trample_A=Poke_Trample:new{ UpgradeDescription = "On stopping, push adjacent tiles.", Push = true }
Poke_Trample_B=Poke_Trample:new{ UpgradeDescription = "Crack all tiles trampled.", Crack = 1 }
Poke_Trample_AB=Poke_Trample:new{ Push = true, Crack = 1 }


function Poke_Trample:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = p1+DIR_VECTORS[dir] * j
			if Board:GetTerrain(curr) == TERRAIN_HOLE then break end
			local pawn = Board:GetPawn(curr)
			if not ((pawn and (pawn:IsShield() or pawn:GetHealth() > self.Damage)) or (Board:IsBuilding(curr) and Board:GetHealth(curr) > self.Damage) or Board:GetTerrain(curr) == TERRAIN_WATER or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN or Board:GetTerrain(curr) == TERRAIN_BUILDING) then
				ret:push_back(curr)
			end
		end
	end
	return ret
end

function Poke_Trample:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local dist = p1:Manhattan(p2)
	local curr = p1
	local targetPawn = Board:GetPawn(p2)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddCharge(move, NO_DELAY)
	for i = 0, dist do
		ret:AddSound("/support/earthmover/attack_first")
		ret:AddEmitter(curr, "Emitter_Dust")
		local damage = SpaceDamage(curr, self.Damage)
		damage.iCrack = self.Crack
		if i == dist - 1 and self.Push then damage.iPush = (dir+2)%4 end
		if Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then ret:AddDamage(SpaceDamage(curr, 1)) end 		--to make sure we oneshot mountains
		if i > 0 and i < dist then ret:AddDamage(damage) end
		if i == dist and targetPawn then ret:AddScript(string.format("Board:GetPawn(%s):Kill(false)", targetPawn:GetId())) end
		ret:AddDelay(0.1)
		ret:AddBounce(curr, 2)
		curr = curr + DIR_VECTORS[dir]
	end
	if self.Push then
		for i = DIR_START, DIR_END do
			local pushDamage = SpaceDamage(p2 + DIR_VECTORS[i], 0, i)
			pushDamage.sAnimtion = PUSH_ANIMS[i]
			if i ~= (dir+2)%4 then ret:AddDamage(pushDamage) end
		end
	end
	return ret
end


Poke_PsychicTerror=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/PsychicTerror.png",	
	Rarity = 3,
	Name = "Psychic Terror",
	Description = "Cancel nearby enemies' queued actions if they have less health that the user.",
	Damage = 0,
	Range = 2,
	PathSize = 8,	
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "+1 Range", "Dreadful" },
	UpgradeCost = { 2, 2 },
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2, 2),
		Building = Point(2,4),
		CustomPawn = "Poke_Metanitar",
	}
}
Poke_PsychicTerror_A=Poke_PsychicTerror:new{ UpgradeDescription = "Affect a larger area.", Range = 3 }
Poke_PsychicTerror_B=Poke_PsychicTerror:new{ UpgradeDescription = "Gain the Dreadful status, which prevents enemies from queueing actions next to this pawn.", Dreadful = true }
Poke_PsychicTerror_AB=Poke_PsychicTerror:new{ Range = 3, Dreadful = true }


function Poke_PsychicTerror:GetTargetArea(p1)
	local ret = PointList()
	ret:push_back(p1)
	return ret
end

function Poke_PsychicTerror:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local hitTiles = {}
	ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 0, 255))", p1:GetString()))
	for i = 1, self.Range do
		local targets = extract_table(general_DiamondTarget(p1, i))
		for k = 1, #targets do	
			if not hitTiles[targets[k]:GetString()] then
				ret:AddScript(string.format("Board:Ping(%s, GL_Color(255, 0, %s))", targets[k]:GetString(), 255 - 80 * i))
				local pawn = Board:GetPawn(targets[k])
				if pawn and pawn:GetHealth() < Board:GetPawn(p1):GetHealth() and pawn:GetTeam() == TEAM_ENEMY and pawn:GetQueuedTarget() ~= Point(-1, -1) then
					local mark = SpaceDamage(targets[k])
					mark.sImageMark = "combat/icons/icon_mind_glow.png"
					ret:AddDamage(mark)
					ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", pawn:GetId()))
				end
			end
			hitTiles[targets[k]:GetString()] = true
		end
		ret:AddDelay(0.3)
	end
	if self.Dreadful then ret:AddScript(string.format("Status.ApplyDreadful(%s)", Board:GetPawn(p1):GetId())) end
	return ret
end


Poke_Present = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Present.png",
	Description = "Gifts a random weapon to an ally if it can equip any. Heals and boosts allies otherwise. Deals 1 damage to enemies.",
	Name = "Present",
	PathSize = 1,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	Damage = 1,
	ZoneTargeting = ZONE_CUSTOM,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_DelibirdHelper",
	}
}

function Poke_Present:GetTargetArea(p1)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(p1 + DIR_VECTORS[i] * j)
		end 
	end
	return ret
end

function Poke_Present:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p2)
	local dir = GetDirection(p2-p1)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Delibird_shoot_"..dir))
	ret:AddDelay(1)
	--anim lasts 2.2 seconds, so we add a delay at the end
	if pawn and pawn:GetTeam() == TEAM_PLAYER then
		if pawn:GetWeaponCount() < 2 then
			local validGifts = {}
			for id, enabled in pairs(modApi.weaponDeck) do
				local weapon = _G[id]
				if weapon.Class ~= "TechnoVek" and weapon.Class ~= "" and weapon.Class ~= "Enemy" and enabled and weapon.Passive == "" then 
				--no technovek weapons because it's funnier if you get gifted flamethrowers and stuff
					validGifts[#validGifts + 1] = id 
				end
			end
			if #validGifts == 0 then return ret end
			local roll = random_removal(validGifts)
			local damage = SpaceDamage(p2)
			damage.sImageMark = "effects/shotup_present.png"
			damage.sScript = string.format("Board:GetPawn(%s):AddWeapon(%q, true)", pawn:GetId(), roll)
			ret:AddArtillery(p1, damage, "effects/shotup_present.png", NO_DELAY)
		else
			local damage = SpaceDamage(p2, -1)
			damage.sScript = string.format("Board:GetPawn(%s):SetBoosted(true)", pawn:GetId())
			ret:AddArtillery(p1, damage, "effects/shotup_present.png", NO_DELAY)
		end
	else
		ret:AddArtillery(p1, SpaceDamage(p2, 1), "effects/shotup_present.png", NO_DELAY)
	end
	ret:AddDelay(1.21)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Delibird"))
	return ret
end

Poke_ScorchingSands = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/ScorchingSands.png",
	Description = "Creates a sandstorm in a 3x3 area. Sets the center on fire. Pushes pawns on the edges.",
	Name = "Scorching Sands",
	Damage = 0,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,1),
		Enemy1 = Point(2,0),
		Target = Point(2,1),
		CustomPawn = "Poke_Tyrachomp",
	}
}

function Poke_ScorchingSands:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 2, 8 do
			ret:push_back(point + DIR_VECTORS[i] * j)
		end 
	end
	return ret
end

Emitter_ScorchingSands = Emitter_Sandstorm_1:new{ variance_x = 20,variance_y = 14,y = -10, burst_count = 5, max_particles = 30, min_alpha = 0.2, max_alpha = 0.3, birth_rate = 0.05,speed=8, lifespan = 0.5}

	
function Poke_ScorchingSands:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	local dir = GetDirection(p2-p1)
	damage.iFire = 1
	ret:AddDamage(damage)
	ret:AddScript(string.format("Weathers.AddWeather(%q, %s, %s, %s)", "Sandstorm", 3, (p2 + Point(-1, -1)):GetString(), (p2 + Point(1, 1)):GetString()))
	for i = -1, 1 do
		for j = -1, 1 do
			-- damage.loc = p2 + Point(i, j)
			ret:AddEmitter(p2 + Point(i, j), "Emitter_ScorchingSands")
			-- ret:AddDamage(damage)
		end
	end
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4], 0, dir))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[dir], 0, dir))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[dir] + DIR_VECTORS[(dir-1)%4], 0, dir))
	
	ret:AddDamage(SpaceDamage(p2 - DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4], 0, (dir+2)%4))
	ret:AddDamage(SpaceDamage(p2 - DIR_VECTORS[dir], 0, (dir+2)%4))
	ret:AddDamage(SpaceDamage(p2 - DIR_VECTORS[dir] + DIR_VECTORS[(dir-1)%4], 0, (dir+2)%4))
	return ret
end

Poke_DragonTail = Skill:new{  
	Class = "TechnoVek",
	Icon = "weapons/DragonTail.png",
	Description = "Sweeps three tiles in a line, pushing all targets hit.",
	Name = "Dragon Tail",
	Rarity = 1,
	PathSize = 1,
	Damage = 1,
	Range = 1,
	Cost = "high",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeCost = { 1,3 },
	UpgradeList = { "Long Push", "+1 Damage" },
	LaunchSound = "/weapons/sword",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Poke_Tyrachomp",
	}
}
Poke_DragonTail_A=Poke_DragonTail:new{ UpgradeDescription = "Can push enemies as far as possible.", Range = 2 }
Poke_DragonTail_B=Poke_DragonTail:new{ UpgradeDescription = "Deals 1 more damage.", Damage = 2 }
Poke_DragonTail_AB=Poke_DragonTail:new{ Range = 2, Damage = 2 }

function Poke_DragonTail:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.Range do
			ret:push_back(point + DIR_VECTORS[i] * j)
		end 
	end
	return ret
end

function Poke_DragonTail:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1) 
	local point = p1 + DIR_VECTORS[direction]
	ret:AddDamage(SoundEffect(p2,self.LaunchSound))
	
	local centerdamage = SpaceDamage(point)
	centerdamage.sAnimation = "explosword_"..direction
	ret:AddDamage(centerdamage)
	
	for i = -1, 1 do
		local curr = point + DIR_VECTORS[(direction + 1)% 4] * i
		if Board:GetPawn(curr) then
			if p1:Manhattan(p2) == 1 then
				ret:AddDamage(SpaceDamage(curr, self.Damage, direction))
			else
				local target = GetProjectileEnd(curr, curr + DIR_VECTORS[direction])
				local hurt = true
				if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
				ret:AddDamage(SpaceDamage(curr, self.Damage))
				ret:AddCharge(Board:GetSimplePath(curr, target), PROJ_DELAY)
				if hurt then
					ret:AddSafeDamage(SpaceDamage(target, 1))
					ret:AddSafeDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
				end
			end
		end
		ret:AddDelay(0.05)
	end 
	return ret
end	


Poke_MountainHurl = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/MountainHurl.png",
	Description = "Throws an adjacent mountain at a distant target, killing it.",
	Name = "Mountain Hurl",
	Damage = DAMAGE_DEATH,
	PathSize = 8,
	PowerCost = 0, --AE Change
	Limited = 1,
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Mountain = Point(2,2),
		Target = Point(2,1),
		CustomPawn = "Poke_Larvitar",
	}
}

function Poke_MountainHurl:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		if Board:IsTerrain(point +  DIR_VECTORS[i], TERRAIN_MOUNTAIN) then
			for j = 2, 8 do
				ret:push_back(point + DIR_VECTORS[i] * j)
			end 
		end
	end
	return ret
end
	
function Poke_MountainHurl:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	local dir = GetDirection(p2-p1)
	damage.iTerrain = TERRAIN_MOUNTAIN
	local removeMountain = SpaceDamage(p1 + DIR_VECTORS[dir])
	removeMountain.iTerrain = TERRAIN_RUBBLE
	local tileset = GetCurrentMission().CustomTile
	if tileset == "" then tileset = Game:GetCorp().name:sub(1, -6) == "" and "grass" or _G[Game:GetCorp().name:sub(1, -6)].Tileset end
	LOG(tileset)
	-- ret:AddDropper(damage, "effects/shotdown_rock.png")
	ret:AddDamage(removeMountain)
	ret:AddArtillery(p1, damage, "combat/tiles_"..tileset.."/mountain_0.png", PROJ_DELAY)
	
	ret:AddScript("Board:AddShake(0.5)")
	--reverse mega evo
	local user = Board:GetPawn(p1)
	for i = user:GetWeaponCount(), 1, -1 do
		if user:GetWeaponBaseType(i) == "Poke_MountainHurl" then 
			ret:AddScript(string.format("Board:GetPawn(%s):RemoveWeapon(%s)", user:GetId(), i)) 
			break 
		end
	end
	if GAME.BranchingEvos[user:GetId()+1] ~= nil then
		ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", user:GetId(), _G[user:GetType()].EvoGraphics[GAME.BranchingEvos[user:GetId()+1]][2]))
	end	
	ret:AddScript("GetCurrentMission().MegaEvolved = -1")
	return ret
end