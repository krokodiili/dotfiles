local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ==========================================
-- Colors (mirrors kitty.conf)
-- ==========================================
config.color_scheme = "Dracula"

config.colors = {
	foreground = "#dddddd",
	background = "#000000",
	cursor_bg = "#faff00",
	cursor_fg = "#000000",
	cursor_border = "#faff00",
	-- selection: omitted -> theme default (matches kitty's `selection ... none`)

	tab_bar = {
		background = "#000000",
		active_tab = {
			bg_color = "#000000",
			fg_color = "#faff00",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#6272a4",
		},
		inactive_tab_hover = {
			bg_color = "#1a1a1a",
			fg_color = "#dddddd",
			italic = false,
		},
		new_tab = {
			bg_color = "#000000",
			fg_color = "#6272a4",
		},
		new_tab_hover = {
			bg_color = "#1a1a1a",
			fg_color = "#faff00",
		},
	},
}

-- ==========================================
-- Fonts (mirrors kitty.conf)
-- ==========================================
config.font = wezterm.font("Comic Code Ligatures")
config.font_size = 16.0
config.line_height = 1.05
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

-- ==========================================
-- Window
-- ==========================================
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 14,
	right = 14,
	top = 12,
	bottom = 2,
}

-- ==========================================
-- Tab bar
-- ==========================================
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 40

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	-- Truncate then pad with generous spaces on each side
	if #title > max_width - 6 then
		title = title:sub(1, max_width - 7) .. "…"
	end
	return string.format("   %s   ", title)
end)

-- ==========================================
-- Panes
-- ==========================================
config.inactive_pane_hsb = {
	saturation = 0.85,
	brightness = 0.7,
}

-- ==========================================
-- Behavior (mirrors kitty.conf)
-- ==========================================
config.scrollback_lines = 2000
config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.animation_fps = 60
config.front_end = "WebGpu"

-- Dynamic background opacity (kitty: dynamic_background_opacity 1)
-- Cmd-Shift-= / Cmd-Shift-- adjusts opacity, Cmd-Shift-0 resets
config.keys = {
	{
		key = "=",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window)
			local o = window:get_config_overrides() or {}
			o.window_background_opacity = math.min((o.window_background_opacity or 0.9) + 0.05, 1.0)
			window:set_config_overrides(o)
		end),
	},
	{
		key = "-",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window)
			local o = window:get_config_overrides() or {}
			o.window_background_opacity = math.max((o.window_background_opacity or 0.9) - 0.05, 0.1)
			window:set_config_overrides(o)
		end),
	},
	{
		key = "0",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window)
			window:set_config_overrides({ window_background_opacity = 0.9 })
		end),
	},
}

return config
