local map = vim.keymap.set
local opts = function(desc, extra)
	return vim.tbl_extend("force", { desc = desc, noremap = true, silent = true }, extra or {})
end

-- ==== General keymaps =====
map("n", "<leader>w", "<cmd>w<cr>", opts("Quick Save", { silent = false }))
map("n", "<leader>q", "<cmd>q<cr>", opts("Quick Quit", { silent = false }))
map("n", "<leader>'", "<C-^>", opts("Switch to Last Buffer"))
map("n", "<leader>no", ":nohlsearch<CR>", opts("Clear Search", { silent = true }))
map("v", "<leader>p", '"_dP', opts("Paste without clobbering yank"))
map("v", "<", "<gv", opts("Indent Left"))
map("v", ">", ">gv", opts("Indent Right"))
map("n", "U", "<C-r>", opts("Redo"))
map("n", "<leader>sh", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
end, opts("Split Horizontal and Move"))
map("n", "<leader>sv", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
end, opts("Split Vertical and Move"))
map("n", "<leader>gx", function()
	local url = vim.fn.expand("<cfile>")

	if url:match("^www%.") then
		url = "https://" .. url
	end

	if url:match("^https?://") then
		local opener = vim.fn.has("macunix") == 1 and "open" or vim.fn.has("unix") == 1 and "xdg-open" or nil
		if opener then
			vim.fn.jobstart({ opener, url }, { detach = true })
		else
			print("Don't know how to open links on this system.")
		end
	else
		print("Not a valid URL under cursor: " .. url)
	end
end, { desc = "Open URL under cursor", silent = true })

-- ==== terminal navigation ====
map("t", "<esc>", [[<C-\><C-n>]], opts("Exit Terminal Mode"))
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts("Move Left"))
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts("Move Down"))
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts("Move Up"))
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts("Move Right"))

-- ==== TMUX navigation ====
local function tmux_or_wincmd(cmd, fallback)
	return function()
		if vim.fn.exists(":" .. cmd) ~= 0 then
			vim.cmd(cmd)
		else
			vim.cmd("wincmd " .. fallback)
		end
	end
end
map("n", "<C-h>", tmux_or_wincmd("NvimTmuxNavigateLeft", "h"), opts("Move Left"))
map("n", "<C-j>", tmux_or_wincmd("NvimTmuxNavigateDown", "j"), opts("Move Down"))
map("n", "<C-k>", tmux_or_wincmd("NvimTmuxNavigateUp", "k"), opts("Move Up"))
map("n", "<C-l>", tmux_or_wincmd("NvimTmuxNavigateRight", "l"), opts("Move Right"))
