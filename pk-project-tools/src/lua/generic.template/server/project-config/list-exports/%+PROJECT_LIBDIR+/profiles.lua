--------------------------------------------------------------------------------
-- lua-aplicado.lua: lua-aplicado exports profile
#{FILE_HEADER}
--------------------------------------------------------------------------------

local tset = import 'lua-nucleo/table-utils.lua' { 'tset' }

--------------------------------------------------------------------------------

local PROFILE = { }

--------------------------------------------------------------------------------

PROFILE.skip = setmetatable(tset { }, {
})

--------------------------------------------------------------------------------

return PROFILE
