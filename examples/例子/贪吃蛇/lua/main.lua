-- @Author              : GGELUA
-- @Date                : 2021-04-24 10:12:21
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-04-27 02:38:46

local SDL = require('SDL')
引擎 =
    require 'SDL.窗口' {
    标题 = 'GGELUA_贪吃蛇',
    宽度 = 800,
    高度 = 600,
    帧率 = 60
}

function 引擎:初始化()
    精灵 = require 'SDL.精灵'(0, 0, 0, 20, 20):置颜色(255)
    蛇体 = {require 'GGE.坐标'(0, 0)}
    方向 = require 'GGE.坐标'(20, 0)
    虫子 = require 'SDL.精灵'(0, 0, 0, 20, 20):置颜色(0, 255)
    位置 = require 'GGE.坐标'(math.random(0, (引擎.宽度 / 20) - 1) * 20, math.random(0, (引擎.高度 / 20) - 1) * 20)
    t = 0
end

function 引擎:更新事件(dt, x, y)
    t = t + dt
    if t > 0.2 then
        t = 0
        蛇体[#蛇体] = 蛇体[1] + 方向
        table.insert(蛇体, 1, table.remove(蛇体))
        if 蛇体[1] == 位置 then
            table.insert(蛇体, 1, 位置 + 方向)
            位置 = require 'GGE.坐标'(math.random(0, (引擎.宽度 / 20) - 1) * 20, math.random(0, (引擎.高度 / 20) - 1) * 20)
        end
    end
end

function 引擎:渲染事件(dt, x, y)
    if self:渲染开始(0x70, 0x70, 0x70) then
        引擎:置颜色(0, 0, 0, 50)
        for y = 20, 引擎.高度, 20 do
            引擎:画线(0, y, 引擎.宽度, y)
        end
        for x = 20, 引擎.宽度, 20 do
            引擎:画线(x, 0, x, 引擎.高度)
        end
        for i, v in ipairs(蛇体) do
            精灵:显示(v:unpack())
        end
        虫子:显示(位置:unpack())
        self:渲染结束()
    end
end

function 引擎:窗口事件(消息)
    if 消息 == SDL.WINDOWEVENT_CLOSE then
        引擎:关闭()
    end
end

function 引擎:键盘事件(KEY, KMOD, 状态, 按住)
    --print(状态,键码,按住)
    if not 状态 then
        t = 1
        if KEY == SDL.KEY_UP then
            方向 = require 'GGE.坐标'(0, -20)
        elseif KEY == SDL.KEY_DOWN then
            方向 = require 'GGE.坐标'(0, 20)
        elseif KEY == SDL.KEY_LEFT then
            方向 = require 'GGE.坐标'(-20, 0)
        elseif KEY == SDL.KEY_RIGHT then
            方向 = require 'GGE.坐标'(20, 0)
        end
    end
end
