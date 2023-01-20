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
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
	tab_bar_style = {
		new_tab = wezterm.format({
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = HOVER_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = HOVER_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
		new_tab_hover = wezterm.format({
			{ Attribute = { Italic = false } },
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = NORMAL_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = NORMAL_TAB_BG } },
			{ Foreground = { Color = NORMAL_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = NORMAL_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
	},
}
