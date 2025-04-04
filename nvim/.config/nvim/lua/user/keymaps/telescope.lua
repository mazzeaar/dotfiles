local nnoremap = require("user.keymaps.utils").nnoremap

return function()
    local builtin = require("telescope.builtin")

    nnoremap("<leader>fb", builtin.buffers, { desc = "Telescope: search buffers" })
    nnoremap("<leader>fg", builtin.live_grep, { desc = "Telescope: live grep" })
    nnoremap("<leader>fh", builtin.help_tags, { desc = "Telescope: help tags" })

    nnoremap("<leader>ff", function()
        builtin.find_files({
            hidden = true,
            no_ignore = true,
            follow = true
        })
    end, { desc = "Telescope: find files" })

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
