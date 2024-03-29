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
        require("nvim-tree").setup()
    end
}
