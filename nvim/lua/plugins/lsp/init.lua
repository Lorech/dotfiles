-- Various LSP-related plugins and their configurations.
--
-- These are grouped together to avoid mass file switching when language-specific features
-- must be changed or updated. See each individual plugin for setup/configuration help
return {
  -- Lua language server, specializing in the Neovim API for easier setup of plugins and settings
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Luvit injection within the Lua language server, loaded when relevant
  { 'Bilal2453/luvit-meta', lazy = true },

  -- Main LSP configuration, injecting LSP functionality into Neovim, and setting up
  -- dependencies for installing and configuring individual LSPs and related tooling
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Package manager and related tooling for installing and running language servers.
      { 'williamboman/mason.nvim', config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      -- Attach an LSP to the buffer when one is opened
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Utility function for auto-generating keymaps related to LSP
          local telescope = require 'telescope.builtin'
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Display a hint about the word under your cursor
          --  Similar to what other IDEs do when you hover over words with your mouse
          map('K', vim.lsp.buf.hover, 'hover hint')

          -- Jump to the definition of the word under the cursor
          --  This is the location of the variable definition or function declaration
          map('gd', telescope.lsp_definitions, 'Goto Definition')

          -- Jump to the declaration of the word under the cursor
          --  This is where the word was declared, not defined, e.g., header file in C
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          -- Find references for the word under your cursor
          --  This is where the variable or function has been used
          map('gr', telescope.lsp_references, 'Goto References')

          -- Jump to the implementation of the word under your cursor
          --  Useful when the language can define types without implementing them (e.g., C)
          map('gI', telescope.lsp_implementations, 'Goto Implementation')

          -- Jump to the type of the word under your cursor
          --  Useful when the type of the variable is unknown but the actual definition is irrelevant
          map('<leader>D', telescope.lsp_type_definitions, 'type Definition')

          -- Fuzzy find all the symbols (e.g., variables, functions, types) in the current document
          map('<leader>ds', telescope.lsp_document_symbols, 'Document Symbols')

          -- Fuzzy find all the symbols (e.g., variables, functions, types) in the current workspace
          map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- Rename the variable under the cursor
          map('<leader>rn', vim.lsp.buf.rename, 'ReName')

          -- Execute a code action under the cursor
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

            -- Show help about the word under the cursor after hovering for some time
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- Clear the hover dialog after moving the cursor
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            -- Clear the hover dialog after removing the buffer
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle inlay Hints')
          end
        end,
      })

      -- Extend the default Neovim LSP capabilities with additional ones from other packages
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enabled language servers, which are set on a per-device basis
      --
      -- To add a new device to the list, determine it's hostname and add a configuration below.
      -- Each new configuration should extend from the `shared` LSP configuration, ensuring some
      -- consistency between devices, for example, to allow making changes in Neovim configs.
      --
      -- The objects support overriding some features of the language server based on the following keys:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features
      --  - settings (table): Override the default settings passed when initializing the server
      --
      -- See documentation for each LSP to find what configurations they may support
      --
      -- See `:help lspconfig-all` for pre-configured and available LSPs
      local servers
      local hostname = vim.loop.os_gethostname()
      if hostname == 'Lauriss-MacBook-Pro.local' then -- TODO: Check if this is correct
        servers = require 'plugins.lsp.laptop'
      elseif hostname == 'Lauriss-MacBook-Pro-2.local' then
        servers = require 'plugins.lsp.work'
      elseif hostname == 'Fractal' then -- TODO: Check if this is correct
        servers = require 'plugins.lsp.desktop'
      else
        servers = require 'plugins.lsp.shared'
      end

      -- Ensure the servers and tools above are installed
      --  See `:Mason` for current status of tools or manual install of non-configured tools
      require('mason').setup()

      -- Configure other LSP-related tools to install to work within Neovim
      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed by the server configuration above.
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
