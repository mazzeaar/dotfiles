return function()
    local utils = require("user.keymaps.utils")

    local vnoremap = utils.vnoremap
    local tnoremap = utils.tnoremap
    local xnoremap = utils.xnoremap

    -- Normal --
    local nnoremap = utils.nnoremap

    nnoremap("<leader>w", "<cmd>w<cr>", { desc = "Save file", silent = false, })
    nnoremap("<leader>q", "<cmd>q<cr>", { desc = "Quit", silent = false, })
    nnoremap("U", "<C-r>", { desc = "undo-undo" })

    nnoremap("<leader>no", "<cmd>noh<cr>", { desc = "Turn off highlighted results" })
    nnoremap("gx", ":sil !open <cWORD><cr>", { desc = "Press gx to open the link under the cursor", silent = true })

    -- Insert --
    local inoremap = utils.inoremap

    inoremap("jj", "<esc>", { desc = "Escape" })
    inoremap("JJ", "<esc>", { desc = "Escape" })
end
