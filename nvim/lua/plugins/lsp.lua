return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

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
        'mhartington/formatter.nvim'
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            -- fix omnisharp bug Invalid character in group name.
            if client.name == 'omnisharp' then
                client.server_capabilities.semanticTokensProvider = {
                    full = vim.empty_dict(),
                    legend = {
                        tokenModifiers = { "static_symbol" },
                        tokenTypes = {
                            "comment",
                            "excluded_code",
                            "identifier",
                            "keyword",
                            "keyword_control",
                            "number",
                            "operator",
                            "operator_overloaded",
                            "preprocessor_keyword",
                            "string",
                            "whitespace",
                            "text",
                            "static_symbol",
                            "preprocessor_text",
                            "punctuation",
                            "string_verbatim",
                            "string_escape_character",
                            "class_name",
                            "delegate_name",
                            "enum_name",
                            "interface_name",
                            "module_name",
                            "struct_name",
                            "type_parameter_name",
                            "field_name",
                            "enum_member_name",
                            "constant_name",
                            "local_name",
                            "parameter_name",
                            "method_name",
                            "extension_method_name",
                            "property_name",
                            "event_name",
                            "namespace_name",
                            "label_name",
                            "xml_doc_comment_attribute_name",
                            "xml_doc_comment_attribute_quotes",
                            "xml_doc_comment_attribute_value",
                            "xml_doc_comment_cdata_section",
                            "xml_doc_comment_comment",
                            "xml_doc_comment_delimiter",
                            "xml_doc_comment_entity_reference",
                            "xml_doc_comment_name",
                            "xml_doc_comment_processing_instruction",
                            "xml_doc_comment_text",
                            "xml_literal_attribute_name",
                            "xml_literal_attribute_quotes",
                            "xml_literal_attribute_value",
                            "xml_literal_cdata_section",
                            "xml_literal_comment",
                            "xml_literal_delimiter",
                            "xml_literal_embedded_expression",
                            "xml_literal_entity_reference",
                            "xml_literal_name",
                            "xml_literal_processing_instruction",
                            "xml_literal_text",
                            "regex_comment",
                            "regex_character_class",
                            "regex_anchor",
                            "regex_quantifier",
                            "regex_grouping",
                            "regex_alternation",
                            "regex_text",
                            "regex_self_escaped_character",
                            "regex_other_escape",
                        },
                    },
                    range = true,
                }
            end
            -- Use prettier for formatting
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            local filetypes = {
                ['javascript'] = true,
                ['javascriptreact'] = true,
                ['typescript'] = true,
                ['typescriptreact'] = true,
                ['vue'] = true,
                ['json'] = true,
                ['css'] = true,
                ['html'] = true,
                ['markdown'] = true,
            }
            if filetypes[filetype] then
                vim.api.nvim_command [[augroup Format]]
                vim.api.nvim_command [[autocmd! * <buffer>]]
                vim.api.nvim_command [[autocmd BufWritePost <buffer> FormatWrite]]
                vim.api.nvim_command [[augroup END]]
            else
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_command [[augroup Format]]
                    vim.api.nvim_command [[autocmd! * <buffer>]]
                    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
                    vim.api.nvim_command [[augroup END]]
                end
            end
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
        end
        lsp_zero.on_attach(on_attach);

        require("fidget").setup({})
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { "cssls", "dockerls", "eslint", "html", "tailwindcss",
                "terraformls", "ts_ls", "vimls", "lua_ls",
            },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    lua_opts.settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' } -- Recognize 'vim' global
                            },
                        },
                    }
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                eslint = function()
                    require('lspconfig').eslint.setup({
                        capabilities = lsp_zero.capabilities,
                        settings = {
                            workingDirectories = { mode = "auto" },
                            experimental = {
                                useFlatConfig = false,
                            }
                        },
                    })
                end,
            }
        })

        require("formatter").setup {
            filetype = {
                javascript = {
                    require("formatter.filetypes.javascript").prettier,
                },
                javascriptreact = {
                    require("formatter.filetypes.javascript").prettier,
                },
                typescript = {
                    require("formatter.filetypes.typescript").prettier,
                },
                typescriptreact = {
                    require("formatter.filetypes.typescript").prettier,
                },
                vue = {
                    require("formatter.filetypes.vue").prettier,
                },
                json = {
                    require("formatter.filetypes.json").prettier,
                },
                css = {
                    require("formatter.filetypes.css").prettier,
                },
                html = {
                    require("formatter.filetypes.html").prettier,
                },
                markdown = {
                    require("formatter.filetypes.markdown").prettier,
                },
            }
        }

        local cmp = require 'cmp'
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
