local base = require 'plugins.lsp.shared'

-- Work-issued 13" M2 MacBook Pro.
return vim.tbl_deep_extend('force', base, {
  -- DevOps
  dockerls = {},
  sqlls = {},
  -- Web
  html = {},
  cssls = {},
  tsserver = {},
  eslint = {},
})
