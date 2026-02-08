require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		c = { "clang-format" },
		vhdl = { "ghdl" },
		nix = { "alejandra" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
