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
-- value = veil
local savedVeils = {}


-- GETTERS AND SETTERS
--------------------------------------------------------------


-- returns savedVeils
--@return savedVeils table
function Visuals:getSavedVeils()
    return savedVeils
end


-- iterates over all CCAVs and finds the veils
-- assumes that a character can only wear one veil at a time
--@param  uuid string - uuid of the character possibly wearing a veil
--@return uuid string - uuid of the veil, else nil
function Visuals:getVeil(uuid)
    local characterVisuals =  Ext.Entity.Get(uuid):GetAllComponents().CharacterCreationAppearance.Visuals
    for _,visual in pairs(characterVisuals) do
        if VEILS[visual] then
            return visual
        end
    end

    return nil
end


-- saves the veil the character is wearing if it exists
--@param  uuid string - uuid of the character
--@param  veil string - uuid of the veil
function Visuals:setVeil(uuid, veil)
    if veil then
        savedVeils[uuid] = veil
    end
end



-- METHODS
--------------------------------------------------------------



-- LISTENERS
--------------------------------------------------------------

