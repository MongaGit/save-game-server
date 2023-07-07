--- @filename TATalkingISChat.lua

local old_ISChat_focus = ISChat.focus
local old_ISChat_unfocus = ISChat.unfocus
local old_ISChat_onGearButtonClick = ISChat.onGearButtonClick

ISChat.talking_collection = {
    "BobTA_Nodding",
    "BobTA_Talking_1",
    "BobTA_Talking_2",
    "BobTA_Talking_3",
    "BobTA_Talking_4",
    "BobTA_Talking_5",
}

function ISChat:focus()
    if not getPlayer():getVariableBoolean("EmotePlaying") then
        if not self.animSelected then
            self.animSelected = 2
        end

        emote = nil
        if self.animSelected == 2 then
            if ZombRand(100) < 5 then
                getPlayer():playEmote("BobTA_Standing_Arguing_1")
            else
                emote = self.talking_collection[ZombRand(#self.talking_collection)+1]
            end
        elseif self.animSelected == 3 then
           emote = "BobTA_Nodding"
        elseif self.animSelected == 4 then
           emote = "BobTA_Talking_1"
        elseif self.animSelected == 5 then
           emote = "BobTA_Talking_2"
        elseif self.animSelected == 6 then
           emote = "BobTA_Talking_3"
        elseif self.animSelected == 7 then
           emote = "BobTA_Talking_4"
        elseif self.animSelected == 8 then
           emote = "BobTA_Talking_5"
        elseif self.animSelected == 9 then
           emote = "BobTA_Standing_Arguing_1"
        elseif self.animSelected == 10 then
           emote = "BobTA_Standing_Arguing_2"
        elseif self.animSelected == 11 then
           emote = "BobTA_Yelling"
        end
        if emote and not self.emotePlay then
            getPlayer():playEmote(emote)
            self.emotePlay = true

            if getPlayer():getPrimaryHandItem() and not (string.sub(getPlayer():getPrimaryHandItem():getType(),1,string.len("WalkieTalkie")) == "WalkieTalkie") then
                self.primaryHandItem = getPlayer():getPrimaryHandItem()
                getPlayer():setPrimaryHandItem(nil)
            end
            if getPlayer():getSecondaryHandItem() and not (string.sub(getPlayer():getSecondaryHandItem():getType(),1,string.len("WalkieTalkie")) == "WalkieTalkie") then
                self.secondaryHandItem = getPlayer():getSecondaryHandItem()
                getPlayer():setSecondaryHandItem(nil)
            end
        end
    end
    old_ISChat_focus(self)
end

function ISChat:unfocus()
    if self.emotePlay then
        if self.primaryHandItem then getPlayer():setPrimaryHandItem(self.primaryHandItem) end
        if self.secondaryHandItem then getPlayer():setSecondaryHandItem(self.secondaryHandItem) end
        self.primaryHandItem = nil
        self.secondaryHandItem = nil
        getPlayer():playEmote("")
        getPlayer():setVariable("EmotePlaying", false) -- print(getPlayer():getVariableBoolean("EmotePlaying"))
        self.emotePlay = false
    end
    old_ISChat_unfocus(self)
end


function ISChat:onGearButtonClick()
    old_ISChat_onGearButtonClick(self)
    local context = getPlayerContextMenu(0);
    local opaqueOnFocusOption = context:addOption(getText("UI_chat_set_animations"), ISChat.instance);
    local opaqueOnFocusSubMenu = context:getNew(context);
    context:addSubMenu(opaqueOnFocusOption, opaqueOnFocusSubMenu);
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_disable"), ISChat.instance, ISChat.changeAnimationType, 1)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_random"), ISChat.instance, ISChat.changeAnimationType, 2)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_nodding"), ISChat.instance, ISChat.changeAnimationType, 3)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_talking_1"), ISChat.instance, ISChat.changeAnimationType, 4)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_talking_2"), ISChat.instance, ISChat.changeAnimationType, 5)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_talking_3"), ISChat.instance, ISChat.changeAnimationType, 6)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_talking_4"), ISChat.instance, ISChat.changeAnimationType, 7)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_talking_5"), ISChat.instance, ISChat.changeAnimationType, 8)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_arguing_1"), ISChat.instance, ISChat.changeAnimationType, 9)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_arguing_2"), ISChat.instance, ISChat.changeAnimationType, 10)
    opaqueOnFocusSubMenu:addOption(getText("UI_chat_context_anim_yelling"), ISChat.instance, ISChat.changeAnimationType, 11)
    if not self.animSelected then
        self.animSelected = 2
    end
    opaqueOnFocusSubMenu:setOptionChecked(opaqueOnFocusSubMenu.options[self.animSelected], true)
end

function ISChat:changeAnimationType(animTypeNum)
    self.animSelected = animTypeNum
end