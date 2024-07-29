-- Data
Ext.Require("Server/Data/Veils.lua")

-- Scrips
Ext.Require("Server/Scripts/Visuals.lua")
Ext.Require("Server/Scripts/Toggleable.lua")

-- Main
Ext.Require("Server/Main.lua")



local wingUUID = "040338f5-d0b8-4c59-88d0-fe2db0ff5e96"
local wingBoneUUID = "101f3f89-a4e5-4e30-a0ff-7b5df0ccc30b"



function WingTest()
    Osi.RemoveCustomVisualOvirride(Osi.GetHostCharacter(), wingUUID)
    Visuals:removeVisualSetSlot(Osi.GetHostCharacter(), wingBoneUUID)
end
