return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"jdtls",
					"ruby_lsp",
					"rust_analyzer",
					"lua_ls",
					"ts_ls",
					"kotlin_language_server",
					"clangd",
				},
				automatic_installation = true,
			})
		end,
	},
}
