local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
-- to avoid conflicts with cmp
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-e>e", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-e>h", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-e>j", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-e>k", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-e>l", function() ui.nav_file(4) end)
