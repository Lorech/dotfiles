-- Expands yank functionality with memory and intuitive positioning
--  See `:help yanky`
return {
  'gbprod/yanky.nvim',
  opts = {},
  keys = {
    {
      '<leader>fy',
      function()
        if require 'telescope' then
          require('telescope').extensions.yank_history.yank_history {}
        else
          vim.cmd [[YankyRingHistory]]
        end
      end,
      mode = { 'n', 'x' },
      desc = 'Yanky: Find Yanks',
    },
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yanky: Yank' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Yanky: Put after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Yanky: Put before cursor' },
    { '[y', '<Plug>(YankyCycleForward)', desc = 'Yanky: goto next Yank' },
    { ']y', '<Plug>(YankyCycleBackward)', desc = 'Yanky: goto previous Yank' },
  },
}
