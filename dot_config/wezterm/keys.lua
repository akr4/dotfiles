local wezterm = require 'wezterm'
local mux = wezterm.mux 
local act = wezterm.action

local M = {}

-----------------------------------------------------------------------------------------------------------------------
-- 前回のWorkspaceに戻る

-- ラッパー: 指定した workspace に切り替えつつ「前の workspace」を保存
local function switch_workspace(name)
  return wezterm.action_callback(function(window, pane)
    local current = window:active_workspace()
    if current == name then
      return
    end

    wezterm.GLOBAL.previous_workspace = current

    window:perform_action(
      act.SwitchToWorkspace { name = name },
      pane
    )
  end)
end

-- 前回の workspace に戻る
local function switch_to_previous_workspace(window, pane)
  local current = window:active_workspace()
  local prev = wezterm.GLOBAL.previous_workspace

  if not prev or prev == current then
    return
  end

  wezterm.GLOBAL.previous_workspace = current

  window:perform_action(
    act.SwitchToWorkspace { name = prev },
    pane
  )
end
 
local function workspace_selector()
  return wezterm.action_callback(function(window, pane)
    local names = mux.get_workspace_names()
    local choices = {}

    for _, name in ipairs(names) do
      table.insert(choices, { id = name, label = name })
    end

    window:perform_action(
      act.InputSelector {
        title = 'Select workspace',
        fuzzy = true,
        choices = choices,
        action = wezterm.action_callback(function(win, _, id, _)
          if not id then
            return
          end
          -- 切り替える直前の workspace を保存
          wezterm.GLOBAL.previous_workspace = win:active_workspace()
          window:perform_action(
            act.SwitchToWorkspace { name = id },
            pane
          )
        end),
      },
      pane
    )
  end)
end
 
------------------------------------------------------------------------------------------------------------------------
-- 同名のワークスペースがあればそこへ移動、なければ作成する
local function create_or_switch_workspace(workspace_name, window, pane)
  local current = mux.get_active_workspace()
  local existing = mux.get_workspace_names()

  -- すでに存在する場合は単に切り替え
  for _, name in ipairs(existing) do
    if name == workspace_name then
      if current ~= workspace_name then
        wezterm.GLOBAL.previous_workspace = current
        mux.set_active_workspace(workspace_name)
      end
      return
    end
  end

  -- なければ新規作成
  local cwd = wezterm.home_dir
  if pane then
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri and cwd_uri.file_path then
      cwd = cwd_uri.file_path
    end
  end

  local first_tab, _, new_window = mux.spawn_window({
    workspace = workspace_name,
    cwd = cwd,
  })

  -- 作成後に previous_workspace を更新して新しい workspace をアクティブに
  wezterm.GLOBAL.previous_workspace = current
  window:perform_action(
    wezterm.action.SwitchToWorkspace({
      name = workspace_name,
      spawn = { cwd = cwd },
    }),
    pane
  )
end


M.keys = {
--    {
--        mods = 'LEADER',
--        key = 'w',
--        --action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES|TABS|KEY_ASSIGNMENTS', title = "Select workspace" },
--        --action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', title = "Select workspace" },
--        action = workspace_selector(),
--    },
    {
        -- Rename workspace
        mods = 'LEADER',
        key = '$',
        action = act.PromptInputLine {
            description = '(wezterm) Set workspace title:',
            action = wezterm.action_callback(function(win, pane, line)
                if line then
                    wezterm.mux.rename_workspace(
                        wezterm.mux.get_active_workspace(),
                        line
                    )
                end
            end),
        },
    },
    {
        mods = "LEADER",
        key = "n",
        action = act.PromptInputLine {
          description = "(wezterm) New or existing workspace name:",
          action = wezterm.action_callback(function(window, pane, line)
            if line and #line > 0 then
              create_or_switch_workspace(line, window, pane)
            end
          end),
        },
    },
    
    -- 前の workspace に戻る
--    {
--        mods = 'LEADER',
--        key = 'b',
--        action = wezterm.action_callback(switch_to_previous_workspace),
--    },
    {
        mods = 'CTRL|SHIFT',
        key = 'P',
        action = wezterm.action.ActivateCommandPalette,
    },
    -- Pane --------------------------------------------------------
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        mods = "LEADER",
        key = "z",
        action = wezterm.action.TogglePaneZoomState,
    },
}

return M
