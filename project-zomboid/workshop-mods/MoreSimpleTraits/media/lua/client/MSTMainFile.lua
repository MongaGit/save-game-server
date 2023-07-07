-- Set local 
local FitnessLvl
local NimbleLvl
local LightfootedLvl
local SprintingLvl	
local SneakLvl

-- Checking skill levels
function checkskillslevel()
	local player = getPlayer();
	if player == nil then
		return
	end

	FitnessLvl = player:getPerkLevel(Perks.Fitness);
	SneakLvl = player:getPerkLevel(Perks.Sneak);	
	NimbleLvl = player:getPerkLevel(Perks.Nimble);
	SprintingLvl = player:getPerkLevel(Perks.Sprinting);		
	LightfootedLvl = player:getPerkLevel(Perks.Lightfoot);	

end

Events.OnGameStart.Add(checkskillslevel);
Events.LevelPerk.Add(checkskillslevel);
Events.OnCreatePlayer.Add(checkskillslevel);
Events.OnCreateLivingCharacter.Add(checkskillslevel);

--- INCREASE AND DECREASE STATS ---

-- DRUNKENNESS
function MSTdecreaseDrunkenness(player, chance, drunkenness)
    if chance == 0 then
        local currentDrunkenness = player:getStats():getDrunkenness();
        player:getStats():setDrunkenness(currentDrunkenness - drunkenness);
        if player:getStats():getDrunkenness() < 0 then
            player:getStats():setDrunkenness(0);
        end
    end
end

-- BOREDOM
function MSTdecreaseBoredom(player, chance, boredom)
	if chance == 0 then
    local currentBoredom = player:getBodyDamage():getBoredomLevel();
    player:getBodyDamage():setBoredomLevel(currentBoredom - boredom);
    if player:getBodyDamage():getBoredomLevel() < 0 then
        player:getBodyDamage():setBoredomLevel(0);
    end
	end
end

-- HUNGER
function MSTincreaseHunger(player, chance,  hunger)
    if chance == 0 then
    local currentHunger = player:getStats():getHunger();
    player:getStats():setHunger(currentHunger + hunger);
    if player:getStats():getHunger() > 0.99 then
        player:getStats():setHunger(0.99);
    end
	end
end	
function MSTdecreaseHunger(player, chance,  hunger)
    if chance == 0 then
    local currentHunger = player:getStats():getHunger();
    player:getStats():setHunger(currentHunger - hunger);
    if player:getStats():getHunger() < 0 then
        player:getStats():setHunger(0);
    end
	end
end	

-- THIRST
function MSTincreaseThirst(player, chance,  thirst)
    if chance == 0 then
    local currentThirst = player:getStats():getThirst();
    player:getStats():setThirst(currentThirst + thirst);
    if player:getStats():getThirst() > 0.99 then
        player:getStats():setThirst(0.99);
    end
	end
end	
function MSTdecreaseThirst(player, chance,  thirst)
    if chance == 0 then
    local currentThirst = player:getStats():getThirst();
    player:getStats():setThirst(currentThirst - thirst);
    if player:getStats():getThirst() < 0 then
        player:getStats():setThirst(0);
    end
	end
end	

-- WETNESS
function MSTincreaseWetness(player, chance, wetness)
	if chance == 0 then
	local currentWetness = player:getBodyDamage():getWetness();
	player:getBodyDamage():setWetness(currentWetness + wetness);
	if player:getBodyDamage():getWetness() > 99 then
	player:getBodyDamage():setWetness(99);
	end
	end
end	
function MSTdecreaseWetness(player, chance, wetness)
	if chance == 0 then
	local currentWetness = player:getBodyDamage():getWetness();
	player:getBodyDamage():setWetness(currentWetness - wetness);
	if player:getBodyDamage():getWetness() < 0 then
	player:getBodyDamage():setWetness(0);
	end
	end
end	

-- STRESS
function MSTincreaseStress(player, chance,  stress)
	if chance == 0 then
	local currentStress = player:getStats():getStress();
	player:getStats():setStress(currentStress + stress);
	if player:getStats():getStress() > 0.99 then
		player:getStats():setStress(0.99);
	end
	end
end
function MSTdecreaseStress(player, chance,  stress)
	if chance == 0 then
	local currentStress = player:getStats():getStress();
	player:getStats():setStress(currentStress - stress);
	if player:getStats():getStress() < 0 then
		player:getStats():setStress(0);
	end
	end
end

-- CIGARETTES STRESS
function MSTincreaseCigStress(player, chance,  cigstress)
	if chance == 0 then
	local currentCigarettesStress = player:getStats():getStressFromCigarettes();
	player:getStats():setStressFromCigarettes(currentCigarettesStress + cigstress);
	if player:getStats():getStressFromCigarettes() > 0.99 then
		player:getStats():setStressFromCigarettes(0.99);
	end
	end
end
function MSTdecreaseCigStress(player, chance,  cigstress)
	if chance == 0 then
	local currentCigarettesStress = player:getStats():getStressFromCigarettes();
	player:getStats():setStressFromCigarettes(currentCigarettesStress - cigstress);
	if player:getStats():getStressFromCigarettes() < 0 then
		player:getStats():setStressFromCigarettes(0);
	end
	end
end

-- UNHAPPYNESS
function MSTincreaseUnhappyness(player, chance,  unhappyness)
	if chance == 0 then
	local currentUnhappyness = player:getBodyDamage():getUnhappynessLevel();
	player:getBodyDamage():setUnhappynessLevel(currentUnhappyness + unhappyness);
	if player:getBodyDamage():getUnhappynessLevel() > 99 then
		player:getBodyDamage():setUnhappynessLevel(99);
	end
	end
