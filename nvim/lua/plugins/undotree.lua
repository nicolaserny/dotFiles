return {
    'mbbill/undotree',
    cmd = "UndotreeToggle",
    keys = { "<leader>u" },
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
