local id = vim.api.nvim_create_augroup('TrailingWhitespaces', {})
vim.api.nvim_create_autocmd('BufWrite', {
  group = id,
  pattern = '*',
  desc = 'Remove trailing whitespace on buffer write',
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd('%s/\\s\\+$//e')
    vim.fn.winrestview(view)
  end
})