end
function MSTdecreaseUnhappyness(player, chance,  unhappyness)
	if chance == 0 then
	local currentUnhappyness = player:getBodyDamage():getUnhappynessLevel();
	player:getBodyDamage():setUnhappynessLevel(currentUnhappyness - unhappyness);
	if player:getBodyDamage():getUnhappynessLevel() < 0 then
		player:getBodyDamage():setUnhappynessLevel(0);
	end
	end
end

-- PANIC
function MSTincreasePanic(player, chance, panic)
    if chance == 0 then
		local currentPanic = player:getStats():getPanic();
		player:getStats():setPanic(currentPanic + panic);
		if player:getStats():getPanic() > 99 then
			player:getStats():setPanic(99);
		end
	end
end

-- FATIGUE
function MSTincreaseFatigue(player, chance, fatigue)
	if chance == 0 then
		local currentFatigue = player:getStats():getFatigue();
		player:getStats():setFatigue(currentFatigue + fatigue);
		if player:getStats():getFatigue() > 0.99 then
			player:getStats():setFatigue(0.99);
		end
	end
end
function MSTdecreaseFatigue(player, chance, fatigue)
	if chance == 0 then
		local currentFatigue = player:getStats():getFatigue();
		player:getStats():setFatigue(currentFatigue - fatigue);
		if player:getStats():getFatigue() < 0 then
			player:getStats():setFatigue(0);
		end
	end
end

-- POISON
function MSTincreasePoison(player, chance, poison)
    local currentFoodPoison = player:getBodyDamage():getFoodSicknessLevel();
    if chance == 0 then
        if player:HasTrait("WeakStomach") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 1.3));
        elseif player:HasTrait("WeakStomach") and player:HasTrait("ProneToIllness") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 1.5));
        elseif player:HasTrait("WeakStomach") and player:HasTrait("Resilient") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 1.1));
        elseif player:HasTrait("ProneToIllness") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 1.2));
        elseif player:HasTrait("ProneToIllness") and player:HasTrait("IronGut") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 0.9));
        elseif player:HasTrait("IronGut") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 0.7));
        elseif player:HasTrait("IronGut") and player:HasTrait("Resilient") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 0.5));
        elseif player:HasTrait("Resilient") then
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + (poison * 0.8));
        else
            player:getBodyDamage():setFoodSicknessLevel(currentFoodPoison + poison);
        end
        if player:getBodyDamage():getFoodSicknessLevel() > 99 then
            player:getBodyDamage():setFoodSicknessLevel(99);
        end
    end
end

-- PAIN
function MSTincreasePain(player, chance, bodyPart, pain)
	if chance == 0 then
	local bodyPartAux = BodyPartType.FromString(bodyPart);
	local playerBodyPart = player:getBodyDamage():getBodyPart(bodyPartAux);
	local currentPain = playerBodyPart:getPain();
	playerBodyPart:setAdditionalPain(currentPain + pain);
	if playerBodyPart:getPain() > 99 then
		playerBodyPart:setAdditionalPain(99);
	end
	end
end

-- ENDURANCE
function MSTincreaseEndurancePercent(player, chance, endurance)
	local MSTOneHundredChance = ZombRand(100);
	if MSTOneHundredChance <= chance then
		local currentEndurance = player:getStats():getEndurance();
		player:getStats():setEndurance(currentEndurance + endurance);
		if player:getStats():getEndurance() > 0.99 then
			player:getStats():setEndurance(0.99);
		end
--	print("MSTincreaseEndurancePercent: " ..  MSTOneHundredChance)			
	end
end
function MSTincreaseEndurance(player, chance, endurance)
	if chance == 0 then
		local currentEndurance = player:getStats():getEndurance();
		player:getStats():setEndurance(currentEndurance + endurance);
		if player:getStats():getEndurance() > 0.99 then
			player:getStats():setEndurance(0.99);
		end
	end
end
function MSTdecreaseEndurance(player, chance, endurance)
	if chance == 0 then
		local currentEndurance = player:getStats():getEndurance();
		player:getStats():setEndurance(currentEndurance - endurance);
		if player:getStats():getEndurance() < 0 then
			player:getStats():setEndurance(0);
		end
	end
end

-------------------------------------------------------

-- WEATHER SENSITIVE TRAIT
function MSTWeatherSensitiveTrait()
	for playerIndex = 0, getNumActivePlayers()-1 do
    local player = getSpecificPlayer(playerIndex);	
	
	if player == nil then
		return
	end		

	local clim = getClimateManager();	
    local forecaster = clim:getClimateForecaster();
	
	local todayforecast = forecaster:getForecast(0);
	local tomorrowforecast = forecaster:getForecast(1);		
	
	local Head = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Head"));		

	-- one hour = 6
	if 	player:HasTrait("WeatherSensitive") then  
		if todayforecast:isHasBlizzard() or todayforecast:isHasTropicalStorm() or todayforecast:isHasStorm() or todayforecast:isHasHeavyRain() then
--		player:Say("today rain +");
		player:getModData().MSThoursSinceLastRain = player:getModData().MSThoursSinceLastRain + 1;	
		elseif not todayforecast:isHasBlizzard() and not todayforecast:isHasTropicalStorm() and not  todayforecast:isHasStorm() and not todayforecast:isHasHeavyRain() then
--		player:Say("today no rain -");
		player:getModData().MSThoursSinceLastRain = player:getModData().MSThoursSinceLastRain - 1;	
		end
	
		if tomorrowforecast:isHasBlizzard() or tomorrowforecast:isHasTropicalStorm() or tomorrowforecast:isHasStorm() or tomorrowforecast:isHasHeavyRain() then
