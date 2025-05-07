-- Formatter configuration shared across all devices.
-- For the most part, only Lua is expected to be here, as it is required to
-- even use Neovim, but, if a pattern of using certain formatters on all devices
-- emerges (e.g., web dev stuff), then this could be updated to include them.
return {
  lua = { 'stylua' },
}
