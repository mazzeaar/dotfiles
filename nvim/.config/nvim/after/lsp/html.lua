local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function on_attach(client, bufnr)
    -- disable all formatting from the HTML LSP
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

return {
    capabilities = capabilities,
    root_markers = {},
    on_attach = on_attach,
}
