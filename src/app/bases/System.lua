local Entity = require("app.bases.Entity")
local System = class("System",Entity)

function System:ctor(node)
    System.super.ctor(self);
end 

return System