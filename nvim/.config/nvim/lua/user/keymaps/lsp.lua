-- lua/user/keymaps/lsp.lua
local utils = require("user.keymaps.utils")
local nnoremap, inoremap = utils.nnoremap, utils.inoremap

local telescope = require("telescope.builtin")

local M = {}

function M.map_lsp_keybinds(bufnr)
	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename", buffer = bufnr })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action", buffer = bufnr })

	nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: Goto Definition", buffer = bufnr })
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: Goto Declaration", buffer = bufnr })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition", buffer = bufnr })

	nnoremap("gr", telescope.lsp_references, { desc = "LSP: References", buffer = bufnr })
	nnoremap("gi", telescope.lsp_implementations, { desc = "LSP: Implementations", buffer = bufnr })
	nnoremap("<leader>bs", telescope.lsp_document_symbols, { desc = "LSP: Buffer Symbols", buffer = bufnr })
	nnoremap("<leader>ps", telescope.lsp_workspace_symbols, { desc = "LSP: Project Symbols", buffer = bufnr })

	nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help", buffer = bufnr })
	inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help", buffer = bufnr })
end

return M
