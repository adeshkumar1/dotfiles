return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", "compile_flags.txt", "CMakeLists.txt", ".git" },
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
}
