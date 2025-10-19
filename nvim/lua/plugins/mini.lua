-- Various small and independent plugins
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside text object support
    local ai = require 'mini.ai'
    local gen_spec = ai.gen_spec
    ai.setup {
      n_lines = 500,
      custom_textobjects = {
        -- Code block
        o = gen_spec.treesitter {
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
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
            '%f[^%s%p][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
            '%f[^%s%p][%a%d]+%f[^%a%d]',
            '^[%a%d]+%f[^%a%d]',
          },
          '^().*()$',
        },
      },
    }

    -- Update surroundings of text objects
    require('mini.surround').setup()

    -- Create code comments
    require('mini.comment').setup()

    -- Enhance the available Nerd Font icon set within Neovim
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
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Change cursor location to COL:ROW in the status line
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
