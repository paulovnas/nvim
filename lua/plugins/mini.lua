return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        -- Auto-pairs: Fecha parênteses, colchetes, etc automaticamente
        require('mini.pairs').setup()
        
        -- Surround: Adiciona/remove/altera caracteres ao redor de texto
        require('mini.surround').setup()
        
        -- Comment: Comenta/descomenta código
        require('mini.comment').setup()
        
        -- Indentscope: Mostra guias de indentação
        require('mini.indentscope').setup({
            symbol = "│",
            options = { try_as_border = true }
        })
        
        -- Files: Gerenciador de arquivos
        require('mini.files').setup()
    end
}
