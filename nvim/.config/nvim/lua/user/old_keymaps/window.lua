local nnoremap = require("user.keymaps.utils").nnoremap

return function()
    nnoremap("<leader>m", ":MaximizerToggle<cr>", { desc = "Window: Maximize" })
    nnoremap("<leader>=", "<C-w>=", { desc = "Window: resize" })
    nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "Window: rotate" })
end
