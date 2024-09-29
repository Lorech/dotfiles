-- Fuzzy-finder for files, text, LSPs, git, and other things.
--  See `:help telescope`
--
-- System dependencies:
--  - Ripgrep (https://github.com/BurntSushi/ripgrep)
--  - FD (https://github.com/sharkdp/fd)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
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
    -- Enable icons if a Nerd Font is enabled in Neovim
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    -- Additional plugins to find more things in Telescope
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
    map('n', '<leader>fh', builtin.help_tags, 'Find Help')
    map('n', '<leader>fk', builtin.keymaps, 'Find Keymaps')
    map('n', '<leader>ff', builtin.find_files, 'Find Files')
    map('n', '<leader>fw', builtin.grep_string, 'Find current Word')
    map('n', '<leader>fg', builtin.live_grep, 'Find by Grep')
    map('n', '<leader>fd', builtin.diagnostics, 'Find Diagnostics')
    map('n', '<leader>fr', builtin.resume, 'Find Resume')
    map('n', '<leader>f.', builtin.oldfiles, 'Find recent files ("." for repeat)')
    map('n', '<leader><leader>', builtin.buffers, 'find existing buffers')

    map('n', '<leader>/', function()
      -- There is no need for such a large UI when searching through the current file, as we already are familiar with it.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, 'Fuzzy search in current buffer')

    map('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, 'Find by grep in open files')

    map('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, 'Find Neovim files')
  end,
}
