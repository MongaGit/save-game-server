

require "TimedActions/ISBaseTimedAction"
require 'Shared_time'

ISJumpAction = ISBaseTimedAction:derive("ISJumpAction");
ISJumpAction.mvtSpeed = 1--PZ distance unit per s. assumed m/s
ISJumpAction.mvtTime = 0.2
ISJumpAction.addedZ = 0.3
ISJumpAction.anticipateMovement = false--movement is not taken into account

function ISJumpAction:isValidStart()
    return true
end

function ISJumpAction:isValid()
    return not self.isInvalid
end

function ISJumpAction:animEvent(event, parameter)
    if event == 'JumpDone' then
        self.isDone = true
        self.isInvalid = true
        self:releaseAnimControl()
        self.lastUpdateTime = nil
        if JumpI.Verbose then  print ('ISJumpAction stop.') end
    elseif event == 'TouchGround' then
        if JumpI.Verbose then  print ('ISJumpAction touchGround.') end
        self.forceZ = nil
    elseif event == 'Thump' then
        if JumpI.Verbose then  print ('ISJumpAction thump.') end
        --getSoundManager():PlaySound(self.sound..rand, false, 0.5);
        --self.character:playSound('CleanBloodScrub');
    end
end

function ISJumpAction:update()
    if self.forceZ then
        self.character:setFallTime(0);
        self.character:setZ(self.forceZ)--don't fall during a jump !
        self.character:setLz(self.forceZ)--don't fall during a jump !
    
        local currentSquare = self.character:getCurrentSquare()
        if currentSquare and currentSquare ~= self.lastKnownSquare then
            if not currentSquare:Is(IsoFlagType.solidfloor) then
                currentSquare:addFloor('');
                currentSquare:RecalcAllWithNeighbours(true)
            end
            self.lastKnownSquare=currentSquare;
            if JumpI.Verbose then  print ('ISJumpAction RecalcAllWithNeighbours on current square '..sq2str(currentSquare)) end
        end
        
        self:updateDukeOfHazzard()
    end
end

function ISJumpAction:start()
    self.action:setUseProgressBar(false)
    
    local anim = nil
    if self.character:isSprinting() then
        anim = 'JumpSprintStart'
        self.isSprinting = true
    elseif self.character:isRunning() then
        anim = 'JumpRunStart'
        self.isSprinting = false
    else
        self.isInvalid = true
    end
    
    if not self.isInvalid then
        self.lastUpdateTime = getGameTime():getWorldAgeHours()
        self:setActionAnim(anim);
        self:consumeEndurance()
        self.callBackCalmDown = function ()ISJumpAction.calmDown(self)end
        Events.OnTick.Add(self.callBackCalmDown)
        if JumpI.Verbose then print ('ISJumpAction start '..anim) end
        self.forceZ = self.character:getZ()
        self.lastKnownSquare = self.character:getCurrentSquare()
        --self.lastKnownSquare:RecalcAllWithNeighbours(true);
        if JumpI.Verbose then  print ('ISJumpAction RecalcAllWithNeighbours on initial square.') end
    end
end

function ISJumpAction:stop()
    self:releaseAnimControl()
    ISBaseTimedAction.stop(self);
end

function ISJumpAction:perform()
    self:releaseAnimControl()
    ISBaseTimedAction.perform(self);
end

function ISJumpAction:new(character, arrivalPos)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.finalX = arrivalPos.x;
    o.finalY = arrivalPos.y;
    o.finalZ = arrivalPos.z;
    o.offsetZ = ISJumpAction.addedZ
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.stopOnAim = false;
    o.isInvalid = false;
    o.isUnderCar = false;
    o.lastUpdateTime = nil
    o.maxTime = -1;
    return o
end

function ISJumpAction:releaseAnimControl()
    self.character:setRunning(not self.isSprinting)
    self.character:setSprinting(self.isSprinting)
    self.character:setIgnoreMovement(false)
    if self.callBackCalmDown then
        Events.OnTick.Remove(self.callBackCalmDown)
    end
    if JumpI.Verbose then  print ('ISJumpAction calmDown releaseAnimControl') end
end

function ISJumpAction:consumeEndurance()--same as vault over fence
    local stats = self.character:getStats();
    if self.isSprinting then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 700.0);
    else
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 300.0);
    end
end

--if falling: cancel everything
--removes sprint and run to allow the animation to be played
function ISJumpAction:calmDown()
    if self.character:isCurrentState(PlayerFallingState.instance()) or self.character:isbFalling() then
        self.character:StopAllActionQueue()
        self.character:setIgnoreMovement(false)
        Events.OnTick.Remove(self.callBackCalmDown)
        if JumpI.Verbose then  print ('ISJumpAction calmDown falling.') end
    elseif not self.character:getCharacterActions():isEmpty() then
        if not self.isDone then
            self.character:setIgnoreMovement(true)
            self.character:setRunning(false)
            self.character:setSprinting(false)
        end
        if self.forceZ then
            self.character:setFallTime(0);
            self.character:setbFalling(false);
        end
    else
        Events.OnTick.Remove(self.callBackCalmDown)
        self.character:setIgnoreMovement(false)
        if JumpI.Verbose then  print ('ISJumpAction calmDown backup.') end
    end
end


function ISJumpAction:updateDukeOfHazzard()
    local vehicle = self.character:getNearVehicle()
    if vehicle then--if there is a vehicle around
        if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard vehicle.') end
        local seat = vehicle:getBestSeat(self.character)
        if seat ~= nil and seat ~= -1 then
            if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat '..seat) end
            if vehicle:isSeatInstalled(seat) and not vehicle:isSeatOccupied(seat) then
                if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat installed and unoccupied '..seat) end
                local doIt = false
                local doorPart = vehicle:getPassengerDoor(seat)
                if doorPart and doorPart:getDoor() and doorPart:getInventoryItem() then
                    local door = doorPart:getDoor()
                    if door and door:isOpen() then
                        if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat open door.') end
                        doIt = true--open door, you can jump in
                    else
                        local windowPart = VehicleUtils.getChildWindow(doorPart)
                        if windowPart then
                            local window = windowPart:getWindow()
                            if not window or window:isDestroyed() or not windowPart:getInventoryItem() then
                                if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat closed door with missing or destroyed window.') end
                                doIt = true--missing or destroyed window, you can jump in
                            elseif window:isOpen() then
                                if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat closed door with open window.') end
                                doIt = true--open window, you can jump in Duke !
                            else
                                if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat closed door with closed window.') end
                            end
                        else
                            if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat closed door no window.') end
                        end
                    end
                else
                    if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard best seat no door.') end
                    doIt = true--no door, you can jump in
                end
                
                if doIt then
                    if JumpI.Verbose then print ('JumpI.updateDukeOfHazzard Do It Duke!') end
                    vehicle:enter(seat, self.character) 
                    self.isInvalid = true
                    self.isDone = true
                end
            end
        end
    end
end


--------------- RE Enter
local lcl = {}
lcl.ISEnterVehicle = {}
lcl.ISEnterVehicle.isValid =ISEnterVehicle.isValid
function ISEnterVehicle:isValid()
    local val = lcl.ISEnterVehicle.isValid(self)
    if JumpI.Verbose then print ('ISEnterVehicle:isValid '..b2str(val)) end
    return val
end

lcl.ISEnterVehicle.start =ISEnterVehicle.start
function ISEnterVehicle:start()
    lcl.ISEnterVehicle.start(self)
    if JumpI.Verbose then print ('ISEnterVehicle:start') end
end


