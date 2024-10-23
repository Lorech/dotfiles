-- Adds the ability to jump to characters across the buffer with a single keypress
return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
  },
  init = function()
    local hop = require 'hop'
    local directions = require('hop.hint').HintDirection

    -- Utility function for auto-generating keymaps related to Hop
    local map = function(keys, func, desc, opts)
      local options = Merge({ desc = 'Hop: ' .. desc }, opts or {})
      vim.keymap.set('', keys, func, options)
    end

    -- Replace built-in f/F/t/T with hop actions for single characters
    map('f', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
    end, 'forward to character', { remap = true })
    map('F', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, 'backward to character', { remap = true })
    map('t', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, 'forward until character', { remap = true })
    map('T', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, 'backward until character', { remap = true })
  end,
}
