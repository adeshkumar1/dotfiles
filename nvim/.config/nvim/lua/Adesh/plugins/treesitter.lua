return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()

			-- ensure parsers are installed
			local parsers = {
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"python",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"cpp",
				"make",
				"cmake",
				"rust",
				"c",
				"css",
				"kotlin",
			}

			-- install missing parsers
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				once = true,
				callback = function()
					local installed = require("nvim-treesitter").get_installed()
					local installed_set = {}
					for _, lang in ipairs(installed) do
						installed_set[lang] = true
					end
					local to_install = {}
					for _, lang in ipairs(parsers) do
						if not installed_set[lang] then
							table.insert(to_install, lang)
						end
					end
					if #to_install > 0 then
						require("nvim-treesitter").install(to_install)
					end
				end,
			})
		end,
	},
}
