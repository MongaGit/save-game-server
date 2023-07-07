require "TimedAction/ISFitnessAction"

local default_exeLooped = ISFitnessAction.exeLooped

-- SORE LEGS PAIN WHILE FITNESS
function ISFitnessAction:exeLooped()
	player = self.character;
	
	if self.exercise == "squats" then
		if player:HasTrait("SoreLegs")then
		MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_L", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_R", ZombRand(4)+1);
		end	
		if player:HasTrait("HighSweaty") then	
--		player:Say("sweat train");		
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end
		
	elseif self.exercise == "burpees" then
		if player:HasTrait("SoreLegs")then
		MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_L", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_R", ZombRand(4)+2);
		MSTincreasePain(player, ZombRand(3), "Foot_L", ZombRand(3)+2);	
		MSTincreasePain(player, ZombRand(3), "Foot_R", ZombRand(3)+2);		
		end
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(12));
		end	
		
	elseif self.exercise == "pushups" then	
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end	

	elseif self.exercise == "situp" then
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end	

	elseif self.exercise == "barbellcurl" then
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end	

	elseif self.exercise == "dumbbellpress" then
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end		
	
	elseif self.exercise == "bicepscurl" then	
		if player:HasTrait("HighSweaty") then		
--		player:Say("sweat train");	
		MSTincreaseThirst(player, ZombRand(20),  0.01);			
		MSTincreaseWetness(player, ZombRand(2), ZombRand(10));
		end			
	end

	default_exeLooped(self)
	
end