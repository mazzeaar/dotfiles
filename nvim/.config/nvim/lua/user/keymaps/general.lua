return function()
    local utils = require("user.keymaps.utils")

    local nnoremap = utils.nnoremap
    local vnoremap = utils.vnoremap
    local inoremap = utils.inoremap
    local tnoremap = utils.tnoremap
    local xnoremap = utils.xnoremap

    -- Save with leader key
    nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })

    -- Quit with leader key
    nnoremap("<leader>q", "<cmd>q<cr>", { silent = false })

    -- Turn off highlighted results
    nnoremap("<leader>no", "<cmd>noh<cr>")
end
