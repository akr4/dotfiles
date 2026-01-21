local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local M = {}

workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"


M.keys = {
  {
    key = "w",
    mods = "LEADER",
    action = workspace_switcher.switch_workspace(),
  },
  {
    key = "b",
    mods = "LEADER",
    action = workspace_switcher.switch_to_prev_workspace(),
  }
}

return M
