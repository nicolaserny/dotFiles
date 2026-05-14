return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("ibl").setup({ scope = { enabled = false, show_start = false, show_end = false } })
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("nvim-autopairs").setup {} end
    },
    { 'tpope/vim-surround', event = "VeryLazy" },
}
