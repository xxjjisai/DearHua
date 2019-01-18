local Manager = require("app.bases.Manager")
local ActorMgr = class("ActorMgr", Manager)

function ActorMgr:ctor() 
    ActorMgr.super.ctor(self);
end

function ActorMgr:CreateActor(sActorType,tbProperty,node) 
    local sActorPath = string.format("app.actors.%s.%s",sActorType,sActorType);
    local sActorCfgPath = string.format("app.actors.%s.%sConfig",sActorType,sActorType);
    local iActor = require(sActorPath).new(node);
    local iCfgActor = require(sActorCfgPath);
    iCfgActor = iActor:FuseiCompoParam(iCfgActor,tbProperty);
    iActor:BindCompo(iCfgActor);
    return iActor;
end

return ActorMgr;