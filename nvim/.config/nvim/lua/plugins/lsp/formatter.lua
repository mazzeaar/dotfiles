return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	opts = function()
		local utils = require("plugins.lsp.utils")
		local servers = utils.load_server_configs()

		local formatters_by_ft = {}

		for name, config in pairs(servers) do
			if config.format then
				local filetypes = config.filetypes or { name }
				for _, ft in ipairs(filetypes) do
					formatters_by_ft[ft] = formatters_by_ft[ft] or {}
					table.insert(formatters_by_ft[ft], config.format)
				end
			end
		end

		return {
			formatters_by_ft = formatters_by_ft,
			format_after_save = {
				lsp_fallback = true,
			},
		}
	end,
}
