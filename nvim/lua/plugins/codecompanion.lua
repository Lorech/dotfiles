-- Integrates AI chat and development agent.
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  config = function()
    require('codecompanion').setup {
      strategies = {
        inline = {
          keymaps = {
            accept_change = {
              modes = { n = '<leader>aa' },
              description = 'Agent: Accept suggestion',
            },
            always_accept = {
              modes = { n = '<leader>ay' },
              description = 'Agent: Always accept suggestion',
            },
            reject_change = {
              modes = { n = '<leader>ar' },
              opts = { nowait = true },
              description = 'Agent: Reject suggestion',
            },
          },
        },
      },
    }

    -- Utility function for creating keymaps
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { desc = 'Agent: ' .. desc, noremap = true, silent = true })
    end

    -- Configure Code Companion-specific keymaps
    map({ 'n', 'v' }, '<leader>a?', '<cmd>CodeCompanionActions<cr>', 'Actions')
    map({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', 'Chat')
    map({ 'n', 'v' }, '<leader>ap', '<cmd>CodeCompanion ', 'Prompt')
    map('v', '<leader>aa', '<cmd>CodeCompanionChat Add<cr>', 'Add to Chat')

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
