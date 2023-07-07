---@class ElectricPanelInsertCarBatteryAction : ISBaseTimedAction
local ElectricPanelInsertCarBatteryAction = ISBaseTimedAction:derive("ElectricPanelInsertCarBatteryAction");

function ElectricPanelInsertCarBatteryAction:isValid()
    return self.generator:getModData().carBattery == nil;
end

function ElectricPanelInsertCarBatteryAction:waitToStart()
	self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
	return self.character:shouldBeTurning()
end

function ElectricPanelInsertCarBatteryAction:start()
    self:setActionAnim("Loot");
    self.character:SetVariable("LootPosition", "");
    self.sound = self.character:playSound("GeneratorConnect");
end

function ElectricPanelInsertCarBatteryAction:update()
    self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
end

function ElectricPanelInsertCarBatteryAction:stop()
    self.character:stopOrTriggerSound(self.sound);
    ISBaseTimedAction.stop(self);
end

function ElectricPanelInsertCarBatteryAction:perform()
    self.character:stopOrTriggerSound(self.sound);

    self.generator:setFuel(self.carBattery:getUsedDelta() * 100);
    self.generator:setCondition(self.carBattery:getCondition() / self.carBattery:getConditionMax() * 100);
    self.generator:getModData().carBattery = self.carBattery:getFullType();
    self.generator:transmitModData();
    self.carBattery:getContainer():Remove(self.carBattery);

    ISBaseTimedAction.perform(self);
end

function ElectricPanelInsertCarBatteryAction:new(playerObj, carBattery, generator)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = playerObj;
    o.carBattery = carBattery;
    o.generator = generator;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 200;
    -- custom fields
    return o;
end

return ElectricPanelInsertCarBatteryAction;
