require "TimedAction/ISFitnessAction"

local default_exeLooped = ISFitnessAction.exeLooped

-- EXERCISE TRAIT EFFECTS
function ISFitnessAction:exeLooped()
    player = self.character;
 
	if self.exercise == "squats" then
		if player:HasTrait("SoreLegsTrait")then
		MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_L", ZombRand(4)+1);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_R", ZombRand(4)+1);
		end	
		elseif self.exercise == "burpees" then
		if player:HasTrait("SoreLegsTrait")then
		MSTincreasePain(player, ZombRand(4), "UpperLeg_L", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "UpperLeg_R", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_L", ZombRand(4)+2);	
		MSTincreasePain(player, ZombRand(4), "LowerLeg_R", ZombRand(4)+2);
		MSTincreasePain(player, ZombRand(3), "Foot_L", ZombRand(3)+2);	
		MSTincreasePain(player, ZombRand(3), "Foot_R", ZombRand(3)+2);		
		end
	end

	default_exeLooped(self)

end