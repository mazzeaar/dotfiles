-- Formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
    callback = function()
        -- Format only if there's at least one LSP client with formatting capability
        if #vim.lsp.get_clients({
                bufnr = 0,
                method = "textDocument/formatting"
            }) > 0 then
            vim.lsp.buf.format({ async = false })
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})