--		player:Say("tomorrow rain +");
		player:getModData().MSThoursSinceLastRain = player:getModData().MSThoursSinceLastRain + 2;		
		elseif not tomorrowforecast:isHasBlizzard() and not tomorrowforecast:isHasTropicalStorm() and not  tomorrowforecast:isHasStorm() and not tomorrowforecast:isHasHeavyRain() then
--		player:Say("tomorrow no rain -");
		player:getModData().MSThoursSinceLastRain = player:getModData().MSThoursSinceLastRain - (ZombRand(1)+2);	
		end
	end

	if 	player:HasTrait("WeatherSensitive") then  
	
		if todayforecast:isHasBlizzard() or todayforecast:isHasTropicalStorm() or todayforecast:isHasStorm() or todayforecast:isHasHeavyRain() then
			if Head:getPain() <= 8 and ZombRand(19) == 0 then	
--			player:Say("today rain pain");
			MSTincreasePain(player, 0, "Head", (ZombRand(27)+27));
			player:playEmote("mstpainhead");
--			print("1");				
			end
		end
		
		if tomorrowforecast:isHasBlizzard() or tomorrowforecast:isHasTropicalStorm() or tomorrowforecast:isHasStorm() or tomorrowforecast:isHasHeavyRain() then
			if player:getModData().MSThoursSinceLastRain <= 143 and Head:getPain() <= 26 then	
--			player:Say("tomorrow rain+ pain");		
			MSTincreasePain(player, ZombRand(4), "Head", ZombRand(45));
				if ZombRand(11) == 0 then
--				print("2");			
				player:playEmote("mstpainhead");
				end
			end
		end

		if not tomorrowforecast:isHasBlizzard() and not tomorrowforecast:isHasTropicalStorm() and not  tomorrowforecast:isHasStorm() and not tomorrowforecast:isHasHeavyRain() then
			if 	player:getModData().MSThoursSinceLastRain >= 144 and Head:getPain() <= 22 then
--			player:Say("tomorrow no rain pain");	
			MSTincreasePain(player, ZombRand(4), "Head", ZombRand(40));
				if ZombRand(11) == 0 then
--				print("3");	
				player:playEmote("mstpainhead");
				end			
			end		
		end

		if player:getModData().MSThoursSinceLastRain > 288 then
        player:getModData().MSThoursSinceLastRain = 288;
		elseif player:getModData().MSThoursSinceLastRain < 0 then
        player:getModData().MSThoursSinceLastRain = 0;
		end	
--	print("player:getModData().MSThoursSinceLastRain: " .. player:getModData().MSThoursSinceLastRain);	
	end
	end
end

-- LARK TRAIT
function larkperson()
	local player = getPlayer();	
    local gameTime = getGameTime();
	local currentHour = gameTime:getHour();
 	if player:HasTrait("LarkPerson") and not player:isAsleep() then
		if currentHour >= 5 and currentHour <= 9 then	
		MSTdecreaseFatigue(player, 0, 0.004)
		end
		if currentHour >= 18 and currentHour <= 22 then
		MSTincreaseFatigue(player, 0, 0.004)		
		end
	end
end

-- OWL TRAIT
function owlperson()
	local player = getPlayer();	
    local gameTime = getGameTime();
	local currentHour = gameTime:getHour();
 	if player:HasTrait("OwlPerson") and not player:isAsleep() then
		if currentHour >= 18 and currentHour <= 22 then	
		MSTdecreaseFatigue(player, 0, 0.004)
		end
		if currentHour >= 5 and currentHour <= 9 then
		MSTincreaseFatigue(player, 0, 0.004)
		end
	end
end

-- RELENTLESS TRAIT - MAIN
function strongnimbleregenendur(player, weapon)
	local player = getPlayer();
	local currentFatigue
	local FatigueMult
	local OverweightMult
	local ObeseMult
	if player:HasTrait("StrongNimble") then
		-- return if Bare Hands
		if weapon:getType() == "BareHands" then
			return
		end
		-- get item stats
		local WeaponInPrimaryHand = player:getPrimaryHandItem();
		local WeaponInSecondaryHand = player:getSecondaryHandItem();	
		-- if no mainhaind weapon then return
		if WeaponInPrimaryHand == nil then
			return
		end
		
		local WeaponEndMod = WeaponInPrimaryHand:getEnduranceMod();
		local WeaponWeight = WeaponInPrimaryHand:getWeight();

		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
				else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
				else ObeseMult = 1	
		end
		
		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		-- Endurance formula	
		local RWeaponEndCost = (((WeaponWeight * 0.003) * WeaponEndMod) * (OverweightMult * ObeseMult)) * FatigueMult;	
		local RWeaponEndCost = round(RWeaponEndCost,6)
		-- Restoring 50% of RWeaponEndCost while swing with 20% chance
		MSTincreaseEndurancePercent(player, 20, (RWeaponEndCost * 0.5));		
	--	print("Relentless: " ..  (RWeaponEndCost * 0.5))
	--	print("FatigueMult: " ..  FatigueMult)	
		end
end

