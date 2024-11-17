local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	-- MAXIMIZE THE WINDOW ON STARTUP
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local function get_cpu_cores()
	local handle = io.popen("nproc")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return tonumber(result) or 1
	end
	return 1
end

local CPU_CORES = get_cpu_cores()

local function get_cpu_usage()
	local handle = io.popen("ps -A -o %cpu | awk '{s+=$1} END {print s}'")
	if handle then
		local result = handle:read("*a")
		handle:close()
		local cpu = tonumber(result)
		if cpu then
			cpu = cpu / CPU_CORES
			return string.format("%.1f%%", math.min(cpu, 100))
		end
	end
	return "N/A"
end

local function get_ram_usage()
	local cmd = [[free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}' ]]
	local handle = io.popen(cmd)
	if handle then
		local result = handle:read("*a")
		handle:close()
		if result and result ~= "" then
			return string.gsub(result, ",", ".")
		end
	end
	return "N/A"
end

local function draw_usage_bar(usage_percent)
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

wezterm.on("update-right-status", function(window, pane)
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
