local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local function get_cpu_usage()
	local success, stdout, stderr = wezterm.run_child_process({ "mpstat", "1", "1" })
	if success then
		local cpu_usage = 100 - string.gsub(string.sub(stdout, -6), ",", ".")
		return string.format("%.1f%%", cpu_usage)
	end
	return "N/A"
end

local function get_ram_usage()
	local success, stdout, stderr = wezterm.run_child_process({ "free", "-m" })
	if success then
		local total_mem, used_mem = stdout:match("^%D+(%d+)%D+(%d+).*$")
		local ram_usage = used_mem * 100 / total_mem
		return string.format("%.1f%%", ram_usage)
	end
	return "N/A"
end

local function draw_usage_bar(usage_percent)
	if usage_percent == "N/A" then
		return ""
	end
	local bar_size = 8
	local used = "━"
	local unused = "┄"
	local inc = math.ceil(tonumber(string.sub(usage_percent, 1, -2)) * bar_size / 125)
	local bar = string.rep(used, inc, nil) .. string.rep(unused, bar_size - inc, nil)

	return bar
end

local CPU_ICON = wezterm.nerdfonts.oct_cpu
local RAM_ICON = wezterm.nerdfonts.fae_chip
local RIGHT_SOFT_DIVIDER = wezterm.nerdfonts.pl_right_soft_divider
local RIGHT_HARD_DIVIDER = wezterm.nerdfonts.pl_right_hard_divider

local last_update = 0
wezterm.on("update-status", function(window, pane)
	local curr_time = os.time()
	if (curr_time - last_update) < 4 then
		return
	end
	last_update = curr_time
	local cpu_usage = get_cpu_usage()
	local ram_usage = get_ram_usage()
	local cpu_bar = draw_usage_bar(cpu_usage)
	local ram_bar = draw_usage_bar(ram_usage)

	local config = window:effective_config()
	local palette = config.resolved_palette
	local active_bg = palette.tab_bar.active_tab.bg_color
	local active_fg = palette.tab_bar.active_tab.fg_color

	local elements = {
		{ Background = { Color = "rgba(0,255,0,0)" } },
		{ Foreground = { Color = active_bg } },
		{ Text = RIGHT_HARD_DIVIDER },
		{ Foreground = { Color = active_fg } },
		{ Background = { Color = active_bg } },
		{ Text = string.format(" %s ", CPU_ICON) },
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format("%s %s ", cpu_usage, cpu_bar) },
		{ Attribute = { Intensity = "Normal" } },
		{ Text = RIGHT_SOFT_DIVIDER },
		{ Text = string.format(" %s ", RAM_ICON) },
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format("%s %s ", ram_usage, ram_bar) },
	}

	window:set_right_status(wezterm.format(elements))
end)

local LEFT_SOFT_DIVIDER = wezterm.nerdfonts.pl_left_soft_divider
local LEFT_HARD_DIVIDER = wezterm.nerdfonts.pl_left_hard_divider
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	local tab_index = tab.tab_index + 1
	title = title or ""
	title = wezterm.truncate_right(title, max_width - 5) .. " "
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

	local divider
	if not tab.is_active and tabs[tab_index + 1] and not tabs[tab_index + 1].is_active then
		divider = LEFT_SOFT_DIVIDER
		arrow_fg = active_bg
	else
		divider = LEFT_HARD_DIVIDER
	end

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Text = " " .. tab_index .. " " },
		{ Attribute = { Intensity = "Normal" } },
		{ Text = title },
		{ Background = { Color = arrow_bg } },
		{ Foreground = { Color = arrow_fg } },
		{ Text = divider },
	}
end)
