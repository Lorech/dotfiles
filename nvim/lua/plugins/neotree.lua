-- Browse the file system within Neovim
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>wr', ':Neotree filesystem reveal<CR>', desc = 'Workspace Reveal', silent = true },
  },
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          added = '+',
          modified = '~',
          deleted = '-',
          renamed = '~',
        },
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
      },
      window = {
        width = 60,
        mappings = {
          ['<leader>wr'] = { 'close_window', desc = 'Workspace unReveal' },
        },
      },
    },
    window = {
      position = 'right',
      mappings = {
        ['<space>'] = 'none',
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local absPath = node:get_id()
            local cwd = vim.fn.getcwd()
            local relPath = string.gsub(absPath, cwd, '')
            vim.fn.setreg('+', relPath, 'c')
          end,
          desc = 'Yank relative path',
        },
        ['YY'] = {
          function(state)
            local node = state.tree:get_node()
            local absPath = node:get_id()
            vim.fn.setreg('+', absPath, 'c')
          end,
          desc = 'Yank absolute path',
        },
      },
    },
  },
}
