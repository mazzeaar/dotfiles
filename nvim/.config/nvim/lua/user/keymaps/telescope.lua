local nnoremap = require("user.keymaps.utils").nnoremap

return function()
	local builtin = require("telescope.builtin")

	nnoremap("<leader>?", builtin.oldfiles, { desc = "[?] Recently opened files" })

	nnoremap("<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })

	nnoremap("<leader>sf", function()
		builtin.find_files({ hidden = true })
	end, { desc = "[S]earch [F]iles" })

	nnoremap("<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

	nnoremap("<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })

	nnoremap("<leader>sc", function()
		builtin.commands(require("telescope.themes").get_dropdown({ previewer = false }))
	end, { desc = "[S]earch [C]ommands" })

	nnoremap("<leader>/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
	end, { desc = "[/] Fuzzy find in buffer" })

	nnoremap("<leader>ss", function()
		builtin.spell_suggest(require("telescope.themes").get_dropdown({ previewer = false }))
	end, { desc = "[S]pell [S]uggestions" })
end

-- Open Spectre for global find/replace for the word under the cursor in normal mode
-- TODO Fix, currently being overriden by Telescope
-- nnoremap("<leader>sw", function()
-- 	require("spectre").open_visual({ select_word = true })
-- end, { desc = "Search current word" })
