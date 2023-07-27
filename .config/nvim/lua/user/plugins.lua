require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'morhetz/gruvbox'
  use 'itchyny/lightline.vim'

  use 'dag/vim-fish'
  use 'dcharbon/vim-flatbuffers'
  use 'cstrahan/vim-capnp'
  use 'tikhomirov/vim-glsl'
  use 'matze/vim-meson'

  use 'nvim-treesitter/nvim-treesitter'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' } -- optional, for file icon
  }

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

  use 'hrsh7th/nvim-cmp'     -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'   -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-path'     -- LSP source for nvim-cmp

  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'         -- Snippets plugin
end)
