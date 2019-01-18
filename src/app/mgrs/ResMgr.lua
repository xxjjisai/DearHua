local Manager = require("app.bases.Manager")
local ResMgr = class("ResMgr", Manager)

function ResMgr:ctor() 
    ResMgr.super.ctor(self);
end

function ResMgr:StartLoadRes(node,pfn)
    -- self.loadingBar = cc.LoadingBar:create("HelloWorld.png");
    -- self.loadingBar:setPercent(0);
    -- node:addChild(self.loadingBar);

    self.pfn = pfn;
    self:updateLoadRes();
end

function ResMgr:updateLoadRes()
    self.nLoadResNum = 0;

    local nUpdateTimes = 0;
    local nNowLoadNums = 0;
    local function UpdateLoad(dt) 
        nUpdateTimes = nUpdateTimes + 1;
        if nUpdateTimes > 20 and nUpdateTimes % 3 == 0 then -- 延迟20帧，并且每3帧加载下一个资源
            nNowLoadNums = nNowLoadNums + 1;
            display.loadImage(ResConfig[nNowLoadNums]..".png", handler(self, self.loadResCallBack))
            if #ResConfig <= nNowLoadNums then 
                print("--> stop update load res...")
                self:closeSchedule(self.scheduleListener)
            end
        end 
    end
    self.scheduleListener = cc.Director:getInstance():getScheduler():scheduleScriptFunc(UpdateLoad , 0 , false)
end

function ResMgr:closeSchedule(scheduleTag)
    if scheduleTag ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scheduleTag)
        scheduleTag = nil
    end
end

function ResMgr:loadResCallBack(texture2d)
    self.nLoadResNum = self.nLoadResNum + 1;
    local plistName = ResConfig[self.nLoadResNum]..".plist"
    -- 加载plist文件
    local spriteFrameCache = cc.SpriteFrameCache:getInstance();
    spriteFrameCache:addSpriteFrames(plistName)
    print(" -- > load res callback plist : " , plistName , self.nLoadResNum)
    local nNowPercent = math.min(100,100 * (self.nLoadResNum/#ResConfig))
    -- self.loadingBar:setPercent(nNowPercent);
    print(string.format( "---->>>> %d/100",nNowPercent ));
    if self.nLoadResNum >= #ResConfig then  
        print("资源全部加载完成！~");
        if self.pfn then 
            self.pfn();
        end 
    end 
end

return ResMgr;