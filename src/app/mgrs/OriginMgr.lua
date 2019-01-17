_G.OriginMgr = {}

OriginMgr.nUniqueID = 0;

function OriginMgr:SetUniqueID() 
    self.nUniqueID = self.nUniqueID + 1; 
    return self.nUniqueID;
end

function OriginMgr:GetUniqueID()
    return self.nUniqueID;
end