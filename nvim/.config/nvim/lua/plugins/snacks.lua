-- nvim/lua/plugins/snacks.lua

local macchiato = require("catppuccin.palettes").get_palette("macchiato")

vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = macchiato.mauve })

local filtered_message = { "No information available" }

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			{
				"lewis6991/gitsigns.nvim",
				init = function()
					require("gitsigns").setup()
				end,
			},
		},
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dim = { enabled = true },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			animate = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			zen = { enabled = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					local notify = Snacks.notifier.notify
					---@diagnostic disable-next-line: duplicate-set-field
					Snacks.notifier.notify = function(message, level, opts)
						for _, msg in ipairs(filtered_message) do
							if message == msg then
								return nil
							end
						end
						return notify(message, level, opts)
					end
				end,
			})
		end,
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Scratch Buffer",
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame",
			},
			{
				"<leader>go",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Open",
				mode = { "n", "v" },
			},
			{
				"<leader>nh",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>z",
				function()
					Snacks.toggle.dim():toggle()
				end,
				desc = "Zen Mode",
			},
		},
	},
}
