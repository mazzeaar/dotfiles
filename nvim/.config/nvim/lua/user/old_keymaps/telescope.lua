local nnoremap = require("user.keymaps.utils").nnoremap

return function()
    local builtin = require("telescope.builtin")

    --[[unused for now

    nnoremap("<leader>?", builtin.oldfiles, { desc = "[?] Recently opened files" })

    nnoremap("<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
    end, { desc = "[/] Fuzzy find in buffer" })

    nnoremap("<leader>ss", function()
        builtin.spell_suggest(require("telescope.themes").get_dropdown({ previewer = false }))
    end, { desc = "[S]pell [S]uggestions" })

    ]] --
end
