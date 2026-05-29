return {
	"saghen/blink.cmp",
	version = "1.*",

	opts = {
		keymap = {
			["<C-y>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
			},
		},

		signature = {
			enabled = true,
			window = {
				show_documentation = true,
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},
	},

	opts_extend = {
		"sources.default",
	},
}
