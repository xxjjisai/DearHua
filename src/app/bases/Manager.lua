local Entity = require("app.bases.Entity")
local Manager = class("ActorMgr", Entity)

Manager.instance = nil;

function Manager:ctor() 
    Manager.super.ctor(self);
end

function Manager:GetInstance()
    if not self.instance then 
        self.instance = self.new();
    end 
    return self.instance;
end

return Manager