-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-23 10:09:27
-- @Last Modified time  : 2022-04-27 02:27:08

local SDL = require('SDL')
引擎 =
    require 'SDL.窗口' {
    标题 = '大航海时代-世界地图',
    宽度 = 800,
    高度 = 600,
    帧率 = 30,
    可调整 = true
}

function 引擎:初始化()
    spr = require('SDL.精灵')('assets/171122.png')
    xy = require('GGE.坐标')(0, 0)
end

function 引擎:更新事件(dt, x, y)
end

function 引擎:渲染事件(dt, x, y)
    if self:渲染开始(0, 0, 0) then
        for x = xy.x - spr.宽度, self.宽度, spr.宽度 do
            spr:显示(x, xy.y)
        end

        self:渲染结束()
    end
end

function 引擎:窗口事件(消息)
    if 消息 == SDL.WINDOWEVENT_CLOSE then
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

function 引擎:鼠标事件(消息, x, y, b)
    if 消息 == SDL.MOUSE_MOTION and b & SDL.BUTTON_LMASK ~= 0 then
        xy = 当前位置 + (require('GGE.坐标')(x, y) - 按下位置)
        if xy.x > 0 then
            xy.x = xy.x % spr.宽度
        else
            xy.x = xy.x % -spr.宽度
        end
    elseif 消息 == SDL.MOUSE_DOWN then
        当前位置 = xy
        按下位置 = require('GGE.坐标')(x, y)
    elseif 消息 == SDL.MOUSE_UP then
        if xy.y > 0 then
            xy.y = 0
        elseif math.abs(xy.y) > spr.高度 - self.高度 then
            xy.y = -(spr.高度 - self.高度)
        end
    end
end

function 引擎:输入事件()
end

function 引擎:销毁事件()
end
