vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local home
if vim.fn.has("win32") == 1 then
    home = os.getenv("USERPROFILE")
else
    home = os.getenv("HOME")
end

vim.opt.shortmess = "ac"
vim.opt.preserveindent = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.history = 200
vim.opt.smartindent = true
vim.opt.showcmd = true    -- display incomplete commands
vim.opt.wildmenu = true   -- display completion matches in a status line
vim.opt.ttimeout = true   -- time out for key codes
vim.opt.ttimeoutlen = 100 -- wait up to 100ms after Esc for special key
vim.opt.scrolloff = 5
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.bg = "dark"
vim.opt.pastetoggle = "<F2>"
vim.opt.belloff = "all"
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.previewheight = 5
vim.opt.updatetime = 50

-- Better display for messages
vim.opt.cmdheight = 1

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"

vim.opt.termguicolors = true

-- statusline
vim.opt.laststatus = 2
vim.opt.showtabline = 0
