local wezterm = require("wezterm")
local shortcuts = require("shortcuts")
require("on")
-- nightly build only for now
-- local scheme_name = "Kanagawa Dragon (Gogh)"
local scheme_name = "tokyonight_night"

local config = wezterm.config_builder()
config.keys = shortcuts
config.audible_bell = "SystemBeep"
config.color_scheme = scheme_name
-- config.font = wezterm.font("Meslo LG S for Powerline", { weight = "Regular" })
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Regular" })
config.font_size = 11.5
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
config.status_update_interval = 2000
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
config.webgpu_power_preference = "HighPerformance"
config.window_close_confirmation = "AlwaysPrompt"

return config
