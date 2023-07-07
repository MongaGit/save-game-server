
if isClient() then return end

local CommonCommands = {}
local Commands = {}


function CommonCommands.exchangePartsVehicleToTrailer(veh1, trailer)
    local partsTable = {}
    for i=1, veh1:getScript():getPartCount() do
        local part = veh1:getPartByIndex(i-1)
        partsTable["wrecker_" .. part:getId()] = {}
        partsTable["wrecker_" .. part:getId()]["InventoryItem"] = part:getInventoryItem()
        partsTable["wrecker_" .. part:getId()]["Condition"] = part:getCondition()
        partsTable["wrecker_" .. part:getId()]["modData"] = part:getModData()
        partsTable["wrecker_" .. part:getId()]["ItemContainer"] = part:getItemContainer()
    end
    for i=1, trailer:getScript():getPartCount() do
        local part = trailer:getPartByIndex(i-1)
        if part:getId() == "ATAVehicleWrecker" then
            part:setInventoryItem(InventoryItemFactory.CreateItem(part:getItemType():get(0)))
            part:getModData()["scriptName"] = veh1:getScript():getName()
            part:getModData()["skin"] = veh1:getSkinIndex()
            part:getModData()["rust"] = veh1:getRust()
        elseif partsTable[part:getId()] then
            part:setInventoryItem(partsTable[part:getId()]["InventoryItem"])
            part:setCondition(partsTable[part:getId()]["Condition"])
            if partsTable[part:getId()]["ItemContainer"] then
                part:setItemContainer(partsTable[part:getId()]["ItemContainer"])
            end
            if partsTable[part:getId()]["modData"] then
                for a, b in pairs(partsTable[part:getId()]["modData"]) do 
                    part:getModData()[a] = b
                end
            end
        end
        trailer:transmitPartItem(part)
    end
    -- print("veh1 keyId: ", veh1:getKeyId())
    -- print("veh2 keyId: ", veh2:getKeyId())
    trailer:setRust(veh1:getRust())
    trailer:setKeyId(veh1:getKeyId())
    -- print("veh2 new keyId: ", veh2:getKeyId())
    return trailer
end

function CommonCommands.exchangePartsVehicleToTrailer2(veh1, trailer)
-- print("exchangePartsVehicleToTrailer2")
    local wreckerPart = trailer:getPartById("ATA2VehicleWrecker")
    wreckerPart:setInventoryItem(InventoryItemFactory.CreateItem(wreckerPart:getItemType():get(0)))
    wreckerPart:getModData()
    wreckerPart:getModData()["scriptName"] = veh1:getScript():getName()
    wreckerPart:getModData()["skin"] = veh1:getSkinIndex()
    wreckerPart:getModData()["h"] = veh1:getColorHue()
    wreckerPart:getModData()["s"] = veh1:getColorSaturation()
    wreckerPart:getModData()["v"] = veh1:getColorValue()
    wreckerPart:getModData()["rust"] = veh1:getRust()
    wreckerPart:getModData().parts = {}
    
    local modDataParts = wreckerPart:getModData().parts
    local containerID = 1
    
    for i=1, veh1:getScript():getPartCount() do
        local part = veh1:getPartByIndex(i-1)
        local trailerPart = trailer:getPartById("wrecker_" .. part:getId())
        if trailerPart then
            trailerPart:setInventoryItem(part:getInventoryItem())
            trailerPart:setCondition(part:getCondition())
            trailerPart:setItemContainer(part:getItemContainer())
            if part:getModData() then
                for a, b in pairs(part:getModData()) do 
                    trailerPart:getModData()[a] = b
                end
            end
            trailer:transmitPartItem(trailerPart)
        else
            modDataParts[part:getId()] = {}
            if part:getItemContainer() then
                local contPartName = "wrecker_Container" .. containerID
                local contPart = trailer:getPartById(contPartName)
                containerID = containerID + 1
                contPart:setInventoryItem(part:getInventoryItem())
                contPart:setCondition(part:getCondition())
                contPart:setItemContainer(part:getItemContainer())
                if part:getModData() then
                    for a, b in pairs(part:getModData()) do 
                        contPart:getModData()[a] = b
                    end
                end
                trailer:transmitPartItem(contPart)
                modDataParts[part:getId()].contPart = contPartName
            else
                if part:getInventoryItem() then
                    modDataParts[part:getId()]["InventoryItem"] = part:getInventoryItem():getFullType()
                else
                    modDataParts[part:getId()]["InventoryItem"] = false
                end
                modDataParts[part:getId()]["Condition"] = part:getCondition()
                modDataParts[part:getId()]["modData"] = part:getModData()
            end
        end
    end
    trailer:transmitPartItem(wreckerPart)
    -- print("veh1 keyId: ", veh1:getKeyId())
    -- print("veh2 keyId: ", veh2:getKeyId())
    trailer:setRust(veh1:getRust())
    trailer:setKeyId(veh1:getKeyId())
    -- print("veh2 new keyId: ", veh2:getKeyId())
    return trailer
