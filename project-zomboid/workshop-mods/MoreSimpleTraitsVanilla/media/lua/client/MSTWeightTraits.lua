function cangrabmorecalc()
	local player = getPlayer();
		if player:HasTrait("CanGrabMore") then
		player:setMaxWeightBase(9);
	end
end
	
function cangrablesscalc()
	local player = getPlayer();
		if player:HasTrait("CanGrabLess") then
		player:setMaxWeightBase(7);
	end
end

Events.OnCreatePlayer.Add(cangrabmorecalc);
Events.OnCreatePlayer.Add(cangrablesscalc);	