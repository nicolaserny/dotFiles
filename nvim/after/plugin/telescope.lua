local actions = require "telescope.actions"
local trouble = require("trouble.providers.telescope")

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<c-t>"] = trouble.open_with_trouble,
            },
            n = {
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<c-t>"] = trouble.open_with_trouble,
            }
        },
        file_ignore_patterns = {
            "node_modules",
            ".work/.*",
            ".cache/.*",
            ".idea/.*",
            "dist/.*",
            ".git/.*"
        },
    },
    pickers = {
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end
        },
        find_files = {
            find_command = { "rg", "--hidden", "--files" },
            prompt_prefix = "🔍 "
        },
    },
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

function GrepWithCurrentWord()
    builtin.grep_string { search = vim.fn.expand("<cword>") }
end

vim.api.nvim_set_keymap('n', '<leader>fw', '<Cmd>lua GrepWithCurrentWord()<CR>', { noremap = true })

function CommandHistory()
    builtin.command_history({ sorter = require("telescope.sorters").get_substr_matcher() })
end

vim.api.nvim_set_keymap('n', '<leader>fr', '<Cmd>lua CommandHistory()<CR>', { noremap = true })

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fp', builtin.resume, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
