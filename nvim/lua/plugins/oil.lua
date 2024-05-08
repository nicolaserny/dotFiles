return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { 'Oil' },
    keys = {
        { "-", vim.cmd.Oil, desc = "Open parent directory in oil" },
    },
    config = function()
        require("oil").setup()
    end
}
