local Utils = require("BasementMod/Utils");

---@class Basement
local Basement = ISBaseObject:derive("Basement");

--- Access object in debug mode
if isDebugEnabled() then
   _G["Basement"] = Basement;
end

--- Stored Global ModData
---@type table
Basement.Data = nil;

--- Basement Sizes
---@class Sizes
Basement.Sizes = {
    small = "small", 
    medium = "medium", 
    large = "large"
};

--- Hatch Sprites
---@class HatchSprite
Basement.HatchSprite = {
    small = { E = "f_pert_basement_1_11", N = "f_pert_basement_1_11" },
    medium = { E = "f_pert_basement_1_10", N = "f_pert_basement_1_10" },
    large = { E = "f_pert_basement_1_9", N = "f_pert_basement_1_9" },
};

--- Electric Panel Sprites
---@class ElectricPanelSprite
Basement.ElectricPanelSprite = "f_pert_basement_1_8";

------------------------------------------------------------------------------------------------------------------------
--- STATIC METHODS
------------------------------------------------------------------------------------------------------------------------

--- Get a basement from the API by ID
---@param basementId number
function Basement.FindById(basementId)
    return BasementAPI.GetBasements()[basementId];
end

--- Get a basement from the API by position
---@param x number
---@param y number
---@param z number
function Basement.FindByPosition(x, y, z)
    local basements = BasementAPI.GetBasements();
    for i = 1, #basements do
        local basement = basements[i];
        if basement and basement:isInBasement(x, y,z) then
            return basement;
        end
    end
end

--- Get the total free basement count
---@param size string small,medium,large
---@return number
function Basement.GetFreeBasementCount(size)
    local count = 0;
    local basements = BasementAPI.GetBasementsOfSize(size);
    for _, basement in ipairs(basements) do
        if not Basement.Data.Basements[basement.id] then
            count = count + 1;
        end
    end
    return count;
end

--- Get electric panel on a square
---@param square IsoGridSquare
---@return IsoObject|nil
function Basement.GetElectricPanelOnSquare(square)
    if instanceof(square, "IsoGridSquare") then
        local objs = square:getObjects();
        for i = 0, objs:size() - 1 do
            local obj = objs:get(i);
            local attachedSprites = obj:getAttachedAnimSprite()
            if attachedSprites ~= nil then
                for i = 0, attachedSprites:size()-1 do
                    local sprite = attachedSprites:get(i):getParentSprite()
                    if sprite and sprite:getName() == Basement.ElectricPanelSprite then
                        return obj;
                    end
                end
            end
        end
    end
end

