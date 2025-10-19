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
    'zenbones-theme/zenbones.nvim',
    priority = 1000,
    lazy = false,
    dependencies = 'rktjmp/lush.nvim',
    config = function()
      vim.cmd.colorscheme 'rosebones'
    end,
  },
}
