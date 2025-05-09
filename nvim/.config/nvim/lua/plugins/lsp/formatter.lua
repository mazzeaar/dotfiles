-- lua/plugins/lsp/formatter.lua

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	config = function()
		local utils = require("plugins.lsp.utils")
		local servers = utils.load_server_configs()

		local formatters_by_ft = {}
		local custom_formatters = {}

		vim.api.nvim_create_user_command("FormatDebug", function()
			local conform = require("conform")
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo[bufnr].filetype
			print("[DEBUG] filetype:", ft)
			print("[DEBUG] buffer name:", vim.api.nvim_buf_get_name(bufnr))
			print("[DEBUG] formatters_by_ft:", vim.inspect(conform.formatters_by_ft[ft]))
			conform.format({
				async = false,
				lsp_fallback = false,
				timeout_ms = 1000,
				on_done = function()
					print("[DEBUG] format done.")
				end,
			})
		end, {})

		for name, config in pairs(servers) do
			if config.format then
				print("Setting up formatter for LSP:", name)
				local filetypes = config.filetypes or {}
				for _, ft in ipairs(filetypes) do
					print(" → attaching to filetype:", ft)
					formatters_by_ft[ft] = formatters_by_ft[ft] or {}
					local formatter_name = type(config.format) == "string" and config.format or config.format.name
					table.insert(formatters_by_ft[ft], formatter_name)
					if type(config.format) == "table" then
						custom_formatters[formatter_name] = config.format.options
					end
				end
			end
		end

		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			formatters = custom_formatters,

			format_after_save = {
				async = true,
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
