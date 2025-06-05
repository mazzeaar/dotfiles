-- Lovingly cribbed from kickstart.nvim TJ Devries is a rock star :)

local map = require("user.utils.keymap")

local M = {}

M.lsp_map = map.curry_map("", "LSP", "n")
M.lsp_multi_map = map.curry_map("", "LSP", { "n", "x" })
M.goto_map = function(key, func, desc) M.lsp_map("<leader>g" .. key, func, "Goto " .. desc) end

local function diagnostic_jump_map(key, count, label, severity)
    M.lsp_map(key, function()
        vim.diagnostic.jump({
            count = count,
            float = true,
            severity = severity and { min = severity } or nil,
        })
    end, label)
end

function M.jump_next(key, label, severity)
    diagnostic_jump_map('<leader>n' .. key, 1, "Next " .. label, severity)
end

function M.jump_prev(key, label, severity)
    diagnostic_jump_map('<leader>p' .. key, -1, "Prev " .. label, severity)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            M.lsp_map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
        end
    end,
})

return M
