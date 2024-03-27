--[[
Author: zhuxn zhuxiangning.zxn@bytedance.com
Date: 2024-03-27 15:53:44
LastEditors: zhuxn zhuxiangning.zxn@bytedance.com
LastEditTime: 2024-03-27 17:08:34
FilePath: \GGELUA2\ggelua\SDL\动画.lua
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
--]]
-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-05-06 09:10:13

local SDL = require('SDL')
local IMG = SDL.IMG_Init()
local ggetype = ggetype

local GGE动画 = require('GGE.动画')
local SDL动画 = class('SDL动画', GGE动画)

function SDL动画:SDL动画(obj)
    GGE动画.GGE动画(self)
    local tp = ggetype(obj)
    local info
    if tp == 'string' then
        info = assert(IMG.LoadAnimation(obj), SDL.GetError())
    elseif tp == 'SDL读写' and obj:取对象() then
        info = assert(IMG.LoadAnimation_RW(obj:取对象()), SDL.GetError())
    elseif tp == 'SDL_RWops' then
        info = assert(IMG.LoadAnimation_RW(obj), SDL.GetError())
    end

    if info then
        self.宽度 = info.width
        self.高度 = info.height
        self:置帧率(info.delays[1] / 1000.0)
        for i, v in ipairs(info.frames) do
            self:添加帧(require('SDL.精灵')(v))
        end
    end
end

return SDL动画