-- SORE LEGS TRAIT
function sorelegscalc()
	local player = getPlayer();
	local SprintingLevel = player:getPerkLevel(Perks.Sprinting);
	local Foot_L = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_L"));
	local Foot_R = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_R"));		

		if player:HasTrait("SoreLegsTrait") then
		-- Walking pain
			if player:isPlayerMoving() and not player:IsRunning() == true and not player:isSprinting() == true then	
				if Foot_L:getPain() <= 18 then
				MSTincreasePain(player, ZombRand(1), "Foot_L", ZombRand(3));	
				end
				if Foot_R:getPain() <= 18 then
				MSTincreasePain(player, ZombRand(1), "Foot_L", ZombRand(3));
				end
			end
		end
		if player:HasTrait("SoreLegsTrait") then
		-- Sprinting level 0 - 3
			if SprintingLevel == 0 or SprintingLevel == 1 or SprintingLevel == 2 or SprintingLevel == 3 then
				if player:IsRunning() == true and player:isPlayerMoving() then
				MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(4)+1);	
				MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(4)+1);	
				MSTincreasePain(player, ZombRand(3), "LowerLeg_L", ZombRand(4)+1);	
				MSTincreasePain(player, ZombRand(3), "LowerLeg_R", ZombRand(4)+1);
					if Foot_L:getPain() <= 42 then
					MSTincreasePain(player, 0, "Foot_L", ZombRand(8)+1);
					end
					if Foot_R:getPain() <= 42 then	
					MSTincreasePain(player, 0, "Foot_R", ZombRand(8)+1);
					end
					
				end
				if player:isSprinting() == true and player:isPlayerMoving() then
--				player:Say("Sprint pain");
				MSTincreasePain(player, ZombRand(2),"UpperLeg_L", ZombRand(12)+7);	
				MSTincreasePain(player, ZombRand(2),"UpperLeg_R", ZombRand(12)+7);	
				MSTincreasePain(player, 0,"LowerLeg_L", ZombRand(17)+7);	
				MSTincreasePain(player, 0,"LowerLeg_R", ZombRand(17)+7);
				MSTincreasePain(player, 0,"Foot_L", ZombRand(25)+15);	
				MSTincreasePain(player, 0,"Foot_R", ZombRand(25)+15);
				MSTdecreaseEndurance(player, 0, 0.03);	
				end
			end
		end
		if player:HasTrait("SoreLegsTrait") then
		-- Sprinting level 4 - 7
		if SprintingLevel == 4 or SprintingLevel == 5 or SprintingLevel == 6 or SprintingLevel == 7 then
			if player:IsRunning() == true and player:isPlayerMoving() then
				MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(3)+1);	
				MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(3)+1);	
				MSTincreasePain(player, ZombRand(3), "LowerLeg_L", ZombRand(3)+1);	
				MSTincreasePain(player, ZombRand(3), "LowerLeg_R", ZombRand(3)+1);
					if Foot_L:getPain() <= 42 then
					MSTincreasePain(player, 0, "Foot_L", ZombRand(6)+1);
					end
					if Foot_R:getPain() <= 42 then	
					MSTincreasePain(player, 0, "Foot_R", ZombRand(6)+1);
					end				
				end
				if player:isSprinting() == true and player:isPlayerMoving() then
				MSTincreasePain(player, ZombRand(2),"UpperLeg_L", ZombRand(10)+6);	
				MSTincreasePain(player, ZombRand(2),"UpperLeg_R", ZombRand(10)+6);	
				MSTincreasePain(player, 0,"LowerLeg_L", ZombRand(15)+6);	
				MSTincreasePain(player, 0,"LowerLeg_R", ZombRand(15)+6);
				MSTincreasePain(player, 0,"Foot_L", ZombRand(20)+13);	
				MSTincreasePain(player, 0,"Foot_R", ZombRand(20)+13);
				MSTdecreaseEndurance(player, 0, 0.02);
				end
			end
		end
		if player:HasTrait("SoreLegsTrait")then
		-- Sprinting level 8 - 10
		if SprintingLevel == 8 or SprintingLevel == 9 or SprintingLevel == 10 then
		if player:IsRunning() == true and player:isPlayerMoving() then			
			MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(2)+1);	
			MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(2)+1);	
			MSTincreasePain(player, ZombRand(3), "LowerLeg_L", ZombRand(2)+1);	
			MSTincreasePain(player, ZombRand(3), "LowerLeg_R", ZombRand(2)+1);
					if Foot_L:getPain() <= 42 then
					MSTincreasePain(player, 0, "Foot_L", ZombRand(4)+1);
					end
					if Foot_R:getPain() <= 42 then	
					MSTincreasePain(player, 0, "Foot_R", ZombRand(4)+1);
					end		
			end
			if player:isSprinting() == true and player:isPlayerMoving() then
			MSTincreasePain(player, ZombRand(2),"UpperLeg_L", ZombRand(9)+5);	
			MSTincreasePain(player, ZombRand(2),"UpperLeg_R", ZombRand(9)+5);	
			MSTincreasePain(player, 0,"LowerLeg_L", ZombRand(14)+5);	
			MSTincreasePain(player, 0,"LowerLeg_R", ZombRand(14)+5);
			MSTincreasePain(player, 0,"Foot_L", ZombRand(18)+12);	
			MSTincreasePain(player, 0,"Foot_R", ZombRand(18)+12);
			MSTdecreaseEndurance(player, 0, 0.01);
			end
		end
	end	
end

-- SORE LEGS STOMP PAIN
function sorellegsstomppain(player, weapon)
	local player = getPlayer();	
	local Foot_R = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_R"));	
	if player:HasTrait("SoreLegsTrait")then
		if weapon:getCategories():contains("Unarmed") and player:isAimAtFloor() and Foot_R:getPain() <= 50 then
--		player:Say("Hayaa");	
		MSTincreasePain(player, 0,"Foot_R", ZombRand(6)+2);
		end
	end
end

