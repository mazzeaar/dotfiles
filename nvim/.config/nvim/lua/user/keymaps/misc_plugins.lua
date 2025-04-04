return function()
    local nnoremap = require("user.keymaps.utils").nnoremap

    -- Map Oil to <leader>e
    nnoremap("<leader>e", function()
        require("oil").toggle_float()
    end)

    -- Open Spectre for global find/replace
    nnoremap("<leader>S", function()
        require("spectre").toggle()
    end)

    -- Open Copilot panel
    nnoremap("<leader>oc", function()
        require("copilot.panel").open({})
    end, { desc = "[O]pen [C]opilot panel" })

    -- nvim-ufo keybinds
    nnoremap("zR", require("ufo").openAllFolds)
    nnoremap("zM", require("ufo").closeAllFolds)

    -- Press leader f to format
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


    nnoremap("<leader>tw", function()
        Snacks.toggle.option("wrap")
    end, { desc = "[T]oggle [Wrap]" })
end
