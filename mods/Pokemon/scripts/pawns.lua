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
    "Abra_ns.png",
    "Abra_h.png",
	
	"Kadabra.png",
    "Kadabra_a.png",
    "Kadabra_w.png",
    "Kadabra_ns.png",
	
	"Alakazam.png",
    "Alakazam_a.png",
    "Alakazam_ns.png",
	"MegaAlakazam.png",
    "MegaAlakazam_a.png",
    "MegaAlakazam_ns.png",
	
	"Dratini.png",
    "Dratini_a.png",
    "Dratini_w.png",
    "Dratini_ns.png",
    "Dratini_h.png",
	
	"Dragonair.png",
    "Dragonair_a.png",
    "Dragonair_w.png",
    "Dragonair_ns.png",
	
	"Dragonite.png",
    "Dragonite_a.png",
    "Dragonite_ns.png",
	"Dragonite_sleep.png",	--only here for Hyper Beam & because it's cute
    
    "Mew.png",
    "Mew_a.png",
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
	"MegaMewtwoX.png",
	"MegaMewtwoX_a.png",
	"MegaMewtwoX_ns.png",
	"MegaMewtwoY.png",
	"MegaMewtwoY_a.png",
	"MegaMewtwoY_ns.png",
	
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
    "Larvitar_ns.png",
    "Larvitar_h.png",
	
	"Pupitar.png",
    "Pupitar_a.png",
    "Pupitar_w.png",
    "Pupitar_ns.png",
	
	"Tyranitar.png",
    "Tyranitar_a.png",
    "Tyranitar_w.png",
    "Tyranitar_ns.png",
	
	"Beldum.png",
	"Beldum_a.png",
	"Beldum_h.png",
	"Beldum_ns.png",
	
	"Metang.png",
	"Metang_a.png",
	"Metang_ns.png",
	"Metang_swipe.png",
	
	"Metagross.png",
    "Metagross_a.png",
    "Metagross_w.png",
    "Metagross_ns.png",
    "Metagross_hover.png",
	
	"Gible.png",
    "Gible_a.png",
    "Gible_w.png",
    "Gible_ns.png",
    "Gible_h.png",
	
	"Gabite.png",
    "Gabite_a.png",
    "Gabite_w.png",
    "Gabite_ns.png",
	
	"Garchomp.png",
    "Garchomp_a.png",
    "Garchomp_w.png",
    "Garchomp_ns.png",
	"MegaGarchomp.png",
    "MegaGarchomp_a.png",
    "MegaGarchomp_w.png",
	"DracoMeteor.png",
	"DracoMeteor_death.png",
	
	"Eevee.png",
    "Eevee_a.png",
    "Eevee_w.png",
    "Eevee_ns.png",
    "Eevee_h.png",
	
	"Jolteon.png",
    "Jolteon_a.png",
    "Jolteon_w.png",
    "Jolteon_ns.png",
    "Jolteon_charge_0.png",
    "Jolteon_charge_1.png",
    "Jolteon_charge_2.png",
    "Jolteon_charge_3.png",
	
	"Vaporeon.png",
    "Vaporeon_a.png",
    "Vaporeon_w.png",
    "Vaporeon_ns.png",
    "Vaporeon_bubble.png",
	
	"Flareon.png",
    "Flareon_a.png",
    "Flareon_w.png",
    "Flareon_ns.png",
	
	"Espeon.png",
    "Espeon_a.png",
    "Espeon_w.png",
    "Espeon_ns.png",
	
	"Umbreon.png",
    "Umbreon_a.png",
    "Umbreon_w.png",
    "Umbreon_ns.png",
	
	"Leafeon.png",
    "Leafeon_a.png",
    "Leafeon_w.png",
    "Leafeon_ns.png",
	
	"Glaceon.png",
    "Glaceon_a.png",
    "Glaceon_w.png",
    "Glaceon_ns.png",
	
	"Sylveon.png",
    "Sylveon_a.png",
    "Sylveon_w.png",
    "Sylveon_ns.png",
	
	"Ralts.png",
    "Ralts_a.png",
    "Ralts_w.png",
    "Ralts_ns.png",
    "Ralts_h.png",
	
	"Kirlia.png",
    "Kirlia_a.png",
    "Kirlia_w.png",
    "Kirlia_ns.png",
	
	"Gardevoir.png",
    "Gardevoir_a.png",
    "Gardevoir_ns.png",
	"MegaGardevoir.png",
    "MegaGardevoir_a.png",
    "MegaGardevoir_ns.png",
	
	"Gallade.png",
    "Gallade_a.png",
    "Gallade_w.png",
    "Gallade_ns.png",
	"MegaGallade.png",
    "MegaGallade_a.png",
    "MegaGallade_w.png",
    "MegaGallade_ns.png",

	"Scyther.png",
    "Scyther_a.png",
    "Scyther_w.png",
    "Scyther_ns.png",
    "Scyther_h.png",
	
	"Scizor.png",
    "Scizor_a.png",
    "Scizor_w.png",
    "Scizor_ns.png",
	
	"Kleavor.png",
    "Kleavor_a.png",
    "Kleavor_w.png",
    "Kleavor_ns.png",
	
	"Dialga.png",
	"Dialga_w.png",
	"Dialga_a.png",
	"Dialga_h.png",
	"Dialga_ns.png",
	"Dialga_sleep.png",
	
	"Palkia.png",
	"Palkia_w.png",
	"Palkia_a.png",
	"Palkia_h.png",
	"Palkia_ns.png",
	"Palkia_sleep.png",
	
	"Giratina.png",
	"Giratina_a.png",
	"Giratina_h.png",
	"Giratina_ns.png",
	
	"PokeBall.png", "HyperBall.png", "MasterBall.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, mechPath.. file)
