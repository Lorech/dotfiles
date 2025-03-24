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
    { '<leader>wr', ':Neotree filesystem reveal toggle<CR>', desc = 'Neotree: Workspace Reveal', silent = true },
    { '<leader>wb', ':Neotree buffers reveal toggle<CR>', desc = 'Neotree: Workspace Buffers', silent = true },
    { '<leader>wc', ':Neotree git_status reveal toggle<CR>', desc = 'Neotree: Workspace Changes', silent = true },
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
        ['K'] = {
          function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require 'neo-tree.ui.renderer'
            renderer.focus_node(state, siblings[1]:get_id())
          end,
          desc = 'Jump to first sibling',
        },
        ['J'] = {
          function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require 'neo-tree.ui.renderer'
            renderer.focus_node(state, siblings[#siblings]:get_id())
          end,
          desc = 'Jump to last sibling',
        },
      },
    },
  },
}
