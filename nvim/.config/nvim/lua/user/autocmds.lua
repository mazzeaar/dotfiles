-- Formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
    callback = function()
        if #vim.lsp.get_clients({
                bufnr = 0,
                method = "textDocument/formatting"
            }) > 0 then
            vim.lsp.buf.format({
                async = false,
                timeout_ms = 2000,
            })
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})
