-- Pull in the wezterm API
local wezterm = require("wezterm")
-- nightly build only for now config.color_scheme = 'Kanagawa Dragon (Gogh)'
local scheme_name = "tokyonight_night"

-- MAXIMIZE THE WINDOW ON STARTUP
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- CONFIG
config.audible_bell = "SystemBeep"
config.color_scheme = scheme_name
config.font = wezterm.font("Meslo LG S for Powerline", { weight = "Regular" })
config.font_size = 12.0
config.enable_scroll_bar = false
config.force_reverse_video_cursor = true
config.window_decorations = "NONE"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#3a2222",
	-- tab_bar = {
	-- 	background = "#333333",
	-- 	active_tab = {
	-- 		bg_color = "#111111",
	-- 		fg_color = "#ffffff",
	-- 		intensity = "Normal",
	-- 		underline = "None",
	-- 		italic = false,
	-- 		strikethrough = false,
	-- 	},
	-- 	inactive_tab = {
	-- 		bg_color = "#333333",
	-- 		fg_color = "#999999",
	-- 	},
	-- 	inactive_tab_hover = {
	-- 		bg_color = "#333333",
	-- 		fg_color = "#FFFFFF",
	-- 	},
	-- 	new_tab = {
	-- 		bg_color = "#333333",
	-- 		fg_color = "#999999",
	-- 	},
	-- 	new_tab_hover = {
	-- 		bg_color = "#333333",
	-- 		fg_color = "#999999",
	-- 	},
	-- },
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.tab_and_split_indices_are_zero_based = false
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.5,
}

config.animation_fps = 1
config.cursor_blink_rate = 0
config.enable_wayland = true
config.exit_behavior = "Hold"
config.exit_behavior_messaging = "Brief"
config.front_end = "WebGpu"
config.prefer_to_spawn_tabs = true
config.scrollback_lines = 5000
config.skip_close_confirmation_for_processes_named = {
	"deno",
	"node",
	"nodejs",
}
config.ssh_backend = "LibSsh"
config.max_fps = 60
config.swallow_mouse_click_on_window_focus = false
config.switch_to_last_active_tab_when_closing_tab = true
config.window_padding = {
	bottom = 0,
	left = 0,
	right = 0,
	top = 0,
}
config.tab_max_width = 18
config.term = "wezterm"
config.ui_key_cap_rendering = "WindowsLong"
config.unicode_version = 14
config.use_ime = false
config.warn_about_missing_glyphs = true
config.webgpu_power_preference = "LowPower"
config.window_close_confirmation = "AlwaysPrompt"

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
config.keys = {
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "!",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_tab()
			tab:activate()
		end),
	},
	{
		key = "|",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	local tab_index = tab.tab_index + 1
	title = " " .. tab_index .. ": " .. (title or "")
	title = wezterm.truncate_right(title, max_width - 2) .. " "
	print(config.resolved_palette.tab_bar)
	local active_bg = config.resolved_palette.tab_bar.active_tab.bg_color
	local inactive_bg = config.resolved_palette.tab_bar.inactive_tab.bg_color
	local bg = config.resolved_palette.tab_bar.background

	local arrow_fg
	local arrow_bg

	if tabs[tab_index + 1] and tabs[tab_index + 1].is_active then
		arrow_bg = active_bg
	else
		arrow_bg = inactive_bg
	end

	if not tabs[tab_index + 1] then
		arrow_bg = bg
	end

	if tab.is_active then
		arrow_fg = active_bg
	else
		arrow_fg = inactive_bg
	end

	return {
		{ Text = title },
		{ Background = { Color = arrow_bg } },
		{ Foreground = { Color = arrow_fg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return config
