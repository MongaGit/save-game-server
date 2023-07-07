-- Jump Through Windows
-- Author: AbraxasDusk
-- Version: 1.1.1

local localPlayerObjectIndex;


-- Get local player objectIndex for comparison.
local function OnCreatePlayer(playerIndex, player)

    localPlayerObjectIndex = player:getObjectIndex();

end


-- If the character is sprinting and enters a collision,  
-- check if the character is colliding with a window and jump out.
function jumpThroughWindow(character, collider)

    -- Check if this is a collision for the current player.
    if instanceof(character, 'IsoPlayer') and character:isSprinting() then

        -- Check if this is a collision with a window.
        if instanceof(collider, 'IsoWindow') then

            -- Make sure the window isn't barricaded.
            if not collider:isBarricaded() then
            
                -- If the window is closed, try to smash it.
                -- chance to damage/lodge glass on unprotected areas
                if not collider:IsOpen() and not collider:isSmashed() then

                    collider:smashWindow();
                    collider:update();

                end

                character:setSprinting(false); -- set false to enable window climb.
                character:climbThroughWindow(collider);

            end

            return;

        end

    end

end


-- Save a ref to the player objectIndex on player creation.
Events.OnCreatePlayer.Add(OnCreatePlayer)

-- Check on every character/object collision.
Events.OnObjectCollide.Add(jumpThroughWindow);