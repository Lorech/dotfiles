local base = require 'plugins.lsp.shared'

-- Personal 14" M1 MacBook Pro
return vim.tbl_deep_extend('force', base, {
  -- DevOps
  dockerls = {},
  sqlls = {},
  -- Web
  html = {},
  cssls = {},
  tsserver = {},
  eslint = {},
  astro = {},
  -- Standalone
  gopls = {},
  clangd = {},
})
