local nnoremap = require("user.keymap-utils").nnoremap
local vnoremap = require("user.keymap-utils").vnoremap
local tnoremap = require("user.keymap-utils").tnoremap


-- ==== Quality of life shortcuts ====
nnoremap("<leader>w", "<cmd>w<cr>", { desc = "Quick save", silent = false })
nnoremap("<leader>q", "<cmd>q<cr>", { desc = "Quick exit", silent = false })
vnoremap("<leader>p", '"_dP', { desc = "Paste without losing buffer content" })
nnoremap("U", "<C-r>", { desc = "Redo" })

nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })

nnoremap("<leader>e",
    function() require("oil").toggle_float() end, { desc = "Open file tree" })

vnoremap("<", "<gv", { desc = "Indent left" })
vnoremap(">", ">gv", { desc = "Indent right" })

nnoremap("<leader>hs", "<cmd>split<cr>", { desc = "Horizontal split" })
nnoremap("<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })


-- ==== terminal keymaps ====
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Terminal: normal mode" })
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Window: left" })
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Window: right" })
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Window: down" })
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Window: up" })


-- ==== TMUX keymaps ====
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


-- ==== General keymaps =====
nnoremap("<leader>no", ":nohlsearch<CR>",
    { desc = "Clear search highlight ", silent = true })


-- ==== Folding ====
nnoremap("zR", "<cmd>lua require('ufo').openAllFolds()<CR>", { desc = "Open all folds" })
nnoremap("zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", { desc = "Close all folds" })
nnoremap("K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if winid ~= nil then
        vim.cmd("stopinsert")
    end
end, { desc = "Peek folded lines" })


-- ==== Harpoon ====
local harpoon = require("harpoon")

nnoremap("<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Open UI" })
nnoremap("<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add current file" })
nnoremap("<leader>hd", function() harpoon:list():remove() end, { desc = "Harpoon: Remove current file" })
nnoremap("<leader>hc", function() harpoon:list():clear() end, { desc = "Harpoon: Remove all files" })

nnoremap("<leader>1", function()
    harpoon:list():select(1)
end, { desc = "Harpoon: jump 1" })

nnoremap("<leader>2", function()
    harpoon:list():select(2)
end, { desc = "Harpoon: jump 2" })

nnoremap("<leader>3", function()
    harpoon:list():select(3)
end, { desc = "Harpoon: jump 3" })

nnoremap("<leader>4", function()
    harpoon:list():select(4)
end, { desc = "Harpoon: jump 4" })

nnoremap("<leader>5", function()
    harpoon:list():select(5)
end, { desc = "Harpoon: jump 5" })


-- ==== Undo Tree ====
nnoremap("<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle [U]ndo[T]ree " })


-- ==== Telescope ====
local telescope = require("telescope.builtin")

nnoremap("<leader>fb", telescope.buffers, { desc = "Telescope: search buffers" })
nnoremap("<leader>fg", telescope.live_grep, { desc = "Telescope: live grep" })
nnoremap("<leader>fh", telescope.help_tags, { desc = "Telescope: help tags" })
nnoremap("<leader>ff", telescope.find_files, { desc = "Telescope: find files" })
nnoremap("<leader>fa", function()
    telescope.find_files({
        hidden = true,
        no_ignore = true,
        follow = true,
    })
end, { desc = "Telescope: find all files" })


-- ==== Snacks ====
local snacks = require("snacks")

nnoremap("<leader>og", function() snacks.gitbrowse() end, { desc = "[O]pen [G]it" })
nnoremap("<leader>gb", function() snacks.git.blame_line() end, { desc = "[G]it [B]lame" })
nnoremap("<leader>nh", function() snacks.notifier.show_history() end, { desc = "Show [N]otifier [H]istory" })
