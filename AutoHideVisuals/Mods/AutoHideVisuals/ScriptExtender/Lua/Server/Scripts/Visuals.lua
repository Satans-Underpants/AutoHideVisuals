------------------------------------------------------------------------------------------------------------------------------
--
--
--                                         For handling visuals
--
--
---------------------------------------------------------------------------------------------------------------------------


-- CONSTRUCTOR
--------------------------------------------------------------

Visuals = {}
Visuals.__index = Visuals



-- GETTERS AND SETTERS
--------------------------------------------------------------


-- iterates over all CCAVs and finds the Visuals
--@param  uuid string - uuid of the character possibly wearing a visual
--@return uuid string - uuid of the visual, else nil
function Visuals:getVisuals(uuid, debug)

    local listOfVisuals = {}
    local characterVisuals =  Ext.Entity.Get(uuid):GetAllComponents().CharacterCreationAppearance.Visuals
    
    for _,visual in pairs(characterVisuals) do
        SatanPrint(debug,visual)
        if CHARACTER_CREATION_VISUALS[visual] then
            table.insert(listOfVisuals, visual)
        end
    end

    return listOfVisuals
end


-- returns the VisualSet.Slots
--@param  uuid string - uuid of the character possibly wearing a visual
--@return uuid string - uuid of the visual, else nil
function Visuals:getSlots(debug, character)

    SatanPrint(debug,  "Getting slots for ".. character)

    local entity = Ext.Entity.Get(character)
    local resource = entity.ServerCharacter.Template.CharacterVisualResourceID
    local slots = Ext.Resource.Get(resource, "CharacterVisual").VisualSet.Slots
    return slots
    
end


-- METHODS
--------------------------------------------------------------


---@param character string     - the character who will take off their Visual
function Visuals:takeOffVisual(character, debug)
    local visuals = Visuals:getVisuals(character)
    for _, visual in pairs(visuals) do
        SatanPrint(debug,"Visual is ".. visual)
        UserVars:AssignVisuals(character, {visual})
        Osi.RemoveCustomVisualOvirride(character, visual)
    end
end


---@param character string     - the character who will put on their Visual again
function Visuals:putOnVisual(character)
    local visuals = UserVars:GetVisuals(character)
    for _, visual in pairs(visuals) do
        Osi.AddCustomVisualOverride(character, visual)
    end

    UserVars:AssignVisuals(character, nil)
end
---



---@param character string - uuid of the character
---@param uuid string - uuid to remove
function Visuals:removeVisualSetSlot(debug, character)

    local slots = Visuals:getSlots(debug, character)
    local entity = Ext.Entity.Get(character)
    local removed = {}

    for i, entry in pairs(slots) do
        SatanPrint(debug, entry.VisualResource)

        if VISUAL_SET_SLOT[entry.VisualResource] then 
            SatanPrint(debug, "match found")
            entry.VisualResource = ""
            
            table.insert(removed, {uuid = entry.VisualResource, index = i})
        end
    end

    UserVars:AssignSlot(character,removed)
    entity:Replicate("GameObjectVisual")
end



---@param character string - uuid of the character
---@param uuid string - uuid to remove
function Visuals:addVisualSetSlot(debug, character)

    SatanPrint(debug, "Add VisualSetSlot for " .. character)

    local slots = Visuals:getSlots(debug,character)
    local entity = Ext.Entity.Get(character)
    local removed = UserVars:GetSlot(character)

    for i, entry in pairs(slots) do
        SatanPrint(debug, entry.VisualResource)

        for _, removedEntry in pairs(removed) do

            if i == removedEntry.index  then 
                SatanPrint(debug, "match found")
                entry.VisualResource = removedEntry.uuid
            end
        end
    end

    UserVars:AssignSlot(character, nil)
    entity:Replicate("GameObjectVisual")

end


