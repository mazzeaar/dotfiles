return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enabled = true },
		quickfile = { enabled = true },
	},

	keys = {
		{
			"<leader>og",
			function()
				require("snacks").gitbrowse()
			end,
			desc = "Open Git",
		},
		{
			"<leader>gb",
			function()
				require("snacks").git.blame_line()
			end,
			desc = "Git Blame Line",
		},
	},
}
