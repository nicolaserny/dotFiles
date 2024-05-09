return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("trouble").setup {}
        vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
            { silent = true, noremap = true }
        )
    end
}
