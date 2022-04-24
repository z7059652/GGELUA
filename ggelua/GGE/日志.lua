-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-04-14 07:25:26

local cprint = require('cprint')
local _isdebug = require('ggelua').isdebug
local lcolor = {
    INFO = '\x1b[47;30mINFO\x1b[0m',
    WARN = '\x1b[43;30mWARN\x1b[0m',
    ERROR = '\x1b[41;30mERROR\x1b[0m'
}

local GGE日志 = class('GGE日志')

function GGE日志:GGE日志(file, logger)
    self._logger = logger or 'GGELUA'
    self._DB = require('LIB.SQLITE3')(file or 'log.db3')

    local r = self._DB:取值("select count(*) from sqlite_master where name='log';")
    if r == 0 then
        self._DB:执行 [[
            CREATE TABLE "log" (
                "date" integer NOT NULL,
                "logger" TEXT,
                "level" integer NOT NULL,
                "message" TEXT NOT NULL,
                "exception" TEXT
              );
        ]]
    end
end

function GGE日志:LOG(level, msg, ...)
    if select('#', ...) > 0 then
        msg = msg:format(...)
    end
    local time = os.time()
    cprint(string.format('[%s] [%s] [%s] %s', os.date('%X', time), self._logger, lcolor[level] or level, tostring(msg)))
    local r = self._DB:执行("insert into log(date,logger,level,message) values('%d','%s','%s','%s')", time, self._logger, level, msg)
end

function GGE日志:INFO(msg, ...)
    self:LOG('INFO', msg, ...)
end

function GGE日志:WARN(msg, ...)
    self:LOG('WARN', msg, ...)
end

function GGE日志:ERROR(msg, ...)
    self:LOG('ERROR', msg, ...)
end

function GGE日志:DEBUG(msg, ...)
    if _isdebug then
        self:LOG('DEBUG', msg, ...)
    end
end
return GGE日志
