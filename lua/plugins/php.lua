return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "php", "phpdoc" },
                highlight = {
                    enable = true,
                },
            })
        end
    },
    {
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("neogen").setup({
                enabled = true,
                languages = {
                    php = {
                        template = {
                            annotation_convention = "phpdoc",
                        },
                    },
                },
                snippet_engine = "luasnip",
            })

            -- Keymaps para geração de documentação
            local opts = { noremap = true, silent = true }
            -- Função/Método
            vim.keymap.set("n", "<Leader>pd", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
            -- Classe
            vim.keymap.set("n", "<Leader>pc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
            -- Tipo
            vim.keymap.set("n", "<Leader>pt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
            -- Arquivo
            vim.keymap.set("n", "<Leader>pf", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
        end
    }
}
