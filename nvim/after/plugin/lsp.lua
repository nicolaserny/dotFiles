local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "cssls", "dockerls", "eslint", "html", "tailwindcss",
    "terraformls", "tsserver", "vimls", "vuels", "lua_ls",
})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    -- Use prettier for formatting
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
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
lsp.on_attach(on_attach);

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
    },
    on_attach = on_attach,
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}
)

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
}
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = vim.NIL,
    ['<S-Tab>'] = vim.NIL,
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end
    },
})

lsp.setup()

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