end

function CommonCommands.exchangePartsTrailerToVehicle(veh1, trailer)
    local partsTable = {}
    for i=1, trailer:getScript():getPartCount() do
        local part = trailer:getPartByIndex(i-1)
        
        local partNameTrim = string.sub(part:getId(), 9)
        if partNameTrim ~= "" then
            partsTable[partNameTrim] = {}
            partsTable[partNameTrim]["InventoryItem"] = part:getInventoryItem()
            partsTable[partNameTrim]["Condition"] = part:getCondition()
            partsTable[partNameTrim]["modData"] = part:getModData()
            partsTable[partNameTrim]["ItemContainer"] = part:getItemContainer()
        end
    end
    for i=1, veh1:getScript():getPartCount() do
        local part = veh1:getPartByIndex(i-1)
        if partsTable[part:getId()] then
            part:setInventoryItem(partsTable[part:getId()]["InventoryItem"])
            part:setCondition(partsTable[part:getId()]["Condition"])
            if partsTable[part:getId()]["ItemContainer"] then
                part:setItemContainer(partsTable[part:getId()]["ItemContainer"])
            end
            if partsTable[part:getId()]["modData"] then
                for a, b in pairs(partsTable[part:getId()]["modData"]) do 
                    part:getModData()[a] = b
                end
            end
            veh1:transmitPartItem(part)
        end
    end
    -- print("veh1 keyId: ", veh1:getKeyId())
    -- print("veh2 keyId: ", veh2:getKeyId())
    veh1:setRust(trailer:getRust())
    veh1:setKeyId(trailer:getKeyId())
    -- print("veh2 new keyId: ", veh2:getKeyId())
    return veh1
end

