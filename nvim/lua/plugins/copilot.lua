if vim.g.location == 'home' then
    return {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = { markdown = true }
        end
    }
else
    return { 'TabbyML/vim-tabby', version = '1.4.0' }
end
