-- Autocompletion support while editing
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet engine
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      dependencies = {
        -- Include a bunch of pre-made code snippets to autocomplete.
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
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
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
}
