
local Entity = class("Entity")

Entity.nUniqueID = 0;

function Entity:ctor()
    self:SetUniqueID();
end

function Entity:SetUniqueID()
    self.nUniqueID = self.nUniqueID + 1; 
    return self.nUniqueID;
end

function Entity:GetUniqueID()
    return self.nUniqueID;
end

function Entity:ResetUniqueID()
    self.nUniqueID = 0;
end

return Entity