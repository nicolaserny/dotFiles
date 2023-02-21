local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

local function encode(str)
    if str == nil then
        return ""
    end
    str = str:gsub("([/. @'~()\"])", char_to_hex)
    return str
end

function DuckDuckGo()
    local url = 'https://duckduckgo.com/?q='
    local query = vim.fn.shellescape(encode(vim.fn.getreg('0')), 1)
    vim.cmd('silent exec "!open \'' .. url .. '".shellescape(' .. query .. ')."' .. '\'"')
end

vim.api.nvim_set_keymap('n', '<leader>k', '<Cmd>lua DuckDuckGo()<CR>', { noremap = true, silent = true })

vim.cmd([[augroup personal]])
vim.cmd([[autocmd!]])
vim.cmd([[
  autocmd BufRead,BufNewFile *.xaml,*.cxml,*.xcml,App.config,NLog.config set filetype=xml
]])
vim.cmd([[autocmd FileType markdown setlocal wrap textwidth=0 colorcolumn=0 spell spelllang=fr,en]])
vim.cmd([[augroup END]])

vim.keymap.set('n', '<leader>es', ':EslintFixAll<CR>')
vim.keymap.set('n', '<leader>ess', ':silent exec "!yarn eslint --fix %"<CR> | redraw')
vim.keymap.set('n', 'cp', ':let @" = expand("%:p")<cr>')

-- Close all other buffers
vim.keymap.set('n', '<leader>o', ':%bd|e#<cr>')
