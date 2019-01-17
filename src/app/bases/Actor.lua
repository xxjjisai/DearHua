local Entity = require("app.bases.Entity")
local Actor = class("Actor",Entity)

function Actor:ctor(iNode)
    Actor.super.ctor(self);
    self.iDisplayArea = cc.Sprite:create();
    self.iNode = iNode;
    self.iNode:addChild(self.iDisplayArea);
end

function Actor:RegisterUpdate()
    if self.Update then 
        self.nUpdateFuncID = cc.Director:getInstance():getscheduler():scheduleScriptFunc(function ()
            self:Update();
        end,0,false)
    end 
end

function Actor:Dectory() 
    if self.Update then 
        cc.Director:getInstance():getscheduler():unscheduleScriptEntry(self.nUpdateFuncID);
    end
    self.iNode:removeChild(self.iDisplayArea);
    self.iDisplayArea = nil;
end

function Actor:SetPos(x,y) 
    local posx,posy = Grid2Pos(x, y)
    self.iDisplayArea:setPositionX(posx)
    self.iDisplayArea:setPositionY(posy)
end

function Actor:TransferParamsToActor()
    if not next(self.tbiCompoList) then
        return;
    end
    for k,d in pairs(self.tbiCompoList) do
        self[k] = d
    end
end

-------------------------------------------------

function Actor:AddiCompo(sClassName,tbParams)
    self.tbiCompoList = self.tbiCompoList or {};
    local iCompo = require(string.format( "app.compos.%s",sClassName )).new(tbParams);
    self.tbiCompoList[sClassName] = iCompo;
    -- self:TransferParamsToActor();
end

function Actor:GetiCompo(sClassName)
    return self.tbiCompoList[sClassName];
end

function Actor:BindCompo(cfg,node) 
    local cfg = cfg;
    for sClassName,tbParams in pairs(cfg) do
        tbParams.actor = self;
        self:AddiCompo(sClassName,tbParams);
    end    
end 

function Actor:Clear()
    if next(self.tbiCompoList) then
        self.tbiCompoList = {};
    end
end

function Actor:ChangeiCompoParam(tbProperty)
    local tbProperty = tbProperty or {};
    if next(tbProperty) then 
        for sComp,tbPro in pairs(tbProperty) do
            if not self:GetiCompo(sComp) then 
                self:AddiCompo(sComp,tbPro)
            end 
            for k,v in pairs(tbPro) do
                self:GetiCompo(sComp)[k] = v;
            end  
        end
    end
end

function Actor:FuseiCompoParam(cfg,tbProperty)
    local tmpCfg = {};
    for sComp,tbPro in pairs(cfg) do
        tmpCfg[sComp] = {};
        for k,v in pairs(tbPro) do
            tmpCfg[sComp][k] = v;
        end  
    end
    tbProperty = tbProperty or {};
    if next(tbProperty) then 
        for sComp,tbPro in pairs(tbProperty) do
            for k,v in pairs(tbPro) do
                tmpCfg[sComp][k] = v;
            end  
        end 
    end
    return tmpCfg
end

return Actor