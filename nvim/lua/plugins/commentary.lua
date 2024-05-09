return {
    'tpope/vim-commentary',
    config = function()
        vim.api.nvim_command('autocmd FileType vue setlocal commentstring=//\\ %s')
    end
}
