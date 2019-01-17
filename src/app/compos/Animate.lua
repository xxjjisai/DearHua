local Compo = require("app.bases.Compo")
local Animate = class("Animate", Compo)

function Animate:ctor(tbParams) 
    Animate.super.ctor(self,tbParams);
    self.tbAnimte = {};
    self:DefineAnimate();
end

function Animate:DefineAnimate()
    local def = 
    {
        nCurrentFrame = 0;
        bRunning = false;
        nFrameCount = self.nFrameCount;
        sSpname = self.sSpname;
        sActionName = self.sActionName;
        bOnce = self.bOnce;
        nInterval = self.nInterval;
        fAdvanceFrame = function (defself)
            defself.nCurrentFrame = defself.nCurrentFrame + 1;
            if defself.nCurrentFrame >= defself.nFrameCount then 
                defself.nCurrentFrame = 0;
                return false;
            end
            return true;
        end,
    }
    if self.sActionName == nil then 
        self.tbAnimte[self.sSpname] = def;
    else
        self.tbAnimte[self.sActionName] = def;
    end
end

function Animate:SetFrame(sActionName,nIndex)
    local def = self.tbAnimte[sActionName];
    if def == nil then 
        return 
    end 
    self:setSpriteFrame(def,nIndex);
end

function Animate:setSpriteFrame(def,nIndex)
    if self.iDisplayArea == nil then 
        return ;
    end 
    local spriteFrameCache = cc.SpriteFrameCache:getInstance();
    local final = nil;
    if def.sActionName ~= nil then 
        final = string.format("%s_%s%d.png",def.sSpname,def.sActionName,nIndex)
    else
        final = string.format("%s%d.png",def.sSpname,nIndex)
    end  
    local nFrame = spriteFrameCache:getSpriteFrame( final )
    if nFrame == nil then 
        print("sprite frame not found!~~~~~")
        return 
    end
    self.iDisplayArea:setSpriteFrame(nFrame);
end

function Animate:Play(sActionName,callback)
    local def = self.tbAnimte[sActionName];
    if def == nil then 
        return  
    end
    if def.nShid == nil then 
        def.nShid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function ()
            if def.bRunning then 
                if def:fAdvanceFrame() then 
                    self:setSpriteFrame(def,def.nCurrentFrame)
                elseif def.bOnce then 
                    def.bRunning = false;
                    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(def.nShid)
                    def.nShid = nil;
                    if callback ~= nil then 
                        callback()
                    end  
                end 
            end  
        end,def.nInterval,false)
    end  
    def.bRunning = true;
end

function Animate:Stop(sActionName)
    local def = self.tbAnimte[sActionName];
    if def == nil then 
        return  
    end
    def.bRunning = false;
end


function Animate:Destory() 
    for _,def in pairs(self.tbAnimte) do
        if def.nShid then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(def.nShid)
        end 
    end 
    self.iDisplayArea = nil;
end 

return Animate;