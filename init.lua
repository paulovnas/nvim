--[[
    Configuração principal do Neovim
    Este arquivo contém as configurações básicas, gerenciamento de plugins e atalhos globais.
    Autor: Paulo Vitor
    Data: 2024
--]]

-- Configuração de teclas líderes
-- Espaço como tecla líder principal para comandos personalizados
vim.g.mapleader = " "
-- Barra invertida como tecla líder local para comandos específicos de buffer
vim.g.maplocalleader = "\\"

-- Configurações básicas do editor
vim.opt.number = true          -- Mostra números das linhas
vim.opt.relativenumber = true  -- Números relativos para navegação mais fácil
vim.opt.mouse = 'a'           -- Habilita suporte completo ao mouse
vim.opt.ignorecase = true     -- Ignora maiúsculas/minúsculas na busca
vim.opt.smartcase = true      -- Busca case-sensitive se usar maiúsculas
vim.opt.hlsearch = false      -- Não destaca resultados após a busca
vim.opt.wrap = false          -- Não quebra linhas longas
vim.opt.breakindent = true    -- Mantém indentação em linhas quebradas
vim.opt.tabstop = 4           -- Largura do tab
vim.opt.shiftwidth = 4        -- Largura da indentação
vim.opt.expandtab = true      -- Converte tabs em espaços
vim.opt.termguicolors = true  -- Cores true color no terminal
vim.opt.signcolumn = "yes"    -- Sempre mostra coluna de sinais (git/lsp)
vim.opt.updatetime = 250      -- Reduz tempo de atualização (mais responsivo)
vim.opt.timeoutlen = 300      -- Tempo para completar sequência de teclas
vim.opt.clipboard = "unnamedplus" -- Usa clipboard do sistema

-- Instalação e configuração do lazy.nvim (gerenciador de plugins)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- Clona o repositório do lazy.nvim se não estiver instalado
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",  -- Clone otimizado
        "--branch=stable",     -- Usa versão estável
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)  -- Adiciona lazy.nvim ao runtime path

-- Inicializa o lazy.nvim com as configurações
require("lazy").setup({
    spec = {
        { import = "plugins" },  -- Carrega plugins do diretório lua/plugins
    },
    install = { colorscheme = { "dracula" } },  -- Tema padrão
    checker = { enabled = true },               -- Verifica atualizações
})

-- Configuração de atalhos globais
-- Aguarda 100ms para garantir que os plugins estejam carregados
vim.defer_fn(function()
    -- Atalhos para Telescope (fuzzy finder)
    local ok, telescope = pcall(require, 'telescope.builtin')
    if ok then
        -- <leader>ff - Busca arquivos
        vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Find files' })
        -- <leader>fg - Busca texto em todos os arquivos do diretório atual e subdiretórios
        vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Find text in all files' })
        -- <leader>fr - Busca arquivos recentes
        vim.keymap.set('n', '<leader>fr', telescope.oldfiles, { desc = 'Find recent files' })
    end
end, 100)

--[[
    Atalhos globais:
    <Space> - Tecla líder
    <leader>ff - Busca arquivos
    <leader>fg - Busca texto em todos os arquivos
    <leader>fr - Arquivos recentes
    
    Navegação:
    hjkl - Movimento básico
    <C-u>/<C-d> - Meia página acima/abaixo
    <C-b>/<C-f> - Página inteira acima/abaixo
    gg/G - Início/fim do arquivo
--]]
