local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "cssls", "diagnosticls", "dockerls", "eslint", "html", "tailwindcss",
    "terraformls", "tsserver", "vimls", "vuels", "lua_ls",
})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
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
    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
end
lsp.on_attach(on_attach);

-- Do not forget to install prettier
-- npm i -g eslint_d prettier
lsp.configure('diagnosticls', {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', "markdown", "vue" },
    init_options = {
        formatters = {
            prettier = {
                command = 'prettier',
                args = { '--stdin', '--stdin-filepath', '%filename' }
            }
        },
        formatFiletypes = {
            css = 'prettier',
            javascript = 'prettier',
            javascriptreact = 'prettier',
            json = 'prettier',
            scss = 'prettier',
            less = 'prettier',
            typescript = 'prettier',
            typescriptreact = 'prettier',
            markdown = 'prettier',
            vue = 'prettier',
        }
    }
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

lsp.setup_nvim_cmp({
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
    }),
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

local saga = require('lspsaga')
saga.setup({
    symbol_in_winbar = {
        enable = true,
        separator = ' ',
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
    },
    ui = {
        theme = 'round',
        border = 'single',
    },
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>)', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<leader>(', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gf', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
