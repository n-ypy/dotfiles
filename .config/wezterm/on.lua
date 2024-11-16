local wezterm = require("wezterm")
-- MAXIMIZE THE WINDOW ON STARTUP
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	local tab_index = tab.tab_index + 1
	title = " " .. tab_index .. ": " .. (title or "")
	title = wezterm.truncate_right(title, max_width - 2) .. " "
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
