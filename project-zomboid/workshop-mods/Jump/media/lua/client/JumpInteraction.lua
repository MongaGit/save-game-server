
JumpI = JumpI or {}
JumpI.Verbose = false
JumpI.MinZ = 0 --TODO set to -10 or whatever the min Z is with B42
JumpI.inhibit = false--inhibit reading once computed
JumpI.key = 'Jump_Key'

require 'UI/KeyBindMod'
KBM.addKeyBinding('[Player Control]', JumpI.key, 33)--'f' for qwerty/azerty

local lcl = {}
lcl.stateName = ''

function JumpI.OnPlayerUpdate(isoPlayer)
    if not isoPlayer then return end--some reuse from elsewhere with missing parameter
    if isoPlayer:getVehicle() then return end--don't jump in the car .. or maybe we could do some funny car animation with that .. :D
    local square = isoPlayer:getSquare()
    if not square then return end--teleport
    
    if isoPlayer:isCurrentState(PlayerFallingState.instance()) or isoPlayer:isbFalling() then
        if not JumpI.inhibit then
            JumpI.inhibit = true
            if JumpI.Verbose then print('JumpI.OnPlayerUpdate inhibit because falling ') end
        end
    end
    
    if JumpI.inhibit or not isoPlayer:isRunning() and not isoPlayer:isSprinting() then return end--need to run or sprint
    
    --when pressing interaction key while no action active
    if isKeyPressed(getCore():getKey(JumpI.key)) and not isoPlayer:hasTimedActions() and not square:HasStairs() and not JumpI.isHealthInhibitingJump(isoPlayer) then
        local charOrientationAngle = isoPlayer:getAnimAngleRadians();--Hum, this is angle 0 = East, PI/2 = South, -PI/2=North, PI=West
        
        local targetDist = 1.5--todo compute distance from skills and traits
        local targetX = isoPlayer:getX()+ math.cos(charOrientationAngle) * targetDist
        local targetY = isoPlayer:getY()+ math.sin(charOrientationAngle) * targetDist
        local targetSquareValidForJump = JumpI.isValidjumpTarget(targetX,targetY,isoPlayer:getZ())
        if targetSquareValidForJump then
            local target = {x=targetX,y=targetY,z=isoPlayer:getZ()}
            if JumpI.Verbose then print('JumpI.OnPlayerUpdate targetSquareValidForJump '..sq2str(square)..' => '..tab2str(target)) end            
            JumpI.inhibit = true
            
            ISTimedActionQueue.clear(isoPlayer)
            ISTimedActionQueue.add(ISJumpAction:new(isoPlayer, target));
        end
    end
end

Events.OnPlayerUpdate.Add(JumpI.OnPlayerUpdate)

--target square is valid if one tile is valid at or below it
function JumpI.isValidjumpTarget(targetX, targetY, targetZ)
    local z = targetZ
    while z >= JumpI.MinZ and getCell():getGridSquare(targetX, targetY, z) == nil do
        z = z - 1
    end
    return z >= JumpI.MinZ
end

function JumpI.OnKeyStartPressed(key)
    if JumpI.Verbose then print ('JumpI.OnKeyStartPressed '..key) end
    if key == getCore():getKey(JumpI.key) then
        JumpI.inhibit = false
    end
end

Events.OnKeyStartPressed.Add(JumpI.OnKeyStartPressed)
