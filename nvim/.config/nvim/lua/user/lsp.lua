-- LSP Configs
local lsp_servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }

-- LSP Setup
local lspconfig    = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Setup LSP Server
local capabilities = vim.lsp.protocol.make_client_capabilities()
cmp_nvim_lsp.update_capabilities(capabilities)

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
    callbacks[choice]()
  end)
end

local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>l', lsp_prompt, { buffer = bufnr, silent = true})
end

for _, server in ipairs(lsp_servers) do
  lspconfig[server].setup { on_attach = on_attach, capabilities = capabilities }
end


