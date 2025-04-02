-- nvim/.config/nvim/lua/plugins/nvim_tmux_navigator.lua

-- nvim/lua/.config/nvim/lua/plugins/nvim_tmux_navigator.lua

return {
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true,
			})
		end,
	},
}
