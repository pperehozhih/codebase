--------------------------------------------------------------------------------
-- request.lua: apigen stub
--------------------------------------------------------------------------------
--
-- WARNING: Run code here inside call()
--
--------------------------------------------------------------------------------

local arguments,
      optional_arguments,
      method_arguments
      = import 'lua-nucleo/args.lua'
      {
        'arguments',
        'optional_arguments',
        'method_arguments'
      }

local fail,
      try
      = import 'pk-core/error.lua'
      {
        'fail',
        'try'
      }

local make_loggers
      = import 'pk-core/log.lua'
      {
        'make_loggers'
      }

--------------------------------------------------------------------------------

local log, dbg, spam, log_error = make_loggers("webservice/request", "WRQ")

--------------------------------------------------------------------------------

local WWW_APPLICATION_CONFIG_SECTION = "#{PROJECT_NAME}"

-- TODO: Move to a more appropriate place?
local get_www_application_config = function(context)
  local config, err = context.config_manager:get_www_application_info(
      WWW_APPLICATION_CONFIG_SECTION
    )
  if not config then
    log_error(
        "failed to get www/application config for", 
        WWW_APPLICATION_CONFIG_SECTION,
        err
      )
    return nil, err
  end
  return config
end

--------------------------------------------------------------------------------

return
{
  WWW_APPLICATION_CONFIG_SECTION = WWW_APPLICATION_CONFIG_SECTION;
  --
  get_www_application_config = get_www_application_config;
}
