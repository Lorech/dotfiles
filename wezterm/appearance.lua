local wezterm = require 'wezterm'

local appearance = {}

function appearance.apply_to_config(config)
  -- Window
  config.enable_tab_bar = false

  -- Text
  config.font = wezterm.font 'CaskaydiaMono Nerd Font'
  config.font_size = 16

  -- Colors
  config.color_scheme = 'rose-pine-moon'
end

return appearance
