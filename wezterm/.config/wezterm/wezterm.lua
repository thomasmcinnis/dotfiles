local wezterm = require("wezterm")

-- Theme and appearance settings
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

-- Get the built-in Catppuccin Latte scheme
local latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]

-- Modify the scheme with your custom colors
latte.background = "#fafaf9" -- base
latte.foreground = "#292524" -- text

-- Update the color palette
latte.ansi = {
	"#292524", -- black (text)
	"#872744", -- red
	"#2D5C45", -- green
	"#B49B2D", -- yellow
	"#3E5375", -- blue
	"#564858", -- mauve (as purple)
	"#638C79", -- teal (as cyan)
	"#d6d3d1", -- white (overlay1)
}

latte.brights = {
	"#57534e", -- bright black (subtext0)
	"#ca3f6a", -- bright red (flamingo)
	"#638C79", -- bright green (teal)
	"#A27A52", -- bright yellow (peach)
	"#265869", -- bright blue (sapphire)
	"#4C557B", -- bright magenta (lavender)
	"#718E98", -- bright cyan (sky)
	"#e7e7e4", -- bright white (overlay0)
}

-- Custom colors
latte.tab_bar = {
	background = "#eeeeec", -- mantle
	active_tab = {
		bg_color = "#4C557B", -- lavender
		fg_color = "#fafaf9", -- base
	},
	inactive_tab = {
		bg_color = "#f4f4f3", -- surface1
		fg_color = "#292524", -- text
	},
	inactive_tab_hover = {
		bg_color = "#f1f1f0", -- surface2
		fg_color = "#292524", -- text
	},
	new_tab = {
		bg_color = "#f7f7f6", -- surface0
		fg_color = "#292524", -- text
	},
	new_tab_hover = {
		bg_color = "#f1f1f0", -- surface2
		fg_color = "#292524", -- text
	},
}

-- Additional custom colors
latte.cursor_bg = "#292524" -- text
latte.cursor_fg = "#fafaf9" -- base
latte.selection_bg = "#e7e7e4" -- overlay0
latte.selection_fg = "#292524" -- text

-- Navigation and keybinding helpers
local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function is_vim(pane)
	local process_name = pane:get_foreground_process_info().name
	return process_name == "nvim" or process_name == "vim"
end

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				local action = resize_or_move == "resize" and { AdjustPaneSize = { direction_keys[key], 3 } }
					or { ActivatePaneDirection = direction_keys[key] }
				win:perform_action(action, pane)
			end
		end),
	}
end

-- Generate navigation keybindings
local nav_keys = {}
for _, action in ipairs({ "move", "resize" }) do
	for _, key in ipairs({ "h", "j", "k", "l" }) do
		table.insert(nav_keys, split_nav(action, key))
	end
end

-- Generate split key bindings
local split_keys = {
	{
		key = "!",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

-- Combine nav_keys and split_keys
local all_keys = {}
for _, v in ipairs(nav_keys) do
	table.insert(all_keys, v)
end
for _, v in ipairs(split_keys) do
	table.insert(all_keys, v)
end

-- Main configuration
return {
	-- Appearance
	color_schemes = {
		["Catppuccin Latte"] = latte,
	},
	color_scheme = scheme_for_appearance(get_appearance()),
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	inactive_pane_hsb = {
		saturation = 0.6,
		brightness = 0.9,
	},

	-- Font settings
	font_size = 16.0,
	line_height = 1.4,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	-- Window settings
	window_decorations = "RESIZE",
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},

	-- Keybindings and mouse bindings
	keys = all_keys,
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
