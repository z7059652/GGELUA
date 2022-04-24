-- @Author              : GGELUA
-- @Date                : 2022-04-14 06:55:04
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-04-14 08:04:48

local _list = setmetatable({}, {__mode = 'v'})
local 日志 = require('GGE.日志')
local 服务 = class('服务', 日志)

function 服务:服务(name)
    _list[self] = self
    self._timer = {}
    self._tick = {}
    self:GGE日志(name .. '.db3', name)
end

function 服务:定时(ms, fun)
    if type(fun) == 'function' then
        table.insert(self._timer, {ms = ms, time = os.clock() * 1000 + ms, fun = fun})
        return
    end
    local co, main = coroutine.running()
    if not main then
        self._tick[co] = os.clock() * 1000
        coroutine.yield()
        self._tick[co] = nil
        return true
    end
end

function 服务:_UPDATE()
    if self.更新 then
        ggexpcall(self.更新, self)
    end
    if next(self._tick) then --协程定时
        local oc = os.clock() * 1000
        for co, t in pairs(self._tick) do
            if oc >= t then
                coroutine.xpcall(co)
            end
        end
    end
    if next(self._timer) then --函数定时
        local oc = os.clock() * 1000
        for i, t in ipairs(self._timer) do
            if oc >= t.time then
                t.ms = ggexpcall(t.fun, t.ms)
                if t.ms == 0 or type(t.ms) ~= 'number' then
                    table.remove(self._timer, i)
                    break
                else
                    t.time = t.ms + oc
                end
            end
        end
    end
end

local delay = gge.delay
function main()
    while true do
        for _, v in pairs(_list) do
            v:_UPDATE()
        end
        delay(10)
    end
end
return 服务
