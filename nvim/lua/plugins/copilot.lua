-- Common configuration for mcphub.nvim
local mcphub_config = {
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
}

-- Common dependencies for avante.nvim
local avante_dependencies = {
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
}

-- Common configuration for avante.nvim
local function get_avante_common_opts()
    return {
        disabled_tools = {
            "list_files", -- Built-in file operations
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash",
        },
        web_search_engine = {
            provider = "google",
            proxy = nil,
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
    }
end

-- Home configuration
local function get_home_config()
    local avante_opts = get_avante_common_opts()
    avante_opts.provider = "claude"
    avante_opts.auto_suggestions_provider = nil
    avante_opts.claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
    }
    avante_opts.behaviour = {
        auto_suggestions = false,
        auto_apply_diff_after_generation = true,
        enable_claude_text_editor_tool_mode = true,
        use_cwd_as_project_root = true,
        enable_cursor_planning_mode = true,
    }

    return {
        {
            'github/copilot.vim',
            config = function()
                vim.g.copilot_filetypes = { markdown = true, Avante = false, AvanteInput = false }
            end
        },
        mcphub_config,
        {
            "yetone/avante.nvim",
            event = "VeryLazy",
            version = false,
            opts = avante_opts,
            build = "make",
            dependencies = avante_dependencies,
        }
    }
end

-- Work configuration
local function get_work_config()
    local avante_opts = get_avante_common_opts()
    avante_opts.provider = "bedrock" -- Need to install the lastest version of curl with brew
    avante_opts.bedrock = {
        model = "us.anthropic.claude-sonnet-4-20250514-v1:0",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 12288,
    }
    avante_opts.behaviour = {
        auto_apply_diff_after_generation = true,
        enable_claude_text_editor_tool_mode = true,
        use_cwd_as_project_root = true,
        enable_cursor_planning_mode = true,
    }

    return {
        mcphub_config,
        {
            "yetone/avante.nvim",
            event = "VeryLazy",
            version = false,
            opts = avante_opts,
            build = "make",
            dependencies = avante_dependencies,
        }
    }
end

-- Return the appropriate configuration based on location
if vim.g.location == 'home' then
    return get_home_config()
else
    return get_work_config()
end
