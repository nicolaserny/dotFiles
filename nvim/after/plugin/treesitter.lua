require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    ensure_installed = {
        "tsx",
        "typescript",
        "javascript",
        "toml",
        "json",
        "yaml",
        "html",
        "scss",
        "css",
        "lua",
        "vim",
        "dockerfile",
        "dot",
        "scss",
        "bash",
        "c_sharp",
        "vue",
        "hcl",
        "markdown",
        "markdown_inline",
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    autotag = {
        enable = true,
    }
}

require("treesitter-context").setup {
    enable = true,
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = {
        default = {
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
        },
        typescript = {
            "class_declaration",
            "abstract_class_declaration",
            "else_clause",
        },
    },
}
