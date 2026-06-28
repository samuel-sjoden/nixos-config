------------------------------------------
---				OPTIONS
------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.clipboard = "unnamedplus"

vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 12

-- Search settings
vim.o.ignorecase = true
vim.o.hlsearch = false

vim.o.updatetime = 300
vim.o.undofile = true

vim.o.termguicolors = true
-- vim.o.background = "dark"
vim.cmd.colorscheme("kanagawa-paper-ink")
vim.o.mouse = "a"

---------------------------------------------
---					KEYMAPS
---------------------------------------------

local set = vim.keymap.set

-- Paste from clipboard
set("n", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
set("v", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
set("n", "<leader>Y", '"+Y', { desc = "Copy to Clipboard" })

-- Acess file explorer (netrw)
set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw" })

-- Search and replace
set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search and replace string under cursor" }
)

-- Make the current file executable
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make Current File Executable" })

-- Clear highlighting after a search with escape
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Buffer navigation

-- switch between last edited file
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to previous buffer" })
-- traverse through active buffers
set("n", "[b", "<cmd>bprevious<cr>", { desc = "Goto previous buffer" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "Goto next buffer" })

-- indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- copy whole file
set("n", "<C-c>", ":%y+<cr>", { noremap = true, silent = true })

-- Telescope remaps
local builtin = require("telescope.builtin")
set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
set("n", "<leader>cm", builtin.git_bcommits, { desc = "Telescope Git Commits" })
set("n", "<leader>br", builtin.git_branches, { desc = "Telescope Git branches" })

set(
	"n",
	"<leader>ls",
	"<cmd>Neotree toggle source=filesystem position=left<cr>",
	{ desc = "Toggle Neotree for filesystem" }
)

-- lsp remaps
set("n", "K", vim.lsp.buf.hover, { desc = "Get information" })
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename all instances in buffer" })
-- set("n", "F", vim.lsp.buf.format, {desc = 'format the current buffer'})

set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "open error/warning message" })
set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "open all errors and warnings in buffer" })

-------------------------------------------
--	 			AUTOCOMMANDS
------------------------------------------

-- Highlight the yanked text on a yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Go to the last line when a buffer is opened
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(event)
		local _ = { "gitcommit" }
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close some filetypes on <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"lspinfo",
		"checkhealth",
		"qf",
	},
	callback = function(event)
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { buffer = event.buf, silent = true })
	end,
})

--------------------------------------------------
--- 					DIAGNOSTICS
--------------------------------------------------
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

----------------------------------------------------
---					LSP CONFIG
----------------------------------------------------

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Set default root markers for all clients
vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = capabilities,
})

-- Clangd lsp setup for c and cpp
vim.lsp.config("c", {
	cmd = { "clangd" },
	root_markers = { ".clangd", "compile_commands.json", ".git" },
	filetypes = { "c", "cpp" },
})

-- pyright for python
vim.lsp.config("python", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python", "ipynb", "cfg" },
})

-- ltex-ls for spelling and tex files
vim.lsp.config("latex", {
	cmd = { "ltex-ls" },
	filetypes = { "markdown", "tex", "text", "gitcommit" },
})

-- nil for nix files
vim.lsp.config("nix", {
	cmd = { "nil" },
	filetypes = { "nix" },
})

--vhdl-ls for vhdl projects
vim.lsp.config("vhdl", {
	cmd = { "vhdl_ls" },
	root_markers = { ".qsf", "vhdl_ls.toml" },
	filetypes = { "vhdl", "vhd" },
})

vim.lsp.config("lua", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
})

vim.lsp.config("asm", {
	cmd = { "asm-lsp" },
	filetypes = { "asm", "s", "S" },
})

vim.lsp.config("rust", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust", ".rs" },
})

-- Enable lsp clients
-- vim.lsp.enable('*')
vim.lsp.enable("c")
vim.lsp.enable("python")
vim.lsp.enable("latex")
vim.lsp.enable("nix")
vim.lsp.enable("vhdl")
vim.lsp.enable("lua")
vim.lsp.enable("asm")
vim.lsp.enable("rust")
