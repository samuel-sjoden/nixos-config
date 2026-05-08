require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		c = { "clang-format" },
		nix = { "alejandra" },
		asm = { "asmfmt" },
		rust = { "rstfmt" },
	},

	formatters = {
		vsg = {
			command = "vsg",
			args = {
				"--fix",
				"--style",
				"indent_only",
				"$FILENAME",
			},
			stdin = false,
		},
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
