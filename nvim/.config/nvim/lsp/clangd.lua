local llvm_clangd = "/opt/homebrew/opt/llvm/bin/clangd"

return {
	cmd = {
		vim.fn.executable(llvm_clangd) == 1 and llvm_clangd or "clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders=true",
		"--fallback-style=llvm",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "<leader>ch", function()
			local params = vim.lsp.util.make_text_document_params(bufnr)
			client:request("textDocument/switchSourceHeader", params, function(err, uri)
				if err or not uri then
					vim.notify("No matching source/header", vim.log.levels.WARN)
					return
				end
				vim.cmd.edit(vim.uri_to_fname(uri))
			end, bufnr)
		end, { buffer = bufnr, desc = "Switch source/header" })
	end,
}
