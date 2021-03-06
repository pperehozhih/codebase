package = "#{PROJECT_NAME}.#{API_NAME}"
version = "scm-1"
source = {
   url = "" -- Installable with `luarocks make` only
}
description = {
   summary = "#{PROJECT_NAME} website #{API_NAME} api",
   homepage = "http://#{PROJECT_DOMAIN}",
   license = "#{LICENSE}",
   maintainer = "#{MAINTAINER}"
}
dependencies = {
   "lua == 5.1",
   "wsapi-fcgi >= 1.3.4",
   "lua-nucleo >= 0.0.1",
   "lua-aplicado >= 0.0.1",
   "luaposix >= 5.1.2",
   "luasocket >= 2.0.2",
   "luuid >= 20100303-1",
   "sidereal >= 0.0.1",
   "lua-nucleo >= 0.0.1",
   "pk-core >= 0.0.1",
   "pk-engine >= 0.0.1",
   "lbase64 >= 20070628-1",
--[[BLOCK_START:ROCKSPEC_DEPENDENCIES]]
   "#{ROCKSPEC_DEPENDENCIES}",
--[[BLOCK_END:ROCKSPEC_DEPENDENCIES]]
   "luajson >= 1.2.1"
   -- TODO: add engine dependencies!
}
build = {
   type = "none",
   copy_directories = {
      "www/#{API_NAME}/service",
      "www/#{API_NAME}/generated"
   },
   install = {
      lua = {
         ["#{PROJECT_NAME}.#{API_NAME}.run"] = "www/#{API_NAME}/site/run.lua"
      },
      bin = {
         "www/#{API_NAME}/bin/#{PROJECT_NAME}-#{API_NAME}.fcgi"
      }
   }
}
