local base = require 'plugins.conform.shared'

-- Work-issued 13" M2 MacBook Pro.
return vim.tbl_extend('force', base, {
  -- DevOps
  sql = { 'sqlfmt' },
  -- Web
  html = { 'prettier' },
  css = { 'prettier' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  typescriptreact = { 'prettier' },
})
