require('gitsigns').setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<leader>h)', function()
            if vim.wo.diff then return '<leader>h)' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '<leader>h(', function()
            if vim.wo.diff then return '<leader>h(' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
    end
})

vim.keymap.set('n', '<leader>dd', ':Gvdiffsplit!<CR>')
vim.keymap.set('n', '<leader>dl', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>dr', ':diffget //3<CR>')
vim.keymap.set('n', '<leader>dn', ']c')
vim.keymap.set('n', '<leader>dp', '[c')

vim.api.nvim_create_user_command('Gitg', 'Git log --graph --decorate --oneline --all', { nargs = 0 })
vim.keymap.set('n', '<leader>hf', ':Git fetch --all --prune<CR>')
vim.keymap.set('n', '<leader>ha', ':Git add -A<CR>')
