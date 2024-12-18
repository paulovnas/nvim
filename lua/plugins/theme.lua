local M = {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("dracula").setup({
            transparent_bg = true,
            italic_comment = true,
            show_end_of_buffer = false,
        })
        vim.cmd("colorscheme dracula")
    end,
}

return M
