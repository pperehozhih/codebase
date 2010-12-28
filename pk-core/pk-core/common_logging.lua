--------------------------------------------------------------------------------
-- common_logging: common logging facilities
--------------------------------------------------------------------------------

local twithdefaults
      = import 'lua-nucleo/table-utils.lua'
      {
        'twithdefaults'
      }

local LOG_LEVEL,
      wrap_file_sink,
      make_common_logging_config
      = import 'lua-nucleo/log.lua'
      {
        'LOG_LEVEL',
        'wrap_file_sink',
        'make_common_logging_config'
      }

local create_common_logging_system,
      get_current_logsystem_date_microsecond
      = import 'pk-core/log.lua'
      {
        'create_common_logging_system',
        'get_current_logsystem_date_microsecond'
      }

--------------------------------------------------------------------------------

local create_common_stdout_logging
do
  local LOG_LEVEL_CONFIG =
  {
    [LOG_LEVEL.ERROR] = true;
    [LOG_LEVEL.LOG]   = true;
    [LOG_LEVEL.DEBUG] = false;
    [LOG_LEVEL.SPAM]  = false;
  }

  local LOG_MODULE_CONFIG =
  {
    -- Empty; everything is enabled by default.
  }

  local LOGGING_SYSTEM_ID = ""

  create_common_stdout_logging = function(
      log_level_config,
      log_module_config,
      logging_system_id,
      pipe
    )
    log_level_config = log_level_config
      and twithdefaults(log_level_config, LOG_LEVEL_CONFIG)
       or LOG_LEVEL_CONFIG

    log_module_config = log_module_config
      and twithdefaults(log_module_config, LOG_MODULE_CONFIG)
       or LOG_MODULE_CONFIG

    logging_system_id = logging_system_id or LOGGING_SYSTEM_ID

    pipe = pipe or io.stdout

    create_common_logging_system(
        logging_system_id,
        wrap_file_sink(pipe),
        make_common_logging_config(
            log_level_config,
            log_module_config
          ),
        get_current_logsystem_date_microsecond
      )
  end
end

return
{
  create_common_stdout_logging = create_common_stdout_logging;
}