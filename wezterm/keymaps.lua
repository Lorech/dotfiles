local wezterm = require 'wezterm'

local keymaps = {}

function keymaps.apply_to_config(config)
  config.leader = { key = 'a', mods = 'CTRL' }
  config.keys = {
    -- Splits
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action {
        SplitHorizontal = {
          domain = 'CurrentPaneDomain',
        },
      },
    },
    {
      key = '_',
      mods = 'LEADER|SHIFT',
      action = wezterm.action {
        SplitVertical = {
          domain = 'CurrentPaneDomain',
        },
      },
    },
    -- Navigation
  }
end

return keymaps
