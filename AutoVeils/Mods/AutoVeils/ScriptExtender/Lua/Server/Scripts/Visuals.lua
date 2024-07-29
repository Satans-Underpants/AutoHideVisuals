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


-- VARIABLES
--------------------------------------------------------------

-- key = Avatar UUID
-- value = visual
local savedVisuals = {}


-- GETTERS AND SETTERS
--------------------------------------------------------------


-- returns savedVisuals
--@return savedVisuals table
function Visuals:getSavedVisuals()
    return savedVisuals
end


-- iterates over all CCAVs and finds the Visuals
-- assumes that a character can only wear one visual at a time
--@param  uuid string - uuid of the character possibly wearing a visual
--@return uuid string - uuid of the visual, else nil
function Visuals:getVisual(uuid)
    local characterVisuals =  Ext.Entity.Get(uuid):GetAllComponents().CharacterCreationAppearance.Visuals
    
    for _,visual in pairs(characterVisuals) do
        print(visual)
        if CHARACTER_CREATION_VISUALS[visual] then
            return visual
        end
    end

    return nil
end


-- saves the visual the character is wearing if it exists
--@param  uuid string - uuid of the character
--@param  visual string - uuid of the visual
function Visuals:setVisual(uuid, visual)
    if visual then
        savedVisuals[uuid] = visual
    end
end



-- METHODS
--------------------------------------------------------------


local wingUUID = "040338f5-d0b8-4c59-88d0-fe2db0ff5e96"
local wingBoneUUID = "101f3f89-a4e5-4e30-a0ff-7b5df0ccc30b"



-- TODO - modify this so it removes all uuids from  VISUAL_SET_SLOT 
-- instead of taking a uuid

---@param character string - uuid of the character
---@param uuid string - uuid to remove
function Visuals:removeVisualSetSlot(character, uuid)

    local entity = Ext.Entity.Get(character)
    local resource = entity.ServerCharacter.Template.CharacterVisualResourceID
    local slots = Ext.Resource.Get(resource, "CharacterVisual").VisualSet.Slots

    local index = 0

    for i, entry in pairs(slots) do
        print(entry.VisualResource)
        if entry.VisualResource == uuid then
            print("match found")
            entry.VisualResource = ""
            index = i
        end
    end

    entity:Replicate("GameObjectVisual")

    Ext.Timer.WaitFor(100, function()
        if index > 0 then
            Ext.Resource.Get(resource, "CharacterVisual").VisualSet.Slots[index].VisualResource = uuid
        end
    end)

end


-- LISTENERS
--------------------------------------------------------------

