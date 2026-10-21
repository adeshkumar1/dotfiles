return {
	"saghen/blink.cmp",
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-y>"] = { "accept", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-d>"] = { "hide_documentation", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		completion = {
			list = { selection = { preselect = true, auto_insert = false } },
			menu = { border = "single" },
			documentation = { auto_show = true, window = { border = "rounded" } },
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
