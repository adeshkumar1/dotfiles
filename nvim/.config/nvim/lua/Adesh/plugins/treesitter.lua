return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- main branch does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			require("nvim-treesitter").install({
				"go", "gomod", "java", "ruby", "bash", "lua", "python",
				"javascript", "typescript", "json", "yaml", "html", "css",
				"cpp", "c", "rust", "tsx", "toml", "markdown", "markdown_inline",
				"vim", "vimdoc", "query", "diff", "cmake", "make", "doxygen",
			})

			-- The main branch dropped the highlight/indent modules; Neovim owns
			-- highlighting now and both have to be turned on per buffer.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
				callback = function(ev)
					local ok, parser = pcall(vim.treesitter.get_parser, ev.buf)
					if not ok or not parser then
						return
					end

					vim.treesitter.start(ev.buf)

					-- Skip languages with no indents query, otherwise we would
					-- clobber a working indentexpr with a no-op.
					if vim.treesitter.query.get(parser:lang(), "indents") then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
