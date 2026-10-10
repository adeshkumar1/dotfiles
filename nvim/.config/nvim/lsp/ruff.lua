return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	on_attach = function(client)
		-- basedpyright provides richer hover
		client.server_capabilities.hoverProvider = false
	end,
}
