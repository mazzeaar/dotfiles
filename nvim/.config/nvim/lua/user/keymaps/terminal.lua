local tnoremap = require("user.keymaps.utils").tnoremap

return function()
    tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Terminal: normal mode" })
    tnoremap("jj", [[<C-\><C-n>]], { desc = "Terminal: normal mode" })

    tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Window: left" })
    tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Window: right" })
    tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Window: down" })
    tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Window: up" })
end
