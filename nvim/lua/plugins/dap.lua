return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        'mfussenegger/nvim-dap',
        "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require('dap')

        require("nvim-dap-virtual-text").setup()

        require("dapui").setup()

        local dapui = require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {
                    os.getenv('HOME') ..
                    '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
                    "${port}" },
            }
        }
        for _, language in ipairs { 'typescript', 'javascript' } do
            dap.configurations[language] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    outputCapture = "std",
                    trace = true
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach',
                    processId = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Debug Jest Tests',
                    -- trace = true, -- include debugger info
                    runtimeExecutable = 'node',
                    runtimeArgs = {
                        './node_modules/jest/bin/jest.js',
                        '--runInBand',
                    },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                },
            }
        end

        -- I have to compile netcoredbg from source to get it to work with apple silicon
        dap.adapters.coreclr = {
            type = 'executable',
            command = '/usr/local/netcoredbg',
            args = { '--interpreter=vscode' }
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            },
            {
                type = 'coreclr',
                request = 'attach',
                name = 'Attach',
                processId = require('dap.utils').pick_process,
            },
        }

        local function load_launchjs()
            require('dap.ext.vscode').load_launchjs(nil, { ['pwa-node'] = { 'javascript', 'typescript' } })
        end

        load_launchjs()

        vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_over()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>di', ':lua require("dap").step_into()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dap").step_out()<CR>',
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dx', ':lua require("dap").clear_breakpoints()<CR>',
            { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>dr', load_launchjs, { noremap = true, silent = true })
    end
}
