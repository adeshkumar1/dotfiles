return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.3",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go", "gomod", "java", "ruby", "bash", "lua", "python",
					"javascript", "typescript", "json", "yaml", "html", "css",
					"cpp", "rust", "kotlin",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
