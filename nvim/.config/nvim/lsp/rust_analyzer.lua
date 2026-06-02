return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = { buildScripts = { enable = true } },
			procMacro = { enable = true },
		},
	},
}
