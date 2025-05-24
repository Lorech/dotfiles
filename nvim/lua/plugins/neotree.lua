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
  keys = function()
    -- Utility for allowing Neotree to switch focus between trees and buffers interchangably.
    local toggle = function(keys, tree, desc)
      vim.keymap.set('n', keys, function()
        local source_manager = require 'neo-tree.sources.manager'
        local window_state = source_manager.get_state_for_window()

        -- Current window is not a Neo-tree window, so focus the tree.
        if not window_state then
          vim.cmd('Neotree focus reveal ' .. tree)
          return
        end

        -- Exit the tree if we are already on it or focus it if we want a new one.
        local renderer = require 'neo-tree.ui.renderer'
        local tree_state = source_manager.get_state(tree)
        if tree_state and renderer.tree_is_visible(tree_state) then
          vim.cmd 'wincmd p'
        else
          vim.cmd('Neotree focus reveal ' .. tree)
        end
      end, { desc = desc })
    end

    -- Add keybinds for trees that can switch focus with buffers.
    toggle('<leader>we', 'filesystem', 'Neotree: Worskpace Explorer')
    toggle('<leader>wb', 'buffers', 'Neotree: Workspace Buffers')
    toggle('<leader>wg', 'git_status', 'Neotree: Workspace Git status')

    -- Toggle Neotree with the last opened tree.
    vim.keymap.set('n', '<leader>wr', function()
      vim.cmd 'Neotree reveal toggle last'
    end, { desc = 'Neotree: Workspace Reveal' })
  end,
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
    },
    window = {
      position = 'right',
      width = 60,
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
          desc = 'yank_relative_path',
        },
        ['YY'] = {
          function(state)
            local node = state.tree:get_node()
            local absPath = node:get_id()
            vim.fn.setreg('+', absPath, 'c')
          end,
          desc = 'yank_absolute_path',
        },
        ['K'] = {
          function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require 'neo-tree.ui.renderer'
            renderer.focus_node(state, siblings[1]:get_id())
          end,
          desc = 'first_sibling',
        },
        ['J'] = {
          function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require 'neo-tree.ui.renderer'
            renderer.focus_node(state, siblings[#siblings]:get_id())
          end,
          desc = 'last_sibling',
        },
      },
    },
  },
}
