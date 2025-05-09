
return function()
	local M = {}
	-- HARPOON --
	local harpoon_mark = require("harpoon.mark")
	local harpoon_ui = require("harpoon.ui")
	local nnoremap = require("user.keymaps.utils").nnoremap

	nnoremap("<leader>ho", harpoon_ui.toggle_quick_menu, { desc = "Harpoon: Open UI" })
	nnoremap("<leader>ha", harpoon_mark.add_file, { desc = "Harpoon: Add current file" })
	nnoremap("<leader>hr", harpoon_mark.rm_file, { desc = "Harpoon: Remove current file" })
	nnoremap("<leader>hc", harpoon_mark.clear_all(), { desc = "Harpoon: Remove all files" })

	nnoremap("<leader>1", harpoon_ui.nav_file(1), { desc = "Harpoon: jump 1" })
	nnoremap("<leader>2", harpoon_ui.nav_file(2), { desc = "Harpoon: jump 2" })
	nnoremap("<leader>3", harpoon_ui.nav_file(3), { desc = "Harpoon: jump 3" })
	nnoremap("<leader>4", harpoon_ui.nav_file(4), { desc = "Harpoon: jump 4" })

	-- QUALITY OF LIFE --
	nnoremap("<leader>e", require("oil").toggle_float, { desc = "Open file tree" })

	return M
end
