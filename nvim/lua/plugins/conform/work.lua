local base = require 'plugins.conform.shared'

-- Work-issued 15" M5 MacBook Pro.
return vim.tbl_extend('force', base, {
  -- DevOps
  sql = { 'sqlfmt' },
  -- Web
  html = { 'prettier' },
  css = { 'prettier' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  typescriptreact = { 'prettier' },
  -- Standalone
  go = { 'gofmt' },
})
