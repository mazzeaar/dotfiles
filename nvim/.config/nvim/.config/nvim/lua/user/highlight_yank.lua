-- nvim/.config/nvim/lua/user/highlight_yank.lua

-- nvim/lua/.config/nvim/lua/user/highlight_yank.lua

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})
