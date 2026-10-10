return {
	cmd = { "typescript-language-server", "--stdio" },

	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},

	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	},

	init_options = {
		preferences = {
			quotePreference = "double",
		},
	},

	settings = {
		typescript = {
			format = {
				indentSize = 2,
				tabSize = 2,
				convertTabsToSpaces = true,
			},
		},
		javascript = {
			format = {
				indentSize = 2,
				tabSize = 2,
				convertTabsToSpaces = true,
			},
		},
	},
}
