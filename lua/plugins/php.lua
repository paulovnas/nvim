return {
    {
        -- Parser de sintaxe para PHP
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",  -- Comando para atualizar os parsers
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Instala os parsers para PHP e PHPDoc
                ensure_installed = { "php", "phpdoc" },
                -- Habilita highlight de sintaxe avançado
                highlight = {
                    enable = true,
                },
            })
        end
    },
    {
        -- Gerador de documentação automática
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",  -- Necessário para análise de código
        },
        config = function()
            require("neogen").setup({
                enabled = true,
                -- Configuração específica para cada linguagem
                languages = {
                    php = {
                        template = {
                            annotation_convention = "phpdoc",  -- Usa o padrão PHPDoc
                        },
                    },
                },
                -- Usa LuaSnip como engine de snippets
                snippet_engine = "luasnip",
            })

            -- Atalhos para geração de documentação
            local opts = { noremap = true, silent = true }
            
            -- Gera documentação para funções/métodos
            -- Exemplo:
            -- /**
            --  * Description
            --  * @param Type $param Description
            --  * @return Type Description
            --  */
            vim.keymap.set("n", "<Leader>pd", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
            
            -- Gera documentação para classes
            -- Exemplo:
            -- /**
            --  * Class Description
            --  * @package Package
            --  */
            vim.keymap.set("n", "<Leader>pc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
            
            -- Gera documentação para tipos (interfaces, traits)
            -- Exemplo:
            -- /**
            --  * Interface/Trait Description
            --  */
            vim.keymap.set("n", "<Leader>pt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
            
            -- Gera documentação para arquivos
            -- Exemplo:
            -- /**
            --  * File Description
            --  * @package Package
            --  * @author Author
            --  */
            vim.keymap.set("n", "<Leader>pf", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
        end
    }
}
