local Entity = require("app.bases.Entity")
local Compo = class("Compo", Entity)

function Compo:ctor(tbParams) 
    Compo.super.ctor(self);
    self.tbParams = tbParams;
    self.iDisplayArea = self:GetActor().iDisplayArea;
    self:TransferParamsToActor();
end

function Compo:GetActor()
    return self.tbParams.actor;
end

function Compo:TransferParamsToActor()
    if not next(self.tbParams) then
        return;
    end
    for k,d in pairs(self.tbParams) do
        self[k] = d
    end
end

return Compo;