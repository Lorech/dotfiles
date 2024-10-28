-- [[ Configuration ]]
require 'utils'
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
  -- Configurations that depend on plugins
  require 'colorschemes',
  -- Standalone plugins
  require 'plugins.autopairs',
  require 'plugins.cheatsheet',
  require 'plugins.comments',
  require 'plugins.completions',
  require 'plugins.conform',
  require 'plugins.copilot',
  require 'plugins.gitsigns',
  require 'plugins.hop',
  require 'plugins.indents',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.neotree',
  require 'plugins.sleuth',
  require 'plugins.telescope',
  require 'plugins.tmux-navigator',
  require 'plugins.treesitter',
  require 'plugins.trouble',
  require 'plugins.which-key',
  require 'plugins.yanky',
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
