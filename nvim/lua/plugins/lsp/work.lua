local base = require 'plugins.lsp.shared'

-- Work-issued 14" M5 MacBook Pro.
return vim.tbl_deep_extend('force', base, {
  -- DevOps
  dockerls = {},
  sqlls = {},
  -- Web
  html = {},
  cssls = {},
  ts_ls = {},
  eslint = {},
  somesass_ls = {},
  -- Standalone
  gopls = {},
  mdx_analyzer = {},
})
