local description = "WIP. A squad of mechs that spread shapeless goo to contain the Vek."

local mod = {
	id = "Djinn_GunkCreep",
	name = "Gunk Creepers",
	version = "1.0.0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/mod_icon.png",
	description = description,
	--metadata = metadata,
}

function mod:init()	
	local path = mod_loader.mods[modApi.currentMod].resourcePath
	local files = {
		"Pilot_SlimeBeast.png",
		"Slimelet.png",
	}
	for _, file in ipairs(files) do
		modApi:appendAsset("img/portraits/pilots/".. file, path.."img/portraits/pilots/".. file)
	end
	
	replaceRepair = require(self.scriptPath.. "replaceRepair/replaceRepair")
	replaceRepair:init(self)
	Devour = require(self.scriptPath.."Devour")
	Devour.init(self, replaceRepair)
	--local options = mod_loader.currentModContent[mod.id].options
	
	local palette = {
		id = self.id,
		name = "Gunky Grime", 
		image = "img/units/player/Djinn_mech_RootingBeast.png",
		colorMap = {
			lights =         {167, 0, 250},	--lights
			
			main_highlight = {157,142,122},	--main highli
			main_light =     {69,72,67},	--main light
			main_mid =       {35, 36, 34},	--main mid
			main_dark =      {16, 38, 1},	--main dark
			
			metal_dark =     {26,15,10},	--metal dark
			metal_mid =      {60,34,22},	--metal mid
			metal_light =    {87,34,34},	--metal light
		}, 
	}
	modApi:addPalette(palette)
	
	-- make a list of our files.
local files = {
	"Grunge.png",
	"Grungea.png",
	"Grunge_ns.png",
	"Grunge_b.png",
	"Grunge_h.png",
	"Grunge_w.png",
	"Harmonic.png",
	"Harmonic_b.png",
	"Harmonica.png",
	"Harmonic_ns.png",
	"Harmonic_h.png",
	"Harmonic_w.png",
	"SlimeBeast.png",
	"SlimeBeast_b.png",
	"SlimeBeasta.png",
	"SlimeBeast_ns.png",
	"SlimeBeast_h.png",
	"SlimeBeast_w.png",
	"Slimelet.png",
	"Slimeleta.png",
}

-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, path .."img/units/player/".. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.HarmonicMech =				a.MechUnit:new{Image = "units/player/Harmonic.png", PosX = -25, PosY = -10 }
a.HarmonicMecha =				a.MechUnit:new{Image = "units/player/Harmonica.png", PosX = -25, PosY = -10, NumFrames = 4 }
a.HarmonicMech_ns =				a.MechUnit:new{Image = "units/player/Harmonic_ns.png", PosX = -23, PosY = 1 }
a.HarmonicMechw =				a.MechUnit:new{Image = "units/player/Harmonic_w.png", PosX = -23, PosY = 1 }
a.HarmonicMechw_broken =		a.MechUnit:new{Image = "units/player/Harmonic_w.png", PosX = -23, PosY = 1 }
a.HarmonicMech_h =				a.MechUnit:new{Image = "units/player/Harmonic_h.png", PosX = -13, PosY = 11 }
a.HarmonicMech_broken =			a.MechUnit:new{Image = "units/player/Harmonic_b.png", PosX = -25, PosY = -10 }

a.GrungeMech =				a.MechUnit:new{Image = "units/player/Grunge.png", PosX = -25, PosY = -10 }
a.GrungeMecha =				a.MechUnit:new{Image = "units/player/Grungea.png", PosX = -25, PosY = -10, NumFrames = 4 }
a.GrungeMech_ns =			a.MechUnit:new{Image = "units/player/Grunge_ns.png", PosX = -3, PosY = 1 }
a.GrungeMechw =				a.MechUnit:new{Image = "units/player/Grunge_w.png", PosX = -23, PosY = 1 }
a.GrungeMechw_broken =		a.MechUnit:new{Image = "units/player/Grunge_w.png", PosX = -23, PosY = 1 }
a.GrungeMech_h =			a.MechUnit:new{Image = "units/player/Grunge_h.png", PosX = 6, PosY = 11 }
a.GrungeMech_broken =		a.MechUnit:new{Image = "units/player/Grunge_b.png", PosX = -25, PosY = -10 }

a.SlimeBeast =					a.MechUnit:new{Image = "units/player/SlimeBeast.png", PosX = -25, PosY = -10 }
a.SlimeBeasta =					a.MechUnit:new{Image = "units/player/SlimeBeasta.png", PosX = -25, PosY = -10, NumFrames = 4 }
a.SlimeBeast_ns =				a.MechUnit:new{Image = "units/player/SlimeBeast_ns.png", PosX = -23, PosY = 1 }
a.SlimeBeastw =					a.MechUnit:new{Image = "units/player/SlimeBeast_w.png", PosX = -23, PosY = 1 }
a.SlimeBeastw_broken =			a.MechUnit:new{Image = "units/player/SlimeBeast_w.png", PosX = -23, PosY = 1 }
a.SlimeBeast_h =				a.MechUnit:new{Image = "units/player/SlimeBeast_h.png", PosX = -13, PosY = 11 }
a.SlimeBeast_broken =			a.MechUnit:new{Image = "units/player/SlimeBeast_b.png", PosX = -25, PosY = -10 }

a.Slimelet =				a.MechUnit:new{Image = "units/player/Slimelet.png", PosX = -23, PosY = 1 }
a.Slimeleta =				a.MechUnit:new{Image = "units/player/Slimeleta.png", PosX = -23, PosY = 1, NumFrames = 4 }

	require(self.scriptPath.."status")
	require(self.scriptPath.."weaponPreview")
	require(self.scriptPath.."customAnim")
	
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."replaceRepair")
	require(self.scriptPath .."devour")
	
	
end

function mod:load( options, version)
	modApi:addSquad(
		{
			"Gunk Creepers",		-- title
			"SlimeBeast",	-- mech #1
			"HarmonicMech",-- mech #2
			"GrungeMech",	-- mech #3
			id="Djinn_GunkCreep"
		},
		"Gunk Creepers",
		"A squad of mechs that spread shapeless goo to contain the Vek.",
		self.resourcePath .."img/mod_icon.png"
	)
	
	
	modApi:addMissionEndHook(function()
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
            if pawn then
                LOG("Detected pawn ".. pawn:GetMechName())
                
                if pawn:IsDead() then
                    LOG(pawn:GetMechName() .." is dead")
                    
                    if pawn:IsAbility("DjinnBlobDevour") then
					
                        LOG("reviving pilot with Devour")
  
						pawn:SetHealth(1)
					
						
                    end
                end
            end
        end
    end)
	
end

return mod