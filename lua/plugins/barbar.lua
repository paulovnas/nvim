return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPCIONAL: para integração com git
        'nvim-tree/nvim-web-devicons', -- OPCIONAL: para ícones
    },
    init = function() 
        vim.g.barbar_auto_setup = false 
    end,
    opts = {
        -- Configuração das abas
        animation = true,           -- Animação ao trocar de aba
        clickable = true,          -- Permite clicar nas abas com o mouse
        icons = {
            buffer_index = false,   -- Não mostra números nas abas
            button = '',          -- Ícone do botão de fechar
            separator = {left = '▎', right = ''},  -- Separadores entre abas
            modified = {button = '●'},             -- Indicador de arquivo modificado
            pinned = {button = '車', filename = true}, -- Indicador de aba fixada
        },
    },
    version = '^1.0.0',
}