end

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
a.Poke_MegaAlakazama = a.MechUnit:new{Image="units/player/MegaAlakazam_a.png",  PosX = -25, PosY = -19, NumFrames = 3, Frames = {0,1,2,1} }
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
a.Poke_MegaMewtwoXa = a.MechUnit:new{Image="units/player/MegaMewtwoX_a.png",  PosX = -25, PosY = -14, NumFrames = 6 }
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
a.Poke_Xerneas_special_sleep = a.MechUnit:new{Image="units/player/Xerneas_tree.png",  PosX = -40, PosY = -40, NumFrames = 4, Time = 1 }
-- we need a separate sleep anim so that when Darkrai puts Xerneas to sleep it doesn't turn into a tree; still suffixed _sleep so it counts for the sleep handling hook
a.Poke_Xerneas_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Xerneas_ns = a.MechIcon:new{Image="units/player/Xerneas_ns.png"}

a.Poke_Palkia =a.MechUnit:new{Image="units/player/Palkia.png", PosX = -20, PosY = 0}
a.Poke_Palkiaw =a.MechUnit:new{Image="units/player/Palkia_w.png", PosX = -20, PosY = 0}
a.Poke_Palkiaa = a.MechUnit:new{Image="units/player/Palkia_a.png",  PosX = -20, PosY = 0, NumFrames = 2, }
a.Poke_Palkia_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Palkia_ns = a.MechIcon:new{Image="units/player/Palkia_ns.png"}


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
a.Poke_MegaGarchomp =a.MechUnit:new{Image="units/player/MegaGarchomp.png", PosX = -10, PosY = -4}
a.Poke_MegaGarchompa = a.MechUnit:new{Image="units/player/MegaGarchomp_a.png",  PosX = -20, PosY = -4, NumFrames = 3, Frames = {0,1,2,1}, }
a.Poke_MegaGarchomp_broken = a.MechUnit:new{Image="units/player/HyperBall.png", PosX = -20, PosY = -2 }
a.Poke_MegaGarchomp_ns = a.MechIcon:new{Image="units/player/Garchomp_ns.png"}
a.Poke_MegaGarchompw =a.MechUnit:new{Image="units/player/MegaGarchomp_w.png", PosX = -20, PosY = 6}
a.Poke_DracoMeteor = a.MechUnit:new{Image="units/player/DracoMeteor.png",  PosX = -20, PosY = -4, NumFrames = 1, }
a.Poke_DracoMeteora = a.Poke_DracoMeteor
a.Poke_DracoMeteord = a.MechUnit:new{Image="units/player/DracoMeteor_death.png",  PosX = -20, PosY = -4, NumFrames = 13, Time = 0.07 }


