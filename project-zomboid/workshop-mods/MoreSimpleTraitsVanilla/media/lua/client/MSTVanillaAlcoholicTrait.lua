-- ALCOHOLIC TRAIT from Dynamic traits mod

function MSTAlcoholicTrait(player)
--	print("function alcoholicTrait is called");
	for playerIndex = 0, getNumActivePlayers()-1 do
	local player = getSpecificPlayer(playerIndex);
	if player == nil then
		return
	end	
	
	local currentDrunkenness = player:getStats():getDrunkenness();

	if player:HasTrait("MSTAlcoholic") and currentDrunkenness >= 70 then
--	player:Say(getText("Alcho power!"));		
	MSTdecreaseDrunkenness(player, 0, (ZombRand(10)+5));
	end
		
	-- Drunkenness is greater than 0 which means the player recently had a drink.
	if currentDrunkenness > 0 then
		player:getModData().MSThoursSinceLastDrink = player:getModData().MSThoursSinceLastDrink - (ZombRand(24)+48);
	-- Drunkenness is equal to 0 which means the player recently haven't had a drink.
	else
		player:getModData().MSThoursSinceLastDrink = player:getModData().MSThoursSinceLastDrink + 1;
	
	local hourstosuffeifnotdrinksafe = 72 + ZombRand(24);
	local hourstosuffeifnotdrinkfull = 192 + ZombRand(96);
--	print("hourstosuffeifnotdrink: " .. hourstosuffeifnotdrink);	
	if player:HasTrait("MSTAlcoholic") then
	
	if player:getModData().MSThoursSinceLastDrink >= hourstosuffeifnotdrinksafe then		
		MSTincreaseUnhappyness(player, ZombRand(7), 1);
		MSTincreaseThirst(player, ZombRand(9),  0.01);
		if player:getStats():getStress() <= 0.45 then
			MSTincreaseStress(player, ZombRand(2), 0.05);
		end		
	end
	if player:getModData().MSThoursSinceLastDrink >= hourstosuffeifnotdrinkfull then	
		MSTincreaseUnhappyness(player, ZombRand(7), ZombRand(3));
		MSTincreaseThirst(player, ZombRand(9),  0.005);		
		MSTincreaseFatigue(player, ZombRand(5), 0.005);
		MSTincreasePain(player, ZombRand(7), "Head", (ZombRand(22)+12));			
		if player:getBodyDamage():getFoodSicknessLevel() <= 35 then
			MSTincreasePoison(player, ZombRand(6), (ZombRand(15)+5));
		end
		if player:getStats():getStress() <= 0.70 then
			MSTincreaseStress(player, ZombRand(1), 0.06);
		end			
	end	
	end

	end
    -- CHECK BOTH VALUES TO KEEP THEM INTO THE LIMITS
		if player:getModData().MSThoursSinceLastDrink > 288 then
			player:getModData().MSThoursSinceLastDrink = 288;
		elseif player:getModData().MSThoursSinceLastDrink < 0 then
			player:getModData().MSThoursSinceLastDrink = 0;
		end

--	print("player:getModData().MSThoursSinceLastDrink: " .. player:getModData().MSThoursSinceLastDrink);
	end
end

function MSTAlcoholicShaking(player)
	local player = getPlayer();
	if player:HasTrait("MSTAlcoholic") and player:getModData().MSThoursSinceLastDrink >= 168 and not player:isAsleep() then
		if ZombRand(8) == 0 and player:isSneaking() == false then
--		print("sway");	
		player:playEmote("mstsway");	
		end
	end	
end

--[[
function MSTAlcoholicSleepingResistance()

	for playerIndex = 0, getNumActivePlayers()-1 do
	local player = getSpecificPlayer(playerIndex);
	local currentDrunkenness = player:getStats():getDrunkenness();
	
	if player:HasTrait("MSTAlcoholic") and player:getModData().MSTminutesAlchoSleepRes > 1 then
	
	MSTdecreaseFatigue(player, 0, 0.004);
	
	end

	if currentDrunkenness > 0 then
		player:getModData().MSTminutesAlchoSleepRes = player:getModData().MSTminutesAlchoSleepRes + 3.5;
	-- Drunkenness is equal to 0 which means the player recently haven't had a drink.
	else
		player:getModData().MSTminutesAlchoSleepRes = player:getModData().MSTminutesAlchoSleepRes - 1;
	end
		if player:getModData().MSTminutesAlchoSleepRes > 50 then
			player:getModData().MSTminutesAlchoSleepRes = 50;
		elseif player:getModData().MSTminutesAlchoSleepRes < 0 then
			player:getModData().MSTminutesAlchoSleepRes = 0;
		end	
	
	print("player:getModData().MSTminutesAlchoSleepRes: " .. player:getModData().MSTminutesAlchoSleepRes);
	end
end

Events.EveryOneMinute.Add(MSTAlcoholicSleepingResistance);
]]

Events.EveryTenMinutes.Add(MSTAlcoholicShaking);

Events.EveryTenMinutes.Add(MSTAlcoholicTrait);

Events.OnPlayerUpdate.Add(MSTVanillaBaseGameCharacterDetails.DoExistingCharacterInitializations);