-- Defina o líder antes de carregar o lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configurações básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.clipboard = "unnamedplus"

-- Configure o caminho para o lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Carregue o lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { colorscheme = { "dracula" } },
    checker = { enabled = true },
})

-- Configurar keymaps após um delay para garantir que os plugins estejam carregados
vim.defer_fn(function()
    -- Keymaps para Telescope
    local ok, telescope = pcall(require, 'telescope.builtin')
    if ok then
        vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Find text' })
        vim.keymap.set('n', '<leader>fr', telescope.oldfiles, { desc = 'Find recent files' })
    end
end, 100)
