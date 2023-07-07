local Functions = require "Dislaik'sClothingPack/Functions"

ISInventoryMenuElements = ISInventoryMenuElements or {};

ISInventoryMenuElements.DislaiksClothingPackContext = function()
    local self = ISMenuElement.new()
    self.inventoryMenu = ISContextManager.getInstance().getInventoryMenu()

    self.createMenu = function(item)
        local source = getPlayer()

        if instanceof(item, "InventoryContainer") and item:canBeEquipped() == "UpperLegs" and not source:isEquippedClothing(item) then
            self.inventoryMenu.context:addOption(getText("ContextMenu_Equip"), item, self.equipContainer, source);
        end
    end

    self.equipContainer = function(item, source)
        ISTimedActionQueue.add(ISWearClothing:new(source, item, 50))
    end

    return self
end

local onClothingUpdated = function(source)

    Functions.replaceVisualClothing(source, "Dislaik.LowerLegs_KneePads", "Dislaik.LowerLegs_KneePadsALTER",
    { "Pants" },
    {   
        "Base.Trousers_WhiteTINT", "Base.Trousers", "Base.Guillie_Trousers", "Base.Trousers_Padded",
        "Base.Trousers_PoliceGrey", "Base.Trousers_Fireman", "Base.Trousers_PrisonGuard", "Base.Trousers_Chef",
        "Base.Trousers_Ranger", "Base.Trousers_Scrubs", "Base.Trousers_Police", "Base.Trousers_Suit",
        "Base.Trousers_SuitWhite", "Base.Trousers_JeanBaggy", "Base.Trousers_ArmyService", "Base.Trousers_CamoGreen",
        "Base.Trousers_CamoDesert", "Base.Trousers_CamoUrban", "Base.Trousers_Black", "Base.TrousersMesh_DenimLight",
        "Base.Trousers_NavyBlue", "Base.Trousers_Denim", "Base.Shorts_CamoUrbanLong", "Dislaik.Trousers_SWAT"
    })

    Functions.replaceVisualClothing(source, "Dislaik.LowerArms_ElbowPads", "Dislaik.LowerArms_ElbowPadsALTER",
    { "SweaterHat", "Sweater", "Jacket", "BathRobe", "Dress", "FullSuitHead", "FullSuit" },
    {   
        "Base.Jacket_CoatArmy", "Base.JacketLong_Doctor", "Base.Jacket_NavyBlue", "Base.Jacket_WhiteTINT",
        "Base.Jacket_Padded", "Base.Jacket_PaddedDOWN", "Base.JacketLong_Santa", "Base.Jacket_Police",
        "Base.WeddingJacket", "Base.Jacket_Fireman", "Base.Jacket_Shellsuit_Black", "Base.Jacket_Shellsuit_Blue",
        "Base.Jacket_Shellsuit_Green", "Base.Jacket_Shellsuit_Pink", "Base.Jacket_Shellsuit_Teal",
        "Base.Jacket_Shellsuit_TINT", "Base.Jacket_Chef", "Base.JacketLong_Random", "Base.Jacket_Ranger",
        "Base.Jacket_ArmyCamoDesert", "Base.Jacket_ArmyCamoGreen", "Base.Jacket_Varsity", "Base.JacketLong_SantaGreen",
        "Base.Ghillie_Top", "Base.Suit_Jacket", "Base.Suit_JacketTINT",  "Base.HoodieUP_WhiteTINT",
        "Base.Jumper_DiamondPatternTINT", "Base.Jumper_PoloNeck", "Base.Jumper_VNeck", "Base.Jumper_RoundNeck",
        "Base.HoodieDOWN_WhiteTINT", "Base.LongCoat_Bathrobe", "Base.HospitalGown", "Base.HazmatSuit",
        "Base.SpiffoSuit", "Base.Boilersuit", "Base.Boilersuit_BlueRed", "Base.Boilersuit_Yellow",
        "Base.Boilersuit_Flying", "Base.Boilersuit_Prisoner", "Base.Boilersuit_PrisonerKhaki", "Dislaik.Jacket_SWAT"
    })

    Functions.replaceVisualClothing(source, "Dislaik.Trousers_SWAT", "Dislaik.Trousers_SWATALTER",
    { "Shoes" },
    {   
        "Base.Shoes_BlackBoots", "Base.Shoes_Wellies", "Base.Shoes_RidingBoots", "Base.Shoes_ArmyBoots",
        "Base.Shoes_ArmyBootsDesert"
    })
end

Events.OnClothingUpdated.Add(onClothingUpdated)