MSTMiniBaseGameCharacterDetails = {}

MSTMiniBaseGameCharacterDetails.DoTraits = function()

	local sneaky = TraitFactory.addTrait("Sneaky", getText("UI_trait_sneaky"), 2, getText("UI_trait_sneakydesc"), false);
    sneaky:addXPBoost(Perks.Sneak, 1)	
	local lightfooted = TraitFactory.addTrait("Lightfooted", getText("UI_trait_lightfooted"), 2, getText("UI_trait_lightfooteddesc"), false);
    lightfooted:addXPBoost(Perks.Lightfoot, 1)
	local nimble = TraitFactory.addTrait("Nimble", getText("UI_trait_nimble"), 3, getText("UI_trait_nimbledesc"), false);
    nimble:addXPBoost(Perks.Nimble, 1)
	
	-- Surviving Traits
	local amforager = TraitFactory.addTrait("AMForager", getText("UI_trait_amforager"), 3, getText("UI_trait_amforagerdesc"), false);
    amforager:addXPBoost(Perks.PlantScavenging, 1)
	local amtrapper = TraitFactory.addTrait("AMTrapper", getText("UI_trait_amtrapper"), 3, getText("UI_trait_amtrapperdesc"), false);
    amtrapper:addXPBoost(Perks.Trapping, 1)
    amtrapper:getFreeRecipes():add("Make Stick Trap");
    amtrapper:getFreeRecipes():add("Make Snare Trap");
    amtrapper:getFreeRecipes():add("Make Wooden Cage Trap");
    amtrapper:getFreeRecipes():add("Make Trap Box");
    amtrapper:getFreeRecipes():add("Make Cage Trap");
	-- Crafting traits	
	local amcook = TraitFactory.addTrait("AMCook", getText("UI_trait_amcook"), 3, getText("UI_trait_amcookdesc"), false);
    amcook:addXPBoost(Perks.Cooking, 1)
	local amelectrician = TraitFactory.addTrait("AMElectrician", getText("UI_trait_amelectrician"), 4, getText("UI_trait_amelectriciandesc"), false);
    amelectrician:addXPBoost(Perks.Electricity, 1)
	local ammechanic = TraitFactory.addTrait("AMMechanic", getText("UI_trait_ammechanic"), 4, getText("UI_trait_ammechanicdesc"), false);
    ammechanic:addXPBoost(Perks.Mechanics, 1)
	local amcarpenter = TraitFactory.addTrait("AMCarpenter", getText("UI_trait_amcarpenter"), 4, getText("UI_trait_amcarpenterdesc"), false);
    amcarpenter:addXPBoost(Perks.Woodwork, 1)
	local ammetalworker = TraitFactory.addTrait("AMMetalworker", getText("UI_trait_ammetalworker"), 4, getText("UI_trait_ammetalworkerdesc"), false);
    ammetalworker:addXPBoost(Perks.MetalWelding, 1)

	-- Combat traits
	local durabile = TraitFactory.addTrait("Durabile", getText("UI_trait_durabile"), 3, getText("UI_trait_durabiledesc"), false);
    durabile:addXPBoost(Perks.Maintenance, 1)	
    local shortbladefan = TraitFactory.addTrait("Shortbladefan", getText("UI_trait_shortbladefan"), 2, getText("UI_trait_shortbladefandesc"), false);
    shortbladefan:addXPBoost(Perks.SmallBlade, 1)
	local shortbluntfan = TraitFactory.addTrait("Shortbluntfan", getText("UI_trait_shortbluntfan"), 3, getText("UI_trait_shortbluntfandesc"), false);
    shortbluntfan:addXPBoost(Perks.SmallBlunt, 1)
	local cutter = TraitFactory.addTrait("Cutter", getText("UI_trait_cutter"), 4, getText("UI_trait_cutterdesc"), false);
    cutter:addXPBoost(Perks.Axe, 1)
    local spearman = TraitFactory.addTrait("Spearman", getText("UI_trait_spearman"), 4, getText("UI_trait_spearmandesc"), false);
    spearman:addXPBoost(Perks.Spear, 1)
    local swordsman = TraitFactory.addTrait("Swordsman", getText("UI_trait_swordsman"), 4, getText("UI_trait_swordsmandesc"), false);
    swordsman:addXPBoost(Perks.LongBlade, 1)
	-- Firearm traits	
    local gunfan = TraitFactory.addTrait("Gunfan", getText("UI_trait_gunfan"), 4, getText("UI_trait_gunfandesc"), false);
    gunfan:addXPBoost(Perks.Aiming, 1)
    gunfan:addXPBoost(Perks.Reloading, 1)

	----------------------------
	--- FORAGING INTEGRATION ---
	----------------------------
		
	forageSkills = forageSkills or {} 
	-- Forrage Skills

	forageSkills["AMForager"] = {
        name 					= "AMForager",
        type 					= "trait",
        visionBonus 			= 0.8,
        weatherEffect 			= 10,
        darknessEffect 			= 3,
        specialisations 		= {
            ["Animals"] 		= 3,
	        ["JunkFood"] 		= 3,	
            ["Berries"] 		= 3,
            ["Mushrooms"] 		= 3,
            ["MedicinalPlants"] = 3,
	        ["ForestRarities"] 	= 3,	
	        ["Insects"] 		= 3,	
	        ["WildPlants"]		= 3,	
	        ["Trash"] 			= 3				
		}
	};
	forageSkills["AMTrapper"] = {	
        name 					= "AMTrapper",
        type 					= "trait",
        specialisations 		= {
            ["Animals"] 		= 5
		},
	};
	forageSkills["AMElectrician"] = {	
        name 					= "AMElectrician",
        type 					= "trait",
        specialisations 		= {
	        ["Trash"] 			= 5				
		}
	};
	forageSkills["AMMechanic"] = {	
        name 					= "AMMechanic",
        type 					= "trait",
        specialisations 		= {
	        ["Trash"] 			= 5				
		},
	};
	forageSkills["AMCarpenter"] = {
        name 					= "AMCarpenter",
        type 					= "trait",
        specialisations 		= {
	        ["Trash"] 			= 5		
		}
	};
	forageSkills["AMMetalworker"] = {
        name 					= "AMMetalworker",
        type 					= "trait",
        specialisations 		= {
	        ["Trash"] 			= 5			
		},
	};
	forageSkills["AMCook"] = {
        name 					= "AMCook",
        type 					= "trait",
        specialisations 		= {
			["JunkFood"]		= 3,
			["Animals"]			= 3,
			["Berries"]			= 3,
			["Mushrooms"]		= 3,			
		}
	};
	    
	-- Compatibility with "More Description for Traits"
	
	BaseGameCharacterDetails.SetTraitDescription(sneaky)
	BaseGameCharacterDetails.SetTraitDescription(lightfooted)
	BaseGameCharacterDetails.SetTraitDescription(nimble)
	
    BaseGameCharacterDetails.SetTraitDescription(amforager)
    BaseGameCharacterDetails.SetTraitDescription(amtrapper)
	BaseGameCharacterDetails.SetTraitDescription(amcook)
	
    BaseGameCharacterDetails.SetTraitDescription(amelectrician)
    BaseGameCharacterDetails.SetTraitDescription(ammechanic)
    BaseGameCharacterDetails.SetTraitDescription(amcarpenter)
    BaseGameCharacterDetails.SetTraitDescription(ammetalworker)
	
	BaseGameCharacterDetails.SetTraitDescription(durabile)
	BaseGameCharacterDetails.SetTraitDescription(shortbladefan)
	BaseGameCharacterDetails.SetTraitDescription(shortbluntfan)
	BaseGameCharacterDetails.SetTraitDescription(cutter)
	BaseGameCharacterDetails.SetTraitDescription(spearman)
	BaseGameCharacterDetails.SetTraitDescription(swordsman)
	BaseGameCharacterDetails.SetTraitDescription(gunfan)
	
end

Events.OnGameBoot.Add(MSTMiniBaseGameCharacterDetails.DoTraits);

