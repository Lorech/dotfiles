local M = {}

--- Finds an appropriate formatting configuration file for the given buffer.
---
--- Files of the same type may have different formatting configurations
--- depending on the project. Given a list of possible file names that may have
--- configuration within them, this function will recursively search up the
--- location of the buffer to check if any of these files exist.
---
--- If a configuration is found, it is safe to assume that the project this
--- file belongs to uses the tool that these configurations are for.
---
--- @param bufnr number the buffer number to find the configuration for
--- @param config_files table a list of possible names for configuration files of a specific tool
--- @return string[] configs the paths to the configuration files found
M.find_config = function(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })
end

--- Determines the appropriate formatter for the given TypeScript or JavaScript
--- buffer.
---
--- My preffered formatter is Biome, due to having parity with Prettier and
--- having a linter built into it, but existing projects run on Prettier. Since
--- both of these formatters can run in parallel using different configurations,
--- this function will check which formatter should be used based on formatter
--- specific configuration files being present within the project.
---
--- @param bufnr number the buffer number to find the configuration for
--- @return table config the Conform-compatible configuration for the requested buffer
M.biome_or_prettier = function(bufnr)
  local has_biome_config = M.find_config(bufnr, { 'biome.json', 'biome.jsonc' })

  if has_biome_config then
    return { 'biome', stop_after_first = true }
  end

  -- Default to Prettier.
  return { 'prettier', stop_after_first = true }
end

--- Lists the files that can have different formatters based on the project.
---
--- These are mostly web development files, which can be formatted either using
--- Prettier or Biome.
M.filetypes_with_dynamic_formatter = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'vue',
  'css',
  'scss',
  'less',
  'html',
  'json',
  'jsonc',
  'yaml',
  'markdown',
  'markdown.mdx',
  'graphql',
  'handlebars',
}

return M
