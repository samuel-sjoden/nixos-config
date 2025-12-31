vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'

local set = vim.keymap.set

-- Paste from clipboard
set("n", "<leader>y", "\"+y")
set("v", "<leader>y", "\"+y")
set("n", "<leader>Y", "\"+Y")

-- Acess file explorer (netrw)
set("n", "<leader>pv", ":Ex<CR>")

-- Search and replace
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- Telescope remaps
local builtin = require('telescope.builtin')
set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
set('n', '<leader>cm', builtin.git_bcommits, { desc = 'Telescope Git Commits'})
set('n', '<leader>br', builtin.git_branches, { desc = 'Telescope Git branches'})

