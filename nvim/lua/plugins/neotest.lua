return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-jest",
            "nvim-neotest/neotest-plenary",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-vitest"),
                    require('neotest-jest')({
                        jestCommand = "npm test --",
                        env = { CI = true },
                        cwd = function()
                            return vim.fn.getcwd()
                        end,
                    }),
                    require("neotest-plenary"),
                }
            })

            vim.keymap.set("n", "<leader>tr", function()
                neotest.run.run()
            end)
            vim.keymap.set("n", "<leader>ts", function()
                neotest.summary.toggle()
                vim.keymap.set("n", "<leader>to", function()
                    neotest.output_panel.toggle()
                end)
            end)
        end,
    },
}
