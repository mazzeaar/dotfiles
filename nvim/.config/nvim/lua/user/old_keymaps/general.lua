return function()
	local utils = require("user.keymaps.utils")

	-- Normal --
	local nnoremap = utils.nnoremap


	nnoremap("gx", ":sil !open <cWORD><cr>", { desc = "Press gx to open the link under the cursor", silent = true })

	-- Insert --
	local inoremap = utils.inoremap

	inoremap("jj", "<esc>", { desc = "Escape" })
	inoremap("JJ", "<esc>", { desc = "Escape" })
end
