local cmp_nvim_lsp = require('cmp_nvim_lsp')
local cmp          = require('cmp')
local luasnip      = require('luasnip')

vim.keymap.set({'i', 's'}, '<C-J>',  function() if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end end);
vim.keymap.set({'i', 's'}, '<CS-J>', function() if luasnip.jumpable(-1)         then luasnip.jump(-1)         end end);

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace },
    ['<Tab>']     = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { 'i', 's' }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer   = "[BUFFER]",
        path     = "[PATH]",
        luasnip  = "[SNIPPET]",
      })[entry.source.name]
      return vim_item
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
}

