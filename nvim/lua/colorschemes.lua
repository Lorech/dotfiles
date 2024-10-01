-- Colorscheme plugins to keep installed using lazy.nvim
local ensure_installed = {
  'folke/tokyonight.nvim',
  'rose-pine/neovim',
}

-- The current colorscheme to use
--
-- Setting plugin will ensure that this specific plugin gets priority loading
-- within lazy.nvim, and will apply the provided colorscheme within Neovim
-- when this plugin initializes, setting the custom colorscheme as soon as possible
local current = {
  plugin = 'rose-pine/neovim',
  colorscheme = 'rose-pine-moon',
}

-- Generate a configuration to load all the defined colorschemes with lazy.nvim
local colorschemes = {}
for _, plugin in pairs(ensure_installed) do
  local colorscheme = { plugin, lazy = false }
  if plugin == current.plugin then
    colorscheme['lazy'] = true
    colorscheme['priority'] = 1000
    colorscheme['init'] = function()
      vim.cmd.colorscheme(current.colorscheme)
    end
  end
  table.insert(colorschemes, colorscheme)
end
return colorschemes
