return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
		"--suggest-missing-includes",
		"--cross-file-rename",
	},

	root_dir = require("lspconfig.util").root_pattern(
		"build/compile_commands.json",
		"compile_flags.txt",
		".git",
		"CMakeLists.txt"
	),

	format = "clang-format",
}
