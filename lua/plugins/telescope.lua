return {
    -- Plugin de busca fuzzy altamente extensível
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',  -- Usa a versão estável 0.1.x
    dependencies = {
        'nvim-lua/plenary.nvim',  -- Biblioteca de funções Lua necessária
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            -- Configurações padrão para todos os pickers
            defaults = {
                -- Exibe caminhos truncados para melhor visualização
                path_display = { "truncate" },
                
                -- Atalhos de teclado
                mappings = {
                    i = {  -- Modo de inserção
                        ["<C-k>"] = actions.move_selection_previous,  -- Ctrl+K: item anterior
                        ["<C-j>"] = actions.move_selection_next,      -- Ctrl+J: próximo item
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,  -- Ctrl+Q: envia para quickfix
                        ["<esc>"] = actions.close                     -- ESC: fecha o telescope
                    },
                },
                
                -- Padrões de arquivo a serem ignorados na busca
                file_ignore_patterns = {
                    "node_modules",  -- Módulos do Node.js
                    ".git",          -- Arquivos do Git
                    ".next",         -- Build do Next.js
                    "dist",          -- Diretório de distribuição
                    "build"          -- Diretório de build
                },
            },
            
            -- Configurações específicas para cada picker
            pickers = {
                -- Busca de arquivos (find_files)
                find_files = {
                    hidden = true  -- Inclui arquivos ocultos na busca
                },
                -- Busca por conteúdo (live_grep)
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }  -- Inclui arquivos ocultos no grep
                    end
                },
            },
        })

        -- Atalhos globais recomendados:
        -- <leader>ff - find_files (busca arquivos)
        -- <leader>fg - live_grep (busca conteúdo)
        -- <leader>fb - buffers (lista buffers)
        -- <leader>fh - help_tags (busca na documentação)
    end
}