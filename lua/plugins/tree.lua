return {
    -- Explorador de arquivos em árvore para Neovim
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",  -- Ícones para arquivos e pastas
    },
    config = function()
        -- Desabilita o netrw (explorador de arquivos padrão do Vim)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            -- Configuração de ordenação
            sort = {
                sorter = "case_sensitive",  -- Ordena considerando maiúsculas/minúsculas
            },
            -- Configuração da visualização
            view = {
                width = 30,     -- Largura da árvore em colunas
                side = "left",  -- Posição da árvore (esquerda)
            },
            -- Configuração de filtros
            filters = {
                dotfiles = false,  -- Mostra arquivos que começam com ponto (.)
            },
            -- Configuração do Git
            git = {
                enable = true,   -- Habilita integração com Git
                ignore = false,  -- Mostra arquivos ignorados pelo Git
            },
            -- Configuração de ações
            actions = {
                open_file = {
                    quit_on_open = false,     -- Mantém a árvore aberta ao abrir arquivo
                    window_picker = {
                        enable = false,        -- Desabilita seletor de janela
                    },
                },
            },
            -- Configuração do renderizador
            renderer = {
                group_empty = true,       -- Agrupa diretórios vazios
                highlight_git = true,     -- Destaca status do Git
                icons = {
                    show = {
                        file = true,          -- Mostra ícones de arquivo
                        folder = true,        -- Mostra ícones de pasta
                        folder_arrow = true,  -- Mostra setas de expansão
                        git = true,           -- Mostra ícones de status Git
                    },
                },
            },
        })

        -- Abre o nvim-tree automaticamente ao iniciar
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                -- Verifica se o argumento é um diretório
                local is_directory = vim.fn.isdirectory(vim.fn.argv(0)) == 1
                -- Verifica se não há argumentos
                local no_name = vim.fn.argc() == 0

                -- Se for um diretório, muda para ele
                if is_directory then
                    vim.cmd.cd(vim.fn.argv(0))
                end

                -- Abre a árvore
                require("nvim-tree.api").tree.open()

                -- Se for diretório ou buffer sem nome, volta para a janela principal
                if is_directory or no_name then
                    vim.cmd("wincmd p")
                end
            end
        })
    end
}

-- Atalhos recomendados:
-- <C-n> - Abre/fecha a árvore
-- a - Adiciona arquivo/diretório
-- d - Remove arquivo/diretório
-- r - Renomeia arquivo/diretório
-- x - Corta arquivo/diretório
-- c - Copia arquivo/diretório
-- p - Cola arquivo/diretório
-- y - Copia nome do arquivo
-- Y - Copia caminho relativo
-- gy - Copia caminho absoluto
