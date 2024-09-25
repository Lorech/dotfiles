-- Highlighter, navigator, and syntax highlighter for code
--  See `:help nvim-treesitter`
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    -- Languages that treesitter should be configured to recognize for highlighting
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    -- Auto-install treesitter configurations for any missing languages when opening a buffer
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on Vim's RegEx highlighting system (such as Ruby) for indent rules.
      --  If weird indenting issues are noticed, add the language to the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
