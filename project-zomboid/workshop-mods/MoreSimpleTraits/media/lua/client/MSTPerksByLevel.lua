

function MSTLevelPerkMain(player, perk, perkLevel, addBuffer)

	-- CALL TO OTHER METHODS THAT RUNS BASED ON THE LevelPerk EVENT
	MSTtraitsGainsByLevel(player, perk, perkLevel);
	--  recipesByPerksLevel(player, perk, perkLevel);

 end

Events.LevelPerk.Add(MSTLevelPerkMain);

function MSTapplyXPBoost(player, perk, boostLevel)
    local currentXPBoost = player:getXp():getPerkBoost(perk);
    local newBoost = currentXPBoost + boostLevel;
    if newBoost > 3 then
        player:getXp():setPerkBoost(perk, 3);
    else
        player:getXp():setPerkBoost(perk, newBoost);
    end
end

function MSTtraitsGainsByLevel(player, perk, perkLevel)

	-- SNEAK
    if perk == Perks.Sneak then
        if perkLevel == 4 and not player:HasTrait("Conspicuous") and not player:HasTrait("Sneaky") then
            player:getTraits():add("Sneaky");
            MSTapplyXPBoost(player, Perks.Sneak, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_sneaky"), true, HaloTextHelper.getColorGreen());
        end
		
		if perkLevel >= 6 and not player:HasTrait("Sneaky")  then
            player:getTraits():add("Sneaky");
            MSTapplyXPBoost(player, Perks.Sneak, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_sneaky"), true, HaloTextHelper.getColorGreen());
        end
		
		if perkLevel >= 8 and player:getPerkLevel(Perks.Lightfoot) >= 8 and not player:HasTrait("NinjaWay")  then
            player:getTraits():add("NinjaWay");
            MSTapplyXPBoost(player, Perks.Sneak, 1);
			MSTapplyXPBoost(player, Perks.Lightfoot, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_ninjaway"), true, HaloTextHelper.getColorGreen());
        end
				
	end
	-- LIGHTFOOT	
	if perk == Perks.Lightfoot then

        if perkLevel == 4 and not player:HasTrait("Clumsy") and not player:HasTrait("Lightfooted") then
            player:getTraits():add("Lightfooted");
            MSTapplyXPBoost(player, Perks.Lightfoot, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_lightfooted"), true, HaloTextHelper.getColorGreen());
        end
	end
	
	if perk == Perks.Lightfoot then
        if perkLevel >= 6 and not player:HasTrait("Lightfooted") then
            player:getTraits():add("Lightfooted");
            MSTapplyXPBoost(player, Perks.Lightfoot, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_lightfooted"), true, HaloTextHelper.getColorGreen());
        end
	
		if perkLevel >= 8 and player:getPerkLevel(Perks.Sneak) >= 8 and not player:HasTrait("NinjaWay")  then
            player:getTraits():add("NinjaWay");
            MSTapplyXPBoost(player, Perks.Sneak, 1);
			MSTapplyXPBoost(player, Perks.Lightfoot, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_ninjaway"), true, HaloTextHelper.getColorGreen());
        end	
	end	
	
	-- SPRINTING
	if perk == Perks.Sprinting then
        if perkLevel >= 8  and player:getPerkLevel(Perks.Fitness) >= 9 and not player:HasTrait("SoreLegsTrait")  and not player:HasTrait("MarathonRunner") then
            player:getTraits():add("MarathonRunner");
            MSTapplyXPBoost(player, Perks.Sprinting, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_marathonrunner"), true, HaloTextHelper.getColorGreen());
        end
	end

	-- FINESS
	if perk == Perks.Fitness then
        if perkLevel >= 9  and player:getPerkLevel(Perks.Sprinting) >= 8 and not player:HasTrait("MarathonRunner") then
            player:getTraits():add("MarathonRunner");
            MSTapplyXPBoost(player, Perks.Sprinting, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_marathonrunner"), true, HaloTextHelper.getColorGreen());
        end
	end

	-- STRENGTH	
	if perk == Perks.Strength then

        if perkLevel >= 8  and player:getPerkLevel(Perks.Nimble) >= 8 and not player:HasTrait("StrongNimble") then
            player:getTraits():add("StrongNimble");
            MSTapplyXPBoost(player, Perks.Nimble, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_strongnimble"), true, HaloTextHelper.getColorGreen());
        end
	end	

	-- NIMBLE	
	if perk == Perks.Nimble then

        if perkLevel >= 8  and player:getPerkLevel(Perks.Strength) >= 8 and not player:HasTrait("StrongNimble") then
            player:getTraits():add("StrongNimble");
            MSTapplyXPBoost(player, Perks.Nimble, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_strongnimble"), true, HaloTextHelper.getColorGreen());
        end
	

        if perkLevel >= 5  and not player:HasTrait("Nimble") then
            player:getTraits():add("Nimble");
            MSTapplyXPBoost(player, Perks.Nimble, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_nimble"), true, HaloTextHelper.getColorGreen());
        end
	end

	-- FORAGING
	if perk == Perks.PlantScavenging then
        if perkLevel >= 6 and not player:HasTrait("AMForager") then
            player:getTraits():add("AMForager");
            MSTapplyXPBoost(player, Perks.PlantScavenging, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_amforager"), true, HaloTextHelper.getColorGreen());
        end
	end		

	-- TRAPPING
	if perk == Perks.Trapping then
        if perkLevel >= 4 and not player:HasTrait("AMTrapper") then
            player:getTraits():add("AMTrapper");
            MSTapplyXPBoost(player, Perks.Trapping, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_amtrapper"), true, HaloTextHelper.getColorGreen());
        end
	end	

	-- COOKING
	if perk == Perks.Cooking then
        if perkLevel >= 4 and not player:HasTrait("AMCook") then
            player:getTraits():add("AMCook");
            MSTapplyXPBoost(player, Perks.Cooking, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_amcook"), true, HaloTextHelper.getColorGreen());
        end
	end		
	
	-- ELECTRICITY
	if perk == Perks.Electricity then
        if perkLevel >= 5 and not player:HasTrait("AMElectrician") then
            player:getTraits():add("AMElectrician");
            MSTapplyXPBoost(player, Perks.Electricity, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_amelectrician"), true, HaloTextHelper.getColorGreen());
        end
	end			
		
	-- MECHANICS
	if perk == Perks.Mechanics then
        if perkLevel >= 5 and not player:HasTrait("AMMechanic") then
            player:getTraits():add("AMMechanic");
            MSTapplyXPBoost(player, Perks.Mechanics, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_ammechanic"), true, HaloTextHelper.getColorGreen());
        end
	end			
	
	-- CARPENTRY
	if perk == Perks.Woodwork then
        if perkLevel >= 5 and not player:HasTrait("AMCarpenter") then
            player:getTraits():add("AMCarpenter");
            MSTapplyXPBoost(player, Perks.Woodwork, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_amcarpenter"), true, HaloTextHelper.getColorGreen());
        end
	end			
	
	-- METALLWEILD
	if perk == Perks.MetalWelding then
        if perkLevel >= 5 and not player:HasTrait("AMMetalworker") then
            player:getTraits():add("AMMetalworker");
            MSTapplyXPBoost(player, Perks.MetalWelding, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_ammetalworker"), true, HaloTextHelper.getColorGreen());
        end
	end			
	
	-- COMBAT TRAITS	
	
	-- MAINTENANCE
	if perk == Perks.Maintenance then
        if perkLevel >= 6 and not player:HasTrait("Durabile") then
            player:getTraits():add("Durabile");
            MSTapplyXPBoost(player, Perks.Maintenance, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_durabile"), true, HaloTextHelper.getColorGreen());
        end
	end		
	
	-- SMALL BLADE
	if perk == Perks.SmallBlade then
        if perkLevel >= 4 and not player:HasTrait("Shortbladefan") then
            player:getTraits():add("Shortbladefan");
            MSTapplyXPBoost(player, Perks.SmallBlade, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_shortbladefan"), true, HaloTextHelper.getColorGreen());
        end
	end			
	
	-- SMALL BLUNT
	if perk == Perks.SmallBlunt then
        if perkLevel >= 4 and not player:HasTrait("Shortbluntfan") then
            player:getTraits():add("Shortbluntfan");
            MSTapplyXPBoost(player, Perks.SmallBlunt, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_shortbluntfan"), true, HaloTextHelper.getColorGreen());
        end
	end				
	
	-- AXE
	if perk == Perks.Axe then
        if perkLevel >= 5 and not player:HasTrait("Cutter") then
            player:getTraits():add("Cutter");
            MSTapplyXPBoost(player, Perks.Axe, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_cutter"), true, HaloTextHelper.getColorGreen());
        end
	end	

	-- SPEAR
	if perk == Perks.Spear then
        if perkLevel >= 6 and not player:HasTrait("Spearman") then
            player:getTraits():add("Spearman");
            MSTapplyXPBoost(player, Perks.Spear, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_spearman"), true, HaloTextHelper.getColorGreen());
        end
	end		
	
	-- LONG BLADE
	if perk == Perks.LongBlade then
        if perkLevel >= 5 and not player:HasTrait("Swordsman") then
            player:getTraits():add("Swordsman");
            MSTapplyXPBoost(player, Perks.LongBlade, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_swordsman"), true, HaloTextHelper.getColorGreen());
        end
	end			

	-- AIMING
	if perk == Perks.Aiming then
--[[        if perkLevel == 4 and player:getPerkLevel(Perks.Reloading) >= 4 and not player:HasTrait("ShortSighted") and not player:HasTrait("Gunfan") then
            player:getTraits():add("Gunfan");
            MSTapplyXPBoost(player, Perks.Aiming, 1);
			MSTapplyXPBoost(player, Perks.Reloading, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_gunfan"), true, HaloTextHelper.getColorGreen());
        end]]
			
        if perkLevel >= 6 and player:getPerkLevel(Perks.Reloading) >= 4 and not player:HasTrait("Gunfan") then
            player:getTraits():add("Gunfan");
            MSTapplyXPBoost(player, Perks.Aiming, 1);
			MSTapplyXPBoost(player, Perks.Reloading, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_gunfan"), true, HaloTextHelper.getColorGreen());
        end

        if perkLevel >= 9 and not player:HasTrait("ShortSighted") and not player:HasTrait("Sharpshooter") then
            player:getTraits():add("Sharpshooter");
            MSTapplyXPBoost(player, Perks.Aiming, 2);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_sharpshooter"), true, HaloTextHelper.getColorGreen());
        end
	end	
	
    if perk == Perks.Reloading then
--[[        if perkLevel >= 4 and player:getPerkLevel(Perks.Aiming) == 4 and not player:HasTrait("ShortSighted") and not player:HasTrait("Gunfan") then
            player:getTraits():add("Gunfan");
            MSTapplyXPBoost(player, Perks.Aiming, 1);
			MSTapplyXPBoost(player, Perks.Reloading, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_gunfan"), true, HaloTextHelper.getColorGreen());
        end]]    

        if perkLevel >= 4 and player:getPerkLevel(Perks.Aiming) >= 6 and not player:HasTrait("Gunfan") then
            player:getTraits():add("Gunfan");
            MSTapplyXPBoost(player, Perks.Aiming, 1);
			MSTapplyXPBoost(player, Perks.Reloading, 1);
            HaloTextHelper.addTextWithArrow(player, getText("UI_trait_gunfan"), true, HaloTextHelper.getColorGreen());
        end
    end

end