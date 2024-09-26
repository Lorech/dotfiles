-- Various small, custom, and independent plugins for editing utilities
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects for parens, brackets, quotes, etc.
    require('mini.ai').setup { n_lines = 500 }

    -- Make surrounding and removing/editing text surroundings easier
    require('mini.surround').setup()

    -- Simple and easy statusline.
    local statusline = require 'mini.statusline'
    -- Enable Nerd Font icons if Vim is configured to have one
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Change cursor location to COL:ROW in the status line
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
