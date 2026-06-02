return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				auto_install = true,
			})
			local langs = { "go", "java", "ruby", "bash", "lua", "python", "javascript", "typescript", "json", "yaml", "html", "css", "cpp", "rust", "kotlin" }
			local installed = {}
			for _, l in ipairs(require("nvim-treesitter").installed()) do
				installed[l] = true
			end
			local missing = {}
			for _, l in ipairs(langs) do
				if not installed[l] then
					table.insert(missing, l)
				end
			end
			if #missing > 0 then
				vim.cmd("TSInstall " .. table.concat(missing, " "))
			end
		end,
	},
}
