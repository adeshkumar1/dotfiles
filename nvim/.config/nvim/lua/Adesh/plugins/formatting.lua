return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
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
				go = { "goimports", "gofmt" },
				java = { "google-java-format" },
				ruby = { "rubocop" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "--style", "{IndentWidth: 4}" },
				},
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},
		})
	end,
}
