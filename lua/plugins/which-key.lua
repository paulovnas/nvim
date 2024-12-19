return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        window = {
            border = "single",
            position = "bottom",
        },
        plugins = { spelling = true },
        defaults = {
            mode = { "n", "v" },
            ["<leader>f"] = { name = "+find" },
            ["<leader>b"] = { name = "+buffer" },
        }
    }
}
