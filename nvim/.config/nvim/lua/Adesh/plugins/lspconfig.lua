return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Add Mason bin to PATH so vim.lsp.enable can find installed servers
		vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config
		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- LSP keybindings on attach
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

		-- Server configurations using vim.lsp.config
		vim.lsp.config("rust_analyzer", {
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

		vim.lsp.config("kotlin_language_server", {
			capabilities = capabilities,
			filetypes = { "kotlin" },
			root_markers = {
				"settings.gradle",
				"settings.gradle.kts",
				"build.gradle",
				"build.gradle.kts",
				".git",
			},
		})

		vim.lsp.config("clangd", {
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--fallback-style=llvm",
				"--query-driver=/usr/bin/*,/usr/local/bin/*,/opt/homebrew/bin/*",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
		})

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
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

		vim.lsp.config("gopls", {
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		vim.lsp.config("jdtls", {
			capabilities = capabilities,
			filetypes = { "java" },
			root_markers = { "build.gradle", "pom.xml", ".git" },
		})

		vim.lsp.config("ruby_lsp", {
			capabilities = capabilities,
			filetypes = { "ruby" },
			root_markers = { "Gemfile", ".git" },
		})

		-- Enable all configured servers
		vim.lsp.enable({
			"rust_analyzer",
			"kotlin_language_server",
			"ts_ls",
			"lua_ls",
			"gopls",
			"jdtls",
		})
	end,
}
