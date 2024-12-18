return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "intelephense" },
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Configuração do Intelephense
            lspconfig.intelephense.setup({
                capabilities = capabilities,
                init_options = {
                    storagePath = vim.fn.stdpath("data") .. "/intelephense",
                    globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
                    licenceKey = nil,
                },
                settings = {
                    intelephense = {
                        environment = {
                            phpVersion = '8.2'
                        },
                        files = {
                            maxSize = 5000000,
                            associations = {"*.php", "*.phtml", "*.inc", "*.module"},
                        },
                        phpdoc = {
                            returnVoid = false,
                            useFullyQualifiedNames = true,
                        },
                        completion = {
                            insertUseDeclaration = true,
                            fullyQualifyGlobalConstantsAndFunctions = true,
                            triggerParameterHints = true,
                            maxItems = 100,
                        },
                        format = {
                            enable = true
                        },
                        diagnostics = {
                            enable = true,
                        },
                        stubs = {
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
                            "zip", "zlib", "wordpress", "phpunit", "laravel"
                        },
                    },
                },
            })

            -- Keymaps LSP
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
            vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format code' })
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

            -- Configuração de diagnóstico
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Ícones de diagnóstico
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end
    }
}
