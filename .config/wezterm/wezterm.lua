---@type Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font_with_fallback({
	"Hack",
	"Symbols Nerd Font",
})
config.font_size = 9.0
config.bold_brightens_ansi_colors = "No"  -- Artifically brighten all colors
config.force_reverse_video_cursor = true  -- Make sure cursor color is inverted text color
config.audible_bell = "Disabled"          -- Disable bell sound

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#6272a4',
      fg_color = '#f8f8f2',
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
  },
}

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

local act = wezterm.action
-- config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = " ", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Backspace", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER", action = act.ActivateLastTab },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }) },
	{ key = "h", mods = "CTRL", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "CTRL", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "CTRL", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "CTRL", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "LeftArrow", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "RightArrow", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "/", mods = "LEADER", action = act({ Search = { CaseSensitiveString = "" } }) },
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			initial_value = "My Tab Name",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- and allow activating one.
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
  {
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then -- If prompt response isn't empty
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Rename workspace:' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then -- If prompt response isn't empty
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
	},

	{ key = "F11", action = act.ToggleFullScreen },
}

for i = 1, 9 do
	-- LEADER + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- Connect via `wezterm connect unix` while on the same host
-- Connect via `wezterm connect SSHMUX:<~/.ssh/config host>` while on a remote host
config.unix_domains = {
  {
    name = 'unix',
  },
}
-- config.default_gui_startup_args = { 'connect', 'unix' }

return config
