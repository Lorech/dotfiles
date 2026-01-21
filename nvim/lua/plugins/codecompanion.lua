-- Integrates AI chat and development agent.

vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    interactions = {
      chat = { adapter = 'mistral' },
      inline = { adapter = 'mistral' },
      cmd = { adapter = 'mistral' },
    },
  },
}
