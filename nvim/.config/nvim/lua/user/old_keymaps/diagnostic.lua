return function()
	local nnoremap = require("user.keymaps.utils").nnoremap
	local diagnostic = vim.diagnostic
	local severity = diagnostic.severity

	-- function to make the code less repetitive
	local function diagnostic_nav(key, direction, sev, desc)
		local goto_fn = direction == "next" and diagnostic.goto_next or diagnostic.goto_prev

		nnoremap(key, function()
			goto_fn({ severity = sev })
			vim.cmd("normal! zz")
		end, { desc = desc })
	end

	-- General navigation
	diagnostic_nav("]d", "next", nil, "Next Diagnostic")
	diagnostic_nav("[d", "prev", nil, "Prev Diagnostic")

	-- Error-specific
	diagnostic_nav("]e", "next", severity.ERROR, "Next Error")
	diagnostic_nav("[e", "prev", severity.ERROR, "Prev Error")

	-- Warning-specific
	diagnostic_nav("]w", "next", severity.WARN, "Next Warning")
	diagnostic_nav("[w", "prev", severity.WARN, "Prev Warning")

	nnoremap("<leader>ld", diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
	nnoremap("<leader>cn", ":cnext<cr>zz", { desc = "Navigate to next qflist item" })
	nnoremap("<leader>cp", ":cprevious<cr>zz", { desc = "Navigate to previos qflist item" })
	nnoremap("<leader>co", ":copen<cr>zz", { desc = "Open the qflist" })
	nnoremap("<leader>cc", ":cclose<cr>zz", { desc = "Close the qflist" })

end
