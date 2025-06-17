local M = {}

function M.toggle_inlay_hints(bufnr)
    local inlay_hint = vim.lsp.inlay_hint
    inlay_hint.enable(not inlay_hint.is_enabled { bufnr = bufnr })

    local status = inlay_hint.is_enabled { bufnr = bufnr }
    vim.notify(status and "Enabled inlay hints" or "Disabled inlay hints")
end

return M
