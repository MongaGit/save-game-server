local Utils = require("BasementMod/Utils");
local Basement = require("BasementMod/Basement");

---@class ExitBasementAction : ISBaseTimedAction
local ExitBasementAction = ISBaseTimedAction:derive("ExitBasementAction");

function ExitBasementAction:isValid()
    return true;
end

function ExitBasementAction:waitToStart()
    self.character:faceLocation(self.character:getX() - 2, self.character:getY())
    return self.character:shouldBeTurning()
end

function ExitBasementAction:start()
    self:setActionAnim("Loot");
	self.character:SetVariable("LootPosition", "High");
    self.sound = self.character:playSound("BasementHatchOpening");
end

function ExitBasementAction:update()
    self.character:faceLocation(self.character:getX() - 2, self.character:getY())
end

function ExitBasementAction:stop()
    self.character:stopOrTriggerSound(self.sound);
    ISBaseTimedAction.stop(self);
end

function ExitBasementAction:perform()
    Utils.delayedFunction(function()
        Basement.ExitBasement(self.character);
        self.character:playSound("BasementHatchClosing");
    end, 1);
    ISBaseTimedAction.perform(self);
end

function ExitBasementAction:new(playerObj)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = playerObj;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 50;
    -- custom fields
    return o;
end

return ExitBasementAction;
