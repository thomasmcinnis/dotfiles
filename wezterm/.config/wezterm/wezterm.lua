local wezterm = require("wezterm")

-- Set up custom catppuccin light theme
local latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
latte.background = "#fafaf9"

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

return {
	color_schemes = {
		["Catppuccin Latte"] = latte,
	},
	color_scheme = scheme_for_appearance(get_appearance()),
	enable_tab_bar = false,
	font_size = 16.0,
	line_height = 1.4,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
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
