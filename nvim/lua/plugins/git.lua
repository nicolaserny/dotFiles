return {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'tpope/vim-fugitive' },
    config = function()
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

        vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>')
        vim.keymap.set('n', '<leader>gl', ':diffget //2<CR>')
        vim.keymap.set('n', '<leader>gr', ':diffget //3<CR>')
        vim.keymap.set('n', '<leader>gn', ']c')
        vim.keymap.set('n', '<leader>gp', '[c')

        vim.api.nvim_create_user_command('Gitg', 'Git log --graph --decorate --oneline --all', { nargs = 0 })
        vim.keymap.set('n', '<leader>gf', ':Git fetch --all --prune<CR>')
        vim.keymap.set('n', '<leader>ga', ':Git add -A<CR>')
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        vim.cmd [[
            command! NpmCommit !tmux send-keys -t 2 'npm run commit' C-m \; select-window -t 2
        ]]
        vim.api.nvim_set_keymap('n', '<leader>cc', ':NpmCommit<CR>', { noremap = true, silent = true })
    end
}
