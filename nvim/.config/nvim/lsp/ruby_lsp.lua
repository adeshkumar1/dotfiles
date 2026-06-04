return {
	cmd = {
		"/usr/lib/rbenv/versions/ae3e1488a5b8485c7b8dfd7adbe076cf3e63be4d_sorbet_ruby_3_3/bin/ruby",
		vim.fn.expand("$HOME") .. "/.local/share/gem/ruby/3.3.0/gems/ruby-lsp-0.4.1/exe/ruby-lsp",
	},
	filetypes = { "ruby", "eruby" },
	root_markers = { "Gemfile", ".git" },
	init_options = {
		formatter = "auto",
		linters = { "rubocop" },
	},
}
