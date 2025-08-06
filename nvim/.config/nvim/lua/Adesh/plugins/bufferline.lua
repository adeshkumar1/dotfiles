return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
			},
			highlights = {
				buffer_selected = {
					bg = "#000000",
					fg = "#ea9a97",
					bold = false,
					italic = false,
				},
				info_selected = {
					bold = true,
					italic = true,
				},
			},
		})
		vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>")
	end,
}
