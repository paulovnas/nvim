return {
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require("flutter-tools").setup({
                ui = {
                    border = "rounded",
                    notification_style = "native",
                },
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                    },
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    register_configurations = function(_)
                        require("dap").configurations.dart = {}
                        require("dap").adapters.dart = {
                            type = "executable",
                            command = "dart",
                            args = {"debug_adapter"}
                        }
                    end,
                },
                flutter_path = "D:\\SDK\\flutter\\bin\\flutter.bat",
                dart_sdk_path = "D:\\SDK\\flutter\\bin\\cache\\dart-sdk",
                lsp = {
                    cmd = { "D:\\SDK\\flutter\\bin\\dart.bat", "language-server", "--protocol=lsp" },
                    color = {
                        enabled = true,
                        background = true,
                        virtual_text = true,
                    },
                    settings = {
                        showTodos = true,
                        renameFilesWithClasses = "prompt",
                        updateImportsOnRename = true,
                        completeFunctionCalls = true,
                        lineLength = 100,
                    },
                    on_attach = function(client, bufnr)
                        -- Keymaps específicos do Flutter
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        
                        -- Flutter commands
                        vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>", opts)
                        vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", opts)
                        vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>", opts)
                        vim.keymap.set("n", "<leader>fD", ":FlutterDevices<CR>", opts)
                        vim.keymap.set("n", "<leader>fd", ":FlutterDevTools<CR>", opts)
                        vim.keymap.set("n", "<leader>fs", function()
                            require("flutter-tools.dev_tools").stop()
                        end, opts)
                        vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", opts)
                        
                        -- LSP keymaps
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
                    end,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "dart",
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "nvim-neotest/nvim-nio",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dapui").setup()
            
            -- Keymaps para debugging
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>", opts)
            vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", opts)
            vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", opts)
            vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", opts)
            vim.keymap.set("n", "<leader>dO", ":DapStepOut<CR>", opts)
            vim.keymap.set("n", "<leader>dr", ":DapToggleRepl<CR>", opts)
            vim.keymap.set("n", "<leader>dl", ":DapShowLog<CR>", opts)
            vim.keymap.set("n", "<leader>du", function()
                require("dapui").toggle()
            end, opts)
        end,
    },
}
