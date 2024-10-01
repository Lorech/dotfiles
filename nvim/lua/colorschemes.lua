-- Colorscheme plugins to keep installed using lazy.nvim
local ensure_installed = {
  'folke/tokyonight.nvim',
}

-- The current colorscheme to use
--
-- Setting plugin will ensure that this specific plugin gets priority loading
-- within lazy.nvim, and will apply the provided colorscheme within Neovim
-- when this plugin initializes, setting the custom colorscheme as soon as possible
local current = {
  plugin = 'folke/tokyonight.nvim',
  colorscheme = 'tokyonight-night',
}

-- Generate a configuration to load all the defined colorschemes with lazy.nvim
local colorschemes = {}
for _, plugin in pairs(ensure_installed) do
  local colorscheme = { plugin, lazy = true }
  if plugin == current.plugin then
    colorscheme['lazy'] = false
    colorscheme['priority'] = 1000
    colorscheme['init'] = function()
      vim.cmd.colorscheme(current.colorscheme)
    end
  end
  table.insert(colorschemes, colorscheme)
end
return colorschemes
