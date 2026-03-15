return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				disable_background = true,
				disable_nc_background = false,
				disable_float_background = false,
				extend_background_behind_borders = false,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					Normal = { bg = "none" }, -- Main background remains transparent
				},
				enable = {
					terminal = false,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
}
