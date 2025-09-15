-- Colorscheme plugins to keep installed using lazy.nvim
--
-- A name property can be provided to change how the plugin is called within lazy.nvim
--
-- A colorscheme property should be provided to determine which colorscheme will be loaded
-- if that specific theme has the active property set to true
--
-- Active should be set true to the theme you wish to use to ensure it loads ASAP, and to
-- change which colorscheme will get initialized as the active one in Neovim. If active is
-- not set, it is assumed that the theme is not active, and therefore will not be loaded
--
-- See `:Telescope colorscheme` to preview the themes
local ensure_installed = {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    colorscheme = 'rose-pine-moon',
    active = true,
  },
}

-- Generate a configuration to load all the defined colorschemes with lazy.nvim
local colorschemes = {}
for _, plugin in pairs(ensure_installed) do
  local colorscheme = { plugin[1], lazy = false }
  if plugin.name then
    colorscheme['name'] = plugin.name
  end
  if plugin.active then
    colorscheme['lazy'] = true
    colorscheme['priority'] = 1000
    colorscheme['init'] = function()
      vim.cmd.colorscheme(plugin.colorscheme)
    end
  end
  table.insert(colorschemes, colorscheme)
end
return colorschemes
