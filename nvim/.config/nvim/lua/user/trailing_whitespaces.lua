local id = vim.api.nvim_create_augroup('TrailingWhitespaces', {})
vim.api.nvim_create_autocmd('BufWrite', {
  group = id,
  pattern = '*',
  desc = 'Remove trailing whitespace on buffer write',
  command = '%s/\\s\\+$//e'
})
