-- A compilation of several LSP plugins for full IDE-like integration
return {
  -- Lua language server, specializing in the Neovim API
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- Main LSP configuration for individual plugins and LSPs to work together
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Package manager and related tooling for installing LSPs
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by blink.cmp
      { 'saghen/blink.cmp' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local telescope = require 'telescope.builtin'

          -- Utility function for auto-generating keymaps related to LSP
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Execute a code action under the cursor
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })

          -- Display a hint about the word under your cursor
          --  Similar to what other IDEs do when you hover over words with your mouse
          map('K', vim.lsp.buf.hover, 'Hint')

          -- Rename the variable under the cursor
          map('grn', vim.lsp.buf.rename, 'Rename')

          -- Find references for the word under your cursor
          map('gr', telescope.lsp_references, 'Goto references')

          -- Find implementations of the word under your cursor
          --  Useful when the language can define types without implementing them
          map('gi', telescope.lsp_implementations, 'Goto implementation')

          -- Jump to the definition of the word under the cursor
          --  This is the location of the variable definition or function declaration
          --  Return to the original position using <C-t>
          map('gd', telescope.lsp_definitions, 'Goto definition')

          -- Jump to the declaration of the word under the cursor
          --  This is where the word was declared e.g., header file in C
          map('gD', vim.lsp.buf.declaration, 'Goto declaration')

          -- Jump to the type of the word under your cursor
          --  Useful when the type is unknown and the definition is irrelevant
          map('gt', telescope.lsp_type_definitions, 'type definition')

          -- Fuzzy find symbols (e.g., variables, functions, types) in the buffer
          map('gS', telescope.lsp_document_symbols, 'Document symbols')

          -- Fuzzy find symbols (e.g., variables, functions, types) in the workspace
          map('gW', telescope.lsp_dynamic_workspace_symbols, 'Workspace symbols')

          -- Highlight references to the current word within the open buffer
          -- when the cursor stays in place for some amount of time.
          --
          -- The first autocommand takes care of highlighting after some idling,
          -- the second autocommand clears the highlighting when the cursor moves.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle inlay hints')
          end
        end,
      })

      -- Diagnostics
      --  See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- Extend the default Neovim LSP capabilities with ones from other packages
      local capabilities = require('blink-cmp').get_lsp_capabilities()

      -- Resolve the hostname to facilitate per-device configuration
      local hostname = vim.loop.os_gethostname()

      -- Enabled language servers, which are set on a per-device basis
      --
      -- To add a new device to the list, create a new configuration derived
      -- from its hostname below. Each new configuration should extend from the
      -- `shared` LSP configuration, ensuring some consistency between devices.
      --
      -- The objects support overriding some features of the server:
      --  - cmd (table): Override the command used to start the server
      --  - filetypes (table): Override the associated filetypes for the server
      --  - capabilities (table): Override capabilities; e.g., to disable LSP features
      --  - settings (table): Override the settings passed when initializing
      --
      -- See `:help lspconfig-all` for pre-configured and available LSPs
      local servers
      if hostname == 'Lauriss-MacBook-Pro.local' then
        servers = require 'plugins.lsp.laptop'
      elseif hostname == 'Lauris-M5.local' then
        servers = require 'plugins.lsp.work'
      elseif hostname == 'Fractal' then
        servers = require 'plugins.lsp.desktop'
      else
        servers = require 'plugins.lsp.shared'
      end

      -- Enabled formatters, which are set on a per-device basis
      --
      -- The actual formatting hooks are set within the configuration for
      -- `conform`, but these are extracted here to enable automatic installs
      -- via Mason for the configured formatters.
      --
      -- To add a new device to the list, create a new configuration derived
      -- from its hostname below. Each new configuration should extend from the
      -- `shared` configuration, ensuring some consistency between devices.
      local formatters
      if hostname == 'Lauriss-MacBook-Pro-2.local' then
        formatters = require 'plugins.conform.work'
      elseif hostname == 'Lauriss-MacBook-Pro.local' then
        formatters = require 'plugins.conform.laptop'
      elseif hostname == 'Fractal' then
        formatters = require 'plugins.conform.desktop'
      else
        formatters = require 'plugins.conform.shared'
      end

      -- Ensure the servers and formatters above are always installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, vim.iter(vim.tbl_values(formatters or {})):flatten():totable())
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- Empty table as these are set via mason-tool-installer
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Override only values explicitly passed by the above configuration
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
