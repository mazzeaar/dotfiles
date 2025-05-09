-- nvim/lua/user/keymaps.lua

local nnoremap = require("user.old_keymaps.utils").nnoremap
local tnoremap = require("user.old_keymaps.utils").tnoremap
local xnoremap = require("user.old_keymaps.utils").xnoremap

-- === QUALITY OF LIFE ===
nnoremap("U", "<C-r>", { desc = "undo-undo" })

nnoremap("<leader>w", "<cmd>w<cr>", { desc = "Save file", silent = false })
nnoremap("<leader>q", "<cmd>q<cr>", { desc = "Quit", silent = false })
xnoremap("<leader>p", '"_dP', { desc = "Paste without loosing buffer content" })
nnoremap("<leader>no", "<cmd>noh<cr>", { desc = "Turn off highlighted results" })
nnoremap("<leader>S", require("spectre").toggle, { desc = "Global find/replace" })

nnoremap("<leader>e", function()
	require("oil").toggle_float()
end, { desc = "Open file tree" })

nnoremap("<leader>td", function()
	require("plugins.lsp.utils").toggle_diagnostics()
end, { desc = "Toggle LSP Diagnostics" })

nnoremap("<leader>d", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Open the diagnostic under the cursor" })

-- === WINDOW MANAGER ===
nnoremap("<C-j>", function()
	if vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
		vim.cmd.NvimTmuxNavigateDown()
	else
		vim.cmd.wincmd("j")
	end
end, { desc = "Window: down" })

nnoremap("<C-k>", function()
	if vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
		vim.cmd.NvimTmuxNavigateUp()
	else
		vim.cmd.wincmd("k")
	end
end, { desc = "Window: up" })

nnoremap("<C-l>", function()
	if vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
		vim.cmd.NvimTmuxNavigateRight()
	else
		vim.cmd.wincmd("l")
	end
end, { desc = "Window: righ" })

nnoremap("<C-h>", function()
	if vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
		vim.cmd.NvimTmuxNavigateLeft()
	else
		vim.cmd.wincmd("h")
	end
end, { desc = "Window: left" })

-- === TERMINAL ===
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Terminal: normal mode" })
tnoremap("jj", [[<C-\><C-n>]], { desc = "Terminal: normal mode" })

tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Window: left" })
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Window: right" })
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Window: down" })
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Window: up" })

-- === HARPOON ===
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

nnoremap("<leader>ho", harpoon_ui.toggle_quick_menu, { desc = "Harpoon: Open UI" })
nnoremap("<leader>ha", harpoon_mark.add_file, { desc = "Harpoon: Add current file" })
nnoremap("<leader>hr", harpoon_mark.rm_file, { desc = "Harpoon: Remove current file" })
nnoremap("<leader>hc", harpoon_mark.clear_all, { desc = "Harpoon: Remove all files" })

nnoremap("<leader>1", function()
	harpoon_ui.nav_file(1)
end, { desc = "Harpoon: jump 1" })

nnoremap("<leader>2", function()
	harpoon_ui.nav_file(2)
end, { desc = "Harpoon: jump 2" })

nnoremap("<leader>3", function()
	harpoon_ui.nav_file(3)
end, { desc = "Harpoon: jump 3" })

nnoremap("<leader>4", function()
	harpoon_ui.nav_file(4)
end, { desc = "Harpoon: jump 4" })

-- === TELESCOPE ===
local telescope = require("telescope.builtin")

nnoremap("<leader>fb", telescope.buffers, { desc = "Telescope: search buffers" })
nnoremap("<leader>fg", telescope.live_grep, { desc = "Telescope: live grep" })
nnoremap("<leader>fh", telescope.help_tags, { desc = "Telescope: help tags" })

nnoremap("<leader>ff", function()
	telescope.find_files({
		hidden = true,
		no_ignore = true,
		follow = true,
	})
end, { desc = "Telescope: find files" })

-- === EXPERIMENTAL: LSP ===
nnoremap("<leader>gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
nnoremap("<leader>gr", vim.lsp.buf.references, { desc = "LSP: Show references" })
nnoremap("<leader>gi", vim.lsp.buf.implementation, { desc = "LSP: Go to implementation" })
nnoremap("<leader>gt", vim.lsp.buf.type_definition, { desc = "LSP: Go to type definition" })
nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover documentation" })
nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
nnoremap("[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous diagnostic" })
nnoremap("]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
