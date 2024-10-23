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
    end, 'Jump forward to character', { remap = true })
    map('F', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, 'Jump backward to character', { remap = true })
    map('t', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, 'Jump forward until character', { remap = true })
    map('T', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, 'Jump backward until character', { remap = true })

    -- Add custom keymaps for Hop
    map('<leader>jf', function()
      hop.hint_char2 { direction = directions.AFTER_CURSOR, current_line_only = true }
    end, 'Jump forward to character pair')
    map('<leader>jF', function()
      hop.hint_char2 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, 'Jump backward to character pair')
    map('<leader>jt', function()
      hop.hint_char2 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, 'Jump forward until character pair')
    map('<leader>jT', function()
      hop.hint_char2 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, 'Jump backward until character pair')
    map('<leader>jl', function()
      hop.hint_lines {}
    end, 'Jump to Line')
    map('<leader>jL', function()
      hop.hint_lines_skip_whitespace {}
    end, 'Jump to Line start')
    map('<leader>jv', function()
      hop.hint_vertical {}
    end, 'Jump Vertically')
    map('<leader>j/', function()
      hop.hint_patterns {}
    end, 'Jump to pattern')
    map('<leader>jw', function()
      hop.hint_words {}
    end, 'Jump to Word')
  end,
}
