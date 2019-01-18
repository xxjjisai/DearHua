local Manager = require("app.bases.Manager")
local GameMgr = class("GameMgr", Manager)

function GameMgr:ctor() 
    GameMgr.super.ctor(self);
end

return GameMgr;