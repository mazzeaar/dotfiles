-- nvim/lua/plugins/cloak.lua

return {
	{
		"laytan/cloak.nvim",
		lazy = false,
		config = function()
			require("cloak").setup()
		end,
	},
}
