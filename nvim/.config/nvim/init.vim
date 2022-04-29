"############################## Set Shell to sh ################################
if &shell =~# 'fish$'
	set shell=sh
endif

"############################ Initialize vim-plug #############################
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'dag/vim-fish'
Plug 'dcharbon/vim-flatbuffers'
Plug 'cstrahan/vim-capnp'
Plug 'tikhomirov/vim-glsl'
Plug 'matze/vim-meson'

Plug 'vim-latex/vim-latex'

Plug 'scrooloose/nerdtree'

Plug 'neovim/nvim-lspconfig'    " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'         " Snippets plugin

call plug#end()

lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

"################################ Setup plugin #################################
"##### color scheme #####
colorscheme gruvbox
set background=dark

"##### NERDTree #####
let NERDTreeIgnore = ['\.hpp\.d$', '\.o$', '\.o\.d$','\.so$', '\.so\.d$','\.a$', '\.a\.d$']

"############################### Useful Keymap #################################
"##### Clear Highlight Search #####
noremap <Leader>c :noh<cr>

"##### NERDTree #####
nnoremap <Leader>n :NERDTree<cr>

"##### FZF #####
nnoremap <Leader>f :FZF -i<cr>

"##### Search and replace words under cursor #####
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"#################################### fzf ######################################

"################################ Preferences ##################################
set softtabstop=2 shiftwidth=2
set expandtab
set textwidth=80

set nowrap

augroup TrailingWhitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup Folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END
