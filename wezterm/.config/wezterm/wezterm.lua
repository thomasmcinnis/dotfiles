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

-- Custom Catppuccin Latte theme
local latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
latte.rosewater = "#543D4F"
latte.flamingo = "#ca3f6a"
latte.red = "#872744"
latte.maroon = "#793252"
latte.pink = "#803449"
latte.mauve = "#564858"
latte.peach = "#843840"
latte.yellow = "#7d5424"
latte.green = "#31473c"
latte.teal = "#284542"
latte.sky = "#254248"
latte.sapphire = "#25414a"
latte.blue = "#2c3d4c"
latte.lavender = "#35384a"
latte.text = "#292524"
latte.subtext1 = "#44403c"
latte.subtext0 = "#57534e"
latte.overlay2 = "#a8a29e"
latte.overlay1 = "#d6d3d1"
latte.overlay0 = "#e7e7e4"
latte.surface2 = "#d6d3d1"
latte.surface1 = "#e7e7e4"
latte.surface0 = "#f1f1f1"
latte.base = "#fafaf9"
latte.mantle = "#f1f1f1"
latte.crust = "#e7e5e4"

latte.background = latte.base
latte.tab_bar = {
	background = latte.overlay1,
	active_tab = {
		bg_color = latte.pink,
		fg_color = latte.base,
	},
	inactive_tab = {
		bg_color = latte.subtext0,
		fg_color = latte.overlay1,
	},
	inactive_tab_hover = {
		bg_color = latte.mauve,
		fg_color = latte.base,
	},
	new_tab = {
		bg_color = latte.surface1,
		fg_color = latte.pink,
	},
	new_tab_hover = {
		bg_color = latte.surface0,
		fg_color = latte.red,
	},
	innactive_tab_edge = latte.flamingo,
}

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
