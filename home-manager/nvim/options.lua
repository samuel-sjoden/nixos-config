vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

-- vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme "nord"
vim.o.mouse = 'a'

local set = vim.keymap.set

-- Paste from clipboard
set("n", "<leader>y", "\"+y", {desc = 'Copy to Clipboard'})
set("v", "<leader>y", "\"+y", {desc = 'Copy to Clipboard'})
set("n", "<leader>Y", "\"+Y", {desc = 'Copy to Clipboard'})

-- Acess file explorer (netrw)
set("n", "<leader>pv", ":Ex<CR>", {desc = 'Open Netrw'})

-- Search and replace
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = 'Search and replace string under cursor'})

-- Make the current file executable
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true, desc = 'Make Current File Executable'})

-- Telescope remaps
local builtin = require('telescope.builtin')
set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
set('n', '<leader>cm', builtin.git_bcommits, { desc = 'Telescope Git Commits'})
set('n', '<leader>br', builtin.git_branches, { desc = 'Telescope Git branches'})

-- lsp remaps
set("n", "K", vim.lsp.buf.hover, { desc = 'Get information'})
set("n", "gd", vim.lsp.buf.definition, { desc = 'Go to definition'})
set("n", "gr", vim.lsp.buf.references, { desc = 'Go to references'})
set("n", "<leader>rn", vim.lsp.buf.rename, { desc = 'rename all instances in buffer'})

set("n", "[d", vim.diagnostic.goto_prev, { desc = 'go to previous diagnostic'})
set("n", "]d", vim.diagnostic.goto_next, { desc = 'go to next diagnostic'})
set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'open error/warning message'})
set("n", "<leader>E", vim.diagnostic.setloclist, { desc = 'open all errors and warnings in buffer'})


-- Configure LSP clients

  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Set default root markers for all clients
vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = capabilities
})

-- Clangd lsp setup for c and cpp
vim.lsp.config('clangd', {
	cmd = {'clangd'},
	root_markers = {'.clangd', 'compile_commands.json', '.git'},
	filetypes = {'c', 'cpp'},
})

-- pyright for python
vim.lsp.config('pyright', {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = {'python', 'ipynb', 'cfg'}
})

-- ltex-ls for spelling and tex files
vim.lsp.config('ltex', {
	cmd = {'ltex-ls'},
	filetypes = {'markdown', 'tex', 'text', 'gitcommit'}
})

-- Enable lsp clients
vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
vim.lsp.enable('ltex')
