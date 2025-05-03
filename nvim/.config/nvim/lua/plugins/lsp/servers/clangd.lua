-- lua/plugins/lsp/servers/clangd.lua

return {
	cmd = { "clangd" },

	root_dir = require("lspconfig.util").root_pattern(
		"build/compile_commands.json",
		"compile_flags.txt",
		".git",
		"CMakeLists.txt"
	),

	filetypes = { "c", "cpp" },

	format = {
		name = "clang_format",
		options = {
			command = "clang-format",
			args = { "--style=file" },
			stdin = true,
			after = function(_, ctx)
				vim.api.nvim_command("edit!")
				print("[Conform] Reloaded buffer after formatting")
			end,
		},
	},

	disable_formatting = true,
}
