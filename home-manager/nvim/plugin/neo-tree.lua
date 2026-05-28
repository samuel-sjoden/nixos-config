require("neo-tree").setup({
	hide_dotfiles = false,
})

-- Keybinds
local set = vim.keymap.set

set("n", "<leader>cc", "<cmd>Neotree toggle source=filesystem position=left")
