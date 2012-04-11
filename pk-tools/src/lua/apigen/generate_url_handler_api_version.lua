--------------------------------------------------------------------------------
-- generate_url_handlers_api_version.lua: api url client_api_version generator
-- This file is a part of pk-tools library
-- Copyright (c) Alexander Gladysh <ag@logiceditor.com>
-- Copyright (c) Dmitry Potapov <dp@logiceditor.com>
-- See file `COPYRIGHT` for the license
--------------------------------------------------------------------------------

local arguments,
      optional_arguments,
      method_arguments,
      eat_true
      = import 'lua-nucleo/args.lua'
      {
        'arguments',
        'optional_arguments',
        'method_arguments',
        'eat_true'
      }

local make_concatter
      = import 'lua-nucleo/string.lua'
      {
        'make_concatter'
      }

local walk_tagged_tree
      = import 'pk-core/tagged-tree.lua'
      {
        'walk_tagged_tree'
      }

local make_loggers
      = import 'pk-core/log.lua'
      {
        'make_loggers'
      }

--------------------------------------------------------------------------------

local log, dbg, spam, log_error = make_loggers(
    "generate_url_handler_api_version", "GUA"
  )

--------------------------------------------------------------------------------

local generate_url_handler_api_version
do
  generate_url_handler_api_version = function(schema, file_header)
    arguments(
        "table", schema,
        "string", file_header
      )
    return [[
--------------------------------------------------------------------------------
-- client_api_version.lua: generated client api version file
]] .. file_header .. [[
--------------------------------------------------------------------------------
-- WARNING! Do not change manually.
--          Generated by apigen.lua
--------------------------------------------------------------------------------

local CLIENT_API_VERSION = ]] .. (("%q"):format(schema.version)) .. [[


--------------------------------------------------------------------------------

return
{
  CLIENT_API_VERSION = CLIENT_API_VERSION;
}
]]
  end
end

--------------------------------------------------------------------------------

return
{
  generate_url_handler_api_version = generate_url_handler_api_version;
}
