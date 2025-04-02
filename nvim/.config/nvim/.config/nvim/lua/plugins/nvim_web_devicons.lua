-- nvim/.config/nvim/lua/plugins/nvim_web_devicons.lua

-- nvim/lua/.config/nvim/lua/plugins/nvim_web_devicons.lua

return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					gleam = {
						icon = "",
						color = "#ffaff3",
						name = "Gleam",
					},
				},
			})
		end,
	},
}
