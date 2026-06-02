return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSInstall go java ruby bash lua python javascript typescript json yaml html css cpp rust kotlin",
		config = function()
			require("nvim-treesitter").setup({
				auto_install = true,
			})
		end,
	},
}