-- MARATHON RUNNER TRAIT - MAIN
function marathonrunnerregen ()
	local player = getPlayer();
	if player == nil then
		return
	end	
	local currentFatigue
	local FatigueMult
	local OverweightMult
	local ObeseMult	
	local AthleticPenalty	
	if player:HasTrait("MarathonRunner") then 
--		local EndRegenChance = 100;	
		local FitnessMult = 0.7 + (FitnessLvl * 0.1)

		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
			else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
			else ObeseMult = 1	
		end
		if FitnessLvl >= 9 then
			AthleticPenalty = 0.4
			else AthleticPenalty = 1
		end	

		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		local MRRunER = (((0.0005 * FitnessMult) * AthleticPenalty) * (OverweightMult * ObeseMult)) * FatigueMult;
		local MRRunER = round(MRRunER,6)	
		-- Running and Sprinting
		if player:IsRunning() == true or player:isSprinting() == true then
			if player:isPlayerMoving() and player:isSneaking() == false then
				MSTincreaseEndurancePercent(player, 100, MRRunER);
		--		print("MR Endurance: " ..  MRRunER)		
			end
		end
	end
end

-- HEAVY BLEED TRAIT
function hbwounds()
	local player = getPlayer();
	if player:HasTrait("HeavilyBleedingWounds") then 
        local bodydamage = player:getBodyDamage();
        local bleeding = bodydamage:getNumPartsBleeding();
        if bleeding > 0 then
            for i = 0, player:getBodyDamage():getBodyParts():size() - 1 do
                local b = player:getBodyDamage():getBodyParts():get(i);
                if b:bleeding() and b:IsBleedingStemmed() == false then
                    local damage = 0.0055;
                    if b:getType() == BodyPartType.Neck then
                        damage = damage * 4;
                    end
                    b:ReduceHealth(damage);
                end
            end
        end
    end
end

-- WEAK BLEED TRAIT
function wbwounds()
	local player = getPlayer();
	    if player:HasTrait("WeaklyBleedingWounds") then
			local bodydamage = player:getBodyDamage();
			local bleeding = bodydamage:getNumPartsBleeding(); 
				if bleeding > 0 then
				for i = 0, player:getBodyDamage():getBodyParts():size() - 1 do
				local b = player:getBodyDamage():getBodyParts():get(i);
					if b:bleeding() and b:IsBleedingStemmed() == false then
					local damage = 0.0014;
					if b:getType() == BodyPartType.Neck then
					damage = damage * 6;
					end
				b:AddHealth(damage);
				end
			end
		end
	end
end

-- SENSITIVE STOMACH TRAIT
function sensitivestomach()
	local player = getPlayer();
	local playerdata = player:getModData();
    local HealByFoodTimer = player:getBodyDamage():getHealthFromFoodTimer();
    if player:HasTrait("SensitiveStomach") then
        if HealByFoodTimer > 1000 then
            if playerdata.fPreviousHealthFromFoodTimer == nil then
                playerdata.fPreviousHealthFromFoodTimer = 1000;
            end
            if HealByFoodTimer > playerdata.fPreviousHealthFromFoodTimer then
                local Torso_Lower = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Torso_Lower"));
                local pain = (HealByFoodTimer - playerdata.fPreviousHealthFromFoodTimer) * (0.003 * (ZombRand(2)+3));
				MSTincreasePoison(player, 0, (ZombRand(11)+5+pain) * 0.3);
                Torso_Lower:setAdditionalPain(Torso_Lower:getAdditionalPain() + pain);
                if Torso_Lower:getAdditionalPain() >= 100 then
					Torso_Lower:setAdditionalPain(100);
                end
            end
            playerdata.fPreviousHealthFromFoodTimer = HealByFoodTimer;
        end
    end
end

-- BETWEEN THE SHADOWS - MAIN
function ninjawayregen ()
	local player = getPlayer();
	if player == nil then
		return
	end	
	local currentFatigue
	local currentEndurance	
	local FatigueMult
	local OverweightMult
	local ObeseMult	
	local AthleticPenalty	
	local FitnessLvlValues = {
		[0] 	= 0.7,
		[1]		= 0.8,
		[2] 	= 0.9,
		[3] 	= 1.0,
		[4] 	= 1.1,
		[5] 	= 1.2,
		[6] 	= 1.3,
		[7] 	= 1.4,
		[8] 	= 1.5,
		[9] 	= 1.55,
		[10]	= 1.6
	}
	local x = FitnessLvl;
	local FitnessMult = FitnessLvlValues[x];		
	if player:HasTrait("NinjaWay") and not player:isAsleep() then 	
		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
				else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
				else ObeseMult = 1	
		end	
		if FitnessLvl >= 9 then
			AthleticPenalty = 0.4
				else AthleticPenalty = 1
		end		
		currentEndurance = player:getStats():getEndurance();
		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		local BtSEnduranceRUN = (((0.0005 * FitnessMult) * AthleticPenalty)* (OverweightMult * ObeseMult)) * FatigueMult;	
		local BtSEnduranceRUN = round(BtSEnduranceRUN,6)	
		local BtSEnduranceRegen = ((0.0005 * FitnessMult) * (OverweightMult * ObeseMult)) * FatigueMult;
		local BtSEnduranceRegen = round(BtSEnduranceRegen,6)	
		if player:isSneaking() == true then
			-- Sneaking NOT MOVING
			if not player:isPlayerMoving() and currentEndurance <= 0.99 then
				if not player:getCurrentState() == PlayerAimState.instance() or player:isSitOnGround() == false then	
					MSTincreaseEndurancePercent(player, 100, (BtSEnduranceRegen * 2));
	--				print("BtS stand: " ..  (BtSEnduranceRegen * 2))		
				end
			end	
			-- Sneaking WALK
			if player:isPlayerMoving() and player:IsRunning() == false then
				if player:IsAiming() == false then
					MSTincreaseEndurancePercent(player, 100, BtSEnduranceRegen);
	--				print("BtS Walk: " ..  BtSEnduranceRegen)		
				end
			end	
			-- Sneaking RUN			
			if player:isPlayerMoving() and player:IsRunning() == true then
				MSTincreaseEndurancePercent(player, 100, (BtSEnduranceRUN * 2));
	--			print("BtS Run: " ..  (BtSEnduranceRUN * 2))		
			end	
		end
	end
