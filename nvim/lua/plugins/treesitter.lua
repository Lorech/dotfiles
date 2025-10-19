-- Highlighter, navigator, and syntax highlighter for code
--  See `:help nvim-treesitter`
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
      -- Ensure certain languages to be auto-configured for TreeSitter. Ones
      -- not included in this list will only be installed when a file is open.
      auto_install = true,
      ensure_installed = { 'bash', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      highlight = {
        enable = true,
        -- Some languages depend on Vim's RegEx highlighting system (such as Ruby) for indent rules.
        --  If weird indenting issues are noticed, add the language to the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
