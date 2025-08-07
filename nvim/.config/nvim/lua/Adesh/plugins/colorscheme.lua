return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- priority = 1000,
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
					-- ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" }, -- Main background remains transparent
					-- Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
					-- PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
					-- PmenuSbar = { bg = "#191724" }, -- Scrollbar background
					-- PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
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
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})

			-- vim.cmd("colorscheme kanagawa")
		end,
	},
	-- Lazy
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true,
				},
			})
		end,
	},
}
