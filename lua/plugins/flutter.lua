return {
    {
        -- Plugin principal para desenvolvimento Flutter
        "akinsho/flutter-tools.nvim",
        lazy = false,  -- Carrega o plugin imediatamente
        dependencies = {
            "nvim-lua/plenary.nvim",    -- Funções utilitárias Lua
            "stevearc/dressing.nvim",   -- UI aprimorada para inputs
        },
        config = function()
            -- Detecta o sistema operacional
            local is_windows = vim.fn.has('win32') == 1
            local flutter_path
            local dart_sdk_path
            local dart_cmd

            -- Configura caminhos baseado no sistema operacional
            if is_windows then
                flutter_path = "D:\\SDK\\flutter\\bin\\flutter.bat"
                dart_sdk_path = "D:\\SDK\\flutter\\bin\\cache\\dart-sdk"
                dart_cmd = { "D:\\SDK\\flutter\\bin\\dart.bat", "language-server", "--protocol=lsp" }
            else
                -- Para macOS/Linux usando ASDF
                local home = os.getenv("HOME")
                flutter_path = home .. "/.asdf/shims/flutter"
                -- Obtém o caminho real do Dart SDK seguindo o shim
                local dart_path = home .. "/.asdf/shims/dart"
                dart_cmd = { dart_path, "language-server", "--protocol=lsp" }
                -- Usa o caminho de instalação do ASDF para o dart_sdk_path
                local flutter_version = vim.fn.trim(vim.fn.system("asdf current flutter | awk '{print $1}'"))
                dart_sdk_path = home .. "/.asdf/installs/flutter/" .. flutter_version .. "/bin/cache/dart-sdk"
            end

            require("flutter-tools").setup({
                -- Configuração da interface do usuário
                ui = {
                    border = "rounded",           -- Bordas arredondadas nos popups
                    notification_style = "native", -- Estilo nativo de notificações
                },
                -- Decorações na statusline
                decorations = {
                    statusline = {
                        app_version = true,  -- Mostra versão do app
                        device = true,       -- Mostra dispositivo atual
                    },
                },
                -- Configuração do debugger
                debugger = {
                    enabled = true,          -- Habilita debugger
                    run_via_dap = true,      -- Usa DAP para debugging
                    register_configurations = function(_)
                        -- Configura o adaptador de debug do Dart
                        require("dap").configurations.dart = {}
                        require("dap").adapters.dart = {
                            type = "executable",
                            command = "dart",
                            args = {"debug_adapter"}
                        }
                    end,
                },
                -- Caminhos do Flutter e Dart SDK
                flutter_path = flutter_path,
                dart_sdk_path = dart_sdk_path,
                
                -- Configuração do LSP (Language Server Protocol)
                lsp = {
                    cmd = dart_cmd,
                    -- Configurações de cores
                    color = {
                        enabled = true,           -- Habilita preview de cores
                        background = true,        -- Mostra cores no background
                        virtual_text = true,      -- Mostra cores no texto virtual
                    },
                    -- Configurações do servidor Dart
                    settings = {
                        showTodos = true,                    -- Mostra TODOs
                        renameFilesWithClasses = "prompt",   -- Pergunta antes de renomear arquivos
                        updateImportsOnRename = true,        -- Atualiza imports ao renomear
                        completeFunctionCalls = true,        -- Completa chamadas de função
                        lineLength = 100,                    -- Comprimento máximo da linha
                    },
                    -- Configuração de atalhos quando o LSP conecta
                    on_attach = function(client, bufnr)
                        -- Keymaps específicos do Flutter
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        
                        -- Comandos Flutter
                        vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>", opts)          -- Executa o app
                        vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", opts)         -- Para o app
                        vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>", opts)      -- Reinicia o app
                        vim.keymap.set("n", "<leader>fD", ":FlutterDevices<CR>", opts)      -- Lista dispositivos
                        vim.keymap.set("n", "<leader>fd", ":FlutterDevTools<CR>", opts)     -- Abre DevTools
                        vim.keymap.set("n", "<leader>fs", function()
                            require("flutter-tools.dev_tools").stop()
                        end, opts)                                                           -- Para DevTools
                        vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", opts)-- Toggle outline
                        
                        -- Atalhos LSP padrão
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)            -- Ir para declaração
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)             -- Ir para definição
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                   -- Mostrar documentação
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)         -- Ir para implementação
                        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)      -- Ajuda de assinatura
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)         -- Renomear símbolo
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)    -- Ações de código
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)             -- Encontrar referências
                        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)          -- Formatar código
                    end,
                },
            })
        end,
    },
    {
        -- Suporte a sintaxe e highlighting
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "dart",
            },
        },
    },
    {
        -- Interface do usuário para debugging
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",    -- Debug Adapter Protocol
            "nvim-neotest/nvim-nio",    -- Async runtime
        },
        config = function()
            require("dapui").setup()
        end
    }
}
