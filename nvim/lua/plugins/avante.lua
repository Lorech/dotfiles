-- Built-in AI integration with chat and autocompletion features
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false,
  opts = {
    provider = 'copilot',
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua', -- Only for GitHub Copilot
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
