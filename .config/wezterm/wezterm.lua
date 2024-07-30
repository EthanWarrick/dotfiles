-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "X::DotShare (terminal.sexy)"
-- config.font = wezterm.font("Hack Nerd Font")
config.font = wezterm.font_with_fallback {
  'Hack',
  'Symbols Nerd Font',
}
config.font_size = 9.0

-- and finally, return the configuration to wezterm
return config
