-- Automatically pair symbols that should pair, e.g., parens, quotes, etc.
return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
