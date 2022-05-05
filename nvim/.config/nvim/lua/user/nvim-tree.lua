local nvim_tree = require('nvim-tree')
nvim_tree.setup {
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- unbind the key to open file with default system application cuz why
        -- would you want to leave vim
        { key = "s", action = ""}
      }
    }
  }
}

vim.keymap.set('n', '<leader>e', nvim_tree.toggle, { silent = true })
