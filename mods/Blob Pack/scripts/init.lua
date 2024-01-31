local description = "Adds six goo enemies and a goo boss."

local mod = {
	id = "Meta_BlobPack",
	name = "Goo Enemies",
	version = "1.0.0",
	requirements = {},
	dependencies = { 
		modApiExt = "1.21",
		memedit = "1.1.4",
		easyEdit = "2.0.6",
	},
	modApiVersion = "2.9.2",
	icon = "img/mod_icon.png",
	description = description,
	--metadata = metadata,
}


function mod:init()
	require(self.scriptPath.."shapeshifter")
	require(self.scriptPath.."spiky")
	require(self.scriptPath.."pylon")
	require(self.scriptPath.."splitting")
	require(self.scriptPath.."nested")
	require(self.scriptPath.."sludge")
	require(self.scriptPath.."titanic")
	require(self.scriptPath.."enemyList")
	require(self.scriptPath.."libs/weaponPreview")
	require(self.scriptPath.."libs/swimmingIcon")
	require(self.scriptPath .."libs/boardEvents")
end

function mod:load(options, version)
	--here to restore the animations some goos have (shapeshifter, nested)
	modApi:addPostLoadGameHook(function()
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			if GetCurrentMission().Meta_GooAnims ~= nil then
				for id, anim in pairs(GetCurrentMission().Meta_GooAnims) do
					if Board:GetPawn(id) then Board:GetPawn(id):SetCustomAnim(anim) end
				end
			end
			if GetCurrentMission().GunkTable ~= nil then
				for id, _ in pairs(GetCurrentMission().GunkTable) do
					local pawn = Board:GetPawn(id)
					if pawn then 
						CustomAnim:add(id, "gunk")
						pawn:SetMoveSpeed(pawn:GetMoveSpeed() - 1)
					end
				end
			end
		end)
    end)
end

return mod