return {
    -- Tema Dracula para Neovim: esquema de cores escuro e moderno
    "Mofiqul/dracula.nvim",
    lazy = false,    -- Carrega o tema imediatamente
    priority = 1000, -- Alta prioridade para garantir que seja carregado primeiro
    config = function()
        require("dracula").setup({
            -- Configurações do tema
            transparent_bg = true,      -- Fundo transparente (usa cor do terminal)
            italic_comment = true,      -- Comentários em itálico
            show_end_of_buffer = false, -- Não mostra '~' no final do buffer
        })
        -- Aplica o tema
        vim.cmd("colorscheme dracula")
    end,
}