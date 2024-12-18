return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- Desabilita o netrw no início
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
                side = "left",
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
                ignore = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    window_picker = {
                        enable = false,
                    },
                },
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
        })

        -- Abre o nvim-tree automaticamente ao iniciar
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                local is_directory = vim.fn.isdirectory(vim.fn.argv(0)) == 1
                local no_name = vim.fn.argc() == 0

                if is_directory then
                    vim.cmd.cd(vim.fn.argv(0))
                end

                require("nvim-tree.api").tree.open()

                if is_directory or no_name then
                    vim.cmd("wincmd p")
                end
            end
        })
    end
}
