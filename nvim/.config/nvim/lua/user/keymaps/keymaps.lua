-- nvim/lua/user/keymaps.lua

return function()
    local utils = require("user.keymaps.utils")

    local nnoremap = utils.nnoremap
    local vnoremap = utils.vnoremap
    local inoremap = utils.inoremap
    local tnoremap = utils.tnoremap
    local xnoremap = utils.xnoremap

    local M = {}

    -- Normal --
    -- Disable Space bar since it'll be used as the leader key
    nnoremap("<space>", "<nop>")

    -- Window +  better kitty navigation
    nnoremap("<C-j>", function()
        if vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
            vim.cmd.NvimTmuxNavigateDown()
        else
            vim.cmd.wincmd("j")
        end
    end)

    nnoremap("<C-k>", function()
        if vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
            vim.cmd.NvimTmuxNavigateUp()
        else
            vim.cmd.wincmd("k")
        end
    end)

    nnoremap("<C-l>", function()
        if vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
            vim.cmd.NvimTmuxNavigateRight()
        else
            vim.cmd.wincmd("l")
        end
    end)

    nnoremap("<C-h>", function()
        if vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
            vim.cmd.NvimTmuxNavigateLeft()
        else
            vim.cmd.wincmd("h")
        end
    end)

    -- Swap between last two buffers
    nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })


    -- Map Undotree to <leader>
    nnoremap("<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle [U]ndo[T]ree " })

    -- Center buffer while navigating
    nnoremap("<C-u>", "<C-u>zz")
    nnoremap("<C-d>", "<C-d>zz")
    -- nnoremap("{", "{zz")
    -- nnoremap("}", "}zz")
    nnoremap("N", "Nzz")
    nnoremap("n", "nzz")
    nnoremap("G", "Gzz")
    nnoremap("gg", "ggzz")
    nnoremap("gd", "gdzz")
    nnoremap("<C-i>", "<C-i>zz")
    nnoremap("<C-o>", "<C-o>zz")
    nnoremap("%", "%zz")
    nnoremap("*", "*zz")
    nnoremap("#", "#zz")

    nnoremap("{", function()
        vim.cmd("normal! [m")
    end)

    -- Jump to next function or block end
    nnoremap("}", function()
        vim.cmd("normal! ]m")
    end)

    -- Press 'S' for quick find/replace for the word under the cursor
    nnoremap("S", function()
        local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
        local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
    end)

    -- Press 'U' for redo
    nnoremap("U", "<C-r>")

    -- Map MaximizerToggle (szw/vim-maximizer) to leader-m
    nnoremap("<leader>m", ":MaximizerToggle<cr>")

    -- Resize split windows to be equal size
    nnoremap("<leader>=", "<C-w>=")

    -- Press leader rw to rotate open windows
    nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

    -- Press gx to open the link under the cursor
    nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })

    -- TSC autocommand keybind to run TypeScripts tsc
    -- nnoremap("<leader>tc", ":TSC<cr>", { desc = "[T]ypeScript [C]ompile" })

    -- Symbol Outline keybind
    nnoremap("<leader>so", ":SymbolsOutline<cr>")

    -- toggle inlay hints
    nnoremap("<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end)

    -- Insert --
    -- Map jj and JJ to <esc>
    inoremap("jj", "<esc>")
    inoremap("JJ", "<esc>")

    -- Visual --
    -- Disable Space bar since it'll be used as the leader key
    vnoremap("<space>", "<nop>")

    -- vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
    -- vnoremap("<A-k>", ":m '<-2<CR>gv=gv")

    -- Paste without losing the contents of the register
    xnoremap("<leader>p", '"_dP')

    -- Reselect the last visual selection
    xnoremap("<<", function()
        -- Move selected text up/down in visual mode
        vim.cmd("normal! <<")
        vim.cmd("normal! gv")
    end)

    xnoremap(">>", function()
        vim.cmd("normal! >>")
        vim.cmd("normal! gv")
    end)

    -- Terminal --
    -- Enter normal mode while in a terminal
    tnoremap("<esc>", [[<C-\><C-n>]])
    tnoremap("jj", [[<C-\><C-n>]])

    -- Window navigation from terminal
    tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]])
    tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]])
    tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]])
    tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]])

    -- Reenable default <space> functionality to prevent input delay
    tnoremap("<space>", "<space>")

    return M
end
