--[[
Author: zhuxn zhuxiangning.zxn@bytedance.com
Date: 2024-03-27 15:53:44
LastEditors: zhuxn zhuxiangning.zxn@bytedance.com
LastEditTime: 2024-03-27 16:55:37
FilePath: \GGELUA2\lua\main.lua
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
--]]
-- @Author       : GGELUA
-- @Date         : 2021-12-05 22:35:55
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2022-01-23 06:10:51

local SDL = require('SDL')
local SDLF = require('SDL.函数')
local GGEF = require('GGE.函数')

引擎 =
    require 'SDL.窗口' {
    标题 = 'GGELUA ver:' .. gge.version,
    宽度 = 1280,
    高度 = 720,
    帧率 = 30,
    可调整 = true
}

function 引擎:初始化()
    if gge.getplatform()=='Android' then
        print(SDLF.取内部存储路径())
        print(SDLF.取外部存储路径())
    end

    res = require('GGE.资源')()
    res:添加路径('assets')
    jpg = res:取精灵('test.jpg')
    bmp = res:取精灵('test.bmp')
    png = res:取精灵('test.png')
    print("jpg",jpg)
    print("bmp",bmp)
    print("png",png)
    print("Hello")

    mp3 = res:取音乐('test.mp3'):播放(true)
    print(mp3)
    sdl = res:取精灵('SDL.png'):置透明(10)
    webp1 = res:取精灵('1.webp'):置过滤(1)
    webp2 = require("SDL.精灵")('assets/2.webp')
end

local 度数 = 0
function 引擎:更新事件(dt, x, y)
    度数 = 度数 + dt * 5
    if 度数 > 359 then
        度数 = 0
    end
    webp1:置旋转(度数, 310, 316)
end

function 引擎:渲染事件(dt, x, y)
    if self:渲染开始(255, 255, 255, 255) then
        sdl:显示(0, 0)
        webp1:显示(引擎.宽度2 - 300, 引擎.高度2 - 300)
        webp2:显示(引擎.宽度2 - 300, 引擎.高度2 - 300)
        self:渲染结束()
    end
end

function 引擎:窗口事件(msg)
    if msg == SDL.WINDOWEVENT_CLOSE then
        引擎:关闭()
    end
end
