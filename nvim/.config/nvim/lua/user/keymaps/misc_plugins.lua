return function()
    local nnoremap = require("user.keymaps.utils").nnoremap

    nnoremap("<leader>e", require("oil").toggle_float, { desc = "Open file tree" })
    nnoremap("<leader>S", require("spectre").toggle, { desc = "Global find/replace" })

    nnoremap("zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    nnoremap("zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

    nnoremap("<leader>f", function()
        local ok, conform = pcall(require, "conform")
        if ok then
            conform.format({
                async = true,
                timeout_ms = 500,
                lsp_format = "fallback",
            })
        else
            vim.notify("conform not loaded yet", vim.log.levels.WARN)
        end
    end, { desc = "Format the current buffer" })

    --[[unused for now
        nnoremap("<leader>oc", function()
            require("copilot.panel").open({})
        end, { desc = "[O]pen [C]opilot panel" })

        nnoremap("<leader>tw", function()
            Snacks.toggle.option("wrap")
        end, { desc = "[T]oggle [Wrap]" })
    ]] --
end
