
-- VARIABLES
--------------------------------------------------------------



-- GETTERS AND SETTERS
--------------------------------------------------------------


-- METHODS
--------------------------------------------------------------


-- LISTENERS
--------------------------------------------------------------



local romanceHasHappened = false
local queued = false

--------------------------------------------------------------------------------------------------------
--                                       Romance/Sex
--------------------------------------------------------------------------------------------------------

-- Saves and removes the Visuals for a romance scene
Ext.Osiris.RegisterListener("QRY_CampNight_TryStartSleepMoment_RomanceNight", 3, "before", function(DIALOGRESOURCE, CHARACTERA, CHARACTERB) 


        -- partner 1
        local currentVisualsA = Visuals:getVisuals(CHARACTERA)
        UserVars:AssignVisuals(CHARACTERA, currentVisualsA)
        Visuals:takeOffVisual(CHARACTERA, GLOBALDEBUG)
        Visuals:removeVisualSetSlot(GLOBALDEBUG, CHARACTERA)

        -- partner 2

        local currentVisualsB = Visuals:getVisuals(CHARACTERB)
        UserVars:AssignVisuals(CHARACTERB, currentVisualsB)
        Visuals:takeOffVisual(CHARACTERB, GLOBALDEBUG)
        Visuals:removeVisualSetSlot(GLOBALDEBUG, CHARACTERB)

        romanceHasHappened = true
end)



-- Triggers when a Romance is over. Reapply Visual
Ext.Osiris.RegisterListener("TeleportedToCamp", 1, "before", function(character)

    if queued then
        return
    end

    queued = true

    if romanceHasHappened then

        local party = Osi.DB_PartyMembers:Get(nil)
        _D(party)
        for i = #party, 1, -1 do
           local character = party[i][1]


            -- if autoVisual passive is activated, toggle it
            if Osi.HasActiveStatus(character, "INSERT_YOUR_TAKE_OFF_STATUS_NAME_HERE") == 0 then

                print("status not active for ", character)

                Osi.TogglePassive(character, "INSERT_YOUR_TAKE_OFF_PASSIVE_NAME_HERE")
                Ext.Timer.WaitFor(300, function ()
                    Osi.TogglePassive(character, "INSERT_YOUR_TAKE_OFF_PASSIVE_NAME_HERE")
                end)
            
            end
        end


        Ext.Timer.WaitFor(15000, function ()
            romanceHasHappened = false
            queued = false
        end)
        

    end

end)



Ext.Osiris.RegisterListener("WentOnStage", 2, "after", function(object, isOnStageNow)  end)


