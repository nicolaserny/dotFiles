return {
    {
        "nvim-java/nvim-java",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require('java').setup({
                jdk = {
                    auto_install = false,
                },
            })
        end,
    },
}
