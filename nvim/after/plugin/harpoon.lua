local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
-- to avoid conflicts with cmp
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- to make it work, I have to set the left option key as esc+ in iterm2
vim.keymap.set("n", "<M-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<M-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<M-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<M-l>", function() ui.nav_file(4) end)
