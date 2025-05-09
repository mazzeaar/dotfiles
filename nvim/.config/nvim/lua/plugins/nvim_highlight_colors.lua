-- nvim/lua/plugins/nvim_highlight_colors.lua

return {
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			---Render style
			---@usage 'background'|'foreground'|'virtual'
			render = "background",

			---Highlight hex colors, e.g. '#FFFFFF'
			enable_hex = false,

			---Highlight short hex colors e.g. '#fff'
			enable_short_hex = false,

			---Highlight rgb colors, e.g. 'rgb(0 0 0)'
			enable_rgb = false,

			---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
			enable_hsl = false,

			---Highlight CSS variables, e.g. 'var(--testing-color)'
			enable_var_usage = false,

			---Highlight named colors, e.g. 'green'
			enable_named_colors = false,

			---Highlight tailwind colors, e.g. 'bg-blue-500'
			enable_tailwind = false,
		},
	},
}
