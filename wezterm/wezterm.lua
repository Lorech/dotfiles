local appearance = require 'appearance'
local keymaps = require 'keymaps'

local config = {}
appearance.apply_to_config(config)
keymaps.apply_to_config(config)
return config
