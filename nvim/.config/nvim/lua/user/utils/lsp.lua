-- Lovingly cribbed from kickstart.nvim TJ Devries is a rock star :)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = vim.keymap.set
        local opts = function(desc, extra)
            return vim.tbl_extend("force", { desc = desc, noremap = true, silent = true }, extra or {})
        end
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client then
            if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

            if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                map("n", "<leader>th", function()
                    require("user.utils.inlay_hints").toggle_inlay_hints(event.buf)
                end, opts("Toggle Inlay Hints"))
            end
        end
    end,
})
