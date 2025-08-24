-- Home configuration
local function get_home_config()
    return {
        {
            'github/copilot.vim',
            config = function()
                vim.g.copilot_filetypes = { markdown = true, Avante = false, AvanteInput = false }
            end
        },
    }
end

-- Work configuration
local function get_work_config()
    return {
    }
end

-- Return the appropriate configuration based on location
if vim.g.location == 'home' then
    return get_home_config()
else
    return get_work_config()
end
