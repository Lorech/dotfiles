-- Adds ZK integration to Neovim
return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup {}
  end,
}
