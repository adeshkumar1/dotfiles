local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- appearance
config.macos_window_background_blur = 16
config.font_size = 17
config.color_scheme = "rose-pine"
config.window_background_opacity = 0.7

config.colors = {
	background = "#000",
	cursor_border = "#9B96B5",
}

config.window_frame = {
	border_left_width = "1px",
	border_right_width = "1px",
	border_bottom_height = "1px",
	border_top_height = "1px",
	border_left_color = "white",
	border_right_color = "white",
	border_bottom_color = "white",
	border_top_color = "white",
}

config.window_padding = {
	left = 18,
	right = 15,
	top = 20,
	bottom = 5,
}

config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = true

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0" }

config.keys = {
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bb" }),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bf" }),
	},
}

return config
