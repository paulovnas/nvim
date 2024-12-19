return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = true,      -- Mostra ícones na coluna de sinais
        sign_priority = 8, -- Prioridade dos sinais
        -- Palavras-chave para destacar
        keywords = {
            FIX = {
                icon = " ",
                color = "error",
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
            fg = "NONE",        -- O grupo de realce para usar para o texto
            bg = "BOLD",        -- O grupo de realce para usar para o fundo
        },
        merge_keywords = true,  -- Mescla palavras-chave customizadas com as padrões
        highlight = {
            multiline = true,   -- Habilita destacar comentários multilinha
            multiline_pattern = "^.", -- Lua pattern para identificar o início do comentário
            multiline_context = 10,   -- Linhas extras para destacar ao redor do comentário
            before = "",       -- "fg" ou "bg" - o que destacar antes da palavra-chave
            keyword = "wide",  -- "fg", "bg", "wide", "wide_bg", "wide_fg" ou vazio
            after = "fg",      -- "fg" ou "bg" - o que destacar depois da palavra-chave
            pattern = [[.*<(KEYWORDS)\s*:]], -- Padrão para destacar (KEYWORDS é substituído)
            comments_only = true,    -- Destacar apenas em comentários
            max_line_len = 400,      -- Ignorar linhas mais longas que isso
            exclude = {},            -- Lista de tipos de arquivo para ignorar
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" }
        },
    }
}
