local utils = require("plugins.lsp.utils")

local M = {}

function M.setup()
    local servers = utils.load_server_configs()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    }

    local on_attach = function(client, bufnr)
        local config = require("plugins.lsp.utils").load_server_configs()[client.name]
        if config and config.disable_formatting then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
        require("plugins.lsp.utils").safe_map_lsp_keybinds(bufnr)
    end

    -- Setup Mason
    require("mason").setup({ ui = { border = "rounded" } })
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })

    -- Setup each server
    for name, config in pairs(servers) do
        local lspconfig = require("lspconfig")
        lspconfig[name].setup(vim.tbl_deep_extend("force", {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
        }, config))
    end

    -- Setup formatter installation
    local tools = vim.tbl_extend("force", vim.tbl_keys(servers), utils.collect_formatters(servers))
    require("mason-tool-installer").setup({
        ensure_installed = tools,
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
    })

    -- Diagnostic UI
    require("lspconfig.ui.windows").default_options.border = "rounded"
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
            vim.diagnostic.config({
                virtual_text = { prefix = "●", spacing = 2 },
                signs = true,
                underline = true,
                severity_sort = true,
                update_in_insert = false,
                float = { border = "rounded", source = "always" },
            })
        end,
    })
end

return M
