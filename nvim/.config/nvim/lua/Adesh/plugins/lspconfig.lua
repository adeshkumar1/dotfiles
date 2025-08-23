return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- "saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs, -- Enable signs in the gutter
			},
			virtual_text = true, -- Specify Enable virtual text for diagnostics
			underline = true, -- Specify Underline diagnostics
			update_in_insert = false, -- Keep diagnostics active in insert mode
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Set up LSP keybindings when server attaches
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- LSP keybindings
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			-- vim.keymap.set("n", "<leader>f", function()
			-- 	vim.lsp.buf.format({ async = true })
			-- end, opts)
		end

		-- Mason-lspconfig will automatically setup servers listed in mason.lua
		-- But we can still override settings here

		-- Rust
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					cargo = {
						buildScripts = {
							enable = true,
						},
					},
					procMacro = {
						enable = true,
					},
				},
			},
		})

		-- Kotlin
		lspconfig.kotlin_language_server.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "kotlin" },
			root_dir = lspconfig.util.root_pattern(
				"settings.gradle",
				"settings.gradle.kts",
				"build.gradle",
				"build.gradle.kts",
				".git"
			),
		})

		-- clangd (C/C++ language server)
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- optional: customize cmd or settings
			-- cmd = { "clangd", "--background-index" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
		})

		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			filetypes = { "typescript" },
		})

		-- Config lsp servers here
		-- lua_ls
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
	end,
}
