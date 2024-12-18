return {
    -- Plugin de AI para autocompletar código
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
            -- Evita conflito com o nvim-cmp, mantendo apenas as sugestões inline
            enable_cmp_source = false,
            
            virtual_text = {
                enabled = true,
                -- false = mostra sugestões automaticamente
                -- true = precisa pressionar um atalho para ver sugestões
                manual = false,
                
                -- Habilita para todos os tipos de arquivo por padrão
                default_filetype_enabled = true,
                
                -- Tempo de espera após parar de digitar para mostrar sugestões
                idle_delay = 75,
                
                -- Prioridade alta para garantir que o texto virtual apareça
                -- sobre outros plugins
                virtual_text_priority = 65535,
                
                -- Habilita os atalhos de teclado
                map_keys = true,
                
                -- Configuração dos atalhos
                key_bindings = {
                    accept = "<S-CR>",     -- Shift + Enter para aceitar sugestão
                    accept_word = "<M-w>",  -- Alt + W para aceitar uma palavra
                    accept_line = "<M-k>",  -- Alt + K para aceitar linha inteira
                    next = "<M-j>",         -- Alt + J para próxima sugestão
                    prev = "<M-h>",         -- Alt + H para sugestão anterior
                    clear = "<M-x>",        -- Alt + X para limpar sugestões
                }
            },
            
            -- Configuração para detectar a raiz do projeto
            workspace_root = {
                -- Usa o LSP para detectar a raiz do projeto
                use_lsp = true,
                
                -- Arquivos/pastas que indicam a raiz do projeto
                paths = {
                    ".git",
                    ".hg",
                    "package.json",
                }
            }
        })
    end
}