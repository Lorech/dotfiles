-- [[ Configuration ]]
require 'custom.globals'
require 'custom.options'
require 'custom.keymaps'
require 'custom.autocommands'

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
  { import = 'custom.colorschemes' },
  { import = 'custom.plugins.comments' },
  { import = 'custom.plugins.completions' },
  { import = 'custom.plugins.conform' },
  { import = 'custom.plugins.gitsigns' },
  { import = 'custom.plugins.lsp' },
  { import = 'custom.plugins.mini' },
  { import = 'custom.plugins.sleuth' },
  { import = 'custom.plugins.telescope' },
  { import = 'custom.plugins.treesitter' },
  { import = 'custom.plugins.which-key' },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
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
