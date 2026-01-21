local wezterm = require 'wezterm'
local M = {}

-----------------------------------------------------------------------------------------------------------------------
-- UI
local function apply_ui_config(config)
    config.initial_cols = 120
    config.initial_rows = 60
    config.window_decorations = 'RESIZE | MACOS_FORCE_ENABLE_SHADOW'
    config.window_background_opacity = 0.97
    config.macos_window_background_blur = 20
    config.show_new_tab_button_in_tab_bar = false
end

-----------------------------------------------------------------------------------------------------------------------
-- テーマ
local color_schemes = {
    'matrix',
    'Lunaria Dark (Gogh)',
    'lovelace',
    'Kasugano (terminal.sexy)',
    'JWR dark (terminal.sexy)',
    'jubi',
    'Ivory Dark (terminal.sexy)',
    'Canvased Pastel (terminal.sexy)',
    'Seafoam Pastel',
}

-- ワークスペースごとの固定color_scheme
local workspace_color_schemes = {
    -- ['workspace-name'] = 'color_scheme_name',
}

-- workspace名から配列のインデックスを生成する
local function get_hash_index(str, array_length)
    local sum = 0
    for i = 1, #str do
        sum = sum + string.byte(str, i)
    end
    return (sum % array_length) + 1
end

local function apply_theme_config(config)
    config.color_scheme = 'Japanesque'
end

-- ワークスペースごとにテーマを変更するイベントハンドラ
wezterm.on('update-status', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local workspace = window:active_workspace()
    local base_path = string.match(workspace, "[^/]+$") or workspace

    -- マップに定義があればそれを使用、なければハッシュでフォールバック
    local color_scheme = workspace_color_schemes[base_path]
    if not color_scheme then
        local index = get_hash_index(workspace, #color_schemes)
        color_scheme = color_schemes[index]
    end

    overrides.color_scheme = color_scheme
    overrides.window_background_opacity = 0.97
    overrides.macos_window_background_blur = 20

    window:set_config_overrides(overrides)

    -- ステータスバー: workspace (緑) + color_scheme (gray)
    window:set_right_status(wezterm.format({
        { Foreground = { Color = "green" } },
        { Text = base_path .. "  " },
        { Foreground = { Color = "gray" } },
        { Text = color_scheme .. "  " },
    }))
end)

-----------------------------------------------------------------------------------------------------------------------
-- フォント
-- /Applications/WezTerm.app/Contents/MacOS/wezterm ls-fonts --list-system
local function apply_font_config(config)
    config.font = wezterm.font_with_fallback({
        { family = '0xProto', weight = 'Regular' },
        { family = 'Hiragino Maru Gothic ProN' },
    })
    -- config.font = wezterm.font('FiraCode Nerd Font Mono', { weight = "Regular" })
    -- config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
    -- config.font = wezterm.font('0xProto')
    config.font_size = 14
    config.line_height = 1.1
end

-----------------------------------------------------------------------------------------------------------------------
-- Inactive pane
local function apply_inactive_pane_config(config)
    config.inactive_pane_hsb = {
        saturation = 0.5,
        brightness = 0.2,
    }
end

-----------------------------------------------------------------------------------------------------------------------
-- タブタイトル
local function get_current_working_dir(tab)
    local current_dir = tab.active_pane.current_working_dir
    local file_path = current_dir and current_dir.file_path or ''
    return current_dir == os.getenv("HOME") and "~" or string.gsub(file_path, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    return get_current_working_dir(tab)
end)

-----------------------------------------------------------------------------------------------------------------------
-- メイン関数: configに全ての設定を適用
function M.apply_to_config(config)
    apply_ui_config(config)
    apply_theme_config(config)
    apply_font_config(config)
    apply_inactive_pane_config(config)
end

return M
