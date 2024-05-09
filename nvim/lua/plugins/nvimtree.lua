return {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeRefresh' },
    keys = {
        { "<C-b>",     vim.cmd.NvimTreeToggle,   desc = "NeoTree" },
        { "<leader>n", vim.cmd.NvimTreeFindFile, desc = "NeoTree find file" },
        { "<leader>r", vim.cmd.NvimTreeRefresh,  desc = "NeoTree refresh" },
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        if vim.g.location == 'home' then
            require("nvim-tree").setup()
        else
            require("nvim-tree").setup({
                view = {
                    width = 40,
                    side = "left",
                }
            })
        end
    end
}
