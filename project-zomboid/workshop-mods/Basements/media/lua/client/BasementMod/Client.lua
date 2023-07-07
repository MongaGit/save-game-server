local Utils = require("BasementMod/Utils");
local Basement = require("BasementMod/Basement");
local EnterBasementAction = require("BasementMod/TimedActions/EnterBasementAction");
local ExitBasementAction = require("BasementMod/TimedActions/ExitBasementAction");
local BasementPowerSwitchAction = require("BasementMod/TimedActions/BasementPowerSwitchAction");
local ElectricPanelInsertCarBatteryAction = require("BasementMod/TimedActions/ElectricPanelInsertCarBatteryAction");
local ElectricPanelRemoveCarBatteryAction = require("BasementMod/TimedActions/ElectricPanelRemoveCarBatteryAction");

------------------------------------------------------------------------------------------------------------------------
--- INIT GLOBAL MODDATA
------------------------------------------------------------------------------------------------------------------------

local function initGlobalModData(isNewGame)
    if isClient() then
        if ModData.exists("BasementMod.BasementData") then
            ModData.remove("BasementMod.BasementData");
        end
        Basement.Data = ModData.getOrCreate("BasementMod.BasementData");
        ModData.request("BasementMod.BasementData");
    end
end
Events.OnInitGlobalModData.Add(initGlobalModData);

------------------------------------------------------------------------------------------------------------------------
--- RECEIVE GLOBAL MODDATA
------------------------------------------------------------------------------------------------------------------------

local function receiveGlobalModData(modDataName, data)
    if modDataName ~= "BasementMod.BasementData" then return; end
    if Basement.Data and type(data) == "table" then
        for key, value in pairs(data) do
            Basement.Data[key] = value;
        end
    end
end
Events.OnReceiveGlobalModData.Add(receiveGlobalModData);

------------------------------------------------------------------------------------------------------------------------
--- RECEIVE SERVER COMMANDS
------------------------------------------------------------------------------------------------------------------------

local function receiveServerCommand(module, command, args)
    if module ~= "BasementMod" then return; end

    if command == "CreateHatch" then
        Basement.CreateHatchServer(args)
    end
end
Events.OnServerCommand.Add(receiveServerCommand);

------------------------------------------------------------------------------------------------------------------------
--- BASEMENT ZOMBIE REMOVER
------------------------------------------------------------------------------------------------------------------------

local lastRoomID;
local function onPlayerUpdate(player)
    local square = player:getSquare();

    if not square then return; end

    local roomID = square:getRoomID();
    if not roomID then return; end

    if lastRoomID ~= roomID then
        lastRoomID = roomID;

        Utils.delayedFunction(function()
            
            local zombies = getCell():getZombieList();

            if zombies:size() <= 0 then return; end

            local x, y, z = square:getX(), square:getY(), square:getZ();
            local basement = Basement.FindByPosition(x, y, z);
            if basement then
                local zombieToRemove = {};
                for i = 0, zombies:size() - 1 do
                    local zombie = zombies:get(i);
                    if zombie and not zombie:isReanimatedPlayer() then
                        local zx, zy, zz = zombie:getX(), zombie:getY(), zombie:getZ();
                        if basement:isInBasement(zx, zy, zz) then
                            table.insert(zombieToRemove, zombie);
                        end
                    end
                end

                for i = 1, #zombieToRemove do
                    local zombie = zombieToRemove[i];
                    if isClient() then
                        local onlineID = zombie:getOnlineID();
                        sendClientCommand("BasementMod", "removeZombie", { onlineID = onlineID });
                    end
                    zombie:removeFromWorld();
                    zombie:removeFromSquare();
                    print("BasementMod deleted a client zombie!");
                end
            end

        end, 10);
    end
end
Events.OnPlayerUpdate.Add(onPlayerUpdate);

------------------------------------------------------------------------------------------------------------------------
--- WORLD CONTEXT MENU
------------------------------------------------------------------------------------------------------------------------

local function predicateCarBattery(item)
	return item:hasTag("CarBattery") or item:getType() == "CarBattery1" or item:getType() == "CarBattery2" or item:getType() == "CarBattery3";
end

