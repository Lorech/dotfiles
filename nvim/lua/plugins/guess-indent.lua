-- Detect `tabstop` and `shiftwidth` based on file type
return {
  'NMAC427/guess-indent.nvim',
  config = function()
    require('guess-indent').setup {}
  end,
}
