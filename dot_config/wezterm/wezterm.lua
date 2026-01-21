local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-----------------------------------------------------------------------------------------------------------------------
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-----------------------------------------------------------------------------------------------------------------------
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1500 }
config.keys = {}

-----------------------------------------------------------------------------------------------------------------------
-- appearance
local appearance = require 'appearance'
appearance.apply_to_config(config)

-----------------------------------------------------------------------------------------------------------------------
-- base keys
local base_keys = require 'keys'

for _, key in ipairs(base_keys.keys) do
    table.insert(config.keys, key)
end

-----------------------------------------------------------------------------------------------------------------------
-- smart workspace switcher
local smart_workspace_switcher_plugin = require 'smart-workspace-switcher'

for _, key in ipairs(smart_workspace_switcher_plugin.keys) do
    table.insert(config.keys, key)
end

-----------------------------------------------------------------------------------------------------------------------
-- resurrect
local resurrect_plugin = require 'resurrect'

for _, key in ipairs(resurrect_plugin.keys) do
    table.insert(config.keys, key)
end

-----------------------------------------------------------------------------------------------------------------------
return config
