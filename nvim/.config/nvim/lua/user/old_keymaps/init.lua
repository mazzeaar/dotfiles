local M = {}

M.utils = require("user.keymaps.utils")

local keymap_modules = {
	"keep_those",
	"general",
	"window",
	"terminal",
	"keymaps",
	"misc_plugins",
	"telescope",
	"lsp",
	"diagnostic",
}

-- Better module loader in keymaps/init.lua
for _, mod in ipairs(keymap_modules) do
	local ok, result = pcall(require, "user.keymaps." .. mod)
	if not ok then
		vim.notify("Failed to load keymap module: " .. mod, vim.log.levels.WARN)
	elseif type(result) == "function" then
		result()
	elseif type(result) == "table" then
		M[mod] = result -- e.g. exposes map_lsp_keybinds
	end
end

return M
