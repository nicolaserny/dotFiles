if vim.g.location == 'home' then
    return {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = { markdown = true }
        end
    }
else
    return {
        {
            "ravitemer/mcphub.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            cmd = "MCPHub",
            build = "npm install -g mcp-hub@latest",
            config = function()
                require("mcphub").setup({
                    auto_approve = false,
                    extensions = {
                        avante = {
                            make_slash_commands = true,
                        }
                    }
                })
            end,
        },
        {
            "yetone/avante.nvim",
            event = "VeryLazy",
            version = false,
            opts = {
                provider = "bedrock", -- Need to install the lastest version of curl with brew
                bedrock = {
                    model = "anthropic.claude-3-5-sonnet-20240620-v1:0",
                    timeout = 30000, -- Timeout in milliseconds
                    temperature = 0,
                    max_tokens = 20480,
                },
                disabled_tools = { "list_files", -- Built-in file operations
                    "search_files",
                    "read_file",
                    "create_file",
                    "rename_file",
                    "delete_file",
                    "create_dir",
                    "rename_dir",
                    "delete_dir",
                    "bash", },
                web_search_engine = {
                    provider = "google",
                    proxy = nil,
                },
                behaviour = {
                    enable_claude_text_editor_tool_mode = true,
                },
                selector = {
                    provider = "telescope",
                    provider_opts = {},
                },
                system_prompt = function()
                    local hub = require("mcphub").get_hub_instance()
                    return hub:get_active_servers_prompt()
                end,
                custom_tools = function()
                    return {
                        require("mcphub.extensions.avante").mcp_tool(),
                    }
                end,
            },
            build = "make",
            dependencies = {
                "ravitemer/mcphub.nvim",
                "nvim-treesitter/nvim-treesitter",
                "stevearc/dressing.nvim",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                --- The below dependencies are optional,
                "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
                "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
                "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
                {
                    -- support for image pasting
                    "HakonHarnes/img-clip.nvim",
                    event = "VeryLazy",
                    opts = {
                        -- recommended settings
                        default = {
                            embed_image_as_base64 = false,
                            prompt_for_file_name = false,
                            drag_and_drop = {
                                insert_mode = true,
                            },
                            -- required for Windows users
                            use_absolute_path = true,
                        },
                    },
                },
                {
                    -- Make sure to set this up properly if you have lazy=true
                    'MeanderingProgrammer/render-markdown.nvim',
                    opts = {
                        file_types = { "markdown", "Avante" },
                    },
                    ft = { "markdown", "Avante" },
                },
            },
        } }
end
