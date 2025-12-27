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

