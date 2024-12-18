return {
    {
        -- Plugin principal de autocompletar
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- Fonte de completação do LSP
            "hrsh7th/cmp-buffer",        -- Completar palavras do buffer
            "hrsh7th/cmp-path",          -- Completar caminhos de arquivo
            "hrsh7th/cmp-cmdline",       -- Completar na linha de comando
            "L3MON4D3/LuaSnip",         -- Engine de snippets
            "saadparwaiz1/cmp_luasnip", -- Integração do LuaSnip com cmp
            "rafamadriz/friendly-snippets", -- Coleção de snippets
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Carrega snippets do VSCode
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                -- Configuração de snippets
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                
                -- Atalhos de teclado
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),      -- Ctrl+B rola documentação para cima
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),       -- Ctrl+F rola documentação para baixo
                    ['<C-Space>'] = cmp.mapping.complete(),       -- Ctrl+Space força mostrar completações
                    ['<C-e>'] = cmp.mapping.abort(),             -- Ctrl+E fecha o menu de completação
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter confirma a seleção
                    
                    -- Tab avança na lista de sugestões ou expande snippet
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    
                    -- Shift+Tab volta na lista de sugestões
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                
                -- Fontes de sugestões em ordem de prioridade
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },  -- LSP tem prioridade máxima
                    { name = 'luasnip' },   -- Depois vem snippets
                    { name = 'buffer' },     -- Depois palavras do buffer
                    { name = 'path' },       -- Por fim, caminhos de arquivo
                }),
                
                -- Formatação das sugestões no menu
                formatting = {
                    format = function(entry, vim_item)
                        -- Adiciona rótulos para identificar a fonte
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
            })

            -- Configuração específica para a linha de comando (:)
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },    -- Primeiro tenta completar caminhos
                    { name = 'cmdline' }  -- Depois comandos do Vim
                })
            })
        end
    }
}
