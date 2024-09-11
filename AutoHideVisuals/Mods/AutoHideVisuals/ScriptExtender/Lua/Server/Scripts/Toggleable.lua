------------------------------------------------------------------------------------------------------------------------------
--
--
--                                         For handling toggleable Visuals
--
--
---------------------------------------------------------------------------------------------------------------------------


-- CONSTRUCTOR
--------------------------------------------------------------

Toggleable = {}
Toggleable.__index = Toggleable




-- LISTENERS
--------------------------------------------------------------


-- Has the partymember take off their Visual if "Take off Visual" is activated
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(character, status, _, _)
    if status == "INSERT_YOUR_TAKE_OFF_STATUS_NAME_HERE" then
        SatanPrint(GLOBALDEBUG, "Take of Visual status activated")
        -- CCAV
		Visuals:takeOffVisual(character)
        -- CharacterVisualResource
        Visuals:removeVisualSetSlot(GLOBALDEBUG, character)
	end
end)


-- Allows the partymember to put on their Visual again if "Take off Visual" is deactivated
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (character, status, _, _)
	if status == "INSERT_YOUR_TAKE_OFF_STATUS_NAME_HERE" then
        -- CCAV
		Visuals:putOnVisual(character)
        -- CharacterVisualResource
        Visuals:addVisualSetSlot(GLOBALDEBUG, character)
	end
end)



-- This function was only possible thanks to Trips research
-- Triggers when Magic Mirror is spoken to

-- Deactivates passive, else magic mirror bugs out
Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "before", function(character, itemTemplate, _, _)
    if (itemTemplate == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91") then

        if Osi.HasPassive(character, "INSERT_YOUR_TAKE_OFF_STATUS_NAME_HERE") then
            Osi.TogglePassive(character, "INSERT_YOUR_TAKE_OFF_PASSIVE_NAME_HERE")
        end
    end
end)

