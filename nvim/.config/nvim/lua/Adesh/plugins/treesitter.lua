return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				ensure_installed = {
					"bash",
					"html",
					"javascript",
					"json",
					"lua",
					"python",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"tsx",
					"cpp",
					"make",
					"cmake",
					"rust",
					"c",
					"kotlin",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},
}
