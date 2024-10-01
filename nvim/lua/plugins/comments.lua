-- Highlight certain keywords in comments, e.g., TODO, NOTE, etc.
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  keys = {
    {
      '<leader>ft',
      ':TodoTelescope<CR>',
      desc = 'Comments: Find Todos',
    },
    {
      '<leader>xt',
      ':TodoQuickFix<CR>',
      desc = 'Comments: Todo list',
    },
  },
}
