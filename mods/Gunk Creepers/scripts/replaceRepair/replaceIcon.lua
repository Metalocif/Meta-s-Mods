local repairIcon = sdlext.surface("img/weapons/repair.png")
local iconHolder = nil

sdlext.addUiRootCreatedHook(function(screen, uiRoot)
	iconHolder = Ui()
		:widthpx(32):heightpx(80)
		:decorate({ DecoSurface() })
		:addTo(uiRoot)
	
	iconHolder.translucent = true
	iconHolder.visible = false
	
	iconHolder.clipRect1 = sdl.rect(0, 0, 32, 65)
	iconHolder.clipRect2 = sdl.rect(0, 0, 18, 15)
	
 	iconHolder.draw = function(self, screen)
 		self.visible = false
 		if repairIcon:wasDrawn() then
			local srf = replaceRepair_internal:GetRepairIcon()
			--local srf = repairReplacementIcons[Pawn:GetPersonality()]
			if srf then
	 			self.x = repairIcon.x
	 			self.y = repairIcon.y
	 			self.clipRect1.x = self.x
	 			self.clipRect1.y = self.y
	 			self.clipRect2.x = self.x
	 			self.clipRect2.y = self.y + self.clipRect1.h
	 			self.visible = true
	 			self.decorations[1].surface = srf
			end
 		end
		
 		screen:clip(self.clipRect1)
 		Ui.draw(self, screen)
 		screen:unclip()
 		screen:clip(self.clipRect2)
 		Ui.draw(self, screen)
 		screen:unclip()
 	end
end)