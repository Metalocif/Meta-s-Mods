-- https://sprites.pmdcollab.org/
-- Repository of Pokemon sprites, roughly ItB-style.
-- It also has portraits but they are not the right size (and I couldn't figure out how to change portraits on evo anyway).
-- For portraits, this website has the ones from Super Mystery Dungeon, which are 55x55, easier to resize.
-- https://projectpokemon.org/home/pokedex/pokemon/psmd
-- For Gen 1-3, use the portraits from the Rescue Team remake, which are bigger.

-- Feel free to steal this code to make more Pokemon stuff or just upgradeable mechs.
-- I check pilot level, but you can check anything - either game variables like the current island, or stuff you keep track of yourself.
-- The fields I use for evolution stuff are:
-- HasEvolutions: a table of two booleans, one for level 1, one for level 2; if you made a Pokemon that evolves on level 2 only, it'd be {false, true}
-- EvoGraphics: lists the graphics of evolved forms; nothing is listed for level 0, which is convenient since Lua tables start at 1.
-- EvoForget: lists the weapons to remove on evolution. Max one weapon to forget per level.
-- EvoLearn: lists the weapons to learn on evolution. You can learn more than one per level; if they overflow into slots 3+ they seem to get removed randomly.
-- EvoNames: solely here for the alert messages.
-- KeepAdding: weapons to keep adding to the pawn at the start of each mission, since they seem to get removed otherwise. You can't upgrade these.
-- BecomeFlyingAtLevel: makes the pawn flying at that level.
-- LoseFlyingAtLevel: makes the pawn not flying at that level.
--   o It would make more sense for the above two to be a table of table of functions to run if we had a ton of such possibilities. 

local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = mod_loader.mods[modApi.currentMod].resourcePath .."img/units/player/"
local files = {
    "Abra.png",
    "Abra_a.png",
    "Abra_w.png",
    -- "Abra_w_broken.png",
    "Abra_broken.png",
    "Abra_ns.png",
    "Abra_h.png",
	
	"Kadabra.png",
    "Kadabra_a.png",
    "Kadabra_w.png",
    -- "Kadabra_w_broken.png",
    "Kadabra_broken.png",
    "Kadabra_ns.png",
    "Kadabra_h.png",
	
	"Alakazam.png",
    "Alakazam_a.png",
    -- "Alakazam_w.png",
    -- "Alakazam_w_broken.png",
    "Alakazam_broken.png",
    "Alakazam_ns.png",
    "Alakazam_h.png",
	
	"Dratini.png",
    "Dratini_a.png",
    "Dratini_w.png",
    -- "Dratini_w_broken.png",
    "Dratini_broken.png",
    "Dratini_ns.png",
    "Dratini_h.png",
	
	"Dragonair.png",
    "Dragonair_a.png",
    "Dragonair_w.png",
    -- "Dragonair_w_broken.png",
    "Dragonair_broken.png",
    "Dragonair_ns.png",
    "Dragonair_h.png",
	
	"Dragonite.png",
    "Dragonite_a.png",
    -- "Dragonite_w.png",
    -- "Dragonite_w_broken.png",
    "Dragonite_broken.png",
    "Dragonite_ns.png",
    "Dragonite_h.png",
	"Dragonite_sleep.png",	--only here for Hyper Beam & because it's cute
    
    "Mew.png",
    "Mew_a.png",
    -- "Mew_w.png",
    -- "Mew_w_broken.png",
    "Mew_broken.png",
    "Mew_ns.png",
    "Mew_h.png",
	
	"Articuno.png",
	"Articuno_a.png",
	"Articuno_h.png",
	"Articuno_ns.png",
	
	"Zapdos.png",
	"Zapdos_a.png",
	"Zapdos_h.png",
	"Zapdos_ns.png",
	
	"Moltres.png",
	"Moltres_a.png",
	"Moltres_h.png",
	"Moltres_ns.png",
	
	"Mewtwo.png",
	"Mewtwo_a.png",
	"Mewtwo_h.png",
	"Mewtwo_ns.png",
	
	"Darkrai.png",
	"Darkrai_a.png",
	"Darkrai_h.png",
	"Darkrai_ns.png",
	
	"Deoxys.png",
	"Deoxys_a.png",
	"Deoxys_w.png",
	"Deoxys_h.png",
	"Deoxys_ns.png",
	"DeoxysA.png",
	"DeoxysA_a.png",
	"DeoxysA_w.png",
	"DeoxysS.png",
	"DeoxysS_a.png",
	"DeoxysS_w.png",
	"DeoxysD.png",
	"DeoxysD_a.png",
	"DeoxysD_w.png",
	
	"Celebi.png",
	"Celebi_a.png",
	"Celebi_h.png",
	"Celebi_ns.png",
	
	"Shaymin.png",
	"Shaymin_a.png",
	"Shaymin_w.png",
	"Shaymin_h.png",
	"Shaymin_ns.png",
	"ShayminAir.png",
	"ShayminAir_a.png",
	
	"Xerneas.png",
	"Xerneas_a.png",
	"Xerneas_sleep.png",
	"Xerneas_tree.png",
	"Xerneas_w.png",
	"Xerneas_h.png",
	"Xerneas_ns.png",
	
	"ArmoredMewtwo.png",
	"ArmoredMewtwo_w.png",
	"ArmoredMewtwo_a.png",
	"ArmoredMewtwo_h.png",
	"ArmoredMewtwo_ns.png",
	
	"Larvitar.png",
    "Larvitar_a.png",
    "Larvitar_w.png",
    -- "Larvitar_broken.png",
    "Larvitar_ns.png",
    "Larvitar_h.png",
	
	"Pupitar.png",
    "Pupitar_a.png",
    "Pupitar_w.png",
    -- "Pupitar_broken.png",
    "Pupitar_ns.png",
    "Pupitar_h.png",
	
	"Tyranitar.png",
    "Tyranitar_a.png",
    "Tyranitar_w.png",
    -- "Tyranitar_broken.png",
    "Tyranitar_ns.png",
    "Tyranitar_h.png",
	
	"Beldum.png",
	"Beldum_a.png",
	"Beldum_h.png",
	"Beldum_ns.png",
	
	"Metang.png",
	"Metang_a.png",
	"Metang_h.png",
	"Metang_ns.png",
	"Metang_swipe.png",
	
	"Metagross.png",
    "Metagross_a.png",
    "Metagross_w.png",
    -- "Metagross_broken.png",
    "Metagross_ns.png",
    "Metagross_h.png",
    "Metagross_hover.png",
	
	"Gible.png",
    "Gible_a.png",
    "Gible_w.png",
    -- "Gible_broken.png",
    "Gible_ns.png",
    "Gible_h.png",
	
	"Gabite.png",
    "Gabite_a.png",
    "Gabite_w.png",
    -- "Gabite_broken.png",
    "Gabite_ns.png",
    "Gabite_h.png",
	
	"Garchomp.png",
    "Garchomp_a.png",
    "Garchomp_w.png",
    -- "Garchomp_broken.png",
    "Garchomp_ns.png",
    "Garchomp_h.png",
	
	"HyperBall.png", "MasterBall.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, mechPath.. file)
end

local a=ANIMS
a.Poke_Abra =a.MechUnit:new{Image="units/player/Abra.png", PosX = -18, PosY = -9}
a.Poke_Abraa = a.MechUnit:new{Image="units/player/Abra_a.png",  PosX = -13, PosY = -4, NumFrames = 4 }
a.Poke_Abraw = a.MechUnit:new{Image="units/player/Abra_w.png", PosX = -13, PosY = 12}
a.Poke_Abra_broken = a.MechUnit:new{Image="units/player/Abra_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Abraw_broken = a.MechUnit:new{Image="units/player/Abra_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Abra_ns = a.MechIcon:new{Image="units/player/Abra_ns.png"}

a.Poke_Kadabra =a.MechUnit:new{Image="units/player/Kadabra.png", PosX = -18, PosY = 2}
a.Poke_Kadabraa = a.MechUnit:new{Image="units/player/Kadabra_a.png",  PosX = -18, PosY = 2, NumFrames = 4 }
a.Poke_Kadabraw = a.MechUnit:new{Image="units/player/Kadabra_w.png", PosX = -13, PosY = 10}
a.Poke_Kadabra_broken = a.MechUnit:new{Image="units/player/Kadabra_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Kadabraw_broken = a.MechUnit:new{Image="units/player/Kadabra_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Kadabra_ns = a.MechIcon:new{Image="units/player/Kadabra_ns.png"}

a.Poke_Alakazam =a.MechUnit:new{Image="units/player/Alakazam.png", PosX = -18, PosY = -9}
a.Poke_Alakazama = a.MechUnit:new{Image="units/player/Alakazam_a.png",  PosX = -18, PosY = -9, NumFrames = 8 }
a.Poke_Alakazamw = a.MechUnit:new{Image="units/player/Alakazam_w.png", PosX = -18, PosY = -2}
a.Poke_Alakazam_broken = a.MechUnit:new{Image="units/player/Alakazam_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Alakazamw_broken = a.MechUnit:new{Image="units/player/Alakazam_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Alakazam_ns = a.MechIcon:new{Image="units/player/Alakazam_ns.png"}


a.Poke_Dratini =a.MechUnit:new{Image="units/player/Dratini.png", PosX = -15, PosY = -2}
a.Poke_Dratinia = a.MechUnit:new{Image="units/player/Dratini_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dratiniw = a.MechUnit:new{Image="units/player/Dratini_w.png", PosX = -15, PosY = 4}
a.Poke_Dratini_broken = a.MechUnit:new{Image="units/player/Dratini_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dratiniw_broken = a.MechUnit:new{Image="units/player/Dratini_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dratini_ns = a.MechIcon:new{Image="units/player/Dratini_ns.png"}

a.Poke_Dragonair =a.MechUnit:new{Image="units/player/Dragonair.png", PosX = -15, PosY = -2}
a.Poke_Dragonaira = a.MechUnit:new{Image="units/player/Dragonair_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dragonairw = a.MechUnit:new{Image="units/player/Dragonair_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonair_broken = a.MechUnit:new{Image="units/player/Dragonair_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonairw_broken = a.MechUnit:new{Image="units/player/Dragonair_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonair_ns = a.MechIcon:new{Image="units/player/Dragonair_ns.png"}

a.Poke_Dragonite =a.MechUnit:new{Image="units/player/Dragonite.png", PosX = -20, PosY = -8}
a.Poke_Dragonitea = a.MechUnit:new{Image="units/player/Dragonite_a.png",  PosX = -20, PosY = -8, NumFrames = 4 }
a.Poke_Dragonitew = a.MechUnit:new{Image="units/player/Dragonite_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonite_broken = a.MechUnit:new{Image="units/player/Dragonite_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonitew_broken = a.MechUnit:new{Image="units/player/Dragonite_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonite_ns = a.MechIcon:new{Image="units/player/Dragonite_ns.png"}
a.Poke_Dragonite_sleep = a.MechUnit:new{Image="units/player/Dragonite_sleep.png", PosX = -15, PosY = -12, NumFrames = 2, Time = 1 }


a.Poke_Mew =a.MechUnit:new{Image="units/player/Mew.png", PosX = -20, PosY = -4}
a.Poke_Mewa = a.MechUnit:new{Image="units/player/Mew_a.png",  PosX = -20, PosY = -4, NumFrames = 4 }
a.Poke_Meww = a.MechUnit:new{Image="units/player/Mew_w.png", PosX = -17, PosY = 2}
a.Poke_Mew_broken = a.MechUnit:new{Image="units/player/Mew_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Meww_broken = a.MechUnit:new{Image="units/player/Mew_w_broken.png", PosX = -20, PosY = 2 }
a.Poke_Mew_ns = a.MechIcon:new{Image="units/player/Mew_ns.png"}


a.Poke_Articuno =a.MechUnit:new{Image="units/player/Articuno.png", PosX = -25, PosY = -14}
a.Poke_Articunoa = a.MechUnit:new{Image="units/player/Articuno_a.png",  PosX = -25, PosY = -14, NumFrames = 6 }
a.Poke_Articuno_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Articuno_ns = a.MechIcon:new{Image="units/player/Articuno_ns.png"}

a.Poke_Zapdos =a.MechUnit:new{Image="units/player/Zapdos.png", PosX = -30, PosY = -14}
a.Poke_Zapdosa = a.MechUnit:new{Image="units/player/Zapdos_a.png",  PosX = -40, PosY = -14, NumFrames = 6 }
a.Poke_Zapdos_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Zapdos_ns = a.MechIcon:new{Image="units/player/Zapdos_ns.png"}

a.Poke_Moltres =a.MechUnit:new{Image="units/player/Moltres.png", PosX = -45, PosY = -25}
a.Poke_Moltresa = a.MechUnit:new{Image="units/player/Moltres_a.png",  PosX = -45, PosY = -25, NumFrames = 6 }
a.Poke_Moltres_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Moltres_ns = a.MechIcon:new{Image="units/player/Moltres_ns.png"}


a.Poke_Mewtwo =a.MechUnit:new{Image="units/player/Mewtwo.png", PosX = -20, PosY = -4}
a.Poke_Mewtwoa = a.MechUnit:new{Image="units/player/Mewtwo_a.png",  PosX = -25, PosY = -14, NumFrames = 6 }
a.Poke_Mewtwo_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Mewtwo_ns = a.MechIcon:new{Image="units/player/Mewtwo_ns.png"}

a.Poke_Darkrai =a.MechUnit:new{Image="units/player/Darkrai.png", PosX = -20, PosY = -4}
a.Poke_Darkraia = a.MechUnit:new{Image="units/player/Darkrai_a.png",  PosX = -20, PosY = -14, NumFrames = 8 }
a.Poke_Darkrai_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Darkrai_ns = a.MechIcon:new{Image="units/player/Darkrai_ns.png"}

a.Poke_Deoxys =a.MechUnit:new{Image="units/player/Deoxys.png", PosX = -20, PosY = -4}
a.Poke_Deoxysw =a.MechUnit:new{Image="units/player/Deoxys_w.png", PosX = -18, PosY = -1}
a.Poke_Deoxysa = a.MechUnit:new{Image="units/player/Deoxys_a.png",  PosX = -15, PosY = -4, NumFrames = 8 }
a.Poke_Deoxys_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Deoxys_ns = a.MechIcon:new{Image="units/player/Deoxys_ns.png"}
a.Poke_DeoxysA =a.MechUnit:new{Image="units/player/DeoxysA.png", PosX = -20, PosY = -4}
a.Poke_DeoxysAw =a.MechUnit:new{Image="units/player/DeoxysA_w.png", PosX = -18, PosY = 4}
a.Poke_DeoxysAa = a.MechUnit:new{Image="units/player/DeoxysA_a.png",  PosX = -20, PosY = -4, NumFrames = 4 }
a.Poke_DeoxysA_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_DeoxysS =a.MechUnit:new{Image="units/player/DeoxysS.png", PosX = -20, PosY = -4}
a.Poke_DeoxysSw =a.MechUnit:new{Image="units/player/DeoxysS_w.png", PosX = -20, PosY = 3}
a.Poke_DeoxysSa = a.MechUnit:new{Image="units/player/DeoxysS_a.png",  PosX = -20, PosY = -4, NumFrames = 4 }
a.Poke_DeoxysS_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_DeoxysD =a.MechUnit:new{Image="units/player/DeoxysD.png", PosX = -20, PosY = -4}
a.Poke_DeoxysDw =a.MechUnit:new{Image="units/player/DeoxysD_w.png", PosX = -18, PosY = 2}
a.Poke_DeoxysDa = a.MechUnit:new{Image="units/player/DeoxysD_a.png",  PosX = -15, PosY = -3, NumFrames = 6, Time = 0.5 }
a.Poke_DeoxysD_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }


a.Poke_Celebi =a.MechUnit:new{Image="units/player/Celebi.png", PosX = -10, PosY = -4}
a.Poke_Celebia = a.MechUnit:new{Image="units/player/Celebi_a.png",  PosX = -15, PosY = -14, NumFrames = 6 }
a.Poke_Celebi_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Celebi_ns = a.MechIcon:new{Image="units/player/Celebi_ns.png"}

a.Poke_Shaymin =a.MechUnit:new{Image="units/player/Shaymin.png", PosX = -10, PosY = 14}
a.Poke_Shayminw =a.MechUnit:new{Image="units/player/Shaymin_w.png", PosX = -10, PosY = 14}
a.Poke_Shaymina = a.MechUnit:new{Image="units/player/Shaymin_a.png",  PosX = -10, PosY = 14, NumFrames = 4 }
a.Poke_Shaymin_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Shaymin_ns = a.MechIcon:new{Image="units/player/Shaymin_ns.png"}
a.Poke_ShayminAir =a.MechUnit:new{Image="units/player/ShayminAir.png", PosX = -10, PosY = 6}
a.Poke_ShayminAira = a.MechUnit:new{Image="units/player/ShayminAir_a.png",  PosX = -15, PosY = 6, NumFrames = 6, Frames = {0, 1, 2, 3} }

a.Poke_Xerneas =a.MechUnit:new{Image="units/player/Xerneas.png", PosX = -30, PosY = -34}
a.Poke_Xerneasw =a.MechUnit:new{Image="units/player/Xerneas_w.png", PosX = -30, PosY = -24}
a.Poke_Xerneasa = a.MechUnit:new{Image="units/player/Xerneas_a.png",  PosX = -30, PosY = -34, NumFrames = 6 }
a.Poke_Xerneas_sleep = a.MechUnit:new{Image="units/player/Xerneas_sleep.png",  PosX = -30, PosY = -44, NumFrames = 2, Time = 1.5 }
a.Poke_Xerneas_tree_sleep = a.MechUnit:new{Image="units/player/Xerneas_tree.png",  PosX = -40, PosY = -40, NumFrames = 4, Time = 1 }
-- we need a separate sleep anim so that when Darkrai puts Xerneas to sleep it doesn't turn into a tree; still suffixed _sleep so it counts for the sleep handling hook
a.Poke_Xerneas_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Xerneas_ns = a.MechIcon:new{Image="units/player/Xerneas_ns.png"}

a.Poke_ArmoredMewtwo =a.MechUnit:new{Image="units/player/ArmoredMewtwo.png", PosX = -20, PosY = 0}
a.Poke_ArmoredMewtwow =a.MechUnit:new{Image="units/player/ArmoredMewtwo_w.png", PosX = -20, PosY = 0}
a.Poke_ArmoredMewtwoa = a.MechUnit:new{Image="units/player/ArmoredMewtwo_a.png",  PosX = -20, PosY = 0, NumFrames = 2 }
a.Poke_ArmoredMewtwo_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_ArmoredMewtwo_ns = a.MechIcon:new{Image="units/player/ArmoredMewtwo_ns.png"}


a.Poke_Larvitar =a.MechUnit:new{Image="units/player/Larvitar.png", PosX = -10, PosY = 6}
a.Poke_Larvitara = a.MechUnit:new{Image="units/player/Larvitar_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Larvitar_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Larvitar_ns = a.MechIcon:new{Image="units/player/Larvitar_ns.png"}
a.Poke_Larvitarw =a.MechUnit:new{Image="units/player/Larvitar_w.png", PosX = -11, PosY = 8}

a.Poke_Pupitar =a.MechUnit:new{Image="units/player/Pupitar.png", PosX = -10, PosY = -4}
a.Poke_Pupitara = a.MechUnit:new{Image="units/player/Pupitar_a.png",  PosX = -15, PosY = -4, NumFrames = 5 }
a.Poke_Pupitar_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Pupitar_ns = a.MechIcon:new{Image="units/player/Pupitar_ns.png"}
a.Poke_Pupitarw =a.MechUnit:new{Image="units/player/Pupitar_w.png", PosX = -15, PosY = 5}

a.Poke_Tyranitar =a.MechUnit:new{Image="units/player/Tyranitar.png", PosX = -10, PosY = -4}
a.Poke_Tyranitara = a.MechUnit:new{Image="units/player/Tyranitar_a.png",  PosX = -20, PosY = 0, NumFrames = 5, Frames = {0,1,2,3,0,1,2,3,0,1,2,3,0,4}, }
a.Poke_Tyranitar_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Tyranitar_ns = a.MechIcon:new{Image="units/player/Tyranitar_ns.png"}
a.Poke_Tyranitarw =a.MechUnit:new{Image="units/player/Tyranitar_w.png", PosX = -15, PosY = 10}


a.Poke_Beldum =a.MechUnit:new{Image="units/player/Beldum.png", PosX = -10, PosY = -4}
a.Poke_Belduma = a.MechUnit:new{Image="units/player/Beldum_a.png",  PosX = -15, PosY = -10, NumFrames = 8 }
a.Poke_Beldum_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Beldum_ns = a.MechIcon:new{Image="units/player/Beldum_ns.png"}

a.Poke_Metang =a.MechUnit:new{Image="units/player/Metang.png", PosX = -10, PosY = -4}
a.Poke_Metanga = a.MechUnit:new{Image="units/player/Metang_a.png",  PosX = -25, PosY = -10, NumFrames = 8 }
a.Poke_Metang_swipe = a.MechUnit:new{Image="units/player/Metang_swipe.png",  PosX = -25, PosY = -10, NumFrames = 8 }
a.Poke_Metang_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Metang_ns = a.MechIcon:new{Image="units/player/Metang_ns.png"}

a.Poke_Metagross =a.MechUnit:new{Image="units/player/Metagross.png", PosX = -10, PosY = -4}
a.Poke_Metagrossa = a.MechUnit:new{Image="units/player/Metagross_a.png",  PosX = -22, PosY = 0, NumFrames = 6, Frames = {2,3,4,5,2,3,4,5,2,3,4,5,0,1}, }
a.Poke_Metagross_hover = a.MechUnit:new{Image="units/player/Metagross_hover.png",  PosX = -22, PosY = 0, NumFrames = 1 }
a.Poke_Metagross_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Metagross_ns = a.MechIcon:new{Image="units/player/Metagross_ns.png"}
a.Poke_Metagrossw =a.MechUnit:new{Image="units/player/Metagross_w.png", PosX = -23, PosY = 9}


a.Poke_Gible =a.MechUnit:new{Image="units/player/Gible.png", PosX = -10, PosY = -4}
a.Poke_Giblea = a.MechUnit:new{Image="units/player/Gible_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Gible_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Gible_ns = a.MechIcon:new{Image="units/player/Gible_ns.png"}
a.Poke_Giblew =a.MechUnit:new{Image="units/player/Gible_w.png", PosX = -12, PosY = 15}

a.Poke_Gabite =a.MechUnit:new{Image="units/player/Gabite.png", PosX = -10, PosY = -4}
a.Poke_Gabitea = a.MechUnit:new{Image="units/player/Gabite_a.png",  PosX = -15, PosY = 3, NumFrames = 4 }
a.Poke_Gabite_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_Gabite_ns = a.MechIcon:new{Image="units/player/Gabite_ns.png"}
a.Poke_Gabitew =a.MechUnit:new{Image="units/player/Gabite_w.png", PosX = -15, PosY = 6}

a.Poke_Garchomp =a.MechUnit:new{Image="units/player/Garchomp.png", PosX = -10, PosY = -4}
a.Poke_Garchompa = a.MechUnit:new{Image="units/player/Garchomp_a.png",  PosX = -20, PosY = -4, NumFrames = 6, Frames = {0,1,2,3,0,1,2,3,0,1,2,3,4,5,4}, }
a.Poke_Garchomp_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -20, PosY = -2 }
a.Poke_Garchomp_ns = a.MechIcon:new{Image="units/player/Garchomp_ns.png"}
a.Poke_Garchompw =a.MechUnit:new{Image="units/player/Garchomp_w.png", PosX = -20, PosY = 6}





modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Abra.png", path .."img/portraits/pilots/Pilot_Poke_Abra.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Dratini.png", path .."img/portraits/pilots/Pilot_Poke_Dratini.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Mew.png", path .."img/portraits/pilots/Pilot_Poke_Mew.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Articuno.png", path .."img/portraits/pilots/Pilot_Poke_Articuno.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Zapdos.png", path .."img/portraits/pilots/Pilot_Poke_Zapdos.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Moltres.png", path .."img/portraits/pilots/Pilot_Poke_Moltres.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Mewtwo.png", path .."img/portraits/pilots/Pilot_Poke_Mewtwo.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Deoxys.png", path .."img/portraits/pilots/Pilot_Poke_Deoxys.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Darkrai.png", path .."img/portraits/pilots/Pilot_Poke_Darkrai.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Celebi.png", path .."img/portraits/pilots/Pilot_Poke_Celebi.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Shaymin.png", path .."img/portraits/pilots/Pilot_Poke_Shaymin.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Xerneas.png", path .."img/portraits/pilots/Pilot_Poke_Xerneas.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_ArmoredMewtwo.png", path .."img/portraits/pilots/Pilot_Poke_ArmoredMewtwo.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Larvitar.png", path .."img/portraits/pilots/Pilot_Poke_Larvitar.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Beldum.png", path .."img/portraits/pilots/Pilot_Poke_Beldum.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Gible.png", path .."img/portraits/pilots/Pilot_Poke_Gible.png")

CreatePilot{
	Id = "Pilot_Poke_Abra",
	Personality = "Vek",
	Name = "Sabrina",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Dratini",
	Personality = "Vek",
	Name = "Lance",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Mew",
	Personality = "Vek",
	Name = "Blue",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Articuno",
	Personality = "Vek",
	Name = "Articuno",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Zapdos",
	Personality = "Vek",
	Name = "Zapdos",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Moltres",
	Personality = "Vek",
	Name = "Moltres",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Mewtwo",
	Personality = "Vek",
	Name = "Mewtwo",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Deoxys",
	Personality = "Vek",
	Name = "Deoxys",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Darkrai",
	Personality = "Vek",
	Name = "Darkrai",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Celebi",
	Personality = "Vek",
	Name = "Celebi",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Shaymin",
	Personality = "Vek",
	Name = "Shaymin",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Xerneas",
	Personality = "Vek",
	Name = "Xerneas",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_ArmoredMewtwo",
	Personality = "Vek",
	Name = "Mewtwo",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Larvitar",
	Personality = "Vek",
	Name = "Karen",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Gible",
	Personality = "Vek",
	Name = "Cynthia",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Beldum",
	Personality = "Vek",
	Name = "Steven",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}

Poke_Abra= Pawn:new{
	Name = "Sabrina",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Teleporter = true,
	Image = "Poke_Abra",
	SkillList = {"Poke_Pound"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Kadabra", "Poke_Alakazam" },
	EvoForget = { "Poke_Pound", "Poke_Confusion" },
	EvoLearn = { { "Poke_Confusion", "Poke_Kinesis" }, { "Poke_Psychic" } },
	EvoNames = { "Abra", "Kadabra", "Alakazam" },
	BecomeFlyingAtLevel = 2,
}
Poke_Dratini = Pawn:new{
	Name = "Lance",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Dratini",
	SkillList = {"Poke_DragonRage", "Poke_Slam"},
	SoundLocation = "/enemy/blobber_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Dragonair", "Poke_Dragonite" },
	EvoForget = { "Poke_DragonRage", "Poke_Slam" },
	EvoLearn = { { "Poke_Twister" }, { "Poke_Fly" } },
	EvoNames = { "Dratini", "Dragonair", "Dragonite" },
	KeepAdding = { "", "Poke_HyperBeam" },
	BecomeFlyingAtLevel = 2,
}
Poke_Mew = Pawn:new{
	Name = "Blue",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Mew",
	SkillList = {"Poke_Psywave", "Poke_Protect"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}
Poke_Articuno = Pawn:new{
	Name = "Articuno",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Articuno",
	SkillList = {"Poke_IcyWind"},
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- HasEvolutions = { false, false },
	KeepAdding = { "", "Poke_Blizzard" },
}
Poke_Zapdos = Pawn:new{
	Name = "Zapdos",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Zapdos",
	SkillList = {"Poke_Shockwave"},
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- HasEvolutions = { false, false },
	KeepAdding = { "", "Poke_Thunder" },
}
Poke_Moltres = Pawn:new{
	Name = "Moltres",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	IgnoreMoltres = true,
	Image = "Poke_Moltres",
	SkillList = {"Poke_HeatWave"},
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- HasEvolutions = { false, false },
	KeepAdding = { "", "Poke_MoltresBlast" },
}
Poke_Mewtwo = Pawn:new{
	Name = "Mewtwo",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Flying = true,
	Corpse = true,
	Image = "Poke_Mewtwo",
	SkillList = {"Poke_Confusion"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoForget = { "Poke_Confusion", "Poke_Psychic" },
	EvoLearn = { { "Poke_Psychic", "Poke_ShadowBall" }, { "Poke_Psystrike" } },
}
Poke_Darkrai = Pawn:new{
	Name = "Darkrai",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Flying = true,
	Corpse = true,
	GhostMovement = true,
	Image = "Poke_Darkrai",
	SkillList = {"Poke_DarkPulse", "Poke_Hypnosis"},
	SoundLocation = "",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { false, true },
	EvoForget = { "", "Poke_Hypnosis" },
	EvoLearn = { { "" }, { "Poke_DarkVoid" } },
}
Poke_Deoxys = Pawn:new{
	Name = "Deoxys",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Poke_Deoxys",
	SkillList = {"Poke_FormChange"},
	SoundLocation = "/enemy/blobber_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoForget = { "", "Poke_CosmicPower" },
	EvoLearn = { { "Poke_CosmicPower" }, { "Poke_PsychoBoost" } },
}
Poke_Celebi = Pawn:new{
	Name = "Celebi",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Celebi",
	SkillList = {"Poke_NaturePower", "Poke_TimeTravel"},
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	GrassMovement = true,
}
Poke_Shaymin = Pawn:new{
	Name = "Shaymin",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	IgnoreAcid = true,
	Image = "Poke_Shaymin",
	SkillList = {"Poke_Bloom" },
	SoundLocation = "/enemy/firefly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { false, true },
	EvoGraphics = { "Poke_Shaymin", "Poke_ShayminAir" },
	EvoForget = { "", "" },
	EvoLearn = { { "" }, { "Poke_SeedFlare" } },
	GrassMovement = true,
	BecomeFlyingAtLevel = 2,
}
Poke_Xerneas = Pawn:new{
	Name = "Xerneas",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Poke_Xerneas",
	SkillList = {"Poke_PetalBlizzard" },
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { "Poke_Moonblast" }, { "" } },
	KeepAdding = { "", "Poke_EternalLife" },
	GrassMovement = true,
}
modApi:addPalette{
    ID = "Poke_ArmoredMewtwo_pal",
	image="units/player/ArmoredMewtwo.png",
    Name = "Armored Mewtwo",
    PlateHighlight = {75,177,255},--lights
    PlateLight     = {169,173,211},--main highlight
    PlateMid       = {129,133,171},--main light
    PlateDark      = {89,93,131},--main mid
    PlateOutline   = {49,53,91},--main dark
    BodyHighlight  = {248,248,248},--metal light
    BodyColor      = {144,152,160},--metal mid
    PlateShadow    = {52,71,75},--metal dark
}
Poke_ArmoredMewtwo = Pawn:new{
	Name = "Mewtwo",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Armor = true,
	Teleporter = true,
	Image = "Poke_ArmoredMewtwo",
	ImageOffset = modApi:getPaletteImageOffset("Poke_ArmoredMewtwo_pal"),
	SkillList = {"Poke_Reflect", "Poke_Teleport" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
Poke_Larvitar = Pawn:new{
	Name = "Karen",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Larvitar",
	SkillList = {"Poke_RockThrow"},
	SoundLocation = "/enemy/digger_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_ROCK,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Pupitar", "Poke_Tyranitar" },
	EvoForget = { "Poke_RockThrow", "Poke_RockSlide" },
	EvoLearn = { { "Poke_RockSlide", "Poke_Sandstorm" }, { "Poke_StoneEdge" } },
	EvoNames = { "Larvitar", "Pupitar", "Tyranitar" },
}
Poke_Beldum = Pawn:new{
	Name = "Steven",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Beldum",
	SkillList = {"Poke_TakeDown"},
	SoundLocation = "/enemy/digger_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Metang", "Poke_Metagross" },
	EvoForget = { "Poke_TakeDown", "Poke_MetalClaw" },
	EvoLearn = { { "Poke_MetalClaw", "Poke_ZenHeadbutt" }, { "Poke_MeteorMash" } },
	EvoNames = { "Beldum", "Metang", "Metagross" },
	LoseFlyingAtLevel = 2,
}
Poke_Gible = Pawn:new{
	Name = "Cynthia",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Poke_Gible",
	SkillList = {"Poke_Bite"},
	SoundLocation = "/enemy/burrower_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Gabite", "Poke_Garchomp" },
	EvoForget = { "Poke_Bite" },
	EvoLearn = { { "Poke_Crunch" }, { "Poke_Earthquake" } },
	EvoNames = { "Gible", "Gabite", "Garchomp" },
}




local oldMove = Move.GetTargetArea
function Move:GetTargetArea(p, ...)
	local mover = Board:GetPawn(p)
	if mover and _G[mover:GetType()].GhostMovement then
		local pathType
		local area = extract_table(general_DiamondTarget(p, mover:GetMoveSpeed()))
		local ret = PointList()
		for _, v in ipairs(area) do
			local terrain = Board:GetTerrain(v)
			if (terrain ~= TERRAIN_HOLE or mover:IsFlying()) and not Board:GetPawn(v) then
				ret:push_back(v)
			end
		end
		return ret
	end
	return oldMove(self, p, ...)
end

local oldMove = Move.GetSkillEffect
function Move:GetSkillEffect(p1, p2, ...)
	local ret = SkillEffect()
	local mover = Board:GetPawn(p1)
	local willBoost
	if mover and _G[mover:GetType()].GhostMovement then
		ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", p1:GetString(), p2:GetString()))
		return ret
	end
	return oldMove(self, p1, p2, ...)
end
