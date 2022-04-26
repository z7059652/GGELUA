-- @Author              : GGELUA
-- @Date                : 2021-04-08 08:00:20
-- @Last Modified by    : GGELUA
-- @Last Modified time  : 2022-04-27 02:32:36
-- 声明：例子仅供学习交流

local GGEF = require('GGE.函数')
local SDL = require('SDL')
引擎 =
    require 'SDL.窗口' {
    标题 = '圆形地图框',
    宽度 = 800,
    高度 = 600,
    帧率 = 30,
}

function 引擎:初始化()
    渲染区 = require('SDL.纹理')(111, 111)
    渲染精灵 = 渲染区:到精灵()
    小地图 = require('SDL.精灵')('assets/镇魔谷.jpg')

    if 1 == 2 then --两种方式
        精灵 = require('SDL.精灵')('assets/B.png')
        抠图 = SDL.ComposeCustomBlendMode(1, 2, 1, 2, 1, 1)
        精灵:置混合(抠图)
    else
        精灵 = require('SDL.精灵')('assets/A.png')
        抠图 = SDL.ComposeCustomBlendMode(1, 2, 3, 2, 2, 3)
        精灵:置混合(抠图)
    end

    print(抠图)
end

function 引擎:更新事件(dt, x, y)
    if 渲染区:渲染开始() then
        小地图:显示(0, 0)
        精灵:显示(0, 0)
        渲染区:渲染结束()
    end
end

function 引擎:渲染事件(dt, x, y)
    if self:渲染开始(0x70, 0x70, 0x70) then
        渲染精灵:显示(50, 50)
        self:渲染结束()
    end
end

function 引擎:窗口事件(ev)
    if ev == SDL.WINDOWEVENT_CLOSE then
        引擎:关闭()
    end
end

function 引擎:键盘事件(KEY, KMOD, 状态, 按住)
    if not 状态 then --弹起
        if KEY == SDL.KEY_F1 then
            print('F1')
        end
    end
    if KMOD & SDL.KMOD_LCTRL ~= 0 then
        print('左CTRL', 按住)
    end
    if KMOD & SDL.KMOD_ALT ~= 0 then
        print('左右ALT', 按住)
    end
end

function 引擎:鼠标事件(key, x, y, btn, ...)
end

function 引擎:输入事件()
end

function 引擎:销毁事件()
end
