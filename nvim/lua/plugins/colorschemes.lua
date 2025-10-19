-- Colorscheme plugins to keep installed using lazy.nvim
--
-- A name property can be provided to change how the plugin is called within
-- lazy.nvim. A colorscheme property should be provided to determine which
-- colorscheme will be loaded if that specific theme has the active property
-- set to true.
--
-- See `:Telescope colorscheme` to preview the themes
return {
  {
    'rose-pine/neovim',
    priority = 1000,
    lazy = false,
    config = function()
      require('rose-pine').setup {
        styles = {
          transparency = true,
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
