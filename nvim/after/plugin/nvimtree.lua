require("nvim-tree").setup()

vim.keymap.set('n', '<C-b>', vim.cmd.NvimTreeToggle)
vim.keymap.set('n', '<leader>r', vim.cmd.NvimTreeRefresh)
vim.keymap.set('n', '<leader>n', vim.cmd.NvimTreeFindFile)
