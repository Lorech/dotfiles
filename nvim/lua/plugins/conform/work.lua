local base = require 'plugins.conform.shared'

-- Work-issued 15" M5 MacBook Pro.
return vim.tbl_extend('force', base, {
  -- Web
  html = { 'prettier' },
  css = { 'prettier' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  typescriptreact = { 'prettier' },
})
