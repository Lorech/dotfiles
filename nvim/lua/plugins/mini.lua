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
            '%f[^%s%p][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
            '%f[^%s%p][%a%d]+%f[^%a%d]',
            '^[%a%d]+%f[^%a%d]',
          },
          '^().*()$',
        },
        -- Indentations
        --
        -- For "a", it will include the non-whitespace line surrounding the indent block.
        -- "a" is line-wise, "i" is character-wise.
        --
        -- Taken from LazyVim's configuration.
        --  See https://github.com/LazyVim/LazyVim/blob/8ba7c64a7da9e46f2ac601919508803824208935/lua/lazyvim/util/mini.lua#L7-L43
        i = function(type)
          local spaces = (' '):rep(vim.o.tabstop)
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local indents = {} ---@type {line: number, indent: number, text: string}[]

          for l, line in ipairs(lines) do
            if not line:find '^%s*$' then
              indents[#indents + 1] = { line = l, indent = #line:gsub('\t', spaces):match '^%s*', text = line }
            end
          end

          local ret = {}

          for i = 1, #indents do
            if i == 1 or indents[i - 1].indent < indents[i].indent then
              local from, to = i, i
              for j = i + 1, #indents do
                if indents[j].indent < indents[i].indent then
                  break
                end
                to = j
              end
              from = type == 'a' and from > 1 and from - 1 or from
              to = type == 'a' and to < #indents and to + 1 or to
              ret[#ret + 1] = {
                indent = indents[i].indent,
                from = { line = indents[from].line, col = type == 'a' and 1 or indents[from].indent + 1 },
                to = { line = indents[to].line, col = #indents[to].text },
              }
            end
          end

          return ret
        end,
      },
    }

    -- Map the `mini.ai` keymaps to the `which-key` help dialog
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == 'which-key.nvim' then
          vim.schedule(WhichKeyMiniAiKeymap)
          return true
        end
      end,
    })

    -- Make surrounding and removing/editing text surroundings easier
    require('mini.surround').setup()

    -- Add shortcuts for automatically creating code comments
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
    -- Enable Nerd Font icons if Vim is configured to have one
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Change cursor location to COL:ROW in the status line
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
