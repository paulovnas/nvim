return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            -- override markdown rendering so that codeium and other plugins use Treesitter
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,         -- Usar uma barra de busca mais bonita
            command_palette = true,       -- UI de comandos no estilo VS Code
            long_message_to_split = true, -- Mensagens longas vão para um buffer separado
            inc_rename = false,           -- Desabilita UI de rename incremental
            lsp_doc_border = false,       -- Adiciona borda na documentação do LSP
        },
    }
}
