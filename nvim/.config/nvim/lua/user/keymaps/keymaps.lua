-- nvim/lua/user/keymaps.lua

return function()
    local utils = require("user.keymaps.utils")

    local nnoremap = utils.nnoremap
    local vnoremap = utils.vnoremap
    local tnoremap = utils.tnoremap
    local xnoremap = utils.xnoremap

    local M = {}

    -- Normal --
    -- Disable Space bar since it'll be used as the leader key
    nnoremap("<space>", "<nop>")


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

    -- nnoremap("{", function()
    --     vim.cmd("normal! [m")
    -- end)

    -- Jump to next function or block end
    -- nnoremap("}", function()
    --     vim.cmd("normal! ]m")
    -- end)

    -- Press 'S' for quick find/replace for the word under the cursor
    nnoremap("S", function()
        local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
        local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
    end)




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


    -- Reenable default <space> functionality to prevent input delay
    tnoremap("<space>", "<space>")
    --[[unused for now

    -- toggle inlay hints
    nnoremap("<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end)

    -- Symbol Outline keybind
    nnoremap("<leader>so", ":SymbolsOutline<cr>")
--]]

    return M
end
