--------------------------------------------------------------------------------
-- handlers.lua: generated information on url handlers
--------------------------------------------------------------------------------
-- WARNING! Do not change manually.
-- Generated by apigen.lua
--------------------------------------------------------------------------------

local common_html_error,
      common_xml_error,
      common_json_error,
      common_luabins_error,
      html_response,
      xml_response,
      json_response,
      luabins_response
      = import 'pk-engine/webservice/response.lua'
      {
        'common_html_error',
        'common_xml_error',
        'common_json_error',
        'common_luabins_error',
        'html_response',
        'xml_response',
        'json_response',
        'luabins_response'
      }

local make_xml_schema_builder
      = import 'pk-engine/xml_schema_builder.lua'
      {
        'make_xml_schema_builder'
      }

local make_json_schema_builder
      = import 'pk-engine/json_schema_builder.lua'
      {
        'make_json_schema_builder'
      }

local make_luabins_schema_builder
      = import 'pk-engine/luabins_schema_builder.lua'
      {
        'make_luabins_schema_builder'
      }

local make_url_handler_wrapper
      = import 'pk-engine/webservice/client_api/url_handler_wrapper.lua'
      {
        'make_url_handler_wrapper'
      }

--------------------------------------------------------------------------------

local FORMATS,
      make_output_format_manager
      = import 'formats.lua'
      {
        'FORMATS',
        'make_output_format_manager'
      }

local TABLES = import '#{PROJECT_NAME}/db/tables.lua' ()

local get_www_game_config,
      get_www_admin_config
      = import '#{PROJECT_NAME}/webservice/request.lua'
      {
        'get_www_game_config',
        'get_www_admin_config'
      }

--------------------------------------------------------------------------------

local INTERNAL_CALL_HANDLERS = { }

local url = make_url_handler_wrapper(
    TABLES,
    get_www_game_config,
    get_www_admin_config,
    make_output_format_manager(),
    INTERNAL_CALL_HANDLERS
  )

--------------------------------------------------------------------------------

local HANDLERS = { }

-- TODO: UBERHACK! Assuming INTERNAL_CALL_HANDLERS is defined
--       in project_specific_data.HEADER.
--local INTERNAL_CALL_HANDLERS = { }
assert(INTERNAL_CALL_HANDLERS)

--------------------------------------------------------------------------------

HANDLERS["/api/"] = url:static("handlers/index.lua")
INTERNAL_CALL_HANDLERS["/"] = function()
  error("Internal calls for static URLs are not supported")
end
HANDLERS["/api/index"] = url:static("handlers/index.lua")
INTERNAL_CALL_HANDLERS["/index"] = function()
  error("Internal calls for static URLs are not supported")
end

--------------------------------------------------------------------------------

-- TODO: Hack. Export only handler_fns themselves
--       (along with urls and formats metadata).
return
{
  HANDLERS = HANDLERS;
  INTERNAL_CALL_HANDLERS = INTERNAL_CALL_HANDLERS;
  URL_HANDLER_WRAPPER = url; -- TODO: Hack? Export getter instead?
}
