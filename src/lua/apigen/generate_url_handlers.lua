--------------------------------------------------------------------------------
-- generate_url_handlers.lua: api url handlers generator
-- This file is a part of pk-tools library
-- Copyright (c) Alexander Gladysh <ag@logiceditor.com>
-- Copyright (c) Dmitry Potapov <dp@logiceditor.com>
-- See file `COPYRIGHT` for the license
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

local make_concatter
      = import 'lua-nucleo/string.lua'
      {
        'make_concatter'
      }

local make_checker
      = import 'lua-nucleo/checker.lua'
      {
        'make_checker'
      }

local tkeys,
      tijoin_many
      = import 'lua-nucleo/table-utils.lua'
      {
        'tkeys',
        'tijoin_many'
      }

local create_path_to_file,
      write_file
      = import 'lua-aplicado/filesystem.lua'
      {
        'create_path_to_file',
        'write_file'
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

local list_globals_in_handler,
      classify_globals,
      generate_globals_header
      = import 'pk-core/api_globals.lua'
      {
        'list_globals_in_handler',
        'classify_globals',
        'generate_globals_header'
      }

--------------------------------------------------------------------------------

local log, dbg, spam, log_error = make_loggers("generate_url_handlers", "GUH")

--------------------------------------------------------------------------------

local generate_url_handlers
do
  local down = { }
  do
    local extract_handler_source = function(handler_fn, tag)
      arguments(
          "function", handler_fn,
          "string", tag
        )

      local info = debug.getinfo(handler_fn)
      assert(info.what == "Lua")

      local filename = info.source:gsub("^@", "")
      local linefrom = info.linedefined
      local lineto = info.lastlinedefined

      local cat, concat = make_concatter()

      -- TODO: Do proper parsing.
      --       Should support other functions, defined on the same line etc.
      local file = assert(io.open(filename, "r"))
      local lineno = 0
      local indent = nil

      for line in file:lines() do
        lineno = lineno + 1

        -- TODO: Fragile! At least fail if substitutions are unsuccessful!
        if lineno > linefrom and lineno < lineto then
          if indent == nil then
            indent = line:match("^(%s+)") -- Unindent by the first line indentation
            if not indent then
              indent = false
            end
          end

          if indent then
            line = line:gsub("^" .. indent, "  ")
          end

          cat (line) "\n"
        elseif lineno == linefrom then
          cat (line:gsub("^%s*" .. tag .. "%s*%(function%(", "function(")) "\n"
        elseif lineno == lineto then
          cat (line:gsub("^%s*end%)[;]-%s-$", "end")) "\n"
        end

        if lineno > lineto then
          break
        end
      end
      file:close()
      file = nil

      return concat()
    end

    local url_down = function(walkers, data)
      local cat, concat = make_concatter()
      walkers.cat_ = cat
      walkers.concat_ = concat
      walkers.current_url_ = { }

      local log_module_name = "handlers" .. data.filename

      -- First character is slash
      -- TODO: Get that from somewhere!
      local log_short_name = data.filename:sub(2, 4):upper()

      -- TODO: Create loggers on-demand, like all other globals and upvalues

      walkers.cat_ [[
--------------------------------------------------------------------------------
-- ]] (data.filename:gsub("^/", "")) [[: generated url handler
--------------------------------------------------------------------------------
-- WARNING! Do not change manually.
-- Generated by apigen.lua
--------------------------------------------------------------------------------

local log, dbg, spam, log_error
    = import 'pk-core/log.lua' { 'make_loggers' } (
        "]] (log_module_name)
  [[", "]] (log_short_name) [["
      )

]]
    end

    down["api:cacheable_url"] = url_down
    down["api:url"] = url_down
    down["api:url_with_dynamic_output_format"] = url_down
    down["api:raw_url"] = url_down

    -- TODO: Reuse this
    local handler_names =
    {
      ["api:handler"] = "handle_api";
      ["api:session_handler"] = "handle_api_session";
      ["api:client_session_handler"] = "handle_api_session";
      ["api:session_handler_with_events"] = "handle_api_session_with_events";
      ["api:dynamic_output_format_handler"] =
        "handle_api_with_dynamic_output_format";
      ["api:raw_handler"] = "handle_raw";
      ["api:error_handler"] = "error_handler";
      ["api:response_handler"] = "response_handler";
    }

   local down_handler = function(walkers, data)
      local checker = make_checker()
      local tglobals = tkeys(
          list_globals_in_handler(
              checker,
              tostring(data.id)
           .. (data.name and (" '" .. tostring(data.name) .. "'") or ""),
              data.handler
            )
        )
      walkers.api_globals_ = walkers.api_globals_ or { }
      if tglobals then
        walkers.api_globals_ = tijoin_many(walkers.api_globals_, tglobals)
      end
      assert(checker:result())

      local handler_name = handler_names[data.id]
      local handler_text = extract_handler_source(
          data.handler,
          data.id
        )
      if handler_name == "error_handler" then
        walkers.error_handler_text = handler_text
      elseif handler_name == "response_handler" then
        walkers.response_handler_text = handler_text
      else
        walkers.handler_name_ = handler_name
        walkers.handler_text_ = handler_text
      end
    end

    down["api:error_handler"] = down_handler
    down["api:response_handler"] = down_handler
    down["api:handler"] = down_handler
    down["api:session_handler"] = down_handler
    down["api:client_session_handler"] = down_handler
    down["api:session_handler_with_events"] = down_handler
    down["api:dynamic_output_format_handler"] = down_handler
    down["api:raw_handler"] = down_handler

    down["api:static_url"] = function(walkers, data)
      local filename = walkers.out_file_root_
        .. walkers.handlers_dir_name_
        .. data.filename

      log("generating", data.name, "to", filename)

      assert(create_path_to_file(filename))
      assert(
          write_file(
              filename,
              [[
--------------------------------------------------------------------------------
-- ]] .. (data.filename:gsub("^/", "")) .. [[: generated static url handler
--------------------------------------------------------------------------------
-- WARNING! Do not change manually.
-- Generated by apigen.lua
--------------------------------------------------------------------------------

local CONTENT_TYPE = ]] .. (("%q"):format(data.content_type)) .. [[

local BODY = ]] .. (("%q"):format(data.text)) .. [[

--------------------------------------------------------------------------------

return
{
  BODY = BODY;
  CONTENT_TYPE = CONTENT_TYPE;
}
]]
            )
        )
    end
  end

  local up = { }
  do
    -- TODO: Fail instead
    local default_handler_text = [[
function(api_context, param)
  return nil, "NOT_IMPLEMENTED"
end
]]

    local url_up = function(walkers, data)
      local filename = walkers.out_file_root_ .. walkers.handlers_dir_name_ .. data.filename

      log("generating", data.filename, "to", filename)

      assert(create_path_to_file(filename))

      -- TODO: Support upvalues!
      local global_overrides = walkers.global_overrides_ or { }

      -- TODO: Create loggers on demand only!
      global_overrides["log"] = true
      global_overrides["dbg"] = true
      global_overrides["spam"] = true
      global_overrides["log_error"] = true

      -- TODO: Remove. All urls must have handlers defined
      walkers.handler_name_ = walkers.handler_name_ or "handle_api"
      walkers.handler_text_ = walkers.handler_text_ or default_handler_text

      walkers.cat_ [[
]] (
    generate_globals_header(
        classify_globals(
            walkers.known_exports_,
            walkers.allowed_requires_,
            walkers.allowed_globals_,
            walkers.api_globals_ or { },
            global_overrides
          )
      )
  ) [[
local ]] (walkers.handler_name_) [[ = ]] (walkers.handler_text_) [[]]
if walkers.error_handler_text ~= nil then
      walkers.cat_ [[
local error_handler = ]] (walkers.error_handler_text) [[]]
end
if walkers.response_handler_text ~= nil then
      walkers.cat_ [[
local response_handler = ]] (walkers.response_handler_text) [[]]
end
      walkers.cat_ [[

--------------------------------------------------------------------------------

return
{
  ]] (walkers.handler_name_) [[ = ]] (walkers.handler_name_) [[;
  error_handler = ]] (walkers.error_handler_text  and "error_handler" or "false" ) [[;
  response_handler = ]] (walkers.response_handler_text  and "response_handler" or "false" ) [[;
}
]]

      assert(
          write_file(
              filename,
              walkers.concat_()
            )
        )

      walkers.cat_ = nil
      walkers.concat_ = nil
      walkers.current_url_ = nil
      walkers.handler_name_ = nil
      walkers.handler_text_ = nil
      walkers.api_globals_ = nil
      walkers.global_overrides_ = nil

      walkers.error_handler_text = nil
      walkers.response_handler_text = nil
      -- TODO: Implement
    end

    up["api:cacheable_url"] = url_up
    up["api:url"] = url_up
    up["api:url_with_dynamic_output_format"] = url_up
    up["api:raw_url"] = url_up
  end

  generate_url_handlers = function(
      schema,
      out_file_root,
      handlers_dir_name,
      known_exports,
      allowed_requires,
      allowed_globals
    )
    arguments(
        "table", schema,
        "string", out_file_root,
        "string", handlers_dir_name,
        "table", known_exports,
        "table", allowed_requires,
        "table", allowed_globals
      )

    local walkers =
    {
      down = down;
      up = up;
      --
      cat_ = nil;
      current_url_ = nil;
      handler_text_ = nil;
      out_file_root_ = out_file_root;
      handlers_dir_name_ = handlers_dir_name;
      api_globals_ = nil;
      global_overrides_ = nil;
      --
      known_exports_ = known_exports;
      allowed_requires_ = allowed_requires;
      allowed_globals_ = allowed_globals;
    }

    for i = 1, #schema do
      walk_tagged_tree(schema[i], walkers, "id")
    end
  end
end

--------------------------------------------------------------------------------

return
{
  generate_url_handlers = generate_url_handlers;
}
