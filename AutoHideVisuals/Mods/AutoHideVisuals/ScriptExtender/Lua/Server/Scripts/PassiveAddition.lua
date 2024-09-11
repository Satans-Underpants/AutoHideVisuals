-- LISTENERS
--------------------------------------------------------------


-- Adds the "Take off Visual" toggle to each partymember
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(_, _)
    local party = Osi.DB_PartyMembers:Get(nil)
    for i = #party, 1, -1 do
        Osi.AddPassive(party[i][1],"INSERT_YOUR_TAKE_OFF_PASSIVE_NAME_HERE")
    end

end)

-- Adds the "Take off Visual" toggle to a partymember added during gameplay
Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Osi.AddPassive(character,"INSERT_YOUR_TAKE_OFF_PASSIVE_NAME_HERE")
end)
