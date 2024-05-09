return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
    config = function()
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
                "java",
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
    end
}
