return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>h", group = "Git Hunk" },
			{ "<leader>l", group = "Lazygit" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>c", group = "Code" },
			{ "<leader>g", group = "Git" },
		},
	},
}
