local wezterm = require("wezterm")
local act = wezterm.action
local act_cb = wezterm.action_callback

local shortcuts = {
	{
		-- Create a new tab in the current window in the current domain.
		key = "o",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		-- Splits the active pane in half horizontally such that the current pane becomes the Left half and the new the Right half.
		key = "|",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		-- Splits the current pane in half vertically such that the current pane becomes the top half and the new bottom half spawns a new command.
		key = '"',
		mods = "CTRL|SHIFT",
		action = act.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		-- Creates a new tab in the window and moves active pane into that tab.
		key = "o",
		mods = "CTRL|SHIFT|ALT",
		action = act_cb(function(win, pane)
			local tab, window = pane:move_to_new_tab()
			tab:activate()
		end),
	},
	{
		-- Closes the current tab, terminating all contained panes. If that was the last tab, closes that window. If that was the last window, wezterm terminates.
		key = "y",
		mods = "CTRL|SHIFT|ALT",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		-- Closes the current pane. If that was the last pane in the tab, closes the tab. If that was the last tab, closes that window. If that was the last window, wezterm terminates.
		key = "y",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		-- Activates copy mode (a.k.a Vi mode)
		key = "x",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		-- Activates the Command Palette, a modal overlay that enables discovery and activation of various commands.
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.ActivateCommandPalette,
	},
	{
		-- ActivatePaneDirection activate an adjacent pane in the Left direction.
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		-- ActivatePaneDirection activate an adjacent pane in the Right direction.
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		-- ActivatePaneDirection activate an adjacent pane in the Up direction.
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		-- ActivatePaneDirection activate an adjacent pane in the Down direction.
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}

return shortcuts
