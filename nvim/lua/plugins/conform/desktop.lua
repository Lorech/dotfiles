local base = require 'plugins.conform.shared'

-- Personal desktop running Linux.
return vim.tbl_deep_extend('force', base, {
  c = { 'clang-format' },
  cpp = { 'clang-format' },
})
