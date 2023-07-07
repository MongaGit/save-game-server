---@class ElectricPanelRemoveCarBatteryAction : ISBaseTimedAction
local ElectricPanelRemoveCarBatteryAction = ISBaseTimedAction:derive("ElectricPanelRemoveCarBatteryAction");

function ElectricPanelRemoveCarBatteryAction:isValid()
    return self.generator:getModData().carBattery ~= nil;
end

function ElectricPanelRemoveCarBatteryAction:waitToStart()
	self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
	return self.character:shouldBeTurning()
end

function ElectricPanelRemoveCarBatteryAction:start()
    self:setActionAnim("Loot");
    self.character:SetVariable("LootPosition", "");
    self.sound = self.character:playSound("GeneratorConnect");
end

function ElectricPanelRemoveCarBatteryAction:update()
    self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
end

function ElectricPanelRemoveCarBatteryAction:stop()
    self.character:stopOrTriggerSound(self.sound);
    ISBaseTimedAction.stop(self);
end

function ElectricPanelRemoveCarBatteryAction:perform()
    self.character:stopOrTriggerSound(self.sound);

    local battery = self.character:getInventory():AddItem(self.generator:getModData().carBattery);
    battery:setUsedDelta(self.generator:getFuel() / 100);
    self.generator:getModData().carBattery = nil;
    self.generator:transmitModData();

    ISBaseTimedAction.perform(self);
end

function ElectricPanelRemoveCarBatteryAction:new(playerObj, generator)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = playerObj;
    o.generator = generator;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 200;
    -- custom fields
    return o;
end

return ElectricPanelRemoveCarBatteryAction;
