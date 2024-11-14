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
	{
		--AdjustPaneSize manipulates the size of the active pane, allowing the size to be adjusted by 5 in Left direction.
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		--AdjustPaneSize manipulates the size of the active pane, allowing the size to be adjusted by 5 in Right direction.
		key = "l",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		--AdjustPaneSize manipulates the size of the active pane, allowing the size to be adjusted by 5 in Down direction.
		key = "j",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		--AdjustPaneSize manipulates the size of the active pane, allowing the size to be adjusted by 5 in Up direction.
		key = "k",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		-- Decreases the font size of the current window by 10%
		key = "_",
		mods = "CTRL|SHIFT",
		action = act.DecreaseFontSize,
	},
	{
		-- Increases the font size of the current window by 10%
		key = "+",
		mods = "CTRL|SHIFT",
		action = act.IncreaseFontSize,
	},
	{
		-- Reset the font size for the current window to the value in configuration.
		key = ")",
		mods = "CTRL|SHIFT",
		action = act.ResetFontSize,
	},
	{
		-- Activates the Command Palette, a modal overlay that enables discovery and activation of various commands.
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.ActivateCommandPalette,
	},
	{
		-- Activates Quick Select Mode.
		key = " ",
		mods = "CTRL|SHIFT",
		action = act.QuickSelect,
	},
	{
		-- Activates copy mode (a.k.a Vi mode)
		key = "x",
		mods = "CTRL|SHIFT",
		action = act.ActivateCopyMode,
	},
	{
		-- Copy the selection to the clipboard buffer.
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("Clipboard"),
	},
	{
		-- Paste the clipboard to the current pane.
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.PasteFrom("Clipboard"),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(shortcuts, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = act.ActivateTab(i - 1),
	})
end

return shortcuts
