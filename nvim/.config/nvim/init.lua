-- VIM Options
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.g.mapleader = " "


-- Package Manager
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

-- Load Plugins
require("lazy").setup("plugins")

-- Keymaps

vim.keymap.set("n", "<leader>nt", "<CMD>tabnew<CR>", { desc = "New Tab", silent = true })
vim.keymap.set("n", "<leader>td", "<CMD>tabclose<CR>", { desc = "Close Tab", silent = true }) -- Check the Bufremove configuration

vim.keymap.set("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Prev buffer", silent = true })
vim.keymap.set("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-left>", "<cmd>tabprevious<cr>", { desc = "Prev buffer", silent = true })
vim.keymap.set("n", "<s-right>", "<cmd>tabnext<cr>", { desc = "Next buffer", silent = true })
