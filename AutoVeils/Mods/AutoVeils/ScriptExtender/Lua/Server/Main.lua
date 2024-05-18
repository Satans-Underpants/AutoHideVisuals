
-- VARIABLES
--------------------------------------------------------------



-- GETTERS AND SETTERS
--------------------------------------------------------------


-- METHODS
--------------------------------------------------------------


-- LISTENERS
--------------------------------------------------------------



--------------------------------------------------------------------------------------------------------
--                                       Romance/Sex
--------------------------------------------------------------------------------------------------------

-- Saves and removes the Veils for a romance scene
Ext.Osiris.RegisterListener("QRY_CampNight_TryStartSleepMoment_RomanceNight", 3, "before", function(DIALOGRESOURCE, CHARACTERA, CHARACTERB) 


        -- partner 1
        local currentVeilA = Visuals:getVeil(CHARACTERA)
        Visuals:setVeil(CHARACTERA, currentVeilA)
        local veil = Visuals:getSavedVeils()[CHARACTERA]
        if currentVeilA then
            Osi.RemoveCustomVisualOvirride(CHARACTERA, currentVeilA)
        end

        -- partner 2

        local currentVeilB = Visuals:getVeil(CHARACTERB)
        Visuals:setVeil(CHARACTERB, currentVeilB)
        local veil = Visuals:getSavedVeils()[CHARACTERB]
        if currentVeilB then
            Osi.RemoveCustomVisualOvirride(CHARACTERB, currentVeilB)
        end
end)



-- Triggers when a Romance is over. Reapply Veil
Ext.Osiris.RegisterListener("TeleportedToCamp", 1, "before", function(character)

    veils = Visuals:getSavedVeils()

    for character,veil in pairs(veils) do
        Osi.AddCustomVisualOverride(character, veil)
    end
end)

