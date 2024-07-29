------------------------------------------------------------------------------------------------------------------------------
--
--
--                                         For handling toggleable veils
--
--
---------------------------------------------------------------------------------------------------------------------------


-- CONSTRUCTOR
--------------------------------------------------------------

Toggleable = {}
Toggleable.__index = Toggleable


-- VARIABLES
--------------------------------------------------------------

-- key = Avatar UUID
-- value = veil


PersistentVars = {}

-- returns toggledOffVeils
--@return toggledOffVeils
function Toggleable:getToggledOffVeils()
    return PersistentVars['toggledOffVeils']
end


-- GETTERS AND SETTERS
--------------------------------------------------------------


-- saves the veil the character is wearing if it exists
--@param  uuid string - uuid of the character
--@param  veil string - uuid of the veil
function Toggleable:setToggledOffVeil(uuid, veil)
    if not PersistentVars['toggledOffVeils'] then
        PersistentVars['toggledOffVeils'] = {}
    end

    if veil then
        Toggleable:getToggledOffVeils()[uuid] = veil
    end
end



-- METHODS
--------------------------------------------------------------

---@param character GUIDSTRING     - the character receiving the passive
---@return passive - string         - the passive being added to the character
function Toggleable:addPassive(character, passive)
    if Osi.HasPassive(character, passive) == 0 then
        Osi.AddPassive(character, passive)
    end
end


---@param character GUIDSTRING     - the character who will take off their veil
function Toggleable:takeOffVeil(character)
    local veil = Visuals:getVisual(character)
    print("veil ", veil)
    if veil then
        print("Veil is ", veil)  
        Toggleable:setToggledOffVeil(character, veil)
        Osi.RemoveCustomVisualOvirride(character, veil)
    end
end

---@param character GUIDSTRING     - the character who will put on their veil again
function Toggleable:putOnVeil(character)
    _D(PersistentVars['toggledOffVeils'])
    print(character)
    local veil = Toggleable:getToggledOffVeils()[character]
    if veil then
        Osi.AddCustomVisualOverride(character, veil)
    end
end


-- LISTENERS
--------------------------------------------------------------



-- Adds the "Take off Veil" toggle to each partymember
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Toggleable:addPassive(party[i][1],"TAKE_OFF_VEIL_PASSIVE")
    end

end)

-- Adds the "Take off Veil" toggle to a partymember added during gameplay
Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Toggleable:addPassive(character,"TAKE_OFF_VEIL_PASSIVE")
end)



-- Has the partymember take off their veil if "Take off Veil" is activated
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(character, status, _, _)
    if status == "TAKE_OFF_VEIL_STATUS" then
        print("Take of veil status activated")
		Toggleable:takeOffVeil(character)
        Visuals:removeVisualSetSlot(character, "101f3f89-a4e5-4e30-a0ff-7b5df0ccc30b")
	end
end)


-- Allows the partymember to put on their veil again if "Take off Veil" is deactivated
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (character, status, _, _)
	if status == "TAKE_OFF_VEIL_STATUS" then
		Toggleable:putOnVeil(character)
	end
end)



-- This function was only possible thanks to Trips research
-- Triggers when Magic Mirror is spoken to

Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "before", function(character, itemTemplate, _, _)
    if (itemTemplate == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91") then
        Osi.RemoveStatus(character, "TAKE_OFF_VEIL_STATUS")
    end
end)

