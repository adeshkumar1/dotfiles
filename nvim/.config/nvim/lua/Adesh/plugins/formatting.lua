return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				python = { "ruff_organize_imports", "ruff_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				go = { "goimports" },
				java = { "google-java-format" },
				ruby = { "rubocop" },
			},
			formatters = {
				["clang-format"] = {
					command = vim.fn.exepath("clang-format") ~= "" and "clang-format"
						or "/opt/homebrew/opt/llvm/bin/clang-format",
					-- clang-format only searches parent dirs, so files outside $HOME miss ~/.clang-format
					prepend_args = function(_, ctx)
						local global = vim.fn.expand("~/.clang-format")
						if vim.fs.root(ctx.dirname, { ".clang-format", "_clang-format" }) or not vim.uv.fs_stat(global) then
							return {}
						end
						return { "--style=file:" .. global }
					end,
				},
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},
		})
	end,
}
