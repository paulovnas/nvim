return {
    {
        -- Gerenciador de instalação de LSP, DAP, linters e formatters
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",   -- Pacote instalado
                        package_pending = "➜",     -- Instalação pendente
                        package_uninstalled = "✗"  -- Pacote não instalado
                    }
                }
            })
        end
    },
    {
        -- Integração do Mason com o LSP
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "intelephense" },  -- Instala automaticamente o LSP do PHP
                automatic_installation = true,          -- Instala LSPs automaticamente quando necessário
            })
        end
    },
    {
        -- Configuração dos servidores LSP
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",           -- Gerenciador de instalação
            "williamboman/mason-lspconfig.nvim", -- Integração Mason + LSP
            "hrsh7th/cmp-nvim-lsp",             -- Integração LSP + nvim-cmp
        },
        config = function()
            local lspconfig = require("lspconfig")
            -- Configura capacidades do LSP para trabalhar com nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Configuração do Intelephense (PHP Language Server)
            lspconfig.intelephense.setup({
                capabilities = capabilities,
                -- Configuração de caminhos para armazenamento
                init_options = {
                    storagePath = vim.fn.stdpath("data") .. "/intelephense",        -- Cache local
                    globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",  -- Cache global
                    licenceKey = nil,                                                -- Chave de licença (opcional)
                },
                settings = {
                    intelephense = {
                        -- Versão do PHP
                        environment = {
                            phpVersion = '8.2'  -- Define versão do PHP para análise
                        },
                        -- Configuração de arquivos
                        files = {
                            maxSize = 5000000,  -- Tamanho máximo de arquivo (5MB)
                            associations = {"*.php", "*.phtml", "*.inc", "*.module"},  -- Extensões suportadas
                        },
                        -- Configuração de documentação
                        phpdoc = {
                            returnVoid = false,                 -- Não adiciona @return void automaticamente
                            useFullyQualifiedNames = true,     -- Usa nomes completamente qualificados
                        },
                        -- Configuração de autocompletar
                        completion = {
                            insertUseDeclaration = true,       -- Insere use statements automaticamente
                            fullyQualifyGlobalConstantsAndFunctions = true,  -- Qualifica constantes/funções globais
                            triggerParameterHints = true,      -- Mostra dicas de parâmetros
                            maxItems = 100,                    -- Máximo de itens no menu
                        },
                        -- Formatação de código
                        format = {
                            enable = true  -- Habilita formatação
                        },
                        -- Diagnósticos (erros, warnings, etc)
                        diagnostics = {
                            enable = true,  -- Habilita diagnósticos
                        },
                        -- Stubs para funções internas e frameworks
                        stubs = {
                            -- PHP Core
                            "apache", "bcmath", "bz2", "calendar",
                            "com_dotnet", "Core", "ctype", "curl", "date",
                            "dba", "dom", "enchant", "exif", "fileinfo",
                            "filter", "fpm", "ftp", "gd", "hash", "iconv",
                            "imap", "interbase", "intl", "json", "ldap",
                            "libxml", "mbstring", "mcrypt", "meta", "mssql",
                            "mysqli", "oci8", "odbc", "openssl", "pcntl",
                            "pcre", "PDO", "pdo_ibm", "pdo_mysql",
                            "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar",
                            "posix", "pspell", "readline", "recode",
                            "Reflection", "regex", "session", "shmop",
                            "SimpleXML", "snmp", "soap", "sockets", "sodium",
                            "SPL", "sqlite3", "standard", "superglobals",
                            "sybase", "sysvmsg", "sysvsem", "sysvshm",
                            "tidy", "tokenizer", "wddx", "xml", "xmlreader",
                            "xmlrpc", "xmlwriter", "xsl", "Zend OPcache",
                            "zip", "zlib",
                            -- Frameworks e ferramentas
                            "wordpress", "phpunit", "laravel"
                        },
                    },
                },
            })

            -- Atalhos globais do LSP
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })         -- Ir para declaração
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })          -- Ir para definição
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })             -- Mostrar documentação
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })   -- Ir para implementação
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })     -- Ajuda de assinatura
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })               -- Renomear símbolo
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })     -- Ações de código
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })          -- Encontrar referências
            vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format code' })           -- Formatar código
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' }) -- Mostrar diagnósticos

            -- Configuração global de diagnósticos
            -- Configura como os diagnósticos devem ser exibidos no editor
            vim.diagnostic.config({
                -- Mostra diagnósticos como texto virtual ao lado do código
                virtual_text = true,      
                -- Mostra ícones na coluna de sinal
                signs = true,             
                -- Sublinha o texto com problema
                underline = true,         
                -- Não atualiza diagnósticos no modo de inserção
                update_in_insert = false, 
                -- Ordena por severidade (erro > aviso > info > dica)
                severity_sort = true,     
            })

            -- Configura ícones para diferentes tipos de diagnóstico
            -- Define os ícones para cada tipo de diagnóstico
            local signs = {
                -- Ícone para erros
                Error = " ", 
                -- Ícone para avisos
                Warn = " ",  
                -- Ícone para dicas
                Hint = " ", 
                -- Ícone para informações
                Info = " "   
            }
            -- Define os ícones para cada tipo de diagnóstico
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end
    }
}
