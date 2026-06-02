return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSInstall go java ruby bash lua python javascript typescript json yaml html css cpp rust kotlin",
		config = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				once = true,
				callback = function()
					vim.cmd("silent! TSInstall go java ruby bash lua python javascript typescript json yaml html css cpp rust kotlin")
				end,
			})
		end,
	},
}
