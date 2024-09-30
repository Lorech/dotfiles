-- Various small, custom, and independent plugins for editing utilities
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside text object support
    local gen_spec = require('mini.ai').gen_spec
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        -- Code block
        o = gen_spec.treesitter {
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.innet' },
        },
        -- Function
        f = gen_spec.treesitter {
          a = { '@function.outer' },
          i = { '@function.inner' },
        },
        -- Class
        c = gen_spec.treesitter {
          a = { '@class.outer' },
          i = { '@class.inner' },
        },
        -- Tags
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        -- Digits
        d = { '%f[%d]%d+' },
        -- Cased words
        e = {
          {
            '%u[%l%d]+%f[^%l%d]',
            '%f[%S][%l%d]+%f[^%l%d]',
            '%f[%P][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
          },
          '^().*()$',
        },
      },
    }

    -- Make surrounding and removing/editing text surroundings easier
    require('mini.surround').setup()

    require('mini.icons').setup {
      init = function()
        package.preload['nvim-web-devicons'] = function()
          require('mini.icons').mock_nvim_web_devicons()
          return package.loaded['nvim-web-devicons']
        end
      end,
    }

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
