-- [[ Options ]]
--  See `:help vim.opt`

-- Configure line numbers
vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Show other lines as relatives

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Defer mode display to Lualine
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Add visual columns for long lines
vim.opt.colorcolumn = '80,120'

-- Save undo history
vim.opt.undofile = true

-- Make searching case-insensitive unless \C or if capital letters are present in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set up tabs for 2 char width, prefer spaces instead, auto-indent newlines
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Keep signcolumn on by default
-- Allocate two columns to support staged and unstaged Git changes from gitsigns
vim.opt.signcolumn = 'yes:2'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Change trailing whitespace character appearance
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Allow selecting whitespace in block editing mode
vim.opt.virtualedit = 'block'

-- Consider kebab-case as words
vim.opt.iskeyword:append '-'
