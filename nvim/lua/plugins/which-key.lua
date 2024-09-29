-- Simple UI display for showing keymaps for pending motions.
--  See `:help which-key`
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    icons = {
      -- Use icons if Nerd Fonts are enabled in Vim, falling back to keycodes otherwise.
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    -- Document existing key chains
    spec = {
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>d', group = 'Document', icon = { icon = '', color = 'green' } },
      { '<leader>r', group = 'Rename', icon = { icon = '', color = 'white' } },
      { '<leader>f', group = 'Find' },
      { '<leader>w', group = 'Workspace', icon = { icon = '󰙅', color = 'yellow' } },
      { '<leader>t', group = 'Toggle' },
      { '<leader>h', group = 'Hunk', mode = { 'n', 'v' }, icon = { icon = '󰊢', color = 'orange' } },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Which-key: buffer keymaps',
    },
  },
}
