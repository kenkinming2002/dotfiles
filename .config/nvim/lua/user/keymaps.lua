vim.env.FZF_DEFAULT_COMMAND = 'find .'
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>FZF -i<cr>',         { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>noh<cr>',            { noremap=true, silent=true })


