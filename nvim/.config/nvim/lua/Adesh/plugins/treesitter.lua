return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		main = "nvim-treesitter",
		opts = {
			ensure_installed = {
				"go", "gomod", "java", "ruby", "bash", "lua", "python",
				"javascript", "typescript", "json", "yaml", "html", "css",
				"cpp", "rust", "kotlin",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}
