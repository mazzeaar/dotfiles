-- lua/plugins/lsp/utils.lua

local M = {}

local scan = require("plenary.scandir")
function M.toggle_diagnostics()
	diagnostics_enabled = not diagnostics_enabled
	vim.diagnostic.config({
		virtual_text = diagnostics_enabled and { prefix = "●", spacing = 2 } or false,
		signs = diagnostics_enabled,
		underline = diagnostics_enabled,
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "always" },
	})

	vim.notify("Diagnostics " .. (diagnostics_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

function M.safe_map_lsp_keybinds(bufnr)
	local ok, keymaps = pcall(require, "user.keymaps")
	if not ok then
		vim.notify("Failed to load LSP keymaps: " .. keymaps, vim.log.levels.WARN)
		return
	end

	if keymaps.map_lsp_keybinds then
		keymaps.map_lsp_keybinds(bufnr)
	end
end

function M.load_server_configs()
	local configs = {}
	local path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/servers"
	for _, file in ipairs(scan.scan_dir(path, { depth = 1, add_extension = false })) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		local ok, config = pcall(require, "plugins.lsp.servers." .. name)
		if ok then
			configs[name] = config
		else
			vim.notify("Failed to load LSP config: " .. name, vim.log.levels.ERROR)
		end
	end
	return configs
end

function M.collect_formatters(configs)
	local formatters = {}
	for _, cfg in pairs(configs) do
		if cfg.format then
			table.insert(formatters, cfg.format)
		end
	end
	return formatters
end

return M
