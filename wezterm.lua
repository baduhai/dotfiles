local wezterm = require 'wezterm';
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)
return {
  font_size = 11,
  color_scheme = 'Catppuccin Mocha',
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font_with_fallback ({
    "Hack Nerd Font",
    "Noto Color Emoji",
  }),
  initial_cols = 108,
  initial_rows = 32,
  enable_tab_bar = false,
  enable_scroll_bar = true,
}
