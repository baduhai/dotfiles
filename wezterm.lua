local wezterm = require 'wezterm';
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
local TAB_BAR_BG = "#1d2021"
local ACTIVE_TAB_BG = "#fe8019"
local ACTIVE_TAB_FG = "Black"
local NORMAL_TAB_BG = "#7c6f64"
local NORMAL_TAB_FG = "Black"
local HOVER_TAB_BG = "#fabd2f"
local HOVER_TAB_FG = "Black"
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)
return {
  font_size = 11,
  color_scheme = 'Atelier Cave (base16)',
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font_with_fallback ({
    "Hack Nerd Font",
    "Noto Color Emoji",
  }),
  initial_cols = 108,
  initial_rows = 32,
  enable_tab_bar = false,
}
