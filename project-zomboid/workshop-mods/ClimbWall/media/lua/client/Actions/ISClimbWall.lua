

require "TimedActions/ISBaseTimedAction"
require 'Shared_time'

ISClimbWall = ISBaseTimedAction:derive("ISClimbWall");
ISClimbWall.mvtSpeed = 1--PZ distance unit per s. assumed m/s
ISClimbWall.mvtTime = 0.2
ISClimbWall.addedZ = 0.3
ISClimbWall.anticipateMovement = false--movement is not taken into account

function ISClimbWall:isValidStart()
    return true
end

function ISClimbWall:isValid()
    return not self.isInvalid
end

function ISClimbWall:animEvent(event, parameter)
    --if Climb.Verbose then  print ('ISClimbWall event '..event) end
    
    if event == "ClimbWallStartDone" then
        if parameter == "90" then
        
            self:computeSuccessRate()
            self:consumeEndurance()
            
            local currentAnim = nil
            if self.isFail then--fail
                currentAnim = self.failAnim
            elseif self.isStruggle then--struggle
                currentAnim = self.struggleAnim
            else--success
                currentAnim = self.successAnim
            end
            --self.moveXY = true
            self:setActionAnim(currentAnim);
            if Climb.Verbose then  print ('ISClimbWall '..currentAnim) end
        end
        --TODO reduce endurance ?
    elseif event == 'ClimbWallSuccessDone' then
        self:setActionAnim(self.stopAnim);
        MovePlayer.Teleport(self.character, self.finalX, self.finalY, self.finalZ);
        self.lastUpdateTime = nil
        if Climb.Verbose then  print ('ISClimbWall step 2') end
        --self.lastUpdateTime = getGameTime():getWorldAgeHours()
    elseif event == 'ClimbWallEndDone' then
        if Climb.Verbose then  print ('ISClimbWall done') end
        self.isInvalid = true;
    elseif event == 'Thump' then
        if Climb.Verbose then  print ('ISClimbWall thump.') end
        --getSoundManager():PlaySound(self.sound..rand, false, 0.5);
        --self.character:playSound('CleanBloodScrub');
    end
end

function ISClimbWall:update()
    if self.lastUpdateTime ~= nil and ISClimbWall.anticipateMovement then
        local currentTime = getGameTime():getWorldAgeHours()
        if currentTime ~= self.lastUpdateTime then
            --apply movement
            local elapsedTime = luatime.getWorldHours2RealtimeSeconds(currentTime - self.lastUpdateTime)
            self.lastUpdateTime = currentTime
            local deltaX = 0
            local deltaY = 0
            if self.moveXY then
                local charOrientationAngle = self.character:getAnimAngleRadians();--this is angle 0 = East, PI/2 = South, -PI/2=North, PI=West
                local forwardDist = ISClimbWall.mvtSpeed * elapsedTime
                deltaX = math.cos(charOrientationAngle) * forwardDist
                deltaY = math.sin(charOrientationAngle) * forwardDist
            end
            local deltaZ = 0
            if self.character:getZ() < self.finalZ then
                deltaZ = self.offsetZ * elapsedTime / ISClimbWall.mvtTime
                if self.character:getZ()+deltaZ >= self.finalZ then
                    deltaZ = self.finalZ - self.character:getZ()
                    if Climb.Verbose then print ('ISClimbWall:update final Z reached.') end
                end
            end
            local newX = self.character:getX()+deltaX
            local newY = self.character:getY()+deltaY
            local newZ = self.character:getZ()+deltaZ
            if Climb.Verbose then print ('ISClimbWall:update move ['..deltaX..','..deltaY..','..deltaZ..']') end
            if Climb.Verbose then print ('ISClimbWall:update pos ['..newX..','..newY..','..newZ..']') end
            MovePlayer.Teleport(self.character, newX, newY, newZ)
            self.character:setFallTime(0);--let's not die already
        end
    
        if Climb.Verbose then print ('ISClimbWall ') end
    end

end

