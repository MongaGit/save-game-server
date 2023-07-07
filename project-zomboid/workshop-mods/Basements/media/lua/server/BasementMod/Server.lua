local Basement = require("BasementMod/Basement");

------------------------------------------------------------------------------------------------------------------------
--- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------

local function deleteZombieID(id)
    local zombies = getCell():getZombieList();
    for i = 0, zombies:size() - 1 do
        local zombie = zombies:get(i);
        if instanceof(zombie, "IsoZombie") and zombie:getOnlineID() == id then
            zombie:removeFromWorld();
            zombie:removeFromSquare();
            print("BasementMod deleted a server zombie!");
            return;
        end
    end
end

------------------------------------------------------------------------------------------------------------------------
--- INIT GLOBAL MODDATA
------------------------------------------------------------------------------------------------------------------------

local function initGlobalModData(isNewGame)
    Basement.Data = ModData.getOrCreate("BasementMod.BasementData");
    Basement.Data.Basements = Basement.Data.Basements or {};
end
Events.OnInitGlobalModData.Add(initGlobalModData);

------------------------------------------------------------------------------------------------------------------------
--- RECEIVE CLIENT COMMANDS
------------------------------------------------------------------------------------------------------------------------

local function receiveClientCommand(module, command, player, args)
    if module ~= "BasementMod" then return; end

    if command == "CreateHatch" then
        Basement.CreateHatchServer(args)
    end

    if command == "removeZombie" then
        pcall(deleteZombieID, args.onlineID);
    end
end
Events.OnClientCommand.Add(receiveClientCommand);
