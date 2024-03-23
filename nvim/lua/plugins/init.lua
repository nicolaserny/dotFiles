return {
    {
        'EdenEast/nightfox.nvim',
        config = function()
            vim.cmd('colorscheme nightfox')
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.4',
        dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } }
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    'windwp/nvim-ts-autotag',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Misc
            { 'onsails/lspkind-nvim' },
        }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({ scope = { enabled = false, show_start = false, show_end = false } })
        end
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    'lewis6991/gitsigns.nvim',

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end
    },

    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'tpope/vim-commentary',

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },

    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    'folke/zen-mode.nvim',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'mhartington/formatter.nvim',
    'github/copilot.vim',

    'mfussenegger/nvim-dap',
    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
    { "rcarriga/nvim-dap-ui",            dependencies = { "mfussenegger/nvim-dap",  "nvim-neotest/nvim-nio" } },
}
