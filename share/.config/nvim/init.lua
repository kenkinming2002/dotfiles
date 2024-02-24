-- 1: Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
  print("Downloading lazy.nvim...")
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
  print("Finished Downloading lazy.nvim")
end
vim.opt.rtp:prepend(lazypath)

-- 2: Download package
require("lazy").setup({
  'L3MON4D3/LuaSnip',
  'cstrahan/vim-capnp',
  'dag/vim-fish',
  'dcharbon/vim-flatbuffers',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'itchyny/lightline.vim',
  'kyazdani42/nvim-tree.lua',
  'kyazdani42/nvim-web-devicons',
  'matze/vim-meson',
  'morhetz/gruvbox',
  'neovim/nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter',
  'saadparwaiz1/cmp_luasnip',
  'tikhomirov/vim-glsl',
  { 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } }
})

-- 3: Requires
local cmp               = require('cmp')
local cmp_nvim_lsp      = require('cmp_nvim_lsp')
local lspconfig         = require('lspconfig')
local luasnip           = require('luasnip')
local nvim_tree         = require('nvim-tree')
local nvim_tree_api     = require('nvim-tree.api')
local telescope_builtin = require('telescope.builtin')

-- 3: Snippet Engine - luasnip
vim.keymap.set({'i', 's'}, '<C-J>',  function() if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end end);
vim.keymap.set({'i', 's'}, '<CS-J>', function() if luasnip.jumpable(-1)         then luasnip.jump(-1)         end end);

-- 4: Completion-Engine - nvim-cmp
cmp_nvim_lsp.default_capabilities()
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
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
}

-- 5: LSP
local lsp_servers = {
  ['clangd']        = {},
  ['rust_analyzer'] = {},
  ['pyright']       = {},
  ['tsserver']      = {},
  ['hls']           = { filetypes = { 'haskell', 'lhaskell', 'cabal' } },
}

for server, setup_params in pairs(lsp_servers) do
  setup_params.on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.declaration,     { buffer = bufnr, silent = true})
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.definition,      { buffer = bufnr, silent = true})
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation,  { buffer = bufnr, silent = true})
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references,      { buffer = bufnr, silent = true})
    vim.keymap.set('n', '<leader>m', vim.lsp.buf.rename,          { buffer = bufnr, silent = true})
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover,           { buffer = bufnr, silent = true})
  end
  setup_params.capabilities = capabilities
  lspconfig[server].setup(setup_params)
end

