-- nvim/lua/user/keymaps.lua

local function bind(op, outer_opts)
	outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

local nnoremap = bind("n")
local xnoremap = bind("x")
local tnoremap = bind("t")

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
	require("plugins.lsp").toggle_diagnostics()
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

nnoremap("<leader>m", ":MaximizerToggle<cr>", { desc = "Window: Maximize" })

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

nnoremap("<leader>5", function()
	harpoon_ui.nav_file(5)
end, { desc = "Harpoon: jump 5" })

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
local M = {}

function M.map_lsp_keybinds(bufnr)
	local opts = { buffer = bufnr }

	nnoremap("<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
	nnoremap("<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to declaration" }))
	nnoremap(
		"<leader>gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" })
	)

	nnoremap("<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Show references" }))
	nnoremap(
		"<leader>gt",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", opts, { desc = "LSP: Go to type definition" })
	)
	nnoremap("<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))
	nnoremap("<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
	nnoremap("K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))

	-- TODO: find better maps for this
	nnoremap("[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "LSP: Previous diagnostic" }))
	nnoremap("]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "LSP: Next diagnostic" }))
end

return M
