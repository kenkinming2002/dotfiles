-- LSP Configs
local lsp_servers = {
  ['clangd']        = { cmd = {'run_clangd', '--malloc-trim'}},
  ['rust_analyzer'] = {},
  ['pyright']       = {},
  ['tsserver']      = {}
}

-- LSP Setup
local lspconfig    = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Setup LSP Server
cmp_nvim_lsp.default_capabilities()

function lsp_prompt()
  local callbacks = {
    ['declaration']     = vim.lsp.buf.declaration,
    ['definition']      = vim.lsp.buf.definition,
    ['implementation']  = vim.lsp.buf.implementation,
    ['type definition'] = vim.lsp.buf.type_definition,
    ['references']      = vim.lsp.buf.references,
    ['rename']          = vim.lsp.buf.rename
  }

  local items = {}
  for key, _ in pairs(callbacks) do
    table.insert(items, key)
  end

  vim.ui.select(items, {}, function(choice)
    if choice then
      callbacks[choice]()
    end
  end)
end

local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>l', lsp_prompt, { buffer = bufnr, silent = true})
end

for server, setup_params in pairs(lsp_servers) do
  setup_params.on_attach    = on_attach
  setup_params.capabilities = capabilities
  lspconfig[server].setup(setup_params)
end


