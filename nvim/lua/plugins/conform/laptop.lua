local base = require 'plugins.conform.shared'

-- Personal 14" M1 MacBook Pro
return vim.tbl_extend('force', base, {
  -- DevOps
  sql = { 'sqlfmt' },
  -- Web
  html = { 'prettier' },
  css = { 'prettier' },
  javascript = { 'prettier', 'eslint' },
  typescript = { 'prettier', 'eslint' },
  typescriptreact = { 'prettier', 'eslint' },
  astro = { 'prettier', 'eslint' },
  -- Standalone
  go = { 'gofmt' },
  c = { 'clang-format' },
  cpp = { 'clang-format' },
})
