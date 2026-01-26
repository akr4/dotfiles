local wezterm = require 'wezterm'

local M = {}

M.keys = {
    {
        mods = 'LEADER',
        key = 'p',
        action = wezterm.action.ActivateCommandPalette,
    },
}

return M
