-- lua/plugins/lsp/lsp.lua

return {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"nvim-lua/plenary.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},

	config = function()
		local utils = require("plugins.lsp.utils")
		local servers = utils.load_server_configs()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		}

		local on_attach = function(client, bufnr)
			local config = utils.load_server_configs()[client.name]
			if config and config.disable_formatting then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			utils.safe_map_lsp_keybinds(bufnr)
		end

		require("mason").setup({ ui = { border = "rounded" } })
		require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })

		local lspconfig = require("lspconfig")
		for name, config in pairs(servers) do
			lspconfig[name].setup(vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
				handlers = handlers,
			}, config))
		end

		local tools = vim.tbl_extend("force", vim.tbl_keys(servers), utils.collect_formatters(servers))
		require("mason-tool-installer").setup({
			ensure_installed = tools,
			auto_update = true,
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 12,
		})

		require("lspconfig.ui.windows").default_options.border = "rounded"
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				utils.toggle_diagnostics()
			end,
		})
	end,
}
