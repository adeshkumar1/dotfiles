return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "jdtls", "rust_analyzer", "lua_ls", "ts_ls", "ruff", "neocmake" },
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
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
				"ruby_lsp",
				"sorbet",
				"neocmake",
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
				virtual_lines = { current_line = true },
				underline = true,
				update_in_insert = false,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf, silent = true, nowait = true }
					vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
					vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
					vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>ci", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
					end, opts)
				end,
			})
		end,
	},
}
