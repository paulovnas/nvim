return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'dracula',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    'branch',
                    {
                        'diff',
                        colored = true,
                        diff_color = {
                            added = { fg = '#98be65' },
                            modified = { fg = '#FF8800' },
                            removed = { fg = '#ec5f67' },
                        },
                        symbols = {
                            added = ' ',
                            modified = ' ',
                            removed = ' ',
                        },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            error = { fg = '#ec5f67' },
                            warn  = { fg = '#FF8800' },
                            info  = { fg = '#98be65' },
                            hint  = { fg = '#3bb6c4' },
                        },
                        symbols = {
                            error = ' ',
                            warn = ' ',
                            info = ' ',
                            hint = ' ',
                        },
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1,
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        }
                    }
                },
                lualine_x = {
                    {
                        'filetype',
                        colored = true,
                        icon_only = false,
                    },
                    'encoding',
                    {
                        'fileformat',
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        }
                    }
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {'nvim-tree'}
        }
    end
}