function CommonCommands.exchangePartsTrailerToVehicle2(veh1, trailer, playerObj)
    local partsTable = {}
    for i=1, trailer:getScript():getPartCount() do
        local part = trailer:getPartByIndex(i-1)
        if string.sub(part:getId(), 1, 7) == "wrecker" then
            local partNameTrim = string.sub(part:getId(), 9)
            if partNameTrim ~= "" then
                local vehPart = veh1:getPartById(partNameTrim)
                if vehPart then
                    vehPart:setInventoryItem(part:getInventoryItem())
                    vehPart:setCondition(part:getCondition())
                    if part:getModData() then
                        for a, b in pairs(part:getModData()) do 
                            vehPart:getModData()[a] = b
                        end
                    end
                    if part:getItemContainer() then
                        vehPart:setItemContainer(part:getItemContainer())
                    end
                    veh1:transmitPartItem(vehPart)
                    if vehPart:getLuaFunction("init") then
                        VehicleUtils.callLua(vehPart:getLuaFunction("init"), veh1, vehPart, playerObj)
                    end
                end
            end
        end
    end
    local wreckerPart = trailer:getPartById("ATA2VehicleWrecker")
    local modDataParts = wreckerPart:getModData().parts
    for wPartName, wTable in pairs(modDataParts) do
        local vehPart = veh1:getPartById(wPartName)
        if modDataParts[wPartName].contPart then
            local part = trailer:getPartById(modDataParts[wPartName].contPart)

            local vehPart = veh1:getPartById(wPartName)
            vehPart:setInventoryItem(part:getInventoryItem())
            vehPart:setCondition(part:getCondition())
            if part:getModData() then
                for a, b in pairs(part:getModData()) do 
                    vehPart:getModData()[a] = b
                end
            end
            if part:getItemContainer() then
                vehPart:setItemContainer(part:getItemContainer())
            end
        else
            if modDataParts[wPartName]["InventoryItem"] then
                vehPart:setInventoryItem(InventoryItemFactory.CreateItem(modDataParts[wPartName]["InventoryItem"]))
            else
                vehPart:setInventoryItem(nil)
            end
            vehPart:setCondition(modDataParts[wPartName]["Condition"])
            if modDataParts[wPartName]["modData"] then
                for a, b in pairs(modDataParts[wPartName]["modData"]) do 
                    vehPart:getModData()[a] = b
                end
            end
        end
        veh1:transmitPartItem(vehPart)
        if vehPart:getLuaFunction("init") then
            VehicleUtils.callLua(vehPart:getLuaFunction("init"), veh1, vehPart, playerObj)
        end
    end
    wreckerPart:getModData()["scriptName"] = nil
    wreckerPart:getModData()["skin"] = nil
    wreckerPart:getModData()["rust"] = nil
    wreckerPart:getModData().parts = nil
    -- print("veh1 keyId: ", veh1:getKeyId())
    -- print("veh2 keyId: ", veh2:getKeyId())
    veh1:setRust(trailer:getRust())
    veh1:setKeyId(trailer:getKeyId())
    -- veh1:createPhysics()
    -- print("veh2 new keyId: ", veh2:getKeyId())
    return veh1
end

function Commands.toggleBatteryHeater(playerObj, args)
    -- print("Commands.toggleBatteryHeater")
    local vehicle = playerObj:getVehicle();
    if vehicle then
        local part = vehicle:getPartById("BatteryHeater");
        if not part:getModData().tsarslib then part:getModData().tsarslib = {} end
        if part then
            part:getModData().tsarslib.active = args.on;
            part:getModData().tsarslib.temperature = args.temp;
            vehicle:transmitPartModData(part);
        end
    else
        noise('player not in vehicle');
    end
end

