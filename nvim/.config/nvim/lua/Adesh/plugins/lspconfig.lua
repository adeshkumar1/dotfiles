return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "jdtls", "rust_analyzer", "lua_ls", "ts_ls", "kotlin_language_server", "ruff" },
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			local servers = {
				"basedpyright",
				"clangd",
				"gopls",
				"lua_ls",
				"ruff",
				"rust_analyzer",
				"jdtls",
				"ts_ls",
				"kotlin_language_server",
				"ruby_lsp",
				"sorbet",
			}
			for _, name in ipairs(servers) do
				local cmd = vim.lsp.config[name].cmd
				if type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1 then
					vim.lsp.enable(name)
				end
			end

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				virtual_text = true,
				underline = true,
				update_in_insert = false,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
