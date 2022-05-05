require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "cpp", "rust" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