a.Poke_Eevee =a.MechUnit:new{Image="units/player/Eevee.png", PosX = -10, PosY = -4}
a.Poke_Eeveea = a.MechUnit:new{Image="units/player/Eevee_a.png",  PosX = -15, PosY = 6, NumFrames = 2 }
a.Poke_Eevee_broken = a.MechUnit:new{Image="units/player/PokeBall.png", PosX = -15, PosY = -2 }
a.Poke_Eevee_ns = a.MechIcon:new{Image="units/player/Eevee_ns.png"}
a.Poke_Eeveew =a.MechUnit:new{Image="units/player/Eevee_w.png", PosX = -12, PosY = 15}

a.Poke_Jolteon =a.MechUnit:new{Image="units/player/Jolteon.png", PosX = -10, PosY = -4}
a.Poke_Jolteona = a.MechUnit:new{Image="units/player/Jolteon_a.png",  PosX = -15, PosY = 6, NumFrames = 2 }
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


a.Poke_Palkia =a.MechUnit:new{Image="units/player/Palkia.png", PosX = -10, PosY = -4}
a.Poke_Palkiaa = a.MechUnit:new{Image="units/player/Palkia_a.png",  PosX = -35, PosY = -21, NumFrames = 4 }
a.Poke_Palkia_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Palkia_ns = a.MechIcon:new{Image="units/player/Palkia_ns.png"}
a.Poke_Palkiaw =a.MechUnit:new{Image="units/player/Palkia_w.png", PosX = -12, PosY = 10}
a.Poke_Palkia_sleep = a.MechUnit:new{Image="units/player/Palkia_sleep.png",  PosX = -32, PosY = -12, NumFrames = 2, Time = 1.5 }


a.Poke_Giratina =a.MechUnit:new{Image="units/player/Giratina.png", PosX = -10, PosY = -4}
a.Poke_Giratinaa = a.MechUnit:new{Image="units/player/Giratina_a.png",  PosX = -35, PosY = -30, NumFrames = 16 }
a.Poke_Giratina_broken = a.MechUnit:new{Image="units/player/MasterBall.png", PosX = -15, PosY = -2 }
a.Poke_Giratina_ns = a.MechIcon:new{Image="units/player/Giratina_ns.png"}


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
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Eevee.png", path .."img/portraits/pilots/Pilot_Poke_Eevee.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Ralts.png", path .."img/portraits/pilots/Pilot_Poke_Ralts.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Scyther.png", path .."img/portraits/pilots/Pilot_Poke_Scyther.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Dialga.png", path .."img/portraits/pilots/Pilot_Poke_Dialga.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Palkia.png", path .."img/portraits/pilots/Pilot_Poke_Palkia.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Giratina.png", path .."img/portraits/pilots/Pilot_Poke_Giratina.png")


CreatePilot{Id = "Pilot_Poke_Abra", Personality = "Vek", Name = "Sabrina", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Dratini", Personality = "Vek", Name = "Lance", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
CreatePilot{Id = "Pilot_Poke_Mew", Personality = "Vek", Name = "Blue", Sex = SEX_VEK, GetSkill = function() IsPokemon = true; return "Survive_Death" end, Rarity = 0, Blacklist = {"Invulnerable", "Popular"},}
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
	EvoLearn = { { { "" }, { "Poke_DarkVoid" } } },
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
	EvoLearn = { { { "" }, { "Poke_SeedFlare" } } },
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
	EvoLearn = { { { "Poke_Moonblast" }, { "" } } },
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
	SkillList = {"Poke_MetalClaw" },
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, true },
	EvoForget = { "", "Poke_MetalClaw" },
	EvoLearn = { { { "Poke_TimeTravel" }, { "Poke_FlashCannon" } } },
	KeepAdding = { "", "Poke_RoarOfTime" },
}

Poke_Palkia = Pawn:new{
	Name = "Palkia",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	FastTeleporter = true,	--custom movement that only does the teleport anim if can't walk there
	IsDragon = true,
	Image = "Poke_Palkia",
	-- SkillList = {"Poke_BreakingSwipe" },
	SkillList = {"Poke_MetalClaw" },
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_Teleport" }, { "" } } },
	-- KeepAdding = { "", "Poke_SpatialRend" },
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
	ImpactMaterial = IMPACT_METAL,
	HasEvolutions = { true, false },
	EvoForget = { "", "" },
	EvoLearn = { { { "Poke_DarkPulse" }, { "" } } },
	-- KeepAdding = { "", "Poke_ShadowForce" },
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