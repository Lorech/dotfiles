-- Auto-formatter based on file type
--  See `help: conform`
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Conform: Code Format',
    },
  },
  opts = {
    notify_on_error = false,
    format_after_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a  standardized coding style.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      astro = { 'prettier', 'eslint' },
      javascript = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      sql = { 'sqlfmt' },
    },
  },
}
