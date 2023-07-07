local self = {}

self.getEquippedClothes = function(inventory)
    local newList = {}
    local itemList = inventory:getItems()

    for i = 0, itemList:size() - 1 do
        if itemList:get(i):IsClothing() and itemList:get(i):isEquipped() then
            newList[tostring(itemList:get(i):getFullType())] = itemList:get(i)
        end
    end

    return newList
end

self.setVisualClothing = function(inventory, item, itemReference)
    local itemListEquipped = self.getEquippedClothes(inventory)

    if itemListEquipped[item] then
        local clothing = itemListEquipped[item]
        local itemVisual = clothing:getVisual()

        itemVisual:setItemType(itemReference)
    end        
end

self.replaceVisualClothing = function(source, item, itemReference, bodyLocations, itemList)
    local scriptItem = getScriptManager():getItem(item)
    if not scriptItem then return end
    local itemBodyLocation = scriptItem:getBodyLocation()
    local inventory = source:getInventory()
    local found = false

    if source:getWornItem(itemBodyLocation) ~= nil then
        local currentItemType = source:getWornItem(itemBodyLocation):getVisual():getItemType()

        for k, v in pairs(bodyLocations) do
            if source:getWornItem(v) ~= nil then
                for i in pairs(itemList) do
                    if source:getWornItem(v):getFullType() == itemList[i] then
                        found = true

                        if currentItemType == item then
                            self.setVisualClothing(inventory, item, itemReference)
                        end

                        break
                    end
                end
                if found then break end
            end
        end

        if not found then
            if currentItemType == itemReference then
                self.setVisualClothing(inventory, item, item)
            end
        end
    end
end

return self