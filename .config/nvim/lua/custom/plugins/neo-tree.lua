return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"\\",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{
				"<leader>eg",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "[E]xplorer [G]it",
			},
			{
				"<leader>eb",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "[E]xplorer [B]uffer",
			},
			{
				"<leader>ef",
				function()
					require("neo-tree.command").execute({ position = "current", toggle = true })
				end,
				desc = "[E]xplorer [F]ullscreen",
			},
		},
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["h"] = "close_node",
					["l"] = {
						function(state)
							local node = state.tree:get_node()
							if node and node.type == "file" or "directory" then
								require("neo-tree.sources.filesystem.commands").open(state)
								if node.type == "file" then
									vim.cmd("Neotree close")
								end
							end
						end,
						desc = "Open File and Close NeoTree",
					},
					["<space>"] = "none",
					["<CR>"] = "open",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
					["P"] = { "toggle_preview", config = { use_float = false } },
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
		},
	},
}
