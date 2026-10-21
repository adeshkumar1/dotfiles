return {
	{
		"3rd/image.nvim",
		lazy = true,
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

			-- clangd's fallbackFlags apply to C too, so pin C++20 for the solutions dir only
			local home = vim.fn.stdpath("data") .. "/leetcode"
			vim.fn.mkdir(home, "p")
			if not vim.uv.fs_stat(home .. "/compile_flags.txt") then
				vim.fn.writefile({ "-std=c++20", "-Wall", "-Wextra" }, home .. "/compile_flags.txt")
			end

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

			local group = vim.api.nvim_create_augroup("leetcode-wrap", { clear = true })
			vim.api.nvim_create_autocmd("WinEnter", {
				group = group,
				callback = enable_wrap_on_leetcode,
			})
			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = group,
				callback = function()
					vim.defer_fn(enable_wrap_on_leetcode, 200)
				end,
			})
			vim.keymap.set("n", "<leader>'", "<cmd>Leet test<cr>", { desc = "LeetCode Test" })
			vim.keymap.set("n", "<leader><cr>", "<cmd>Leet submit<cr>", { desc = "LeetCode Submit" })
			vim.keymap.set("n", "<leader>z", "<cmd>Leet desc<cr>", { desc = "LeetCode Description" })
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
						"#include <unordered_set>",
						"#include <map>",
						"#include <set>",
						"#include <queue>",
						"#include <deque>",
						"#include <stack>",
						"#include <numeric>",
						"using namespace std;",
					},
					after = {
						"int main() {",
						"    Solution sol;",
						"    return 0;",
						"}",
					},
				},
			},
		},
	},
}