-- 6: telescope
require('telescope').setup{
  -- See https://github.com/nvim-telescope/telescope.nvim/issues/2105
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    },
  },
}
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- 7: nvim-tree
nvim_tree.setup {
  on_attach = function(bufnr)
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', '<C-]>',          nvim_tree_api.tree.change_root_to_node,       opts('CD'))
    vim.keymap.set('n', '<C-e>',          nvim_tree_api.node.open.replace_tree_buffer,  opts('Open: In Place'))
    vim.keymap.set('n', '<C-k>',          nvim_tree_api.node.show_info_popup,           opts('Info'))
    vim.keymap.set('n', '<C-r>',          nvim_tree_api.fs.rename_sub,                  opts('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>',          nvim_tree_api.node.open.tab,                  opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>',          nvim_tree_api.node.open.vertical,             opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>',          nvim_tree_api.node.open.horizontal,           opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>',           nvim_tree_api.node.navigate.parent_close,     opts('Close Directory'))
    vim.keymap.set('n', '<CR>',           nvim_tree_api.node.open.edit,                 opts('Open'))
    vim.keymap.set('n', '<Tab>',          nvim_tree_api.node.open.preview,              opts('Open Preview'))
    vim.keymap.set('n', '>',              nvim_tree_api.node.navigate.sibling.next,     opts('Next Sibling'))
    vim.keymap.set('n', '<',              nvim_tree_api.node.navigate.sibling.prev,     opts('Previous Sibling'))
    vim.keymap.set('n', '.',              nvim_tree_api.node.run.cmd,                   opts('Run Command'))
    vim.keymap.set('n', '-',              nvim_tree_api.tree.change_root_to_parent,     opts('Up'))
    vim.keymap.set('n', 'a',              nvim_tree_api.fs.create,                      opts('Create'))
    vim.keymap.set('n', 'bmv',            nvim_tree_api.marks.bulk.move,                opts('Move Bookmarked'))
    vim.keymap.set('n', 'B',              nvim_tree_api.tree.toggle_no_buffer_filter,   opts('Toggle No Buffer'))
    vim.keymap.set('n', 'c',              nvim_tree_api.fs.copy.node,                   opts('Copy'))
    vim.keymap.set('n', 'C',              nvim_tree_api.tree.toggle_git_clean_filter,   opts('Toggle Git Clean'))
    vim.keymap.set('n', '[c',             nvim_tree_api.node.navigate.git.prev,         opts('Prev Git'))
    vim.keymap.set('n', ']c',             nvim_tree_api.node.navigate.git.next,         opts('Next Git'))
    vim.keymap.set('n', 'd',              nvim_tree_api.fs.remove,                      opts('Delete'))
    vim.keymap.set('n', 'D',              nvim_tree_api.fs.trash,                       opts('Trash'))
    vim.keymap.set('n', 'E',              nvim_tree_api.tree.expand_all,                opts('Expand All'))
    vim.keymap.set('n', 'e',              nvim_tree_api.fs.rename_basename,             opts('Rename: Basename'))
    vim.keymap.set('n', ']e',             nvim_tree_api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', '[e',             nvim_tree_api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F',              nvim_tree_api.live_filter.clear,              opts('Clean Filter'))
    vim.keymap.set('n', 'f',              nvim_tree_api.live_filter.start,              opts('Filter'))
    vim.keymap.set('n', 'g?',             nvim_tree_api.tree.toggle_help,               opts('Help'))
    vim.keymap.set('n', 'gy',             nvim_tree_api.fs.copy.absolute_path,          opts('Copy Absolute Path'))
    vim.keymap.set('n', 'H',              nvim_tree_api.tree.toggle_hidden_filter,      opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I',              nvim_tree_api.tree.toggle_gitignore_filter,   opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'J',              nvim_tree_api.node.navigate.sibling.last,     opts('Last Sibling'))
    vim.keymap.set('n', 'K',              nvim_tree_api.node.navigate.sibling.first,    opts('First Sibling'))
    vim.keymap.set('n', 'm',              nvim_tree_api.marks.toggle,                   opts('Toggle Bookmark'))
    vim.keymap.set('n', 'o',              nvim_tree_api.node.open.edit,                 opts('Open'))
    vim.keymap.set('n', 'O',              nvim_tree_api.node.open.no_window_picker,     opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p',              nvim_tree_api.fs.paste,                       opts('Paste'))
    vim.keymap.set('n', 'P',              nvim_tree_api.node.navigate.parent,           opts('Parent Directory'))
    vim.keymap.set('n', 'q',              nvim_tree_api.tree.close,                     opts('Close'))
    vim.keymap.set('n', 'r',              nvim_tree_api.fs.rename,                      opts('Rename'))
    vim.keymap.set('n', 'R',              nvim_tree_api.tree.reload,                    opts('Refresh'))
    vim.keymap.set('n', 'S',              nvim_tree_api.tree.search_node,               opts('Search'))
    vim.keymap.set('n', 'U',              nvim_tree_api.tree.toggle_custom_filter,      opts('Toggle Hidden'))
    vim.keymap.set('n', 'W',              nvim_tree_api.tree.collapse_all,              opts('Collapse'))
    vim.keymap.set('n', 'x',              nvim_tree_api.fs.cut,                         opts('Cut'))
    vim.keymap.set('n', 'y',              nvim_tree_api.fs.copy.filename,               opts('Copy Name'))
    vim.keymap.set('n', 'Y',              nvim_tree_api.fs.copy.relative_path,          opts('Copy Relative Path'))
    vim.keymap.set('n', '<2-LeftMouse>',  nvim_tree_api.node.open.edit,                 opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', nvim_tree_api.tree.change_root_to_node,       opts('CD'))
  end
}
vim.keymap.set('n', '<leader>e', nvim_tree_api.tree.toggle, { silent = true })

 -- 8: Options
vim.opt.softtabstop    = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true
vim.opt.wrap           = false
vim.opt.termguicolors  = true
vim.opt.relativenumber = true
vim.opt.shell          = '/bin/sh'

 -- 9: Colorscheme
vim.cmd('colorscheme gruvbox')

 -- 10: Keymaps
vim.keymap.set('n', '<C-P>', '<cmd>cprevious<cr>', { silent = true })
vim.keymap.set('n', '<C-N>', '<cmd>cnext<cr>',     { silent = true })

 -- 11: Useful Stuffs
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
