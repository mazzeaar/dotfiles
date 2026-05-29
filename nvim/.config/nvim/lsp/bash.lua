local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
end

return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git", ".editorconfig" },
    capabilities = capabilities,
    on_attach = on_attach,
}
