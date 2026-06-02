return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate bash html javascript json lua python tsx typescript vim yaml cpp make cmake rust c css kotlin go java ruby",
		config = function()
			require("nvim-treesitter").setup()
		end,
	},
}
