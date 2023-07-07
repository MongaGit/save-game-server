--/////////////////////////////////////////////////////////////////////////
--//////////////////////////// Matías N. Salas ////////////////////////////
--///////////////////////////////////////////////////////////////////////// 
---@version 5.1 Kahlua
---@meta

---@class Thread
local Thread = {};
---@type table
local Threads = {};

---A Thread is created.
---@param cb function
---@return Thread
Thread.CreateThread = function(self, cb)
    local instance = {};
    setmetatable(instance, self);
    self.__index = self;

    instance.waitThread = 0;
    instance.ms = 0;
    instance.coroutine = coroutine.create(cb);

    table.insert(Threads, instance);

    return instance;
end

---Suspends thread execution in milliseconds.
---@param miliseconds number
---@nodiscard
Thread.Wait = function(self, miliseconds)
    self.ms = miliseconds;
    coroutine.yield();
end

local mainThread = function(tick)
    local time = math.floor(os.time() * 1000)

    for i = 1, #Threads do

        if os.difftime(time, Threads[i].waitThread + Threads[i].ms) > 0 then
            Threads[i].waitThread = time;

            if coroutine.status(Threads[i].coroutine) == "suspended" then
                coroutine.resume(Threads[i].coroutine, Threads[i])
            end
        end
    end
end

Events.OnTick.Add(mainThread);

return Thread;