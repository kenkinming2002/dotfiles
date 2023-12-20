-- LSP Configs
local lsp_servers = {
  ['clangd']        = {},
  ['rust_analyzer'] = {},
  ['pyright']       = {},
  ['tsserver']      = {},
  ['hls']           = { filetypes = { 'haskell', 'lhaskell', 'cabal' } },
}

-- LSP Setup
local lspconfig    = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Setup LSP Server
cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.declaration,     { buffer = bufnr, silent = true})
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.definition,      { buffer = bufnr, silent = true})
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation,  { buffer = bufnr, silent = true})
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.references,      { buffer = bufnr, silent = true})
  vim.keymap.set('n', '<leader>m', vim.lsp.buf.rename,          { buffer = bufnr, silent = true})
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover,           { buffer = bufnr, silent = true})
end

for server, setup_params in pairs(lsp_servers) do
  setup_params.on_attach    = on_attach
  setup_params.capabilities = capabilities
  lspconfig[server].setup(setup_params)
end


