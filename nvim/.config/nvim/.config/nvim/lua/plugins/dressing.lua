-- nvim/.config/nvim/lua/plugins/dressing.lua

-- nvim/lua/.config/nvim/lua/plugins/dressing.lua

return {
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},
}
