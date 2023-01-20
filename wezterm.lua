local wezterm = require 'wezterm';
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
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
  tab_bar_style = {
    active_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    active_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
    inactive_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    inactive_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
  },
}