-- sendClientCommand(playerObj, 'commonlib', 'bulbSmash', {vehicle = vehicle:getId(),})
function Commands.bulbSmash(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById("LightCabin")
        if part and part:getInventoryItem() then
            part:setCondition(0)
            vehicle:transmitPartCondition(part)
        end
    end
end

-- sendClientCommand(playerObj, 'commonlib', 'installTuning', {vehicle = vehicle:getId(), part = self.part:getId(),})
function Commands.installTuning(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById(args.part)
        local item = InventoryItemFactory.CreateItem("Base.LightBulb")
        if part then
            part:setInventoryItem(item)
            part:getModData().tuning2 = {}
            part:getModData().tuning2.model = args.model
            vehicle:transmitPartModData(part)
            local tbl = part:getTable("install")
			if tbl and tbl.complete then
				VehicleUtils.callLua(tbl.complete, vehicle, part, nil)
			end
            vehicle:transmitPartItem(part)
        end
    end
end

-- sendClientCommand(playerObj, 'commonlib', 'uninstallTuning', {vehicle = vehicle:getId(), part = self.part:getId(),})
function Commands.uninstallTuning(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById(args.part)
        if part and part:getInventoryItem() then
            part:setInventoryItem(nil)
            local tbl = part:getTable("uninstall")
            part:getModData().tuning2 = {}
            vehicle:transmitPartModData(part)
			if tbl and tbl.complete then
				VehicleUtils.callLua(tbl.complete, vehicle, part, nil)
			end
            vehicle:transmitPartItem(part)
        end
    end
end

-- sendClientCommand(playerObj, 'commonlib', 'cabinlightsOn', {vehicle = vehicle:getId(),})
function Commands.cabinlightsOn(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById("LightCabin")
        if part and part:getInventoryItem() then
            local apipart = vehicle:getPartById("HeadlightRearRight")
            local newItem = InventoryItemFactory.CreateItem("Base.LightBulb")
            local partCondition = part:getCondition()
            newItem:setCondition(partCondition)
            apipart:setInventoryItem(newItem, 10) -- transmit
            vehicle:transmitPartItem(apipart)
            partCondition = partCondition - 1
            part:setCondition(partCondition)
            vehicle:transmitPartCondition(part)
        end
    end
end


-- sendClientCommand(self.character, 'commonlib', 'updatePaintVehicle', {vehicle = self.vehicle:getId(),})
function Commands.updatePaintVehicle(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById("TireFrontLeft")
        local invItem = part:getInventoryItem()
        part:setInventoryItem(nil)
        vehicle:transmitPartItem(part)
        part:setInventoryItem(invItem)
        vehicle:transmitPartItem(part)
        part = vehicle:getPartById("TireFrontRight")
        invItem = part:getInventoryItem()
        part:setInventoryItem(nil)
        vehicle:transmitPartItem(part)
        part:setInventoryItem(invItem)
        vehicle:transmitPartItem(part)
        part = vehicle:getPartById("TireRearLeft")
        invItem = part:getInventoryItem()
        part:setInventoryItem(nil)
        vehicle:transmitPartItem(part)
        part:setInventoryItem(invItem)
        vehicle:transmitPartItem(part)
        part = vehicle:getPartById("TireRearRight")
        invItem = part:getInventoryItem()
        part:setInventoryItem(nil)
        vehicle:transmitPartItem(part)
        part:setInventoryItem(invItem)
        vehicle:transmitPartItem(part)
    end
end
-- sendClientCommand(self.character, 'commonlib', 'usePortableMicrowave', {vehicle = self.vehicle:getId(), oven = self.oven:getId(), on = true, timer = self.oven:getModData().tsarslib.timer, maxTemperature = self.oven:getModData().tsarslib.maxTemperature})
function Commands.usePortableMicrowave(playerObj, args)
    if args.vehicle then
        local vehicle = getVehicleById(args.vehicle)
        local part = vehicle:getPartById(args.oven)
        if not part:getModData().tsarslib then part:getModData().tsarslib = {} end
        part:getModData().tsarslib.maxTemperature = args.maxTemperature
        part:getModData().tsarslib.timer = args.timer
        if part:getItemContainer():isActive() and not args.on then
            part:getItemContainer():setActive(false)
            part:getModData().tsarslib.timer = 0
            part:getModData().tsarslib.timePassed = 0
        elseif part:getModData().tsarslib.timer > 0 and args.on then
            part:getItemContainer():setActive(true)
            part:getModData().tsarslib.timePassed = 0.001
            part:setLightActive(true)
        end
        vehicle:transmitPartModData(part)
    end
end

-- sendClientCommand(self.character, 'commonlib', 'loadVehicle', {trailer = self.trailer:getId(), vehicle = self.vehicle:getId()})
function Commands.loadVehicle(playerObj, args)
    -- print("Commands.loadVehicle")
    if args.trailer and args.vehicle then
        local trailer = getVehicleById(args.trailer)
        local vehicle = getVehicleById(args.vehicle)
        -- local newTrailerName = AquaConfig.Trailers[trailer:getScript():getName()].trailerWithBoatTable[vehicle:getScript():getName()]
        -- if isServer() then
        -- trailer = TCLConfig.replaceVehicle(trailer, newTrailerName, vehicle:getSkinIndex())
        -- else
            -- AquaConfig.replaceVehicleScript(trailer, newTrailerName)
        -- end
        if trailer:getPartById("ATAVehicleWrecker") then
            CommonCommands.exchangePartsVehicleToTrailer(vehicle, trailer)
            vehicle:permanentlyRemove()
        elseif trailer:getPartById("ATA2VehicleWrecker") then
            CommonCommands.exchangePartsVehicleToTrailer2(vehicle, trailer)
            vehicle:permanentlyRemove()
        end
    end
end

function Commands.launchVehicle(playerObj, args)
-- print("launchVehicle")
    if args.trailer then
        local trailer = getVehicleById(args.trailer)
        local wreckerPart = trailer:getPartById("ATAVehicleWrecker")
        if not wreckerPart then wreckerPart = trailer:getPartById("ATA2VehicleWrecker") end
        if wreckerPart then
            local scriptName = wreckerPart:getModData()["scriptName"]
            local square = getSquare(args.x, args.y, 0)
            if square then
                local vehicle = addVehicleDebug(scriptName, IsoDirections.N, trailer:getSkinIndex(), square)
                vehicle:setAngles(trailer:getAngleX(), trailer:getAngleY(), trailer:getAngleZ())
                
                vehicle:setSkinIndex(wreckerPart:getModData()["skin"])
                vehicle:updateSkin()
                
                vehicle:setColorHSV(wreckerPart:getModData()["h"], wreckerPart:getModData()["s"], wreckerPart:getModData()["v"])
                vehicle:transmitColorHSV()
                
                if trailer:getPartById("ATAVehicleWrecker") then
                    CommonCommands.exchangePartsTrailerToVehicle(vehicle, trailer)
                elseif trailer:getPartById("ATA2VehicleWrecker") then
                    CommonCommands.exchangePartsTrailerToVehicle2(vehicle, trailer, playerObj)
                end
                
                wreckerPart:setInventoryItem(nil)
                trailer:transmitPartItem(wreckerPart)

                -- Delete key
                local xx = vehicle:getX()
                local yy = vehicle:getY()

                for z=0, 3 do
                    for i=xx - 15, xx + 15 do
                        for j=yy - 15, yy + 15 do
                            local tmpSq = getCell():getGridSquare(i, j, z)
                            if tmpSq ~= nil then
                                for k=0, tmpSq:getObjects():size()-1 do
                                    local ttt =    tmpSq:getObjects():get(k)
                                    if ttt:getContainer() ~= nil then
                                        local items = ttt:getContainer():getItems()
                                        for ii=0, items:size()-1 do
                                            if items:get(ii):getKeyId() == vehicle:getKeyId() then
                                                items:remove(ii)
                                            end
                                        end
                                    elseif instanceof(ttt, "IsoWorldInventoryObject") then
                                        if ttt:getItem() and ttt:getItem():getContainer() then
                                            local items = ttt:getItem():getContainer():getItems()
                                            for ii=0, items:size()-1 do
                                                if items:get(ii):getKeyId() == vehicle:getKeyId() then
                                                    items:remove(ii)
                                                end
                                            end
                                        end
                                        
                                        if ttt:getItem() and ttt:getItem():getKeyId() == vehicle:getKeyId() then
                                            tmpSq:removeWorldObject(ttt)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


-- sendClientCommand(self.character, 'commonlib', 'addVehicle', {trailer=self.trailer:getId(), activate = self.activate})
CommonCommands.OnClientCommand = function(module, command, playerObj, args)
    --print("CommonCommands.OnClientCommand")
    if module == 'commonlib' and Commands[command] then
        --print("trailer")
        local argStr = ''
        args = args or {}
        for k,v in pairs(args) do
            argStr = argStr..' '..k..'='..tostring(v)
        end
        --noise('received '..module..' '..command..' '..tostring(trailer)..argStr)
        Commands[command](playerObj, args)
    end
end

Events.OnClientCommand.Add(CommonCommands.OnClientCommand)
