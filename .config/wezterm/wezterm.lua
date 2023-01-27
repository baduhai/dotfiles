local wezterm = require 'wezterm';



local function compute_scheme()
  local time = tonumber(os.date("%H"))
  local just_dark = false
  if time >= 18 or time < 7 or just_dark then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end



return {
  font_size = 11,
  color_scheme = compute_scheme(),
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
