local Utils = require("BasementMod/Utils");
local Basement = require("BasementMod/Basement");

---@class EnterBasementAction : ISBaseTimedAction
local EnterBasementAction = ISBaseTimedAction:derive("EnterBasementAction");

function EnterBasementAction:isValid()
    return true;
end

function EnterBasementAction:waitToStart()
    if self.currentHatch then
        self.character:faceThisObject(self.currentHatch)
        return self.character:shouldBeTurning()
    end
end

function EnterBasementAction:start()
    self:setActionAnim("Loot");
	self.character:SetVariable("LootPosition", "Low");
    self.sound = self.character:playSound("BasementHatchOpening");
end

function EnterBasementAction:update()
    if self.currentHatch then
        self.character:faceThisObject(self.currentHatch)
    end
end

function EnterBasementAction:stop()
    self.character:stopOrTriggerSound(self.sound);
    ISBaseTimedAction.stop(self);
end

function EnterBasementAction:perform()
    Utils.delayedFunction(function()
        Basement.EnterBasementId(self.character, self.basementId);
        self.character:playSound("BasementHatchClosing");
    end, 1);
    ISBaseTimedAction.perform(self);
end

function EnterBasementAction:new(playerObj, basementId, currentHatch)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = playerObj;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 50;
    -- custom fields
    o.basementId = basementId;
    o.currentHatch = currentHatch
    return o;
end

return EnterBasementAction;
