return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("typescript", { "tsdoc" })
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("typescriptreact", { "tsdoc" })
            ls.filetype_extend("javascriptreact", { "jsdoc" })

            local s = ls.snippet
            local i = ls.insert_node
            local t = ls.text_node
            local themeSnippet = s("snTheme", {
                t("${({theme}) =>"),
                i(1, "ThemeExpression"),
                t(" });"),
            });

            ls.add_snippets("typescriptreact", {
                themeSnippet
            })
            ls.add_snippets("javascriptreact", {
                themeSnippet
            })

            vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }
}
