-- Run under Homebrew's CRuby, isolated from RVM's JRuby env (ruby-lsp needs Ruby 3+)
local ruby = "/opt/homebrew/opt/ruby/bin/ruby"
local gem_home = vim.fn.glob("~/.gem/ruby/*", false, true)
gem_home = gem_home[#gem_home] or ""

return {
	cmd = { ruby, gem_home .. "/bin/ruby-lsp" },
	cmd_env = {
		GEM_HOME = gem_home,
		GEM_PATH = gem_home .. ":" .. vim.fn.glob("/opt/homebrew/lib/ruby/gems/*", false, true)[1],
		-- Standalone bundle: our projects pin JRuby/2.x, which ruby-lsp can't compose a bundle against
		BUNDLE_GEMFILE = vim.fn.expand("~/.local/share/ruby-lsp/Gemfile"),
		RUBY_VERSION = "",
		MY_RUBY_HOME = "",
	},
	filetypes = { "ruby", "eruby" },
	root_markers = { "Gemfile", ".git" },
	init_options = {
		formatter = "auto",
		linters = { "rubocop" },
	},
}
