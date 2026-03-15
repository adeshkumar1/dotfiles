return {
	{
		"3rd/image.nvim",
		lazy = false,
		opts = {
			backend = "kitty",
			integrations = {
				markdown = { enabled = true },
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
			lang = "cpp",
			image_support = true,
			injector = {
				["cpp"] = {
					before = {
						"#include <iostream>",
						"#include <vector>",
						"#include <string>",
						"#include <algorithm>",
						"#include <unordered_map>",
						"#include <map>",
						"#include <set>",
						"#include <queue>",
						"#include <deque>",
						"#include <stack>",
						"#include <numeric>",
						"using namespace std;",
					},
				},
			},
			keys = {
				{ "q", "<cmd>Leet exit<cr>", mode = { "n" }, desc = "Exit LeetCode" },
				{ "<leader>lt", "<cmd>Leet test<cr>", mode = { "n" }, desc = "LeetCode Test" },
				{ "<leader>ls", "<cmd>Leet submit<cr>", mode = { "n" }, desc = "LeetCode Submit" },
				{ "<leader>li", "<cmd>Leet info<cr>", mode = { "n" }, desc = "LeetCode Info" },
				{ "<leader>lr", "<cmd>Leet run<cr>", mode = { "n" }, desc = "LeetCode Run" },
			},
		},
	},
}
