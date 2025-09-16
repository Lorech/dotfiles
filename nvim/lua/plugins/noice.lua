-- Modifies the command line to act as a prompt with notification toasts
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {},
  config = function()
    require('noice').setup {
      lsp = {
        -- Override markdown rendering so cmp and other plugins use Treesitter
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true, -- Use a classic bottom cmdline for search, replacing the status line
        command_palette = true, -- Position the cmdline and popupmenu together
        long_message_to_split = true, -- Send long messages to splits
      },
      views = {
        cmdline_popup = {
          border = {
            style = 'none',
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
      },
    }
  end,
}