function ISClimbWall:start()
    self.action:setUseProgressBar(false)
    self.character:setBlockMovement(true);
    local isoPlayer = self.character
    local releaseBlockMovement = function()--safe guard for cancel and errors
        if not isoPlayer:isDoingActionThatCanBeCancelled() then
            if isoPlayer:isBlockMovement() then
                isoPlayer:setBlockMovement(false);
            end
            Events.OnTick.Remove(releaseBlockMovement)
        end
    end
    Events.OnTick.Add(releaseBlockMovement)
    
    self.startAnim    = 'ClimbWallStart'
    self.successAnim  = 'ClimbWallSuccess'
    self.struggleAnim = 'ClimbWallStruggle'
    self.failAnim     = 'ClimbWallFail'
    self.stopAnim     = 'ClimbWallEnd'
    
    --replace with sitting on ground for dead body
    self:setActionAnim(self.startAnim);
    
    --update anim speed
    self:updateAnimSpeed(1) 
    
    self.lastUpdateTime = getGameTime():getWorldAgeHours()
    if Climb.Verbose then print ('ISClimbWall start '..self.startAnim) end
end

function ISClimbWall:updateAnimSpeed(animIter) 
    if animIter == 1 or animIter == 2 then
        local speedGain = 1.0f
        
        local vanillaClimbState = ClimbOverWallState.instance()
        
        local spriteInstance = self.character:getSpriteDef()
        spriteInstance:setFrameSpeedPerFrame(speedGain)
    end
end

function ISClimbWall:stop()
    ISBaseTimedAction.stop(self);
    self.character:setBlockMovement(false);
end

function ISClimbWall:perform()
    ISBaseTimedAction.perform(self);
    self.character:setBlockMovement(false);
end

function ISClimbWall:new(character, targetSquare, arrivalPos)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.targetSquare = targetSquare;
    o.finalX = arrivalPos.x;
    o.finalY = arrivalPos.y;
    o.finalZ = arrivalPos.z;
    o.offsetZ = ISClimbWall.addedZ
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.stopOnAim = false;
    o.isInvalid = false;
    o.isUnderCar = false;
    o.lastUpdateTime = nil
    o.maxTime = -1;
    return o
end

--Converted to lua from ClimbOverWallState B41.78.16
function ISClimbWall:computeSuccessRate()
    local traits = self.character:getTraits()
    local moodles = self.character:getMoodles()

    local successProba = 80     + self.character:getPerkLevel(Perks.Fitness)   * 2;-- 80+20
    successProba = successProba + self.character:getPerkLevel(Perks.Strength)  * 2;-- +20
    successProba = successProba - moodles:getMoodleLevel(MoodleType.Endurance) *10;-- 0->4 *10-- -40
    successProba = successProba - moodles:getMoodleLevel(MoodleType.HeavyLoad) *16;-- 0->4 *16 -- -64
    if (traits:contains("Emaciated") or traits:contains("Obese") or traits:contains("Very Underweight")) then
        if Climb.Verbose then print('ISClimbWall:computeSuccessRate traits high negative impact') end
        successProba = successProba - 25;
    elseif (traits:contains("Underweight") or traits:contains("Overweight")) then
        if Climb.Verbose then print('ISClimbWall:computeSuccessRate traits low negative impact') end
        successProba = successProba - 15;
    end

    local square = self.character:getCurrentSquare();
    if square then
        local movingObjects = square:getMovingObjects()
        for objIter = 0, movingObjects:size()-1 do
           local isoMovingObject = movingObjects:get(objIter);
           if instanceof(isoMovingObject, "IsoZombie") then
              if isoMovingObject:getTarget() == self.character and isoMovingObject:getCurrentState() == AttackState.instance() then
                 successProba = successProba - 25;
              else
                 successProba = successProba - 7;
              end
           end
        end
    end
    
    if successProba < 0 then successProba = 0 end
    local rand = ZombRand(0,101)--1 == critical success
    self.isStruggle = rand > 1 and rand > (successProba-25);
    self.isFail  = rand > 1 and rand > successProba;--no critical failure. player must be able to guarantee success if carefull
    if Climb.Verbose then print('ISClimbWall:computeSuccessRate '..successProba..' '..rand) end
end


function ISClimbWall:consumeEndurance()
    local stats = self.character:getStats();
    if not self.tractionDone then
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 1200.0);
        self.tractionDone = true
    end
    if self.isStruggle then--stuggle costs more AND provokes a recall
        stats:setEndurance(stats:getEndurance() - ZomboidGlobals.RunningEnduranceReduce * 500.0);
    end
end
