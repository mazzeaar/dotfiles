-- File: lua/plugins/lsp.lua

-- Expose utility functions at module level
local diagnostics_enabled = true
local function toggle_diagnostics()
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

local function safe_map_lsp_keybinds(bufnr)
	local ok, keymaps = pcall(require, "user.keymaps")
	if not ok or type(keymaps) ~= "table" then
		vim.notify("Failed to load LSP keymaps", vim.log.levels.WARN)
		return
	end
	if keymaps.map_lsp_keybinds then
		keymaps.map_lsp_keybinds(bufnr)
	end
end

-- Plugin specification
local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"nvim-lua/plenary.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "stevearc/conform.nvim", event = "BufWritePre", cmd = "ConformInfo" },
	},
}

M.config = function()
	-- server configurations
	local servers = {
		clangd = {
			cmd = { "clangd" },
			root_dir = require("lspconfig.util").root_pattern("build/", "compile_flags.txt", ".git", "CMakeLists.txt"),
			filetypes = { "c", "cpp" },
			format = {
				name = "clang_format",
				options = {
					command = "clang-format",
					args = { "--style=file" },
					stdin = true,
				},
				after = function(_, _)
					vim.api.nvim_command("edit!")
					print("[Conform] Reloaded buffer after formatting")
				end,
			},
			disable_formatting = true,
		},

		cmake = {
			filetypes = { "cmake" },
			format = "cmake_format",
		},

		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
					},
					telemetry = { enabled = false },
				},
			},
			filetypes = { "lua" },
			format = "stylua",
		},

		pyright = {
			cmd = { "pyright-langserver", "--stdio" },
			root_dir = require("lspconfig.util").root_pattern(
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				".git"
			),
			filetypes = { "python" },
			format = {
				name = "black",
				options = {
					command = "black",
					args = { "--quiet", "-" },
					stdin = true,
				},
			},
			disable_formatting = true,
		},
	}

	-- Install and configure Mason
	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })

	-- LSP capabilities and handlers
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}

	-- On-attach function
	local on_attach = function(client, bufnr)
		local cfg = servers[client.name]
		if cfg and cfg.disable_formatting then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
		safe_map_lsp_keybinds(bufnr)
	end

	-- Setup each LSP server
	local lspconfig = require("lspconfig")
	for name, cfg in pairs(servers) do
		lspconfig[name].setup(vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		}, cfg))
	end

	-- Collect formatters and setup Conform
	local formatters_by_ft, custom_formatters = {}, {}
	for _, cfg in pairs(servers) do
		if cfg.format then
			local fts = cfg.filetypes or {}
			for _, ft in ipairs(fts) do
				formatters_by_ft[ft] = formatters_by_ft[ft] or {}
				local fname = type(cfg.format) == "string" and cfg.format or cfg.format.name
				table.insert(formatters_by_ft[ft], fname)
				if type(cfg.format) == "table" then
					custom_formatters[fname] = cfg.format.options
					if cfg.format.after then
						custom_formatters[fname].after = cfg.format.after
					end
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

	-- Debug command for formatting
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

	-- Ensure Mason Tool Installer installs servers and formatters
	local tools = vim.tbl_keys(servers)
	for fname, _ in pairs(custom_formatters) do
		table.insert(tools, fname)
	end
	require("mason-tool-installer").setup({
		ensure_installed = tools,
		auto_update = true,
		run_on_start = true,
		start_delay = 3000,
		debounce_hours = 12,
	})

	-- Rounded borders for LSP UI windows
	require("lspconfig.ui.windows").default_options.border = "rounded"

	-- Toggle diagnostics on attach
	vim.api.nvim_create_autocmd("LspAttach", { callback = toggle_diagnostics })
end

-- Expose utilities for external use (e.g., keymaps)
M.toggle_diagnostics = toggle_diagnostics
M.safe_map_lsp_keybinds = safe_map_lsp_keybinds

return M
