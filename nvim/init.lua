-- [[ Configuration ]]
require 'globals'
require 'options'
require 'keymaps'
require 'autocommands'

-- [[ `lazy.nvim` ]]
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
--  See `:Lazy`
require('lazy').setup({
  { import = 'colorschemes' },
  { import = 'plugins.autopairs' },
  { import = 'plugins.comments' },
  { import = 'plugins.completions' },
  { import = 'plugins.conform' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.indents' },
  { import = 'plugins.lsp' },
  { import = 'plugins.mini' },
  { import = 'plugins.neotree' },
  { import = 'plugins.sleuth' },
  { import = 'plugins.telescope' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.which-key' },
}, {
  ui = {
    -- Use icons for UI if a Nerd Font is enabled in Vim, falling back to an empty field otherwise.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