--- Get a random free basement
---@param size string small,medium,large
---@return Basement|nil
function Basement.GetRandomFreeBasement(size)
    local available = {};
    local basements = BasementAPI.GetBasementsOfSize(size);
    for _, basement in ipairs(basements) do
        if not Basement.Data.Basements[basement.id] then
            table.insert(available, basement);
        end
    end
    if #available > 0 then
        local random = ZombRand(1, #available + 1);
        return available[random];
    end
    return nil;
end

--- Check if a basement is already taken by ID
---@return boolean
function Basement.IsBasementIdTaken(basementId)
    return Basement.Data.Basements[basementId] ~= nil;
end

--- Teleport a player inside a basement from a basement ID
---@param playerObj IsoPlayer
---@param basementId number
---TEST: Basement.EnterBasementId(getPlayer(), 8)
function Basement.EnterBasementId(playerObj, basementId)
    local basement = Basement.FindById(basementId);
    if basement then
        basement:enterBasement(playerObj);
    end
end

--- Teleport a player out of the basement
---@param playerObj IsoPlayer
---TEST: Basement.ExitBasement(getPlayer())
function Basement.ExitBasement(playerObj)
    local basement = Basement.FindByPosition(playerObj:getX(), playerObj:getY(), playerObj:getZ());
    local basementData = basement and Basement.Data.Basements[basement.id];
    if basementData then
        playerObj:setX(basementData.hatchPosition.x + 0.5);
        playerObj:setY(basementData.hatchPosition.y + 0.5);
        playerObj:setZ(basementData.hatchPosition.z);
        playerObj:setLx(basementData.hatchPosition.x + 0.5);
        playerObj:setLy(basementData.hatchPosition.y + 0.5);
        playerObj:setLz(basementData.hatchPosition.z);
        playerObj:getModData().BasementMod.lastHatchPosition = nil; --- Clear last hatch position
        print("Player exited basement id = " .. tostring(basement.id) .. "!");
    else
        --- Backup if something wrong happen lets go back from player moddata
        local modData = playerObj:getModData();
        if modData.BasementMod and modData.BasementMod.lastHatchPosition then
            playerObj:setX(modData.BasementMod.lastHatchPosition.x + 0.5);
            playerObj:setY(modData.BasementMod.lastHatchPosition.y + 0.5);
            playerObj:setZ(modData.BasementMod.lastHatchPosition.z);
            playerObj:setLx(modData.BasementMod.lastHatchPosition.x + 0.5);
            playerObj:setLy(modData.BasementMod.lastHatchPosition.y + 0.5);
            playerObj:setLz(modData.BasementMod.lastHatchPosition.z);
            modData.BasementMod.lastHatchPosition = nil; --- Clear last hatch position
            print("Player exited basement id = " .. tostring(basement.id) .. " from player moddata!");
        end
    end
end

--- Check an object is a hatch
---@return boolean
function Basement.IsObjectHatch(obj)
    local spriteName = obj:getSprite():getName() or obj:getSpriteName();
    for _, size in pairs(Basement.Sizes) do
        if spriteName == Basement.HatchSprite[size].E or spriteName == Basement.HatchSprite[size].N then
            return true;
        end
    end
end

--- Get hatch on a square
---@param square IsoGridSquare
---@return IsoObject|nil
---TEST: print(Basement.GetHatchOnSquare(getPlayer():getSquare()))
function Basement.GetHatchOnSquare(square)
    if instanceof(square, "IsoGridSquare") then
        local objs = square:getObjects();
        for i = 0, objs:size() - 1 do
            local obj = objs:get(i);
            if Basement.IsObjectHatch(obj) then
                return obj;
            end
        end
    end
end

--- Get hatch in a building
---@param building IsoBuilding
---@return IsoObject|nil
---TEST: print(Basement.GetHatchInBuilding(getPlayer():getBuilding()))
function Basement.GetHatchInBuilding(building)
    if instanceof(building, "IsoBuilding") then
        local def = building:getDef();
        if def then
            for x = def:getX(), def:getX2() do
                for y = def:getY(), def:getY2() do
                    local square = getSquare(x, y, 0);
                    local hatch = Basement.GetHatchOnSquare(square);
                    if hatch then
                        return hatch;
                    end
                end
            end
        end
    end
end

--- Check if hatch can be built on this square
---@param square IsoGridSquare
function Basement.CanCreateHatchOnSquare(square)
    if instanceof(square, "IsoGridSquare") then
        local building = square:getBuilding();
        local x, y, z = square:getX(), square:getY(), square:getZ();
        return building and z == 0 and not Basement.FindByPosition(x, y, z) and not Basement.GetHatchInBuilding(building);
    end
    return false;
end

--- Check if hatch of size can be built on this square
---@param square IsoGridSquare
---@param size string small,medium,large
function Basement.CanCreateHatchOfSizeOnSquare(square, size)
    return Basement.CanCreateHatchOnSquare(square) and Basement.GetFreeBasementCount(size) > 0;
end

--- Create a new hatch
--- Position must be inside a building, there must be no other hatch in that building
---@param x number
---@param y number
---@param size string small,medium,large
---@param facing string E or N
function Basement.CreateHatch(x, y, size, facing)
    if isServer() then return; end

    
    local square = getSquare(x, y, 0);
    if not square then return; end
    
    local building = square:getBuilding();
    if not building then return; end
    
    local basement = Basement.GetRandomFreeBasement(size);
    if not basement then return; end

    if not Basement.CanCreateHatchOnSquare(square) then return; end

    local basementData = {
        basementId = basement.id,
        buildingId = building:getID(),
        hatchPosition = {
            x = x, 
            y = y, 
            z = 0
        }
    };

    --- Remove removable object on square
    for i = 0, square:getObjects():size() - 1 do
        local object = square:getObjects():get(i);
        if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
            square:transmitRemoveItemFromSquare(object)
            square:RemoveTileObject(object);
            break
        end
    end

    --- Disable erosion
    square:disableErosion();
    if isClient() then
        local args = { x = x, y = y, z = 0 };
        sendClientCommand('erosion', 'disableForSquare', args);
    end

    --- Create IsoObject Hatch
    local hatch = IsoObject.new(getCell(), square, Basement.HatchSprite[size][facing]);
    hatch:getModData().BasementMod = basementData;
    square:AddSpecialObject(hatch);

    if isClient() then
        hatch:transmitCompleteItemToServer();
    end
    sendClientCommand("BasementMod", "CreateHatch", basementData);
end

--- Create a new hatch on the server
---@param basementData table
function Basement.CreateHatchServer(basementData)
    Basement.Data.Basements[basementData.basementId] = basementData;
    if isServer() then
        sendServerCommand("BasementMod", "CreateHatch", basementData);
        -- ModData.transmit("BasementMod.BasementData");
    end
end

--- Get the hatch basement id
---@param hatch IsoObject
---@return number if nil no basement was assigned
function Basement.GetHatchBasementId(hatch)
    if instanceof(hatch, "IsoObject") then
        return hatch:getModData().BasementMod and hatch:getModData().BasementMod.basementId;
    end
end

------------------------------------------------------------------------------------------------------------------------
--- INSTANCE METHODS
------------------------------------------------------------------------------------------------------------------------

--- Check if this basement already taken
---@return boolean
function Basement:isTaken()
    return Basement.IsBasementIdTaken(self.id);
end

--- Teleport a player to the basement
---@param playerObj IsoPlayer
function Basement:enterBasement(playerObj)
    local x, y, z = playerObj:getX(), playerObj:getY(), playerObj:getZ()
    local modData = playerObj:getModData();
    modData.BasementMod = modData.BasementMod or {};
    modData.BasementMod.lastHatchPosition = { x = playerObj:getX(), y = playerObj:getY(), z = playerObj:getZ() }; --- Store last hatch position
    playerObj:setX(self.x + self.exitX + 0.5);
    playerObj:setY(self.y + self.exitY + 0.5);
    playerObj:setZ(self.z);
    playerObj:setLx(self.x + self.exitX + 0.5);
    playerObj:setLy(self.y + self.exitY + 0.5);
    playerObj:setLz(self.z);

    --- Fall through Patch
    local ticks = 0;
    local function temporaryForceZPosition()
        ticks = ticks + 1
        if ticks < 300 then
            playerObj:setZ(self.z);
            playerObj:setbFalling(false);
            playerObj:setFallTime(0);
            playerObj:setLastFallSpeed(0);
        else
            local square = getSquare(self.x + self.exitX, self.y + self.exitY, self.z);
            if not square or not square:TreatAsSolidFloor() then
                Basement.ExitBasement(playerObj);
                playerObj:Say(getText("IGUI_Basements_map_not_loading"))
            end
            Events.OnTick.Remove(temporaryForceZPosition);
            print("Basements: temporaryForceZPosition completed!");
        end
    end
    if self.z > 1 then
        print("Basements: temporaryForceZPosition started...");
        Events.OnTick.Add(temporaryForceZPosition);
    else
        --- Void map patch
        Utils.delayedFunction(function()
            local square = getSquare(self.x + self.exitX, self.y + self.exitY, self.z);
            if not square or not square:TreatAsSolidFloor() then
                Basement.ExitBasement(playerObj);
                playerObj:Say(getText("IGUI_Basements_map_not_loading"));
            end
        end, 60);
    end

    Utils.delayedFunction(function()
        self:disableAlarm(playerObj);
    end, 5);

    print("Player entered basement id = " .. tostring(self.id) .. "!");
end

--- Get the generator position
---return x,y,z
function Basement:getGeneratorPosition()
    return (self.x + self.width / 2), (self.y + self.height / 2), self.z + 1;
end

--- Get the basement generator if any
---@return IsoGenerator|nil
function Basement:getGenerator()
    local x, y, z = self:getGeneratorPosition();
    local square = getSquare(x, y, z);
    if square then
        local objs = square:getObjects();
        for i = 0, objs:size() - 1 do
            local obj = objs:get(i);
            if instanceof(obj, "IsoGenerator") then
                return obj;
            end
        end
    end
end

--- Create the basement generator if none
---@return IsoGenerator
function Basement:getOrCreateGenerator()
    local generator = self:getGenerator();
    if not generator then
        local x, y, z = self:getGeneratorPosition();
        local square = getSquare(x, y, z);
        if square then
            local item = InventoryItemFactory.CreateItem("Base.Generator");
            generator = IsoGenerator.new(item, getCell(), square);
            generator:setConnected(false);
            generator:setCondition(ZombRand(101));
            generator:setFuel(0);
            if isServer() then
                generator:transmitCompleteItemToClients();
            end
        end
    end
    return generator;
end

--- Check if the basement generator has a car battery
---@return boolean
function Basement:hasCarBattery()
    local generator = self:getOrCreateGenerator();
    local modData = generator and generator:getModData();
    return modData and modData.carBattery ~= nil;
end

--- Check how much power left in the generator
---@return number
function Basement:getPowerLeft()
    local generator = self:getOrCreateGenerator();
    return generator and generator:getFuel() or 0;
end

--- Check if the generator is powered
---@return boolean
function Basement:isPowered()
    local generator = self:getOrCreateGenerator();
    return generator and generator:isActivated();
end

--- Remove basement's alarm if there is one.
---@param playerObj IsoPlayer
function Basement:disableAlarm(playerObj)
    local square = playerObj:getSquare()
    if not square then return; end

    local building = square:getBuilding();
    if not building then return; end

    local buildingDef = building:getDef()
    if buildingDef then
        buildingDef:setAlarmed(false);
    end
end

--- Check if coordinate is inside this basement
---@param x number
---@param y number
---@param z number
---@return boolean
function Basement:isInBasement(x, y, z)
    return (x >= self.x) and (y >= self.y) and (x <= self.x + self.width) and (y <= self.y + self.height) and (z == self.z);
end

--- Check if IsoObject is inside this basement
---@param obj IsoObject|IsoPlayer
---@return boolean
function Basement:isObjectInBasement(obj)
    return self:isInBasement(obj:getX(), obj:getY(), obj:getZ());
end

--- Check if coordinate is on the exit tile
---@param x number
---@param y number
---@param z number
---@return boolean
function Basement:isOnExit(x, y, z)
    return math.floor(x) == self.x + self.exitX and math.floor(y) == self.y + self.exitY and math.floor(z) == self.z;
end

--- Check if IsoObject is on the exit tile
---@param obj IsoObject|IsoPlayer
---@return boolean
function Basement:isObjectOnExit(obj)
    return self:isOnExit(obj:getX(), obj:getY(), obj:getZ());
end

---@return string small,medium,large
function Basement:getSize()
    return self.size;
end

---@return number
function Basement:getW()
    return self.width;
end

---@return number
function Basement:getH()
    return self.height;
end

---@return number
function Basement:getX()
    return self.x;
end

---@return number
function Basement:getX()
    return self.x;
end

---@return number
function Basement:getX2()
    return self.x + self.width;
end

---@return number
function Basement:getY()
    return self.y;
end

---@return number
function Basement:getY2()
    return self.y + self.height;
end

---@return number
function Basement:getZ()
    return self.z;
end

-- function Basement:RemoveZombies(radius, coordX, coordY, coordZ)

-- 	if isClient() then
-- 		SendCommandToServer(string.format("/removezombies -x %d -y %d -z %d -radius %d", coordX, coordY, coordZ, radius))
-- 		return
-- 	end

-- 	for x=coordX-radius, coordX + radius do
-- 		for y=coordY-radius, coordY + radius do
-- 			local sq = getCell():getGridSquare(x,y,coordZ);
-- 			if sq then
-- 				for i=sq:getMovingObjects():size(),1,-1 do
-- 					local targets = sq:getMovingObjects():get(i-1);
-- 					if instanceof(targets, "IsoZombie") then
-- 						targets:removeFromWorld();
-- 						targets:removeFromSquare();
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end

--- Create a new basement instance
---@param size string small,medium,large
---@param x number
---@param y number
---@param width number
---@param height number
---@param exitX number
---@param exitY number
function Basement:new(size, x, y, z, width, height, exitX, exitY)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.id = -1; -- will be set by the api
    o.size = size;
    o.x = x;
    o.y = y;
    o.z = z;
    o.width = width;
    o.height = height;
    o.exitX = exitX;
    o.exitY = exitY;
    return o;
end

return Basement;
