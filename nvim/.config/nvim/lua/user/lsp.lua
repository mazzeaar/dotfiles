-- lua/user/lsp.lua

local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
    local server_name = vim.fn.fnamemodify(f, ':t:r')
    table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)

local function diagnostic_jump(count, severity)
    return function()
        vim.diagnostic.jump({
            count = count,
            float = true,
            severity = severity and { min = severity } or nil,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(event)
        local map = vim.keymap.set
        local bufnr = event.buf

        local function opts(desc, extra)
            return vim.tbl_extend("force", {
                buffer = bufnr,
                desc = desc,
                noremap = true,
                silent = true,
            }, extra or {})
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        -- Core LSP
        map("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
        map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename Symbol"))
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))

        -- Diagnostics
        local diag_utils = require("user.diagnostics")
        map("n", "<leader>fl", vim.diagnostic.setloclist, opts("Open Diagnostic Loclist"))
        map("n", "<leader>td", diag_utils.toggle_virtual_lines, opts("Toggle Virtual Lines"))

        map("n", "<leader>nd", diagnostic_jump(1), opts("Next Diagnostic"))
        map("n", "<leader>pd", diagnostic_jump(-1), opts("Prev Diagnostic"))
        map("n", "<leader>ne", diagnostic_jump(1, vim.diagnostic.severity.ERROR), opts("Next Error"))
        map("n", "<leader>pe", diagnostic_jump(-1, vim.diagnostic.severity.ERROR), opts("Prev Error"))
        map("n", "<leader>nw", diagnostic_jump(1, vim.diagnostic.severity.WARN), opts("Next Warning"))
        map("n", "<leader>pw", diagnostic_jump(-1, vim.diagnostic.severity.WARN), opts("Prev Warning"))

        -- Inlay hints
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "<leader>th", function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                    { bufnr = bufnr }
                )
            end, opts("Toggle Inlay Hints"))
        end

        -- Document highlight
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                buffer = bufnr,
                group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = false }),
                callback = function(detach_event)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({
                        group = "user-lsp-highlight",
                        buffer = detach_event.buf,
                    })
                end,
            })
        end
    end,
})
