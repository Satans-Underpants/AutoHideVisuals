


-- Makes sure visuals appears/disappear correclty over saving/loading the same, or multiple games

Ext.Events.GameStateChanged:Subscribe(function(e)

     -- ------------------  Loaded - also  on level swap------------------------------ --


    if e.FromState == "Sync" and e.ToState == "Running" then


        local party = Osi.DB_PartyMembers:Get(nil)
        for i = #party, 1, -1 do
           local uuid = party[i][1]

           local visuals = UserVars:GetVisuals(uuid)
           local slots = UserVars:GetSlot(uuid)

            if visuals then
                Visuals:takeOffVisual(uuid, GLOBALDEBUG)
            end

            if slots then
                Visuals:removeVisualSetSlot(GLOBALDEBUG, uuid)
            end

        end
     
    end


end)


-- Norbyte said they reset on LoadModule



-- TODO - Passive procs when going to Camp


-- TODO - on reload they reappear when toggled off 