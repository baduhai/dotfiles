local wezterm = require 'wezterm';

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Macchiato"
  end
end

return {
  font_size = 11,
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
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
