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
})

require 'user.options'
require 'user.trailing_whitespaces'
require 'user.nvim-tree'
require 'user.colorscheme'
require 'user.keymaps'
require 'user.cmp'
require 'user.lsp'
