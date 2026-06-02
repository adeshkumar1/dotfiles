return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash", "html", "javascript", "json", "lua", "python",
					"tsx", "typescript", "vim", "yaml", "cpp", "make", "cmake",
					"rust", "c", "css", "kotlin", "go", "java", "ruby",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
