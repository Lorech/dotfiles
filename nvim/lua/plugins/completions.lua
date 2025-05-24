-- Autocompletion support while editing.
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      -- Documentation
      ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      -- Navigation; uses standard keymap familiar from other plugins
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      -- Completion; uses the snippet under the cursor, or the first one otherwise.
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = {
        enabled = false,
      },
      menu = { border = 'single' },
      documentation = { window = { border = 'single' } },
    },
    sources = {
      default = function()
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
          return { 'buffer' }
        elseif vim.bo.filetype == 'lua' then
          return { 'lsp', 'path' }
        else
          return { 'lsp', 'path', 'snippets', 'buffer' }
        end
      end,
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
