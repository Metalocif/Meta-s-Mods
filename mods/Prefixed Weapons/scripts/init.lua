local description = "Adds prefixes to weapons. Mech weapons can have random modifiers that change their effects."
local mod = {
	id = "Meta_PrefixedWeapons",
	name = "Prefixed Weapons",
	version = "1.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.3",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	require(self.scriptPath .."prefixes")
end

function mod:load( options, version)
	-- modApi:addMissionStartHook(function()
        -- for id = 0, 2 do
            -- for each weapon
			-- if weapon is modifier, powered, and other weapon is not modified
			-- modify other weapon, remove modifier
        -- end
    -- end)
end

function mod:metadata()
	
end

return mod
