local Utils = require("BasementMod/Utils");
local Basement = require("BasementMod/Basement");

---@class BasementPowerSwitchAction : ISBaseTimedAction
local BasementPowerSwitchAction = ISBaseTimedAction:derive("BasementPowerSwitchAction");

function BasementPowerSwitchAction:isValid()
    return true;
end

function BasementPowerSwitchAction:waitToStart()
	self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
	return self.character:shouldBeTurning()
end

function BasementPowerSwitchAction:start()
    self:setActionAnim("Loot");
    self.character:SetVariable("LootPosition", "");
end

function BasementPowerSwitchAction:update()
    self.character:faceLocation(self.character:getSquare():getX() - 1, self.character:getSquare():getY());
end

function BasementPowerSwitchAction:stop()
    ISBaseTimedAction.stop(self);
end

function BasementPowerSwitchAction:perform()
    self.sound = self.character:playSound("BasementPowerSwitch");
    self.generator:setActivated(not self.generator:isActivated());
    ISBaseTimedAction.perform(self);
end

function BasementPowerSwitchAction:new(playerObj, square, generator)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = playerObj;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 10;
    -- custom fields
    o.square = square;
    o.generator = generator;
    return o;
end

return BasementPowerSwitchAction;
