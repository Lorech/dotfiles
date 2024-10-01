-- Provides a built-in cheat sheet for various built-in Vim motions
return {
  'sudormrfbin/cheatsheet.nvim',
  dependencies = {
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    {
      '<leader>fc',
      ':Cheatsheet<CR>',
      mode = { 'n' },
      desc = 'Cheatsheet: Find Cheats',
    },
  },
}
