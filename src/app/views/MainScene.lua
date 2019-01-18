
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

local ActorMgr = require "app.mgrs.ActorMgr" -- 参演者管理器
local ResMgr = require "app.mgrs.ResMgr" -- 资源加载类

function MainScene:onCreate()

    ResMgr:GetInstance():StartLoadRes(self,function ()
        local iPlayer = ActorMgr:GetInstance():CreateActor("Player",nil,self)
        iPlayer:GetiCompo("Animate"):SetFrame("run",0);
        iPlayer:GetiCompo("Animate"):Play("run");
        iPlayer.iDisplayArea:setPositionX(200)
        iPlayer.iDisplayArea:setPositionY(200)

        Tools:Trace(self,1,"self.classname",table.show(iPlayer.__cname,"iPlayer"))
    end)

end

return MainScene