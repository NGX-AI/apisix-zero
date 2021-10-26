-- load comment libs
local require   = require

-- local function
local ngx          = ngx
local ngx_log      = ngx.log
local setmetatable = setmetatable
local tostring     = tostring
local unpack       = unpack

-- module define
local _M = {
    _VERSION = 0.1
}


local log_levels = {
    stderr = ngx.STDERR,
    emerg  = ngx.EMERG,
    alert  = ngx.ALERT,
    crit   = ngx.CRIT,
    error  = ngx.ERR,
    warn   = ngx.WARN,
    notice = ngx.NOTICE,
    info   = ngx.INFO,
    debug  = ngx.DEBUG,
}

local func_do_nothing = function() end
local cur_level = ngx.config.subsystem == "http" and
                  require("ngx.errlog").get_sys_filter_level()


-- create an new log instance with custom log prefix
function _M.new(log_prefix)
    local m = { _VERSION = _M._VERSION }
    setmetatable(m, {__index = function(self, cmd)
        local log_level = log_levels[cmd]

        local method
        if cur_level and (log_level > cur_level)
        then
            method = func_do_nothing
        else
            method = function(...)
                return ngx_log(log_level, log_prefix, ...)
            end
        end

        -- cache the lazily generated method in our module table
        m[cmd] = method
        return method
    end})

    return m
end


--
setmetatable(_M, {__index = function(self, cmd)
    local log_level = log_levels[cmd]

    local method
    if cur_level and (log_level > cur_level) then
        method = func_do_nothing
    else
        method = function(...)
            return ngx_log(log_level, ...)
        end
    end

    -- cache the lazily generated method in our module table
    _M[cmd] = method
    return method
end})


return _M
