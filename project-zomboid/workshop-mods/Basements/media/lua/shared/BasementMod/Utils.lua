---@class Utils
local Utils = {};

--- Delay a function call
---@param func function
---@param delay number
function Utils.delayedFunction(func, delay)
    delay = delay or 1;
    local ticks = 0;
    local function onTick()
        if ticks < delay then
            ticks = ticks + 1;
            return;
        end
        Events.OnTick.Remove(onTick);
        func();
    end
    Events.OnTick.Add(onTick);
end

return Utils;
