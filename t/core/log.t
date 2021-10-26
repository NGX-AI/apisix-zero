use t::firmware 'no_plan';

repeat_each(2);

run_tests;

__DATA__
=== TEST 1: utils - core.log error log
--- config
location /t {
	content_by_lua_block {
		local log = require("core.log")
		log.error("error log")
		log.warn("warn log")
		log.notice("notice log")
		log.info("info log")
		ngx.say("done")
	}
}
--- log_level: error
--- request
GET /t
--- error_log
error log
--- no_error_log
warn log
notice log
info log



=== TEST 2: utils - core.log warn log
--- config
    location /t {
        content_by_lua_block {
            local log = require("core.log")
            log.error("error log")
            log.warn("warn log")
            log.notice("notice log")
            log.info("info log")
            log.debug("debug log")
            ngx.say("done")
        }
    }
--- log_level: warn
--- request
GET /t
--- error_log
error log
warn log
--- no_error_log
notice log
info log
debug log



=== TEST 3: notice log
--- config
    location /t {
        content_by_lua_block {
            local log = require("core.log")
            log.error("error log")
            log.warn("warn log")
            log.notice("notice log")
            log.info("info log")
            log.debug("debug log")
            ngx.say("done")
        }
    }
--- log_level: notice
--- request
GET /t
--- error_log
error log
warn log
notice log
--- no_error_log
info log
debug log



=== TEST 4: info log
--- config
    location /t {
        content_by_lua_block {
            local log = require("core.log")
            log.error("error log")
            log.warn("warn log")
            log.notice("notice log")
            log.info("info log")
            log.debug("debug log")
            ngx.say("done")
        }
    }
--- log_level: info
--- request
GET /t
--- error_log
error log
warn log
notice log
info log
--- no_error_log
debug log



=== TEST 5: debug log
--- config
    location /t {
        content_by_lua_block {
            local log = require("core.log")
            log.error("error log")
            log.warn("warn log")
            log.notice("notice log")
            log.info("info log")
            log.debug("debug log")
            ngx.say("done")
        }
    }
--- log_level: debug
--- request
GET /t
--- error_log
error log
warn log
notice log
info log
debug log



=== TEST 6: print error log with prefix
--- config
    location /t {
        content_by_lua_block {
            local log = require("core.log").new("test: ")
            log.error("error log")
            log.warn("warn log")
            log.notice("notice log")
            log.info("info log")
            ngx.say("done")
        }
    }
--- log_level: error
--- request
GET /t
--- error_log
error log
--- no_error_log
test: warn log
test: notice log
test: info log
