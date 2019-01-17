
-- 设置选项
require 'app.settings.Option'

-- 第三方类库
require "socket"
require "app.libs.Common"
require "app.libs.Tools"
require "app.libs.Utils"

-- 全局配置
require "app.configs.ResConfig"

-- 全局管理器
require "app.mgrs.ActorMgr" -- 参演者管理器
require "app.mgrs.OriginMgr" -- 唯一ID管理器
require "app.mgrs.ResMgr" -- 资源加载类