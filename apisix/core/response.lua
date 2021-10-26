-- load comment libs
local require   = require

local json_encode = require("cjson.safe").encode

-- local function
local ngx          = ngx
local ngx_arg      = ngx.arg
local ngx_header   = ngx.header
local ngx_log      = ngx.log
local ngx_exit     = ngx.exit
local ngx_print    = ngx.print

-- module define
local _M = {
    _VERSION = 0.1
}

function _M.say(...)

end

return _M
