local nvim_tree = require('nvim-tree')
nvim_tree.setup {
  view = {
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