local function onFillWorldObjectContextMenu(player, context, worldobjects, test)
    if getCore():getGameMode() == 'LastStand' then return; end
    if test then return; end

    local square = clickedSquare;
    local playerObj = getSpecificPlayer(player);
    local playerInv = playerObj:getInventory();
    local squareX, squareY, squareZ = square:getX(), square:getY(), square:getZ();

    if playerObj:getVehicle() then return; end

    ---@type Basement
    local currentBasement = Basement.FindByPosition(squareX, squareY, squareZ);

    ---@type IsoObject
    local currentHatch = Basement.GetHatchOnSquare(square);
    -- Fix object blocking the view of the basement entrance
    if not currentHatch then
        for xx = squareX - 1, squareX + 1 do
            for yy = squareY - 1, squareY + 1 do
                local sq = getSquare(xx, yy, squareZ)
                currentHatch = Basement.GetHatchOnSquare(sq);
                if currentHatch then break end;
            end
            if currentHatch then break end;
        end
    end
    
    --- IS INSIDE A BASEMENT

    if currentBasement then

        --- IS ON EXIT TILE

        local function doExitBasement()
            ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, currentBasement.x + currentBasement.exitX + 0.5, currentBasement.y + currentBasement.exitY + 0.5, currentBasement.z));
            ISTimedActionQueue.add(ExitBasementAction:new(playerObj));
        end
        context:addOptionOnTop(getText("ContextMenu_BasementExit"), nil, doExitBasement);

        --- IS ON ELECTRIC PANEL

        local ElecShutModifier = getSandboxOptions():getOptionByName("ElecShutModifier"):getValue();
        if Basement.GetElectricPanelOnSquare(square) then
            
            local generator = currentBasement:getGenerator();
            if not generator then generator = currentBasement:getOrCreateGenerator(); end
            local modData = generator:getModData();
            generator:setConnected(modData.carBattery ~= nil);
            
            --- CITY POWER GRID IS DOWN

            if (getGameTime():getNightsSurvived() >= ElecShutModifier) then
                if modData.carBattery then
                    local function removeCarBattery()
                        ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, squareX + 0.5, squareY + 0.5, squareZ));
                        ISTimedActionQueue.add(ElectricPanelRemoveCarBatteryAction:new(playerObj, generator));
                    end
                    local option = context:addOptionOnTop(getText("ContextMenu_Basement_RemoveCarBattery"), nil, removeCarBattery);
                    if generator:isActivated() then
                        option.notAvailable = true;
                        local tooltip = ISWorldObjectContextMenu.addToolTip();
                        tooltip.description = " <RGB:1,0.3,0.3> " .. getText("Tooltip_basement_turnoff_power_first");
                        option.toolTip = tooltip;
                    end
                else
                    local carBatteries = playerInv:getAllEvalRecurse(predicateCarBattery);
                    local function doInsertCarBattery(carBattery)
                        ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, squareX + 0.5, squareY + 0.5, squareZ));
                        ISTimedActionQueue.add(ElectricPanelInsertCarBatteryAction:new(playerObj, carBattery, generator));
                    end
                    local insertCarBattery = context:addOptionOnTop(getText("ContextMenu_Basement_InsertCarBattery"));
                    if generator:isActivated() then
                        insertCarBattery.notAvailable = true;
                        local tooltip = ISWorldObjectContextMenu.addToolTip();
                        tooltip.description = " <RGB:1,0.3,0.3> " .. getText("Tooltip_basement_turnoff_power_first");
                        insertCarBattery.toolTip = tooltip;
                    
                    elseif (carBatteries:size() > 0) then
                        local insertCarBatteryContext = ISContextMenu:getNew(context);
                        context:addSubMenu(insertCarBattery, insertCarBatteryContext);

                        for i = 0, carBatteries:size() - 1 do
                            local carBattery = carBatteries:get(i);
                            insertCarBatteryContext:addOption(carBattery:getName() .. " (" .. luautils.round(carBattery:getUsedDelta() * 100, 2) .. "%)" , carBattery, doInsertCarBattery);
                        end
                    else
                        insertCarBattery.notAvailable = true;
                        local tooltip = ISWorldObjectContextMenu.addToolTip();
                        tooltip.description = " <RGB:1,0.3,0.3> " .. getText("Tooltip_basement_no_car_battery_found");
                        insertCarBattery.toolTip = tooltip;
                    end
                end

                -- Toggle Power Option
                local function togglePower()
                    ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, squareX + 0.5, squareY + 0.5, squareZ));
                    ISTimedActionQueue.add(BasementPowerSwitchAction:new(playerObj, square, generator));
                end
                if modData.carBattery then
                    context:addOptionOnTop(generator:isActivated() and getText("ContextMenu_Basement_TurnPowerOff") or getText("ContextMenu_Basement_TurnPowerOn"), nil, togglePower);
                end

            --- CITY POWER GRID IS ON
            else
                generator:setActivated(false);
            end

            -- ELECTRIC PANEL INFO OPTION

            local powertOption = context:addOptionOnTop(getText("ContextMenu_BasementElectricPanel"));
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_basement_electric_panel"));

            if (getGameTime():getNightsSurvived() < ElecShutModifier) then
                tooltip.description = " <RGB:0.3,1,0.3> " .. getText("Tooltip_basement_using_city_power_grid");
            
            elseif modData.carBattery then
                tooltip.description = getText("Tooltip_basement_battery") .. ": " .. luautils.round(generator:getFuel(), 2) .. "%";
                tooltip.description = tooltip.description .. "\n" .. getText("Tooltip_basement_condition") .. ": " .. luautils.round(generator:getCondition(), 2) .. "%";
            else
                tooltip.description = " <RGB:1,0.3,0.3> " .. getText("Tooltip_basement_no_car_battery");
            end

            powertOption.toolTip = tooltip;
        end
    end

    --- IS NOT INSIDE A BASEMENT

    if not currentBasement then
        local basementId = Basement.GetHatchBasementId(currentHatch);

        --- CLICKED A BASEMENT HATCH

        if currentHatch and basementId then
            local function doEnterBasement()
                if luautils.walkAdj(playerObj, currentHatch:getSquare()) then
                    ISTimedActionQueue.add(EnterBasementAction:new(playerObj, basementId, currentHatch));
                end
            end
            context:addOptionOnTop(getText("ContextMenu_BasementEnter"), nil, doEnterBasement);
        end

        --- NO HATCH IN THIS BUILDING
        if Basement.CanCreateHatchOnSquare(square) then
            if ISBuildMenu.cheat == true or (playerInv:getFirstTagRecurse("Hammer") and playerInv:getFirstTagRecurse("DigGrave")) then
                local function doBuildHatch(size)
                    local multiplier = size == "medium" and 2 or size == "large" and 3 or 1;
                    local hatch = ISHatch:new("BasementHatch", size, Basement.HatchSprite[size]);
                    hatch.modData["xp:Woodwork"] = 200;
                    hatch.modData["need:Base.Plank"] = tostring(20 * multiplier);
                    hatch.modData["need:Base.Nails"] = tostring(30 * multiplier);
                    hatch.player = player;
                    hatch.completionSound = "BuildWoodenStructureLarge";
                    getCell():setDrag(hatch, player);
                end

                local buildOption = context:addOptionOnTop("Basement");
                local buildContext = ISContextMenu:getNew(context);
                context:addSubMenu(buildOption, buildContext);

                for _, size in pairs(Basement.Sizes) do
                    local hatchOption = buildContext:addOption(getText("ContextMenu_BasementBuildHatch_" .. size), size, doBuildHatch);
                    
                    local recipeName = "build " .. size .. " basement";
                    local magazine = getScriptManager():getItem("BasementMod.BasementsMag_" .. size);
                    if not ISBuildMenu.cheat and not playerObj:isRecipeKnown(recipeName) then
                        local tooltip = ISWorldObjectContextMenu.addToolTip();
                        tooltip:setName(getText("ContextMenu_Hatch_" .. size));
                        tooltip.description = getText("Tooltip_craft_hatchLearnRecipeDesc", magazine:getDisplayName()) .. tooltip.description;
                        hatchOption.toolTip = tooltip;
                        hatchOption.notAvailable = true;
                    else
                        local multiplier = size == "medium" and 2 or size == "large" and 3 or 1;
                        local tooltip = ISBuildMenu.canBuild(20 * multiplier, 30 * multiplier, 2, 1, 0, 3 * multiplier, hatchOption, player);
                        tooltip:setTexture(Basement.HatchSprite[size].E);
                        tooltip:setName(getText("ContextMenu_Hatch_" .. size));
                        tooltip.description = getText("Tooltip_craft_hatchDesc_" .. size) .. tooltip.description;
                        if not ISBuildMenu.cheat and not hatchOption.notAvailable then
                            hatchOption.notAvailable = not Basement.CanCreateHatchOfSizeOnSquare(square, size);
                        end
                    end

                end
            end
        end
    end

    --- DEBUG/ADMIN MENU

    if isDebugEnabled() or isAdmin() then

        local adminOption = context.addDebugOption and context:addDebugOption("Basement Tools") or context:addOption("[DEBUG] Basement Tools");
        local adminContext = ISContextMenu:getNew(context);
        context:addSubMenu(adminOption, adminContext);

        --- Hatch Tools
        if currentHatch then

            local hatchInfo = currentHatch:getModData().BasementMod;
            local hatchBasement = Basement.FindById(hatchInfo.basementId);
            local hatchBasementData = Basement.Data.Basements[hatchBasement.id];
            local infoOption = adminContext:addOption("Hatch Info");
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName("Hatch #" .. hatchBasement.id);
            tooltip.description = "Size: " .. hatchBasement:getW() .. "x" .. hatchBasement:getH();
            tooltip.description = tooltip.description .. " \n Position: X:" .. squareX .. " Y:" .. squareY .. " Z:" .. squareZ;
            
            if hatchBasementData then
                tooltip.description = tooltip.description .. " \n Building ID: " .. hatchBasementData.buildingId;
                tooltip.description = tooltip.description .. " \n Entrance Position: X:" .. hatchBasement.x + hatchBasement.exitX .. " Y:" .. hatchBasement.y + hatchBasement.exitY .. " Z:" .. hatchBasement.z;
            end

            infoOption.toolTip = tooltip;
        end

        --- Current Basement Tools
        if currentBasement then

            local infoOption = adminContext:addOption("Basement Info");
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName("Basement #" .. currentBasement.id);
            tooltip.description = "Size: " .. currentBasement:getW() .. "x" .. currentBasement:getH();
            tooltip.description = tooltip.description .. " \n Position: X:" .. currentBasement:getX() .. " Y:" .. currentBasement:getY() .. " Z:" .. currentBasement:getZ();
            
            local basementData = Basement.Data.Basements[currentBasement.id];
            if basementData then
                tooltip.description = tooltip.description .. " \n Building ID: " .. basementData.buildingId;
                tooltip.description = tooltip.description .. " \n Hatch Position: X:" .. basementData.hatchPosition.x .. " Y:" .. basementData.hatchPosition.y .. " Z:" .. basementData.hatchPosition.z;
            end

            infoOption.toolTip = tooltip;

            adminContext:addOption("Exit Basement", playerObj, Basement.ExitBasement);

        end

        --- Teleport Tools
        local teleportOption = adminContext:addOption("Teleport to");
        local teleportContext = ISContextMenu:getNew(adminContext);
        adminContext:addSubMenu(teleportOption, teleportContext);

        local basements = BasementAPI.GetBasements();

        --- Teleport to Active Basements
        local teleportActiveOption = teleportContext:addOption("assigned");
        local teleportActiveContext = ISContextMenu:getNew(teleportContext);
        teleportContext:addSubMenu(teleportActiveOption, teleportActiveContext);
        for _, basementData in pairs(Basement.Data.Basements) do
            local basement = Basement.FindById(basementData.basementId);
            if basement then
                local option = teleportActiveContext:addOption("Basement #" .. basement.id, playerObj, Basement.EnterBasementId, basement.id);
                option.notAvailable = currentBasement and currentBasement.id == basement.id;
            end
        end

        --- Teleport to All Basements
        for _, size in pairs(Basement.Sizes) do
            local teleportSizeOption = teleportContext:addOption(size);
            local teleportSizeContext = ISContextMenu:getNew(teleportContext);
            teleportContext:addSubMenu(teleportSizeOption, teleportSizeContext);

            for _, basement in ipairs(basements) do
                if basement.size == size then
                    local option = teleportSizeContext:addOption("Basement #" .. basement.id, playerObj, Basement.EnterBasementId, basement.id);
                    option.notAvailable = currentBasement and currentBasement.id == basement.id;
                end
            end
        end

    end

end
Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu);
