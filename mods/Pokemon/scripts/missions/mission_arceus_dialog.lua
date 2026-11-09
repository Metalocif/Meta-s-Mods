Personality.Artificial.Pokemon_Arceus_Turn1 = {"I am that which mankind calls Arceus. You who seek my power, prove your might.",}
Personality.Artificial.Pokemon_Arceus_Turn2 = {"I have made both Pokemonkind and mankind. I have watched over your struggles.",}
Personality.Artificial.Pokemon_Arceus_Turn3 = {"The Vek are what your science would classify as Bug-type Pokemon. They are my children, too.",}
Personality.Artificial.Pokemon_Arceus_Turn4 = {"Vek trampling the towns of men is the same as a Seaking feasting on a school of Magikarps - regrettable internecine violence that I have chosen not to prevent.",}
Personality.Artificial.Pokemon_Arceus_Turn5 = {"Have you beheld the foundations of the Earth, seen its footings and its cornerstone?",}
Personality.Artificial.Pokemon_Arceus_SecondForm = {"Your bonds are magnificent. I am proud of you.",}
Personality.Artificial.Pokemon_Arceus_Death = {"Rejoice in your triumph, my children. When you leave the Earth shall you behold the true beauty of my creation. The dawn of a thousand thousand stars. Unknown life forms as you have never dreamed. This I bequeath you.",}

Personality.Artificial.Pokemon_Arceus_Turn1_Missingno = {"I am that which mankind calls Arceus. You are a taint upon my creation.",}
Personality.Artificial.Pokemon_Arceus_Turn2_Missingno = {"You are part of the Uncreated; things implicit in the fabric of the universe that should not be.",}
Personality.Artificial.Pokemon_Arceus_Turn3_Missingno = {"That humans would harness your misbegotten forms is disappointing, but hardly surprising.",}
Personality.Artificial.Pokemon_Arceus_Turn4_Missingno = {"There are many of you, all your forms horrific, your cries disturbing.",}
Personality.Artificial.Pokemon_Arceus_Turn5_Missingno = {"Worse yet, your presence harms reality itself. You must be destroyed.",}
Personality.Artificial.Pokemon_Arceus_SecondForm_Missingno = {"I will purge you from this world. And when you are gone, I will recreate the world so that you will never have existed.",}
Personality.Artificial.Pokemon_Arceus_Death_Missingno = {"Fitting, that my eternities of existence should be ended by the one thing I never made. My mistake. My folly.",}


modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn1", {Odds = 100,{ main = "Pokemon_Arceus_Turn1" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn2", {Odds = 100,{ main = "Pokemon_Arceus_Turn2" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn3", {Odds = 100,{ main = "Pokemon_Arceus_Turn3" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn4", {Odds = 100,{ main = "Pokemon_Arceus_Turn4" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn5", {Odds = 100,{ main = "Pokemon_Arceus_Turn5" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_SecondForm", {Odds = 100,{ main = "Pokemon_Arceus_SecondForm" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Death", {Odds = 100,{ main = "Pokemon_Arceus_Death" }})

modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn1_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Turn1_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn2_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Turn2_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn3_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Turn3_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn4_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Turn4_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Turn5_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Turn5_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_SecondForm_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_SecondForm_Missingno" }})
modapiext.dialog:addRuledDialog("Pokemon_Arceus_Death_Missingno", {Odds = 100,{ main = "Pokemon_Arceus_Death_Missingno" }})


return {
	CEO_Snow = {
		Briefing = {
			"We have excavated the Azure Flute, an ancient object used to beckon Arceus. Will you face it in battle?"
		},
		Failure = {
			"Its powers could have saved this world."
		},
		Success = {
			"That was impressive. Can nothing stop you?"
		},
	},
	
	CEO_Sand = {
		Briefing = {
			"We have excavated the Azure Flute, an ancient object used to beckon Arceus. Will you face it in battle?"
		},
		Failure = {
			"Its powers could have saved this world."
		},
		Success = {
			"That was impressive. Can nothing stop you?"
		},
	},
	
	CEO_Grass = {
		Briefing = {
			"We have excavated the Azure Flute, an ancient object used to beckon Arceus. Will you face it in battle?"
		},
		Failure = {
			"Its powers could have saved this world."
		},
		Success = {
			"That was impressive. Can nothing stop you?"
		},
	},
	
	CEO_Acid = {
		Briefing = {
			"We have excavated the Azure Flute, an ancient object used to beckon Arceus. Will you face it in battle?"
		},
		Failure = {
			"Its powers could have saved this world."
		},
		Success = {
			"That was impressive. Can nothing stop you?"
		},
	},
}