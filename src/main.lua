
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "app.settings.Include"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
