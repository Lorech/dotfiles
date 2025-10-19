-- [[ Configuration ]]
-- Must be required first and in this specific order to avoid
-- issues when plugins start being loaded later on in this file.
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
  require 'plugins.autopairs',
  require 'plugins.colorschemes',
  require 'plugins.comments',
  require 'plugins.completions',
  require 'plugins.conform',
  require 'plugins.gitsigns',
  require 'plugins.guess-indent',
  require 'plugins.indent-guide',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.neotree',
  require 'plugins.render-markdown',
  require 'plugins.telescope',
  require 'plugins.tmux-navigator',
  require 'plugins.treesitter',
  require 'plugins.trouble',
  require 'plugins.yanky',
  require 'plugins.zk',
}, {
  ui = {
    -- Use emojis for UI if Nerd Fonts are disabled. Providing an empty
    -- table will allow lazy.nvim to use it's built-in icons instead.
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
