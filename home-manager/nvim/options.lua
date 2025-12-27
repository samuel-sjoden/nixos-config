vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.api.nvim_set_keymap('n', '<leader>t', ':echo "Test Leader Key"<CR>', { noremap = true, silent = true })


vim.o.clipboard = 'unnamedplus'

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'
