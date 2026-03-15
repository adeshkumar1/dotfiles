return {
	{
		"3rd/image.nvim",
		lazy = true,
		opts = {
			backend = "kitty",
			integrations = {
				markdown = { enabled = false },
				neorg = { enabled = false },
			},
			tmux_show_only_in_active_window = true,
		},
	},
	{
		"kawre/leetcode.nvim",
		lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		opts = {
			lang = "python3",
			image_support = true,
		},
	},
}
