-- Fuzzy-finder for files, text, and a lot more
--  See `:help telescope`
--
-- System dependencies:
--  - ripgrep (https://github.com/BurntSushi/ripgrep)
--  - fd (https://github.com/sharkdp/fd)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Utility function for creating keymaps
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { desc = 'Telescope: ' .. desc })
    end

    -- Configure Telescope-specific keymaps
    local builtin = require 'telescope.builtin'
    map('n', '<leader>fh', builtin.help_tags, 'Find help')
    map('n', '<leader>fk', builtin.keymaps, 'Find keymaps')
    map('n', '<leader>ff', builtin.find_files, 'Find files')
    map('n', '<leader>fw', builtin.grep_string, 'Find current word')
    map('n', '<leader>fg', builtin.live_grep, 'Find by grep')
    map('n', '<leader>fd', builtin.diagnostics, 'Find diagnostics')
    map('n', '<leader>fr', builtin.resume, 'Find resume')
    map('n', '<leader>f.', builtin.oldfiles, 'Find recent files')
    map('n', '<leader><leader>', function()
      builtin.buffers { ignore_current_buffer = true, sort_lastused = true }
    end, 'find buffers')
    map('n', '<leader>/', function()
      -- Decrease UI size since the current buffer is already familiar.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, 'Search current buffer')
    map('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, 'Grep open buffers')
    map('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, 'Find Neovim files')
  end,
}
