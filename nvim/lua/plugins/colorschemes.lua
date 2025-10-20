-- Colorscheme plugins to keep installed using lazy.nvim
--
-- The actual colorscheme to use gets set at the very end of `init.lua` to
-- ensure that every scheme has been downloaded and loaded by lazy.nvim before
-- we attempt to reconfigur Neovim to actually use it.
--
-- See `:Telescope colorscheme` to preview the themes
return {
  {
    'p00f/alabaster.nvim',
    priority = 1000,
    lazy = false,
  },
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
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    priority = 1000,
    lazy = false,
    dependencies = 'rktjmp/lush.nvim',
  },
}
