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
latte.background = "#fafaf9"

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

	-- Font settings
	font_size = 16.0,
	line_height = 1.4,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	-- Window settings
	window_decorations = "RESIZE",
	window_padding = {
		top = 0,
		bottom = 0,
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