end

-- PANIC ATTACKS TRAIT - MAIN
function panicattackscalc ()
	local player = getPlayer();
	local playersurvivedhours = player:getHoursSurvived();	
	local stats = player:getStats();
	local panic = stats:getPanic();
	local speedcontrolforpa = UIManager.getSpeedControls();
	local gamespeedforpa = speedcontrolforpa:getCurrentGameSpeed();	
	
	if player:HasTrait("PanicAttacks") then

	PAchancecalc = 720 + (playersurvivedhours * 0.1);
	PAchance = ZombRand(PAchancecalc);

	if PAchance == 0 then
--	Panic attack while sleeping	
	if player:isAsleep() then
		forceAwakechance = ZombRand(3);
		if forceAwakechance == 0 then
		player:forceAwake();
		getSoundManager():PlaySound("ZombieSurprisedPlayer", false, 0):setVolume(0.2);			
		player:playEmote("mstshiver");	
		MSTincreasePanic(player, 0, (ZombRand(31)+70));
		MSTincreaseStress(player, 0, 0.30);
		MSTincreaseWetness(player, 0, (ZombRand(31)+10));
		end
	end
--	Panic attack not sleeping	
	if not player:isAsleep() then		
		if gamespeedforpa <= 3 then
		getSoundManager():PlaySound("ZombieSurprisedPlayer", false, 0):setVolume(0.2);			
		end
		player:playEmote("mstshiver");	
		MSTincreasePanic(player, 0, (ZombRand(31)+70));
		MSTincreaseStress(player, 0, 0.30);
		MSTincreaseWetness(player, 0, (ZombRand(31)+10));
		end
	end
--	Panic increase		
	if panic >= 10 and panic <= 49 then
	MSTincreasePanic (player, 0, (ZombRand(3)+1));	
	end
	if panic >= 50 and panic <= 79 then
	MSTincreasePanic (player, ZombRand(2), (ZombRand(5)+1));	
	end	
	if panic >= 80 then
	MSTincreasePanic (player, ZombRand(3), (ZombRand(10)+1));	
	end	
--	print("PAchancecalc: " .. PAchancecalc);			
--	print("PAchance: " .. PAchance);	
	end		
end

-- ALLERGIC TRAIT - MAIN
function allergictrait ()
	local player = getPlayer();

	if player:HasTrait("MSTAllergic") and not player:isAsleep() then
	
	local itemmh = player:getPrimaryHandItem()
	local itemsh = player:getSecondaryHandItem()
	
		if player:HasTrait("ProneToIllness") then
		AllergicSneezeChance = 230
			else AllergicSneezeChance = 288
		end
--		print("AllergicSneezeChance: " .. AllergicSneezeChance);		
		if ZombRand(AllergicSneezeChance) == 0 then
			-- Sneezing
			if not player:hasEquipped("Base.ToiletPaper") and not player:hasEquipped("Base.Tissue") then
			player:Say(getText("IGUI_PlayerText_Sneeze"));	
			if not player:isOutside() then	
			addSound(player, player:getX(), player:getY(), player:getZ(), 32, 40);
				else 
				addSound(player, player:getX(), player:getY(), player:getZ(), 46, 58);
			end
			player:playEmote("mstsneeze");	
			end

			-- Sneezing Toilet Paper			
			if player:hasEquipped("Base.ToiletPaper") or player:hasEquipped("Base.Tissue") then
			
				if ZombRand(2) == 0 then			
					if itemmh and itemmh:getType() == "ToiletPaper" then
					itemmh:Use()
						elseif itemsh and itemsh:getType() == "ToiletPaper" then
						itemsh:Use()
							elseif itemmh and itemmh:getType() == "Tissue" then
							itemmh:Use()
								elseif itemsh and itemsh:getType() == "Tissue" then
								itemsh:Use()						
					end
				end
			player:Say(getText("IGUI_PlayerText_SneezeMuffled"));
			addSound(player, player:getX(), player:getY(), player:getZ(), 4, 6);	
			player:playEmote("mstsneeze");	
			end
		
		end		
	end
end




-- ACCMETABOLISM TRAIT
function accmetabolismtrait(player, perk, amount)
	local player = getPlayer();
	local stats = player:getStats();	
	local hunger = stats:getHunger();	
	local modifier = 1.25
--	modifier = modifier;
	if player:HasTrait("AccMetabolism") and hunger < 0.249 then
		if perk == Perks.Fitness or perk == Perks.Strength then
			amount = amount * (modifier - 1);			
			player:getXp():AddXP(perk, amount, false, false, false);
		end
	end
end

