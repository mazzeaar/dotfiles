-- nvim/lua/user/toggle_diagnostics.lua

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	Snacks.toggle.diagnostics():toggle()
end, {})
