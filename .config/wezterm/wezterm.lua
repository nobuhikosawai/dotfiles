-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "Catppuccin Mocha"
-- config.window_background_opacity = 0.85

config.font = wezterm.font_with_fallback { {
  family = 'JetBrainsMono Nerd Font',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' },
}, 'Ubuntu Mono' }
config.font_size = 10.5
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

config.use_ime = true
config.xim_im_name = 'fcitx'
config.ime_preedit_rendering = 'System'

config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