-- HOURS UNTIL DEPRESSION FOR OPTIMIST
function hoursindepression ()

	for playerIndex = 0, getNumActivePlayers()-1 do
	local player = getSpecificPlayer(playerIndex);

	if player:HasTrait("MSTOptimist") then
		if player:getBodyDamage():getUnhappynessLevel() >= 39 then
		player:getModData().MSThoursUntilDepression = player:getModData().MSThoursUntilDepression + 1;
		else
			player:getModData().MSThoursUntilDepression = player:getModData().MSThoursUntilDepression - 2;	
	end
	if player:getModData().MSThoursUntilDepression > 120 then
		player:getModData().MSThoursUntilDepression = 120;
		elseif player:getModData().MSThoursUntilDepression < 0 then
		player:getModData().MSThoursUntilDepression = 0;
		end	
	end
--	print("MSThoursUntilDepression = " .. player:getModData().MSThoursUntilDepression)
	end
end

-- OPTIMIST TRAIT
function optimisttrait ()

	for playerIndex = 0, getNumActivePlayers()-1 do
	local player = getSpecificPlayer(playerIndex);

	if player:HasTrait("MSTOptimist") and not player:isAsleep() and player:getModData().MSThoursUntilDepression <= 48 then
		if player:getBodyDamage():getUnhappynessLevel() >= 50 then
			player:getBodyDamage():setUnhappynessLevel(49);	
		end
	end
	
	end
end

-- OPTIMIST TRAIT BOREDOOM PART
function optimistraitbored ()
	local player = getPlayer();
	local boredoommod = 0.040;
	if player:HasTrait("MSTOptimist") and not player:isAsleep() then	
--	passive reducing boredoom	
	MSTdecreaseBoredom(player, 0, boredoommod);
	end
--	passive reducing boredoom while sleeping	
	if player:HasTrait("MSTOptimist") and player:isAsleep() then	
	MSTdecreaseBoredom(player, ZombRand(4), (boredoommod * 2));
	end	
end

-- DEPRESSIVE TRAIT
function depressivemoodtrait ()
	local player = getPlayer();
	if player:HasTrait("MSTDepressive") and not player:isAsleep() then
		MSTincreaseUnhappyness(player, ZombRand(15), ZombRand(5));	
		if ZombRand(864) == 0 then
--		576 ten minutes - once per 4 day +-
--		player:Say("I am sad");				
		MSTincreaseUnhappyness(player, 0, (ZombRand(39)+61));
		end
	end
end		

-- SNORER TRAIT - MAIN
function snorertrait ()
	local player = getPlayer();
	if player:HasTrait("Snorer") and player:isAsleep() then
		if ZombRand(17) == 0 then
			addSound(player, player:getX(), player:getY(), player:getZ(), 15, 20);	
		end
		if ZombRand(80) == 0 then
			addSound(player, player:getX(), player:getY(), player:getZ(), 22, 26);	
		end		
		
	end
end

-- LOW SWEATING - MAIN
function lesssweatytrait()	
	local player = getPlayer();
	local currentWetness = player:getBodyDamage():getWetness();
    local climateManager = getClimateManager();
    local currRainIntensity = climateManager:getRainIntensity();
 
	if player:HasTrait("LessSweaty") and currentWetness > 0 and not player:isAsleep() then 	
	if not player:isOutside() or not player:getVehicle() == nil then
		if player:IsRunning() == false and player:isSprinting() == false then	
--		player:Say("safe antisweat");	
		MSTdecreaseWetness(player, ZombRand(2), ZombRand(2));
		end
		if player:IsRunning() == true then
--		player:Say("safe run antisweat");	
		MSTdecreaseWetness(player, ZombRand(4), ZombRand(1));
		end
		if player:isSprinting() == true then
--		player:Say("safe sprint antisweat");	
		MSTdecreaseWetness(player, ZombRand(4), ZombRand(2));
		end		
	end
	if player:isOutside() and player:getVehicle() == nil and currRainIntensity < 0.10 then	
		if player:IsRunning() == false and player:isSprinting() == false then	
--		player:Say("otside antisweat");	
		MSTdecreaseWetness(player, ZombRand(2), ZombRand(2));
		end
		if player:IsRunning() == true then
--		player:Say("otside run antisweat");	
		MSTdecreaseWetness(player, ZombRand(4), ZombRand(1));
		end
		if player:isSprinting() == true then
--		player:Say("otside sprint antisweat");	
		MSTdecreaseWetness(player, ZombRand(4), ZombRand(2));
		end		
	end
	if player:isOutside() and player:getVehicle() == nil and currRainIntensity > 0.10 then
		if player:IsRunning() == false and player:isSprinting() == false then	
--		player:Say("rain antisweat");		
		MSTdecreaseWetness(player, ZombRand(4), ZombRand(2));
		end
		if player:IsRunning() == true then
--		player:Say("rain run antisweat");	
		MSTdecreaseWetness(player, ZombRand(6), ZombRand(1));
		end
		if player:isSprinting() == true then
--		player:Say("rain sprint antisweat");	
		MSTdecreaseWetness(player, ZombRand(6), ZombRand(2));
		end		
	end
	end
end	

-- EXCESSIVE SWEATING TRAIT - MAIN
function highsweatytrait()	
	local player = getPlayer();
    local climateManager = getClimateManager();
    local currRainIntensity = climateManager:getRainIntensity();
 
	if player:HasTrait("HighSweaty") then 	
		if player:IsRunning() == false and player:isSprinting() == false then
--		player:Say("sweat");		
		MSTincreaseWetness(player, ZombRand(7), ZombRand(5));
		end
		if player:IsRunning() == true then
--		player:Say("run sweat");
		MSTincreaseThirst(player, ZombRand(19),  0.01);		
		MSTincreaseWetness(player, ZombRand(2), ZombRand(4));
		end
		if player:isSprinting() == true then
