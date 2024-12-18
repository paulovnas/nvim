return {
    -- Plugin para uma linha de status bonita e funcional
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'  -- Ícones para arquivos e status
    },
    config = function()
        require('lualine').setup {
            -- Configurações gerais
            options = {
                icons_enabled = true,         -- Habilita ícones
                theme = 'dracula',            -- Tema dracula para combinar com o editor
                component_separators = { left = '', right = ''}, -- Separadores entre componentes
                section_separators = { left = '', right = ''},   -- Separadores entre seções
                disabled_filetypes = {        -- Tipos de arquivo onde a statusline é desabilitada
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},            -- Buffers para ignorar ao mudar foco
                always_divide_middle = true,  -- Sempre divide a linha no meio
                globalstatus = true,          -- Uma única statusline para todas as janelas
                refresh = {                   -- Taxa de atualização em milissegundos
                    statusline = 1000,        -- Atualiza a cada 1 segundo
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            -- Seções da statusline
            sections = {
                -- Seção A (esquerda extrema): Modo do editor
                lualine_a = {'mode'},
                -- Seção B (esquerda): Informações do Git e diagnósticos
                lualine_b = {
                    'branch',  -- Mostra o branch atual do Git
                    {
                        'diff',  -- Mostra mudanças do Git
                        colored = true,
                        diff_color = {
                            added = { fg = '#98be65' },      -- Verde para adições
                            modified = { fg = '#FF8800' },   -- Laranja para modificações
                            removed = { fg = '#ec5f67' },    -- Vermelho para remoções
                        },
                        symbols = {
                            added = ' ',      -- Símbolo para adições
                            modified = ' ',   -- Símbolo para modificações
                            removed = ' ',    -- Símbolo para remoções
                        },
                    },
                    {
                        'diagnostics',  -- Mostra diagnósticos do LSP
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            error = { fg = '#ec5f67' },  -- Vermelho para erros
                            warn  = { fg = '#FF8800' },  -- Laranja para avisos
                            info  = { fg = '#98be65' },  -- Verde para informações
                            hint  = { fg = '#3bb6c4' },  -- Azul para dicas
                        },
                        symbols = {
                            error = ' ',  -- Símbolo para erros
                            warn = ' ',   -- Símbolo para avisos
                            info = ' ',   -- Símbolo para informações
                            hint = ' ',   -- Símbolo para dicas
                        },
                    }
                },
                -- Seção C (centro-esquerda): Nome do arquivo
                lualine_c = {
                    {
                        'filename',
                        file_status = true,  -- Mostra status do arquivo
                        path = 1,            -- 0 = apenas nome, 1 = relativo, 2 = absoluto
                        symbols = {
                            modified = '[+]',     -- Arquivo foi modificado
                            readonly = '[-]',     -- Arquivo é somente leitura
                            unnamed = '[No Name]', -- Buffer sem nome
                            newfile = '[New]',    -- Novo arquivo
                        }
                    }
                },
                -- Seção X (centro-direita): Informações do arquivo
                lualine_x = {
                    {
                        'filetype',           -- Tipo do arquivo
                        colored = true,       -- Colorido baseado no tipo
                        icon_only = false,    -- Mostra texto e ícone
                    },
                    'encoding',              -- Codificação do arquivo (utf-8, etc)
                    {
                        'fileformat',         -- Formato do arquivo
                        symbols = {
                            unix = 'LF',      -- Linux/Mac line endings
                            dos = 'CRLF',     -- Windows line endings
                            mac = 'CR',       -- Classic Mac line endings
                        }
                    }
                },
                -- Seção Y (direita): Progresso no arquivo
                lualine_y = {'progress'},     -- Porcentagem do arquivo
                -- Seção Z (direita extrema): Posição no arquivo
                lualine_z = {'location'}      -- Linha:Coluna
            },
            -- Configuração para janelas inativas
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},    -- Mostra apenas o nome do arquivo
                lualine_x = {'location'},    -- E a posição
                lualine_y = {},
                lualine_z = {}
            },
            -- Configuração da tabline (barra de tabs)
            tabline = {},
            -- Configuração da winbar (barra da janela)
            winbar = {},
            -- Configuração da winbar inativa
            inactive_winbar = {},
            -- Extensões carregadas
            extensions = {'nvim-tree'}
        }
    end
}
