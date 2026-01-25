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
-- local tileToScreen = require(path .."scripts/libs/tileToScreen")
local mechPath = mod_loader.mods[modApi.currentMod].resourcePath .."img/units/player/"

modApi:appendAssets("img/units/player/", "img/units/player/")

local a=ANIMS
a.Poke_Abra =a.MechUnit:new{Image="units/player/Abra.png", PosX = -18, PosY = -9}
a.Poke_Abraa = a.MechUnit:new{Image="units/player/Abra_a.png",  PosX = -13, PosY = -4, NumFrames = 4 }
a.Poke_Abraw = a.MechUnit:new{Image="units/player/Abra_w.png", PosX = -13, PosY = 12}
a.Poke_Abra_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Abra_ns = a.MechIcon:new{Image="units/player/Abra_ns.png"}

a.Poke_Kadabra =a.MechUnit:new{Image="units/player/Kadabra.png", PosX = -18, PosY = 2}
a.Poke_Kadabraa = a.MechUnit:new{Image="units/player/Kadabra_a.png",  PosX = -18, PosY = 2, NumFrames = 4 }
a.Poke_Kadabraw = a.MechUnit:new{Image="units/player/Kadabra_w.png", PosX = -13, PosY = 10}
a.Poke_Kadabra_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
-- a.Poke_Kadabraw_broken = a.MechUnit:new{Image="units/player/Kadabra_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Kadabra_ns = a.MechIcon:new{Image="units/player/Kadabra_ns.png"}

a.Poke_Alakazam =a.MechUnit:new{Image="units/player/Alakazam.png", PosX = -18, PosY = -9}
a.Poke_Alakazama = a.MechUnit:new{Image="units/player/Alakazam_a.png",  PosX = -18, PosY = -9, NumFrames = 8 }
a.Poke_Alakazam_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Alakazam_ns = a.MechIcon:new{Image="units/player/Alakazam_ns.png"}
a.Poke_MegaAlakazam =a.MechUnit:new{Image="units/player/MegaAlakazam.png", PosX = -18, PosY = -9}
a.Poke_MegaAlakazama = a.MechUnit:new{Image="units/player/MegaAlakazam_a.png",  PosX = -25, PosY = -19, NumFrames = 8, Frames = {0,1,2,3,4,4,4,4,5,6,7} }
a.Poke_MegaAlakazam_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaAlakazam_ns = a.MechIcon:new{Image="units/player/MegaAlakazam_ns.png"}


a.Poke_Dratini =a.MechUnit:new{Image="units/player/Dratini.png", PosX = -15, PosY = -2}
a.Poke_Dratinia = a.MechUnit:new{Image="units/player/Dratini_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dratiniw = a.MechUnit:new{Image="units/player/Dratini_w.png", PosX = -15, PosY = 4}
a.Poke_Dratini_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
-- a.Poke_Dratiniw_broken = a.MechUnit:new{Image="units/player/Dratini_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dratini_ns = a.MechIcon:new{Image="units/player/Dratini_ns.png"}

a.Poke_Dragonair =a.MechUnit:new{Image="units/player/Dragonair.png", PosX = -15, PosY = -2}
a.Poke_Dragonaira = a.MechUnit:new{Image="units/player/Dragonair_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dragonairw = a.MechUnit:new{Image="units/player/Dragonair_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonair_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonairw_broken = a.MechUnit:new{Image="units/player/Dragonair_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonair_ns = a.MechIcon:new{Image="units/player/Dragonair_ns.png"}

a.Poke_Dragonite =a.MechUnit:new{Image="units/player/Dragonite.png", PosX = -20, PosY = -8}
a.Poke_Dragonitea = a.MechUnit:new{Image="units/player/Dragonite_a.png",  PosX = -20, PosY = -8, NumFrames = 4 }
a.Poke_Dragonitew = a.MechUnit:new{Image="units/player/Dragonite_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonite_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonitew_broken = a.MechUnit:new{Image="units/player/Dragonite_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonite_ns = a.MechIcon:new{Image="units/player/Dragonite_ns.png"}
a.Poke_Dragonite_sleep = a.MechUnit:new{Image="units/player/Dragonite_sleep.png", PosX = -15, PosY = -12, NumFrames = 2, Time = 1 }


a.Poke_Mew =a.MechUnit:new{Image="units/player/Mew.png", PosX = -20, PosY = -4}
a.Poke_Mewa = a.MechUnit:new{Image="units/player/Mew_a.png",  PosX = -20, PosY = -4, NumFrames = 4 }
a.Poke_Meww = a.MechUnit:new{Image="units/player/Mew_w.png", PosX = -17, PosY = 2}
a.Poke_Mew_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
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
a.Poke_MegaMewtwoX =a.MechUnit:new{Image="units/player/MegaMewtwoX.png", PosX = -20, PosY = -4}
a.Poke_MegaMewtwoXa = a.MechUnit:new{Image="units/player/MegaMewtwoX_a.png",  PosX = -25, PosY = -14, NumFrames = 12 }
a.Poke_MegaMewtwoX_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaMewtwoX_ns = a.MechIcon:new{Image="units/player/MegaMewtwoX_ns.png"}
a.Poke_MegaMewtwoY =a.MechUnit:new{Image="units/player/MegaMewtwoY.png", PosX = -20, PosY = -4}
a.Poke_MegaMewtwoYa = a.MechUnit:new{Image="units/player/MegaMewtwoY_a.png",  PosX = -25, PosY = -14, NumFrames = 6 }
a.Poke_MegaMewtwoY_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaMewtwoY_ns = a.MechIcon:new{Image="units/player/MegaMewtwoY_ns.png"}

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
a.Poke_DeoxysDa = a.MechUnit:new{Image="units/player/DeoxysD_a.png",  PosX = -15, PosY = -3, NumFrames = 3, Time = 0.5, Frames = {0, 1, 2, 1} }
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
a.Poke_Xerneas_special_sleep = a.MechUnit:new{Image="units/player/Xerneas_tree.png",  PosX = -40, PosY = -40, NumFrames = 4, Time = 1 }
-- we need a separate sleep anim so that when Darkrai puts Xerneas to sleep it doesn't turn into a tree; still suffixed _sleep so it counts for the sleep handling hook
a.Poke_Xerneas_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Xerneas_ns = a.MechIcon:new{Image="units/player/Xerneas_ns.png"}

a.Poke_ArmoredMewtwo =a.MechUnit:new{Image="units/player/ArmoredMewtwo.png", PosX = -20, PosY = 0}
a.Poke_ArmoredMewtwoa = a.MechUnit:new{Image="units/player/ArmoredMewtwo_a.png",  PosX = -20, PosY = 0, NumFrames = 6, Frames = {0,1,2,3,4,5,4,3,2,1} }
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
a.Poke_MegaTyranitar =a.MechUnit:new{Image="units/player/MegaTyranitar.png", PosX = -10, PosY = -4}
a.Poke_MegaTyranitara = a.MechUnit:new{Image="units/player/MegaTyranitar_a.png",  PosX = -15, PosY = 6, NumFrames = 3, Frames ={0,1,2,1} }
a.Poke_MegaTyranitar_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaTyranitar_ns = a.MechIcon:new{Image="units/player/Tyranitar_ns.png"}
a.Poke_MegaTyranitarw =a.MechUnit:new{Image="units/player/MegaTyranitar_w.png", PosX = -12, PosY = 15}


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
a.Poke_MegaGarchomp =a.MechUnit:new{Image="units/player/MegaGarchomp.png", PosX = -10, PosY = -4}
a.Poke_MegaGarchompa = a.MechUnit:new{Image="units/player/MegaGarchomp_a.png",  PosX = -20, PosY = -4, NumFrames = 3, Frames = {0,1,2,1}, }
a.Poke_MegaGarchomp_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -20, PosY = -2 }
a.Poke_MegaGarchomp_ns = a.MechIcon:new{Image="units/player/Garchomp_ns.png"}
a.Poke_MegaGarchompw =a.MechUnit:new{Image="units/player/MegaGarchomp_w.png", PosX = -20, PosY = 6}
a.Poke_DracoMeteor = a.MechUnit:new{Image="units/player/DracoMeteor.png",  PosX = -20, PosY = -4, NumFrames = 1, }
a.Poke_DracoMeteora = a.Poke_DracoMeteor
a.Poke_DracoMeteord = a.MechUnit:new{Image="units/player/DracoMeteor_death.png",  PosX = -20, PosY = -4, NumFrames = 13, Time = 0.07 }


a.Poke_Eevee =a.MechUnit:new{Image="units/player/Eevee.png", PosX = -15, PosY = 6}
a.Poke_Eeveea = a.MechUnit:new{Image="units/player/Eevee_a.png",  PosX = -15, PosY = 6, NumFrames = 2 }
a.Poke_Eevee_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Eevee_ns = a.MechIcon:new{Image="units/player/Eevee_ns.png"}
a.Poke_Eeveew =a.MechUnit:new{Image="units/player/Eevee_w.png", PosX = -12, PosY = 15}

a.Poke_Jolteon =a.MechUnit:new{Image="units/player/Jolteon.png", PosX = -15, PosY = 6}
a.Poke_Jolteona = a.MechUnit:new{Image="units/player/Jolteon_a.png",  PosX = -15, PosY = 6, NumFrames = 3, Frames = {0,2,1,2} }
a.Poke_Jolteon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Jolteon_ns = a.MechIcon:new{Image="units/player/Jolteon_ns.png"}
a.Poke_Jolteonw =a.MechUnit:new{Image="units/player/Jolteon_w.png", PosX = -12, PosY = 15}
a.Poke_Jolteon_charge_0 = a.MechUnit:new{Image="units/player/Jolteon_charge_0.png",  PosX = -15, PosY = 6 }
a.Poke_Jolteon_charge_1 = a.MechUnit:new{Image="units/player/Jolteon_charge_1.png",  PosX = -15, PosY = 6 }
a.Poke_Jolteon_charge_2 = a.MechUnit:new{Image="units/player/Jolteon_charge_2.png",  PosX = -15, PosY = 6 }
a.Poke_Jolteon_charge_3 = a.MechUnit:new{Image="units/player/Jolteon_charge_3.png",  PosX = -15, PosY = 6 }

a.Poke_Vaporeon =a.MechUnit:new{Image="units/player/Vaporeon.png", PosX = -10, PosY = -4}
a.Poke_Vaporeona = a.MechUnit:new{Image="units/player/Vaporeon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Vaporeon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Vaporeon_ns = a.MechIcon:new{Image="units/player/Vaporeon_ns.png"}
a.Poke_Vaporeonw =a.MechUnit:new{Image="units/player/Vaporeon_w.png", PosX = -12, PosY = 15}
a.Poke_Vaporeon_bubble = a.MechUnit:new{Image="units/player/Vaporeon_bubble.png",  PosX = -15, PosY = 6 }

a.Poke_Flareon =a.MechUnit:new{Image="units/player/Flareon.png", PosX = -10, PosY = -4}
a.Poke_Flareona = a.MechUnit:new{Image="units/player/Flareon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Flareon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Flareon_ns = a.MechIcon:new{Image="units/player/Flareon_ns.png"}
a.Poke_Flareonw =a.MechUnit:new{Image="units/player/Flareon_w.png", PosX = -12, PosY = 15}

a.Poke_Espeon =a.MechUnit:new{Image="units/player/Espeon.png", PosX = -10, PosY = -4}
a.Poke_Espeona = a.MechUnit:new{Image="units/player/Espeon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Espeon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Espeon_ns = a.MechIcon:new{Image="units/player/Espeon_ns.png"}
a.Poke_Espeonw =a.MechUnit:new{Image="units/player/Espeon_w.png", PosX = -12, PosY = 15}

a.Poke_Umbreon =a.MechUnit:new{Image="units/player/Umbreon.png", PosX = -10, PosY = -4}
a.Poke_Umbreona = a.MechUnit:new{Image="units/player/Umbreon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Umbreon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Umbreon_ns = a.MechIcon:new{Image="units/player/Umbreon_ns.png"}
a.Poke_Umbreonw =a.MechUnit:new{Image="units/player/Umbreon_w.png", PosX = -12, PosY = 15}

a.Poke_Leafeon =a.MechUnit:new{Image="units/player/Leafeon.png", PosX = -10, PosY = -4}
a.Poke_Leafeona = a.MechUnit:new{Image="units/player/Leafeon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Leafeon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Leafeon_ns = a.MechIcon:new{Image="units/player/Leafeon_ns.png"}
a.Poke_Leafeonw =a.MechUnit:new{Image="units/player/Leafeon_w.png", PosX = -12, PosY = 15}

a.Poke_Glaceon =a.MechUnit:new{Image="units/player/Glaceon.png", PosX = -10, PosY = -4}
a.Poke_Glaceona = a.MechUnit:new{Image="units/player/Glaceon_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Glaceon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Glaceon_ns = a.MechIcon:new{Image="units/player/Glaceon_ns.png"}
a.Poke_Glaceonw =a.MechUnit:new{Image="units/player/Glaceon_w.png", PosX = -12, PosY = 15}

a.Poke_Sylveon =a.MechUnit:new{Image="units/player/Sylveon.png", PosX = -10, PosY = -4}
a.Poke_Sylveona = a.MechUnit:new{Image="units/player/Sylveon_a.png",  PosX = -15, PosY = 1, NumFrames = 4 }
a.Poke_Sylveon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Sylveon_ns = a.MechIcon:new{Image="units/player/Sylveon_ns.png"}
a.Poke_Sylveonw =a.MechUnit:new{Image="units/player/Sylveon_w.png", PosX = -15, PosY = 7}


a.Poke_Ralts =a.MechUnit:new{Image="units/player/Ralts.png", PosX = -10, PosY = -4}
a.Poke_Raltsa = a.MechUnit:new{Image="units/player/Ralts_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Ralts_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Ralts_ns = a.MechIcon:new{Image="units/player/Ralts_ns.png"}
a.Poke_Raltsw =a.MechUnit:new{Image="units/player/Ralts_w.png", PosX = -12, PosY = 15}

a.Poke_Kirlia =a.MechUnit:new{Image="units/player/Kirlia.png", PosX = -10, PosY = -4}
a.Poke_Kirliaa = a.MechUnit:new{Image="units/player/Kirlia_a.png",  PosX = -15, PosY = 6, NumFrames = 13, Time = 0.1, Frames = {0,0,0,1,1,1,2,2,2,3,3,3,4,5,6,7,8,9,10,11,12}}
a.Poke_Kirlia_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Kirlia_ns = a.MechIcon:new{Image="units/player/Kirlia_ns.png"}
a.Poke_Kirliaw =a.MechUnit:new{Image="units/player/Kirlia_w.png", PosX = -12, PosY = 15}

a.Poke_Gardevoir =a.MechUnit:new{Image="units/player/Gardevoir.png", PosX = -10, PosY = -4}
a.Poke_Gardevoira = a.MechUnit:new{Image="units/player/Gardevoir_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_Gardevoir_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Gardevoir_ns = a.MechIcon:new{Image="units/player/Gardevoir_ns.png"}
a.Poke_Gardevoirw =a.MechUnit:new{Image="units/player/Gardevoir_w.png", PosX = -12, PosY = 15}
a.Poke_MegaGardevoir =a.MechUnit:new{Image="units/player/MegaGardevoir.png", PosX = -10, PosY = -4}
a.Poke_MegaGardevoira = a.MechUnit:new{Image="units/player/MegaGardevoir_a.png",  PosX = -15, PosY = 6, NumFrames = 4 }
a.Poke_MegaGardevoir_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaGardevoir_ns = a.MechIcon:new{Image="units/player/MegaGardevoir_ns.png"}
a.Poke_MegaGardevoirw =a.MechUnit:new{Image="units/player/MegaGardevoir_w.png", PosX = -12, PosY = 15}

a.Poke_Gallade =a.MechUnit:new{Image="units/player/Gallade.png", PosX = -10, PosY = -4}
a.Poke_Galladea = a.MechUnit:new{Image="units/player/Gallade_a.png",  PosX = -15, PosY = -3, NumFrames = 4 }
a.Poke_Gallade_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Gallade_ns = a.MechIcon:new{Image="units/player/Gallade_ns.png"}
a.Poke_Galladew =a.MechUnit:new{Image="units/player/Gallade_w.png", PosX = -12, PosY = 10}
a.Poke_MegaGallade =a.MechUnit:new{Image="units/player/MegaGallade.png", PosX = -10, PosY = -4}
a.Poke_MegaGalladea = a.MechUnit:new{Image="units/player/MegaGallade_a.png",  PosX = -15, PosY = -3, NumFrames = 4 }
a.Poke_MegaGallade_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_MegaGallade_ns = a.MechIcon:new{Image="units/player/MegaGallade_ns.png"}
a.Poke_MegaGalladew =a.MechUnit:new{Image="units/player/MegaGallade_w.png", PosX = -12, PosY = 10}

a.Poke_Scyther =a.MechUnit:new{Image="units/player/Scyther.png", PosX = -10, PosY = -4}
a.Poke_Scythera = a.MechUnit:new{Image="units/player/Scyther_a.png",  PosX = -25, PosY = -1, NumFrames = 4 }
a.Poke_Scyther_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Scyther_ns = a.MechIcon:new{Image="units/player/Scyther_ns.png"}
a.Poke_Scytherw =a.MechUnit:new{Image="units/player/Scyther_w.png", PosX = -12, PosY = 10}

a.Poke_Scizor =a.MechUnit:new{Image="units/player/Scizor.png", PosX = -10, PosY = -4}
a.Poke_Scizora = a.MechUnit:new{Image="units/player/Scizor_a.png",  PosX = -20, PosY = -3, NumFrames = 4 }
a.Poke_Scizor_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Scizor_ns = a.MechIcon:new{Image="units/player/Scizor_ns.png"}
a.Poke_Scizorw =a.MechUnit:new{Image="units/player/Scizor_w.png", PosX = -12, PosY = 10}

a.Poke_Kleavor =a.MechUnit:new{Image="units/player/Kleavor.png", PosX = -10, PosY = -4}
a.Poke_Kleavora = a.MechUnit:new{Image="units/player/Kleavor_a.png",  PosX = -28, PosY = -1, NumFrames = 4 }
a.Poke_Kleavor_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Kleavor_ns = a.MechIcon:new{Image="units/player/Kleavor_ns.png"}
a.Poke_Kleavorw =a.MechUnit:new{Image="units/player/Kleavor_w.png", PosX = -12, PosY = 10}

a.Poke_Dialga =a.MechUnit:new{Image="units/player/Dialga.png", PosX = -10, PosY = -4}
a.Poke_Dialgaa = a.MechUnit:new{Image="units/player/Dialga_a.png",  PosX = -35, PosY = -21, NumFrames = 4 }
a.Poke_Dialga_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Dialga_ns = a.MechIcon:new{Image="units/player/Dialga_ns.png"}
a.Poke_Dialgaw =a.MechUnit:new{Image="units/player/Dialga_w.png", PosX = -12, PosY = 10}
a.Poke_Dialga_sleep = a.MechUnit:new{Image="units/player/Dialga_sleep.png",  PosX = -32, PosY = -12, NumFrames = 2, Time = 1.5 }
a.Poke_DialgaOrigin =a.MechUnit:new{Image="units/player/DialgaOrigin.png", PosX = -10, PosY = -4}
a.Poke_DialgaOrigina = a.MechUnit:new{Image="units/player/DialgaOrigin_a.png",  PosX = -35, PosY = -31, NumFrames = 8 }
a.Poke_DialgaOrigin_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_DialgaOrigin_ns = a.MechIcon:new{Image="units/player/DialgaOrigin_ns.png"}
a.Poke_DialgaOriginw =a.MechUnit:new{Image="units/player/DialgaOrigin_w.png", PosX = -12, PosY = 10}


a.Poke_Palkia =a.MechUnit:new{Image="units/player/Palkia.png", PosX = -10, PosY = -4}
a.Poke_Palkiaa = a.MechUnit:new{Image="units/player/Palkia_a.png",  PosX = -35, PosY = -21, NumFrames = 4 }
a.Poke_Palkia_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Palkia_ns = a.MechIcon:new{Image="units/player/Palkia_ns.png"}
a.Poke_Palkiaw =a.MechUnit:new{Image="units/player/Palkia_w.png", PosX = -35, PosY = -21}
a.Poke_Palkia_sleep = a.MechUnit:new{Image="units/player/Palkia_sleep.png",  PosX = -32, PosY = -12, NumFrames = 2, Time = 1.5 }
a.Poke_PalkiaOrigin =a.MechUnit:new{Image="units/player/PalkiaOrigin.png", PosX = -10, PosY = -4}
a.Poke_PalkiaOrigina = a.MechUnit:new{Image="units/player/PalkiaOrigin_a.png",  PosX = -35, PosY = -31, NumFrames = 8 }
a.Poke_PalkiaOrigin_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_PalkiaOrigin_ns = a.MechIcon:new{Image="units/player/PalkiaOrigin_ns.png"}
a.Poke_PalkiaOriginw =a.MechUnit:new{Image="units/player/PalkiaOrigin_w.png", PosX = -12, PosY = 10}


a.Poke_Giratina =a.MechUnit:new{Image="units/player/Giratina.png", PosX = -10, PosY = -4}
a.Poke_Giratinaa = a.MechUnit:new{Image="units/player/Giratina_a.png",  PosX = -35, PosY = -30, NumFrames = 16 }
a.Poke_Giratina_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Giratina_ns = a.MechIcon:new{Image="units/player/Giratina_ns.png"}
a.Poke_GiratinaShadow_ns = a.MechIcon:new{Image="units/player/GiratinaShadow.png", PosX = -10, PosY = -4}
a.Poke_GiratinaShadow =a.MechUnit:new{Image="units/player/GiratinaShadow.png", PosX = -10, PosY = -4}
a.Poke_GiratinaShadowa = a.MechUnit:new{Image="units/player/GiratinaShadow_a.png",  PosX = -35, PosY = -30, NumFrames = 16 }

a.Poke_Arceus =a.MechUnit:new{Image="units/player/Arceus.png", PosX = -10, PosY = -4}
a.Poke_Arceusa = a.MechUnit:new{Image="units/player/Arceus_a.png",  PosX = -25, PosY = -30, NumFrames = 8 }

a.Poke_ArceusElectric =a.Poke_Arceus:new{Image="units/player/ArceusElectric.png"}
a.Poke_ArceusElectrica = a.Poke_Arceusa:new{Image="units/player/ArceusElectric_a.png"}
a.Poke_ArceusFairy =a.Poke_Arceus:new{Image="units/player/ArceusFairy.png"}
a.Poke_ArceusFairya = a.Poke_Arceusa:new{Image="units/player/ArceusFairy_a.png"}
a.Poke_ArceusFire =a.Poke_Arceus:new{Image="units/player/ArceusFire.png"}
a.Poke_ArceusFirea = a.Poke_Arceusa:new{Image="units/player/ArceusFire_a.png"}
a.Poke_ArceusGrass =a.Poke_Arceus:new{Image="units/player/ArceusGrass.png"}
a.Poke_ArceusGrassa = a.Poke_Arceusa:new{Image="units/player/ArceusGrass_a.png"}
a.Poke_ArceusGround =a.Poke_Arceus:new{Image="units/player/ArceusGround.png"}
a.Poke_ArceusGrounda = a.Poke_Arceusa:new{Image="units/player/ArceusGround_a.png"}
a.Poke_ArceusIce =a.Poke_Arceus:new{Image="units/player/ArceusIce.png"}
a.Poke_ArceusIcea = a.Poke_Arceusa:new{Image="units/player/ArceusIce_a.png"}
a.Poke_ArceusPoison =a.Poke_Arceus:new{Image="units/player/ArceusPoison.png"}
a.Poke_ArceusPoisona = a.Poke_Arceusa:new{Image="units/player/ArceusPoison_a.png"}
a.Poke_ArceusWater =a.Poke_Arceus:new{Image="units/player/ArceusWater.png"}
a.Poke_ArceusWatera = a.Poke_Arceusa:new{Image="units/player/ArceusWater_a.png"}

a.Poke_Arceus_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Arceus_ns = a.MechIcon:new{Image="units/player/Arceus_ns.png"}

a.Poke_Metanitar =a.MechUnit:new{Image="units/player/Metanitar.png", PosX = -20, PosY = -11}
a.Poke_Metanitara = a.MechUnit:new{Image="units/player/Metanitar_a.png",  PosX = -20, PosY = -11, NumFrames = 3, Time = 0.4, Frames = {0,1,2,1} }
a.Poke_Metanitar_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Metanitar_ns = a.MechIcon:new{Image="units/player/Metanitar_ns.png"}
a.Poke_Metanitarw =a.MechUnit:new{Image="units/player/Metanitar_w.png", PosX = -16, PosY = 0}

a.Poke_Tyrachomp =a.MechUnit:new{Image="units/player/Tyrachomp.png", PosX = -10, PosY = -4}
a.Poke_Tyrachompa = a.MechUnit:new{Image="units/player/Tyrachomp_a.png", PosX = -20, PosY = -4, NumFrames = 4, }
a.Poke_Tyrachomp_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -20, PosY = -2 }
a.Poke_Tyrachomp_ns = a.MechIcon:new{Image="units/player/Tyrachomp_ns.png"}
a.Poke_Tyrachompw =a.MechUnit:new{Image="units/player/Tyrachomp_w.png", PosX = -20, PosY = 6}


a.Poke_Charmander =a.MechUnit:new{Image="units/player/Charmander.png", PosX = -15, PosY = 6}
a.Poke_Charmandera = a.MechUnit:new{Image="units/player/Charmander_a.png",  PosX = -15, PosY = 6, NumFrames = 3 }
a.Poke_Charmander_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Charmander_ns = a.MechIcon:new{Image="units/player/Charmander_ns.png"}
a.Poke_Charmanderw =a.MechUnit:new{Image="units/player/Charmander_w.png", PosX = -12, PosY = 15}

a.Poke_Charmeleon =a.MechUnit:new{Image="units/player/Charmeleon.png", PosX = -15, PosY = 3}
a.Poke_Charmeleona = a.MechUnit:new{Image="units/player/Charmeleon_a.png",  PosX = -15, PosY = 3, NumFrames = 3, Frames = {0,1,2,1} }
a.Poke_Charmeleon_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Charmeleon_ns = a.MechIcon:new{Image="units/player/Charmeleon_ns.png"}
a.Poke_Charmeleonw =a.MechUnit:new{Image="units/player/Charmeleon_w.png", PosX = -15, PosY = 6}

a.Poke_Charizard =a.MechUnit:new{Image="units/player/Charizard.png", PosX = -20, PosY = -4}
a.Poke_Charizarda = a.MechUnit:new{Image="units/player/Charizard_a.png",  PosX = -20, PosY = -4, NumFrames = 5, Frames = {0,1,2,1,0,1,2,1,0,1,4,3}, }
a.Poke_Charizard_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -20, PosY = -2 }
a.Poke_Charizard_ns = a.MechIcon:new{Image="units/player/Charizard_ns.png"}
a.Poke_MegaCharizardX =a.MechUnit:new{Image="units/player/MegaCharizardX.png", PosX = -20, PosY = -4}
a.Poke_MegaCharizardXa = a.MechUnit:new{Image="units/player/MegaCharizardX_a.png",  PosX = -20, PosY = -4, NumFrames = 3, Frames = {0,2,1,2}, }
a.Poke_MegaCharizardX_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -20, PosY = -2 }
a.Poke_MegaCharizardX_ns = a.Poke_Charizard_ns
a.Poke_MegaCharizardY =a.MechUnit:new{Image="units/player/MegaCharizardY.png", PosX = -20, PosY = -4}
a.Poke_MegaCharizardYa = a.MechUnit:new{Image="units/player/MegaCharizardY_a.png",  PosX = -20, PosY = -4, NumFrames = 3, Frames = {0,1,2,1}, }
a.Poke_MegaCharizardY_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -20, PosY = -2 }
a.Poke_MegaCharizardY_ns = a.Poke_Charizard_ns

a.Poke_Bulbasaur =a.MechUnit:new{Image="units/player/Bulbasaur.png", PosX = -10, PosY = -4}
a.Poke_Bulbasaura = a.MechUnit:new{Image="units/player/Bulbasaur_a.png",  PosX = -15, PosY = 6, NumFrames = 2 }
a.Poke_Bulbasaur_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Bulbasaur_ns = a.MechIcon:new{Image="units/player/Bulbasaur_ns.png"}
a.Poke_Bulbasaurw =a.MechUnit:new{Image="units/player/Bulbasaur_w.png", PosX = -12, PosY = 15}

a.Poke_Ivysaur =a.MechUnit:new{Image="units/player/Ivysaur.png", PosX = -10, PosY = -4}
a.Poke_Ivysaura = a.MechUnit:new{Image="units/player/Ivysaur_a.png",  PosX = -15, PosY = 3, NumFrames = 3 }
a.Poke_Ivysaur_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Ivysaur_ns = a.MechIcon:new{Image="units/player/Ivysaur_ns.png"}
a.Poke_Ivysaurw =a.MechUnit:new{Image="units/player/Ivysaur_w.png", PosX = -15, PosY = 6}

a.Poke_Venusaur =a.MechUnit:new{Image="units/player/Venusaur.png", PosX = -20, PosY = 6}
a.Poke_Venusaura = a.MechUnit:new{Image="units/player/Venusaur_a.png",  PosX = -20, PosY = 6, NumFrames = 3, Frames = {0,2,1,2}, }
a.Poke_Venusaur_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -20, PosY = -2 }
a.Poke_Venusaur_ns = a.MechIcon:new{Image="units/player/Venusaur_ns.png"}
a.Poke_Venusaurw =a.MechUnit:new{Image="units/player/Venusaur_w.png", PosX = -20, PosY = 6}

a.Poke_Squirtle =a.MechUnit:new{Image="units/player/Squirtle.png", PosX = -10, PosY = -4}
a.Poke_Squirtlea = a.MechUnit:new{Image="units/player/Squirtle_a.png",  PosX = -15, PosY = 6, NumFrames = 3, Frames = {2,0,2,1}, }
a.Poke_Squirtleshell = a.MechUnit:new{Image="units/player/Squirtle_shell.png",  PosX = -15, PosY = 6, NumFrames = 1 }
a.Poke_Squirtle_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Squirtle_ns = a.MechIcon:new{Image="units/player/Squirtle_ns.png"}
a.Poke_Squirtlew =a.MechUnit:new{Image="units/player/Squirtle_w.png", PosX = -12, PosY = 15}
a.Poke_Squirtleshell_ns = a.Poke_Squirtle_ns


a.Poke_Wartortle =a.MechUnit:new{Image="units/player/Wartortle.png", PosX = -10, PosY = -4}
a.Poke_Wartortlea = a.MechUnit:new{Image="units/player/Wartortle_a.png",  PosX = -15, PosY = 3, NumFrames = 3, Frames = {0,1,2,1}, }
a.Poke_Wartortleshell = a.MechUnit:new{Image="units/player/Wartortle_shell.png",  PosX = -15, PosY = 3, NumFrames = 1 }
a.Poke_Wartortle_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Wartortle_ns = a.MechIcon:new{Image="units/player/Wartortle_ns.png"}
a.Poke_Wartortlew =a.MechUnit:new{Image="units/player/Wartortle_w.png", PosX = -15, PosY = 6}
a.Poke_Wartortleshell_ns = a.Poke_Wartortle_ns

a.Poke_Blastoise =a.MechUnit:new{Image="units/player/Blastoise.png", PosX = -10, PosY = 6}
a.Poke_Blastoisea = a.MechUnit:new{Image="units/player/Blastoise_a.png",  PosX = -20, PosY = 6, NumFrames = 3, Frames = {0,2,1,2}, }
a.Poke_Blastoiseshell = a.MechUnit:new{Image="units/player/Blastoise_shell.png",  PosX = -20, PosY = 6, NumFrames = 1 }
a.Poke_Blastoise_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -20, PosY = -2 }
a.Poke_Blastoise_ns = a.MechIcon:new{Image="units/player/Blastoise_ns.png"}
a.Poke_Blastoisew =a.MechUnit:new{Image="units/player/Blastoise_w.png", PosX = -20, PosY = 6}
a.Poke_Blastoiseshell_ns = a.Poke_Blastoise_ns

modApi:appendAssets("img/portraits/pilots/", "img/portraits/pilots/")


CreatePilot{Id = "Pilot_Poke_Abra", Personality = "Vek", Name = "Sabrina", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Dratini", Personality = "Vek", Name = "Lance", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Mew", Personality = "Vek", Name = "Mew", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Articuno", Personality = "Vek", Name = "Articuno", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Zapdos", Personality = "Vek", Name = "Zapdos", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Moltres", Personality = "Vek", Name = "Moltres", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Mewtwo", Personality = "Vek", Name = "Mewtwo", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_ArmoredMewtwo", Personality = "Vek", Name = "Mewtwo", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Deoxys", Personality = "Vek", Name = "Deoxys", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Darkrai", Personality = "Vek", Name = "Darkrai", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Celebi", Personality = "Vek", Name = "Celebi", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Shaymin", Personality = "Vek", Name = "Shaymin", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Xerneas", Personality = "Vek", Name = "Xerneas", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Larvitar", Personality = "Vek", Name = "Karen", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Gible", Personality = "Vek", Name = "Cynthia", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Beldum", Personality = "Vek", Name = "Steven", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Eevee", Personality = "Vek", Name = "Bianca", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Ralts", Personality = "Vek", Name = "Wally", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Scyther", Personality = "Vek", Name = "Aaron", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}

CreatePilot{Id = "Pilot_Poke_Dialga", Personality = "Vek", Name = "Dialga", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Palkia", Personality = "Vek", Name = "Palkia", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Giratina", Personality = "Vek", Name = "Giratina", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Arceus", Personality = "Vek", Name = "Arceus", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Metanitar", Personality = "Vek", Name = "Metanitar", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Tyrachomp", Personality = "Vek", Name = "Tyrachomp", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}

CreatePilot{Id = "Pilot_Poke_Delibird", Personality = "Vek", Name = "Delibird", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}

CreatePilot{Id = "Pilot_Poke_Charmander", Personality = "Vek", Name = "Red", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Bulbasaur", Personality = "Vek", Name = "Green", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Squirtle", Personality = "Vek", Name = "Blue", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}


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
	EvoGraphics = { {"Poke_Kadabra", "Poke_Alakazam"} },
	EvoForget = { "Poke_Pound", "Poke_Confusion" },
	EvoLearn = { { { "Poke_Confusion", "Poke_Kinesis" }, { "Poke_Psychic" } } },
	EvoNames = { {"Abra", "Kadabra", "Alakazam"} },
	MegaEvos = { "Poke_MegaAlakazam" },
	MegaEvoMoves = { "Poke_MindOverMatter" },
	MegaEvoNames = { "Mega Alakazam" },
	BecomeFlyingAtLevel = {2},
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
	EvoGraphics = { { "Poke_Dragonair", "Poke_Dragonite" } },
	EvoForget = { "Poke_DragonRage", "Poke_Slam" },
	EvoLearn = { { { "Poke_Twister" }, { "Poke_Fly" } } },
	EvoNames = { { "Dratini", "Dragonair", "Dragonite" } },
	KeepAdding = { "", "Poke_HyperBeam" },
	BecomeFlyingAtLevel = {2},
	IsDragon = true,
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
	IgnoreFire = true,
	Image = "Poke_Moltres",
	SkillList = {"Poke_HeatWave"},
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	-- HasEvolutions = { false, false },
	KeepAdding = { "", "Poke_FireBlast" },
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
	EvoGraphics = { { "Poke_Mewtwo", "Poke_Mewtwo" } },		--necessary because mega evo retransforms
	MegaEvos = { "Poke_MegaMewtwoX", "Poke_MegaMewtwoY" },
	MegaEvoMoves = { "Poke_VanishingStrikes", "Poke_ShatteredPsyche" },
	MegaEvoNames = { "Mega Mewtwo X", "Mega Mewtwo Y" },
	EvoForget = { "Poke_Confusion", "Poke_Psychic" },
	EvoLearn = { { { "Poke_Psychic", "Poke_ShadowBall" }, { "Poke_Psystrike" } },
				 { { "Poke_Psychic", "Poke_ShadowBall" }, { "Poke_Psystrike" } },
			   },
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
	EvoLearn = { { { }, { "Poke_DarkVoid" } } },
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
	EvoLearn = { { { "Poke_CosmicPower" }, { "Poke_PsychoBoost" } } },
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
	SkillList = { "Poke_Bloom" },
	SoundLocation = "/enemy/firefly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { false, true },
	EvoGraphics = { { "Poke_Shaymin", "Poke_ShayminAir" } },
	EvoForget = { "", "" },
	EvoLearn = { { { }, { "Poke_SeedFlare" } } },
	GrassMovement = true,
	BecomeFlyingAtLevel = {2},
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
	EvoLearn = { { { "Poke_Moonblast" }, { } } },
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
	Flying = true,
	Teleporter = true,
	Image = "Poke_ArmoredMewtwo",
	ImageOffset = modApi:getPaletteImageOffset("Poke_ArmoredMewtwo_pal"),
	SkillList = {"Poke_Reflect", "Poke_Teleport" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	SandstormImmune = true,	--redundant with IMPACT_METAL but here for clarity
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
	EvoGraphics = { { "Poke_Pupitar", "Poke_Tyranitar" } },
	EvoForget = { "Poke_RockThrow", "Poke_RockSlide" },
	EvoLearn = { { { "Poke_RockSlide", "Poke_Sandstorm" }, { "Poke_StoneEdge" } } },
	EvoNames = { { "Larvitar", "Pupitar", "Tyranitar" } },
	MegaEvos = { "Poke_MegaTyranitar" },
	MegaEvoMoves = { "Poke_MountainHurl" },
	MegaEvoNames = { "Mega Tyranitar" },
	SandstormImmune = true,
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
	EvoGraphics = { { "Poke_Metang", "Poke_Metagross" } },
	EvoForget = { "Poke_TakeDown", "Poke_MetalClaw" },
	EvoLearn = { { { "Poke_MetalClaw", "Poke_ZenHeadbutt" }, { "Poke_MeteorMash" } } },
	EvoNames = { { "Beldum", "Metang", "Metagross" } },
	LoseFlyingAtLevel = {2},
	SandstormImmune = true,
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
	EvoGraphics = { { "Poke_Gabite", "Poke_Garchomp" } },
	EvoForget = { "Poke_Bite", "" },
	EvoLearn = { { { "Poke_Crunch" }, { "Poke_Earthquake" } } },
	EvoNames = { { "Gible", "Gabite", "Garchomp" } },
	MegaEvos = { "Poke_MegaGarchomp" },
	MegaEvoMoves = { "Poke_DracoMeteor" },
	MegaEvoNames = { "Mega Garchomp" },
	IsDragon = true,
	SandstormImmune = true,
}
Poke_Eevee = Pawn:new{
	Name = "Bianca",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Image = "Poke_Eevee",
	SkillList = {"Poke_QuickAttack"},
	SoundLocation = "/enemy/leaper_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	BranchesAtLevel = 1,
	BranchingEvos = { "Vaporeon", "Jolteon", "Flareon", "Espeon", "Umbreon", "Leafeon", "Glaceon", "Sylveon" },
	EvoGraphics = { { "Poke_Vaporeon", "Poke_Vaporeon" }, 
					{ "Poke_Jolteon", "Poke_Jolteon" }, 
					{ "Poke_Flareon", "Poke_Flareon" }, 
					{ "Poke_Espeon", "Poke_Espeon" },
					{ "Poke_Umbreon", "Poke_Umbreon" },
					{ "Poke_Leafeon", "Poke_Leafeon" },
					{ "Poke_Glaceon", "Poke_Glaceon" },
					{ "Poke_Sylveon", "Poke_Sylveon" },
				  },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_BouncyBubble" }, {  } },
				 { { "Poke_ZippyZap" }, {  } },
				 { { "Poke_SizzlySlide" }, {  } },
				 { { "Poke_GlitzyGlow" }, {  } },
				 { { "Poke_BaddyBad" }, {  } },
				 { { "Poke_SappySeed" }, {  } },
				 { { "Poke_FreezyFrost" }, {  } },
				 { { "Poke_SparklySwirl" }, {  } },
		       },
	EvoNames = { { "Eevee", "Vaporeon", "Vaporeon" },
				 { "Eevee", "Jolteon", "Jolteon" },
				 { "Eevee", "Flareon", "Flareon" },
				 { "Eevee", "Espeon", "Espeon" },
				 { "Eevee", "Umbreon", "Umbreon" },
				 { "Eevee", "Leafeon", "Leafeon" },
				 { "Eevee", "Glaceon", "Glaceon" },
				 { "Eevee", "Sylveon", "Sylveon" },
			   },
}
Poke_Ralts = Pawn:new{
	Name = "Wally",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Ralts",
	SkillList = {"Poke_Synchronize", "Poke_Pound"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	BranchesAtLevel = 2,
	BranchingEvos = { "Gardevoir", "Gallade" },
	MegaEvos = { "Poke_MegaGardevoir", "Poke_MegaGallade" },
	MegaEvoMoves = { "Poke_LightOfRuin", "Poke_SacredSword" },
	EvoGraphics = { { "Poke_Kirlia", "Poke_Gardevoir" }, 
					{ "Poke_Kirlia", "Poke_Gallade" }, 
				  },
	EvoForget = { "Poke_Pound", "Poke_Confusion" },
	EvoLearn = { { { "Poke_Confusion" }, { "Poke_FutureSight" } },
				 { { "Poke_Confusion" }, { "Poke_PsychoCut" } },
		       },
	EvoNames = { { "Ralts", "Kirlia", "Gardevoir" },
				 { "Ralts", "Kirlia", "Gallade" },
			   },
    BecomeFlyingAtLevel = {2, 3},	--only happens in one branch
}
Poke_Scyther = Pawn:new{
	Name = "Aaron",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Scyther",
	SkillList = {"Poke_FuryCutter"},
	SoundLocation = "/enemy/leaper_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	BranchesAtLevel = 1,
	BranchingEvos = { "Scizor", "Kleavor" },
	EvoGraphics = { { "Poke_Scizor", "Poke_Scizor" }, 
					{ "Poke_Kleavor", "Poke_Kleavor" }, 
				  },
	EvoForget = { "", "Poke_FuryCutter" },
	EvoLearn = { { { "Poke_BulletPunch" }, { "Poke_XScissor" } },
				 { { "Poke_StoneAxe" }, { "Poke_XScissor" } },
		       },
	EvoNames = { { "Scyther", "Scizor", "Scizor" },
				 { "Scyther", "Kleavor", "Kleavor" },
			   },
	SandstormImmune = { { false, true, true },
						{ false, true, true },
					  },
}

Poke_Dialga = Pawn:new{
	Name = "Dialga",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	IsDragon = true,
	Image = "Poke_Dialga",
	SkillList = {"Poke_DragonBreath", "Poke_TimeTravel" },
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, true },
	EvoForget = { "Poke_DragonBreath", "" },
	EvoLearn = { { { "Poke_Wither" }, { } } },
	MegaEvos = { "Poke_DialgaOrigin" },
	MegaEvoMoves = { "Poke_RoarOfTime" },
	MegaEvoNames = { "Dialga" },
}

Poke_Palkia = Pawn:new{
	Name = "Palkia",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	FastTeleporter = true,	--custom movement that only does the teleport anim if pawn can't walk to destination
	IsDragon = true,
	Image = "Poke_Palkia",
	SkillList = {"Poke_Warpstrike" },
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_Teleport" }, { } } },
	MegaEvos = { "Poke_PalkiaOrigin" },
	MegaEvoMoves = { "Poke_SpatialRift" },
	MegaEvoNames = { "Palkia" },
}

Poke_Giratina = Pawn:new{
	Name = "Giratina",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	GhostMovement = true,
	Flying = true,
	IsDragon = true,
	Image = "Poke_Giratina",
	SkillList = {"Poke_ConfuseRay" },
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_DarkTendrils" }, { } } },
	KeepAdding = { "", "Poke_ShadowForce" },
}

Poke_Arceus = Pawn:new{
	Name = "Arceus",
	Class = "TechnoVek",
	Health = 4,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Arceus",
	SkillList = {"Poke_Judgment" },
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_Wormhole" }, { } } },
	KeepAdding = { "", "Poke_Unmake" },
}

Poke_Metanitar = Pawn:new{
	Name = "Metanitar",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Armor = true,
	Image = "Poke_Metanitar",
	SkillList = {"Poke_Trample" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, false },
	EvoLearn = { { { "Poke_PsychicTerror" }, { } } },
	EvoForget = { "", "" },
	SandstormImmune = true,
}

Poke_Tyrachomp = Pawn:new{
	Name = "Tyrachomp",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Armor = true,
	Image = "Poke_Tyrachomp",
	SkillList = {"Poke_DragonTail" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, false },
	EvoLearn = { { { "Poke_ScorchingSands" }, { } } },
	EvoForget = { "", "" },
	SandstormImmune = true,
	IsDragon = true,
}

Poke_Bulbasaur = Pawn:new{
	Name = "Bulbasaur",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Bulbasaur",
	SkillList = {"Poke_VineWhip"},
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { { "Poke_Ivysaur", "Poke_Venusaur" } },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_Growth" }, { } } },
	-- KeepAdding = { "", "Poke_Blossom" },
	KeepAdding = { "", "Poke_SolarBeam" },	--more iconic, less buggy, less annoying
	PokemonIsOwnWeapon = { "Poke_PowderPuff", "Poke_BulletSeed", "Poke_Spore" }
}
Poke_Charmander = Pawn:new{
	Name = "Charmander",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	IgnoreFire = true,
	Image = "Poke_Charmander",
	SkillList = {"Poke_FireTail", "Poke_Scratch"},
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { { "Poke_Charmeleon", "Poke_Charizard" } },
	MegaEvos = { "Poke_MegaCharizardX", "Poke_MegaCharizardY" },
	MegaEvoMoves = { "Poke_BlastBurn", "Poke_BlastBurn" },
	MegaEvoNames = { "Mega Charizard X", "Mega Charizard Y" },
	EvoForget = { "Poke_Scratch", "Poke_FireTail" },
	EvoLearn = { { { "Poke_Flamethrower" }, { "Poke_Fly" } },
				 { { "Poke_Flamethrower" }, { "Poke_Fly" } },
			   },
	BecomeFlyingAtLevel = {2, 2},
}
Poke_Squirtle = Pawn:new{
	Name = "Squirtle",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	-- This is not quite what I want, but I can't find a way to refer to the pawn instance for which we are running GetArmor
	GetArmor = function(self) 
		local mission = GetCurrentMission()
		-- if mission and not mission.savedTable then mission.savedTable = true LOG(save_table(self)) end
		return (mission and Game and mission.LastWithdrawTurn == Game:GetTurnCount() or false) 
	end,
	Image = "Poke_Squirtle",
	SkillList = {"Poke_Withdraw", "Poke_WaterGun" },
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { { "Poke_Wartortle", "Poke_Blastoise" } },
	EvoForget = { "Poke_WaterGun", "Poke_BubbleBeam" },
	EvoLearn = { { { "Poke_BubbleBeam" }, { "Poke_HydroPump" } } },
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
	elseif mover and _G[mover:GetType()].FastTeleporter then
		local pathType
		local area = extract_table(general_DiamondTarget(p, mover:GetMoveSpeed()))
		local ret = PointList()
		for _, v in ipairs(area) do
			local terrain = Board:GetTerrain(v)
			if not Board:IsBlocked(v, mover:GetPathProf()) then
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
	if mover and _G[mover:GetType()].GhostMovement then
		ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(%s)", p1:GetString(), p2:GetString()))
		return ret
	elseif mover and _G[mover:GetType()].FastTeleporter and Board:GetDistance(p1, p2, mover:GetPathProf()) > mover:GetMoveSpeed() then
		ret:AddTeleport(p1, p2, FULL_DELAY)
		return ret
	end
	return oldMove(self, p1, p2, ...)
end


local oldGetSkillInfo = GetSkillInfo
function GetSkillInfo(skill)

	if IsPokemon then
		IsPokemon = nil
		-- modApi.modLoaderDictionary["Freezing"..id.."_Upgrade1"] = _G[id].UpgradeList[1]
		-- if skill == "Survive_Death" then
			-- if GameData ~= nil then
				-- local level = 0
				-- for i = 0, 2 do
					-- LOG(GameData.current["pilot"..i].id, Id)
					-- if GameData.current["pilot"..i].id == Id then level = GameData.current["pilot"..i].level break end
				-- end
				-- return PilotSkill(Types[level+1], SkillDescriptions[level+1])
			-- else
				-- return PilotSkill("Pokemon", "Normal Pilots cannot be equipped. Revives at the end of battle.")
			-- end
		-- end
		return PilotSkill("Pokemon", "Normal Pilots cannot be equipped. Revives at the end of battle.")
	end
	return oldGetSkillInfo(skill)
end