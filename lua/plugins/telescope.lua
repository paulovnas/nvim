local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<esc>"] = actions.close
                    },
                },
                file_ignore_patterns = {
                    "node_modules",
                    ".git",
                    ".next",
                    "dist",
                    "build"
                },
            },
            pickers = {
                find_files = {
                    hidden = true
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end
                },
            },
        })
    end
}

return M
