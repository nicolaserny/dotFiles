return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
    config = function()
        vim.keymap.set('n', '<leader>mp', '<Plug>MarkdownPreview')
        vim.keymap.set('n', '<leader>ms', '<Plug>MarkdownPreviewStop')
    end
}
