if vim.fn.exists("g:vscode") == 1 then
  vim.g.vscode = true
else
  vim.g.vscode = false
end

-- Initialize Lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- General Vim options
require("vim-options")

-- Lazy.vim opts
local opts = {}

-- Setup plugins
require("lazy").setup("plugins", opts)
