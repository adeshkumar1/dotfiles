return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "pylint" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local available = {}
				for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
					local linter = lint.linters[name]
					local cmd = linter and linter.cmd
					if type(cmd) == "function" then
						cmd = cmd()
					end
					if cmd and vim.fn.executable(cmd) == 1 then
						table.insert(available, name)
					end
				end
				if #available > 0 then
					pcall(lint.try_lint, available)
				end
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
