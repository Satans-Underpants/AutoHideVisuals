UserVars = {}
UserVars.__index = UserVars



-- set the name AutoHideVisuals_Visual to a mod specific name
-- Example: MyCoolMod_Visual
Ext.Vars.RegisterUserVariable("AutoHideVisuals_Visual", {})
Ext.Vars.RegisterUserVariable("AutoHideVisuals_Slot", {})

---@param character string - uuid
---@param visuals table - table of visuals
function UserVars:AssignVisuals(character, visuals)
    local e = Ext.Entity.Get(character)
    e.Vars.AutoHideVisuals_Visual = visuals   -- change  AutoHideVisuals_Visual here to your custom name
end

---@param character string - uuid
function UserVars:GetVisuals(character)
    local e = Ext.Entity.Get(character)
    return e.Vars.AutoHideVisuals_Visual   -- change  AutoHideVisuals_Visual here to your custom name

end




---@param character string - uuid
---@param visuals table - table of visuals
function UserVars:AssignSlot(character, visuals)
    local e = Ext.Entity.Get(character)
    e.Vars.AutoHideVisuals_Slot = visuals   -- change  AutoHideVisuals_Visual here to your custom name
end

---@param character string - uuid
function UserVars:GetSlot(character)
    local e = Ext.Entity.Get(character)
    return e.Vars.AutoHideVisuals_Slot   -- change  AutoHideVisuals_Visual here to your custom name

end


