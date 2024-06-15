local wezterm = require("wezterm")
return {
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 16.0,
	line_height = 1.3,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	-- text_background_opacity = 1.0,
	macos_window_background_blur = 25,
	-- window_background_opacity = 0.92,
	window_background_opacity = 1.0,
	-- window_background_opacity = 0.85,
	window_decorations = "RESIZE",
	window_padding = {
		top = 16,
		bottom = 0,
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
