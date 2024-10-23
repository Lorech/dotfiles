-- Simple UI display for showing keymaps for pending motions.
--  See `:help which-key`

-- Register all text objects within which-key
function WhichKeyMiniAiKeymap()
  -- The keys to add to the which-key UI.
  --
  -- Set `desc` to "NOOP" to hide a key from which-key, e.g.,
  -- if you don't intend to use or have unmapped a built-in key.
  --
  -- Taken from LazyVim's configuration.
  --  See https://github.com/LazyVim/LazyVim/blob/8ba7c64a7da9e46f2ac601919508803824208935/lua/lazyvim/plugins/coding.lua#L169-L199
  local objects = {
    { ' ', desc = 'whitespace' },
    { '"', desc = '" string' },
    { "'", desc = "' string" },
    { '(', desc = '() block' },
    { ')', desc = '() block with ws' },
    { '<', desc = '<> block' },
    { '>', desc = '<> block with ws' },
    { '?', desc = 'user prompt' },
    { '[', desc = '[] block' },
    { ']', desc = '[] block with ws' },
    { '_', desc = 'underscore' },
    { '`', desc = '` string' },
    { 'a', desc = 'argument' },
    { 'b', desc = ')]} block' },
    { 'B', desc = 'NOOP' },
    { 'c', desc = 'class' },
    { 'd', desc = 'digit(s)' },
    { 'e', desc = 'CamelCase / snake_case' },
    { 'f', desc = 'function' },
    { 'i', desc = 'indent' },
    { 'o', desc = 'block, conditional, loop' },
    { 'q', desc = 'quote `"\'' },
    { 't', desc = 'tag' },
    { '{', desc = '{} block' },
    { '}', desc = '{} with ws' },
  }

  local ret = { mode = { 'o', 'x' } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend('force', {}, {
    around = 'a',
    inside = 'i',
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',
  }, {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub('^around_', ''):gsub('^inside_', '')
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == 'i' then
        desc = desc:gsub(' with ws', '')
      end
      local hidden = false
      if desc == 'NOOP' then
        hidden = true
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc, hidden = hidden }
    end
  end
  require('which-key').add(ret, { notify = false })
end

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    icons = {
      -- Use icons if Nerd Fonts are enabled in Vim, falling back to keycodes otherwise.
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
      rules = {
        {
          plugin = 'cheatsheet.nvim',
          icon = '',
          color = 'purple',
        },
      },
    },
    -- Document existing key chains
    spec = {
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>d', group = 'Document', icon = { icon = '', color = 'green' } },
      { '<leader>r', group = 'Rename', icon = { icon = '', color = 'white' } },
      { '<leader>f', group = 'Find' },
      { '<leader>w', group = 'Workspace', icon = { icon = '󰙅', color = 'yellow' } },
      { '<leader>t', group = 'Toggle' },
      { '<leader>h', group = 'Hunk', mode = { 'n', 'v' }, icon = { icon = '󰊢', color = 'orange' } },
      { '<leader>j', group = 'Jump', icon = { icon = '', color = 'cyan' } },
      { '<leader>x', group = 'Trouble', icon = { icon = '󰙅', color = 'red' } },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Which-key: buffer keymaps',
    },
  },
}
