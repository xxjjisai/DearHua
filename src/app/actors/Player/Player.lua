local Actor = require("app.bases.Actor")
local Player = class("Player", Actor)

function Player:ctor(node)
    Player.super.ctor(self,node);
end

return Player;