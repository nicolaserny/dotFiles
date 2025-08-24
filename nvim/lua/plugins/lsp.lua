return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'stevearc/conform.nvim',

        -- LSP Support
        { 'mason-org/mason.nvim' },
        { 'mason-org/mason-lspconfig.nvim' },

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        "L3MON4D3/LuaSnip",

        -- Misc
        'onsails/lspkind-nvim',

        'j-hui/fidget.nvim',

        'nvim-java/nvim-java',
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript      = { "prettier", lsp_format = "fallback" },
                javascriptreact = { "prettier", lsp_format = "fallback" },
                typescript      = { "prettier", lsp_format = "fallback" },
                typescriptreact = { "prettier", lsp_format = "fallback" },
                vue             = { "prettier", lsp_format = "fallback" },
                json            = { "prettier", lsp_format = "fallback" },
                css             = { "prettier", lsp_format = "fallback" },
                html            = { "prettier", lsp_format = "fallback" },
                markdown        = { "prettier", lsp_format = "fallback" },
                java            = { "google-java-format", lsp_format = "fallback" },
                kotlin          = { "ktlint", lsp_format = "fallback" },
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })

        -- Mason v2: Global LSP capabilities configuration
        vim.lsp.config("*", {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )
        })

        local cmp = require('cmp')

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>)", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>(", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-v>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })

        require("fidget").setup({})
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { "cssls", "dockerls", "eslint", "html", "tailwindcss",
                "terraformls", "ts_ls", "vimls", "lua_ls", "kotlin_language_server"
            },
            automatic_enable = true,
        })

        local lspkind = require 'lspkind'
        local source_mapping = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buffer]",
        }
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    local menu = source_mapping[entry.source.name]
                    vim_item.menu = menu
                    return vim_item
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<Tab>'] = vim.NIL,
                ['<S-Tab>'] = vim.NIL,
                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        })

        vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
    end
}
