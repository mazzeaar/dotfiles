return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
		heading = {
			sign = false,
			icons = {},
		},
	},
	ft = { "markdown", "norg", "rmd", "org" },
	keys = {
		{
			"<leader>tm",
			function()
				require("render-markdown").toggle()
			end,
			desc = "Toggle render-markdown",
		},
	},
}
