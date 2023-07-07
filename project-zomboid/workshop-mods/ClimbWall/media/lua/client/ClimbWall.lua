
Climb = Climb or {}
Climb.Verbose = false
Climb.key = 'Climb_Key'

require 'UI/KeyBindMod'
KBM.addKeyBinding('[Player Control]', Climb.key, 33)--'f' for qwerty/azerty


function Climb.OnPlayerUpdate(isoPlayer)
    if not isoPlayer then return end--some reuse from elsewhere with missing parameter
    local square = isoPlayer:getSquare()
    if not square then return end--teleport
    
    --when pressing interaction key while no action active
    if isKeyPressed(getCore():getKey(Climb.key)) and not isoPlayer:hasTimedActions() and not square:HasStairs()  and not Climb.isHealthInhibitingClimb(isoPlayer) then
        local charOrientationAngle = isoPlayer:getAnimAngleRadians();--Hum, this is angle 0 = East, PI/2 = South, -PI/2=North, PI=West
        local forwardDist = 0.5
        local forwardX = isoPlayer:getX()+ math.cos(charOrientationAngle) * forwardDist
        local forwardY = isoPlayer:getY()+ math.sin(charOrientationAngle) * forwardDist
        local targetSquare = getCell():getGridSquare(forwardX, forwardY, isoPlayer:getZ()+1)

        if Climb.isClimbableWallInBounds(square,targetSquare) then
            if Climb.Verbose then print('Climb.OnPlayerUpdate lets go '..sq2str(targetSquare)) end
            ISTimedActionQueue.clear(isoPlayer)
            ISTimedActionQueue.add(ISClimbWall:new(isoPlayer, targetSquare, {x=forwardX,y=forwardY,z=isoPlayer:getZ()+1}));
        end
    
    end
end

Events.OnPlayerUpdate.Add(Climb.OnPlayerUpdate)




function Climb.isClimbableWallInBounds(square,targetSquare)
    if not square or not targetSquare then
        if Climb.Verbose then print('Climb.isClimbableWallInBounds '..sq2str(square)..' / '..sq2str(targetSquare)) end
        return nil
    end
    
    if not targetSquare:TreatAsSolidFloor() then
        if Climb.Verbose then print('Climb.isClimbableWallInBounds not solid floor on target square '..sq2str(targetSquare)) end
        return nil
    elseif targetSquare:isSolidTrans() or targetSquare:isSolid() or targetSquare:HasStairs() then
        if Climb.Verbose then print('Climb.isClimbableWallInBounds occupied target square '..sq2str(targetSquare)) end
        return nil
    end
    local sourceX = square:getX()
    local sourceY = square:getY()
    local targetX = targetSquare:getX()
    local targetY = targetSquare:getY()
    
    if sourceX == targetX and sourceY == targetY then
        if Climb.Verbose then print('Climb.isClimbableWallInBounds '..sq2str(square)..' on same vertical as '..sq2str(targetSquare)) end
        return nil
    end
    local sourceZ = square:getZ()
    local targetZ = targetSquare:getZ()
    
    local upSquare = getCell():getGridSquare(sourceX, sourceY, targetZ)
    if upSquare then
        if upSquare:TreatAsSolidFloor() or upSquare:isSolid() or upSquare:isSolidTrans() then
            if Climb.Verbose then print('Climb.isClimbableWallInBounds '..sq2str(square)..' has blocking square (with floor) above.') end
            return nil
        end
        if Climb.Verbose then print('Climb.isClimbableWallInBounds '..sq2str(square)..' has valid square (without floor) above.') end
    else
        if Climb.Verbose then print('Climb.isClimbableWallInBounds '..sq2str(square)..' has no valid square above.') end
    end
    
    local canCimb = true
    if targetY == sourceY then
        if targetX > sourceX then--going east
            if Climb.Verbose then print('Climb.isClimbableWallInBounds going East.') end
            canCimb = not Climb.isBlockedOnWestSide(targetSquare)
        elseif targetX < sourceX then--going west
            if Climb.Verbose then print('Climb.isClimbableWallInBounds going West.') end
            canCimb = not upSquare or not Climb.isBlockedOnWestSide(upSquare)
        else
            if Climb.Verbose then print('Climb.isClimbableWallInBounds same square.') end
            canCimb = false
        end
    elseif targetX == sourceX then
        if targetY > sourceY then--going south
            if Climb.Verbose then print('Climb.isClimbableWallInBounds going South.') end
            canCimb = not Climb.isBlockedOnNorthSide(targetSquare)
        elseif targetY < sourceY then--going north
            if Climb.Verbose then print('Climb.isClimbableWallInBounds going North.') end
            canCimb = not upSquare or not Climb.isBlockedOnNorthSide(upSquare)
        else
            if Climb.Verbose then print('Climb.isClimbableWallInBounds algo error.') end
            canCimb = false
        end
    end
    
    if canCimb then return targetSquare end
    return nil
end

function Climb.isBlockedOnWestSide(square)
    if not square then return false end
    return square:Is(IsoFlagType.collideW) or square:Is(IsoFlagType.WindowW) or square:Is(IsoFlagType.doorW) or square:Is(IsoFlagType.HoppableW)--see IsoFlagType for potential other flags
end 
function Climb.isBlockedOnNorthSide(square)
    if not square then return false end
    return square:Is(IsoFlagType.collideN) or square:Is(IsoFlagType.WindowN) or square:Is(IsoFlagType.doorN) or square:Is(IsoFlagType.HoppableN)--see IsoFlagType for potential other flags
end 

