local nnoremap = require("user.keymaps.utils").nnoremap

return function()
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
    nnoremap("<leader>=", "<C-w>=", { desc = "Window: resize" })
    nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "Window: rotate" })
end
