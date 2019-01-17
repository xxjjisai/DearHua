
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()

    ResMgr:StartLoadRes(self,function ()
        local iPlayer = ActorMgr:CreateActor("Player",nil,self)
        iPlayer:GetiCompo("Animate"):SetFrame("run",0);
        iPlayer:GetiCompo("Animate"):Play("run");
        iPlayer.iDisplayArea:setPositionX(200)
        iPlayer.iDisplayArea:setPositionY(200)

        Tools:Trace(self,1,"self.classname",table.show(iPlayer.__cname,"iPlayer"))
    end)



end

return MainScene