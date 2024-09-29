-- Add git-related symbols to the gutter, as well as utilities and keymaps for managing changes
--  See `:help gitsigns`
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame_opts = {
      -- Configured for quick scanning of files, but not enabled by default
      -- Toggle to enable blame with '<leader>tb'
      virt_text_pos = 'right_align',
      delay = 0,
    },
    on_attach = function()
      local gitsigns = require 'gitsigns'

      -- Utility function for setting keymaps
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { desc = 'Git: ' .. desc })
      end

      -- [[ Navigation ]]
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, 'jump to next Hunk')

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, 'jump to previous Hunk')

      -- [[ Actions ]]
      -- [[ Visual ]]
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Hunk Stage')
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Hunk Reset')
      -- [[ Normal ]]
      map('n', '<leader>hs', gitsigns.stage_hunk, 'Hunk Stage')
      map('n', '<leader>hr', gitsigns.reset_hunk, 'Hunk Reset')
      map('n', '<leader>hS', gitsigns.stage_buffer, 'Hunk Stage buffer')
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Hunk Undo stage')
      map('n', '<leader>hR', gitsigns.reset_buffer, 'Hunk Reset stage')
      map('n', '<leader>hp', gitsigns.preview_hunk, 'Hunk Preview')
      map('n', '<leader>hb', gitsigns.blame_line, 'Hunk Blame line')
      map('n', '<leader>hd', gitsigns.diffthis, 'Hunk Diff index')
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, 'Hunk Diff last commit')
      -- [[ Toggles ]]
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle show blame line')
      map('n', '<leader>tD', gitsigns.toggle_deleted, 'Toggle show Deleted')
    end,
  },
}
