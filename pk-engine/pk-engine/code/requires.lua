--------------------------------------------------------------------------------
-- require.lua: information on 3rd party Lua modules
--------------------------------------------------------------------------------

-- Map of global symbol name to module name where it is defined
local REQUIRE_GLOBALS =
{
  copas = "copas";
  posix = "posix";
  socket = "socket";
  xavante = "xavante";
  luabins = "luabins";
  wsapi = "wsapi";
  md5 = "md5";
  luasql = "luasql";
  uuid = "uuid";
  lfs = "lfs";
  base64 = "base64";
}

--------------------------------------------------------------------------------

return
{
  REQUIRE_GLOBALS = REQUIRE_GLOBALS;
}