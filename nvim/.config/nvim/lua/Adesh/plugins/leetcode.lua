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
		config = function(_, opts)
			require("leetcode").setup(opts)

			local function enable_wrap_on_leetcode()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.bo[buf].filetype
					local name = vim.api.nvim_buf_get_name(buf)
					if ft == "leetcode.nvim" or name:match("leetcode") then
						vim.wo[win].wrap = true
						vim.wo[win].linebreak = true
					end
				end
			end

			vim.api.nvim_create_autocmd("WinEnter", {
				callback = enable_wrap_on_leetcode,
			})
			vim.api.nvim_create_autocmd("BufWinEnter", {
				callback = function()
					vim.defer_fn(enable_wrap_on_leetcode, 200)
				end,
			})
		end,
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
