
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()

    local size = cc.Director:getInstance():getWinSize();
    local spriteFrameCache = cc.SpriteFrameCache:getInstance();
    spriteFrameCache:addSpriteFrames("res/tex.plist")

    local iPlayer = ActorMgr:CreateActor("Player",nil,self)
    iPlayer:GetiCompo("Animate"):SetFrame("run",0);
    iPlayer:GetiCompo("Animate"):Play("run");
    
    iPlayer.iDisplayArea:setPositionX(200)
    iPlayer.iDisplayArea:setPositionY(200)
end

return MainScene

    -- add background image
    -- display.newSprite("HelloWorld.png")
    --     :move(display.center)
    --     :addTo(self)

    -- add HelloWorld label
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx, display.cy + 200)
    --     :addTo(self)