--		player:Say("sprint antisweat");
		MSTincreaseThirst(player, ZombRand(9),  0.01);		
		MSTincreaseWetness(player, ZombRand(1), ZombRand(5));
		end		
	end
end
-- EXCESSIVE SWEATING TRAIT - ATTACK
function highsweatyattack(player, weapon)	
	local player = getPlayer();

	if player:HasTrait("HighSweaty") and not player:isAsleep() then
	
		if not weapon:getCategories():contains("Unarmed") then
			if weapon:getCategories():contains("Blunt") or weapon:getCategories():contains("LongBlade") or weapon:getCategories():contains("Spear") or weapon:getCategories():contains("Axe") then
--			player:Say("sweat big");	
			MSTincreaseThirst(player, ZombRand(20),  0.01);			
			MSTincreaseWetness(player, ZombRand(4), ZombRand(6))
			end
			if weapon:getCategories():contains("SmallBlunt") then
--			player:Say("sweat smol");
			MSTincreaseThirst(player, ZombRand(25),  0.01);		
			MSTincreaseWetness(player, ZombRand(4), ZombRand(4))
			end
			if weapon:getCategories():contains("SmallBlade") then
--			player:Say("sweat knifu");
			MSTincreaseThirst(player, ZombRand(30),  0.01);			
			MSTincreaseWetness(player, ZombRand(4), ZombRand(2))
			end
		end	
				
		if weapon:getCategories():contains("Unarmed") then
			if not player:isAimAtFloor() then
--			player:Say("sweat push");	
			MSTincreaseThirst(player, ZombRand(20),  0.01);			
			MSTincreaseWetness(player, ZombRand(4), ZombRand(3))
			end
			if player:isAimAtFloor() then
--			player:Say("sweat floor");
			MSTincreaseThirst(player, ZombRand(25),  0.01);			
			MSTincreaseWetness(player, ZombRand(4), ZombRand(4))
			end				
		end	
	end
end


-- FEAR OF THE DARK TRAIT - MAIN
function fearofthedarktrait () 
    local player = getPlayer();
	local stats = player:getStats();
	local currpanic = stats:getPanic();	
	local currstress = stats:getStress();

	if player:HasTrait("FearoftheDark") and not player:isAsleep() then 	
		local currsquare = player:getCurrentSquare();
		if currsquare == nil then
		return
		end
		local lightLevel = currsquare:getLightLevel(player:getPlayerNum());
		if lightLevel <= 0.36 then
			if currpanic <= 15 then
			player:getStats():setPanic(currpanic + 5.9);
			end
		if player:HasTrait("Cowardly") then
			if currpanic >= 1 and currpanic <= 35 then
			player:getStats():setPanic(currpanic + (ZombRand(11)+20));
	--		player:getStats():setPanic(25);		
				if currstress <= 0.3 then 
				MSTincreaseStress(player, 0, 0.05);
				end
			end		
			else
				if currpanic >= 1 and currpanic <= 12 then
				player:getStats():setPanic(currpanic + (ZombRand(6)+15));
		--		player:getStats():setPanic(25);		
					if currstress <= 0.3 then 
					MSTincreaseStress(player, 0, 0.05);	
					end
				end	
		end
		
		if player:getStats():getPanic() > 99 then
			player:getStats():setPanic(99);
		end	
		if player:getStats():getPanic() < 0 then
			player:getStats():setPanic(0);
		end		
		
		end
	end
--	print("lightLevel: " .. lightLevel);	
end

-- CRUELTY - MAIN
function crueltytrait(player, perk, amount)
	local player = getPlayer();
	local modifier = 1.20;
	if player:HasTrait("Cruelty") then
		if perk == Perks.Axe	
		or perk == Perks.Blunt
		or perk == Perks.SmallBlunt
		or perk == Perks.LongBlade	
		or perk == Perks.SmallBlade	
		or perk == Perks.Spear
		or perk == Perks.Maintenance
		or perk == Perks.Aiming			
		then
--			print("Xp amount: " .. amount);	
			amount = amount * (modifier - 1);			
			player:getXp():AddXP(perk, amount, false, false, false);
--			print("Cruel newamount: " .. amount);				
		end
	end
end


Events.OnWeaponSwingHitPoint.Add(sorellegsstomppain);
Events.OnWeaponSwingHitPoint.Add(strongnimbleregenendur);
Events.OnWeaponSwingHitPoint.Add(highsweatyattack);

Events.OnPlayerUpdate.Add(sensitivestomach);
Events.OnPlayerUpdate.Add(hbwounds);
Events.OnPlayerUpdate.Add(wbwounds);
Events.OnPlayerUpdate.Add(optimisttrait);

Events.EveryOneMinute.Add(marathonrunnerregen);
Events.EveryOneMinute.Add(ninjawayregen);
Events.EveryOneMinute.Add(sorelegscalc);
Events.EveryOneMinute.Add(panicattackscalc);
Events.EveryOneMinute.Add(allergictrait);
Events.EveryOneMinute.Add(optimistraitbored);
Events.EveryOneMinute.Add(lesssweatytrait);
Events.EveryOneMinute.Add(highsweatytrait);
Events.EveryOneMinute.Add(fearofthedarktrait);

Events.EveryTenMinutes.Add(MSTWeatherSensitiveTrait);
Events.EveryTenMinutes.Add(larkperson);
Events.EveryTenMinutes.Add(owlperson);
Events.EveryTenMinutes.Add(depressivemoodtrait);
Events.EveryTenMinutes.Add(snorertrait);

Events.EveryHours.Add(hoursindepression);

Events.AddXP.Add(crueltytrait);
Events.AddXP.Add(accmetabolismtrait);