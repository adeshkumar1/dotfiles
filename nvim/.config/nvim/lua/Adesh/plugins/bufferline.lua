return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal,
			},
			highlights = {
				background = { fg = "none", bg = "none" },
				buffer = { fg = "none", bg = "none" },
				buffer_visible = { fg = "none", bg = "none" },
				buffer_selected = { fg = "#ea9a97", bg = "none", bold = false, italic = false },
				close_button = { fg = "none", bg = "none" },
				close_button_visible = { fg = "none", bg = "none" },
				close_button_selected = { fg = "none", bg = "none" },
				indicator_visible = { fg = "none", bg = "none" },
				indicator_selected = { fg = "none", bg = "none" },
				modified = { fg = "none", bg = "none" },
				modified_visible = { fg = "none", bg = "none" },
				modified_selected = { fg = "none", bg = "none" },
				duplicate = { fg = "none", bg = "none" },
				duplicate_visible = { fg = "none", bg = "none" },
				duplicate_selected = { fg = "none", bg = "none" },
				separator = { fg = "none", bg = "none" },
				separator_visible = { fg = "none", bg = "none" },
				separator_selected = { fg = "none", bg = "none" },
				tab = { fg = "none", bg = "none" },
				tab_selected = { fg = "none", bg = "none" },
				fill = { fg = "none", bg = "none" },
				info = { fg = "none", bg = "none" },
				info_visible = { fg = "none", bg = "none" },
				info_selected = { bold = true, italic = true, bg = "none" },
			},
		})
		vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "<leader>ba", "<CMD>BufferLineCloseOthers<CR>")
	end,
}
