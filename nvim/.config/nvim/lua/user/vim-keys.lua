local map = vim.keymap.set
local opts = function(desc, extra)
    return vim.tbl_extend("force", { desc = desc, noremap = true, silent = true }, extra or {})
end

-- ==== General keymaps =====
map("n", "<leader>w", "<cmd>w<cr>", opts("Quick Save", { silent = false }))
map("n", "<leader>q", "<cmd>q<cr>", opts("Quick Quit", { silent = false }))
map("n", "<leader>e", function() require("oil").toggle_float() end, opts("File Tree"))
map("n", "<leader>'", "<C-^>", opts("Switch to Last Buffer"))
map("n", "<leader>no", ":nohlsearch<CR>", opts("Clear Search", { silent = true }))
map("n", "<leader>ut", ":UndotreeToggle<CR>", opts("Undo Tree"))
map("v", "<leader>p", '"_dP', opts("Paste without clobbering yank"))
map("v", "<", "<gv", opts("Indent Left"))
map("v", ">", ">gv", opts("Indent Right"))
map("n", "U", "<C-r>", opts("Redo"))
map("n", "<leader>sh", function()
    vim.cmd("split")
    vim.cmd("wincmd j")
end, opts("Split Horizontal and Move"))
map("n", "<leader>sv", function()
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
end, opts("Split Vertical and Move"))

-- ==== terminal navigation ====
map("t", "<esc>", [[<C-\><C-n>]], opts("Exit Terminal Mode"))
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts("Move Left"))
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts("Move Down"))
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts("Move Up"))
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts("Move Right"))

-- ==== TMUX navigation ====
local function tmux_or_wincmd(cmd, fallback)
    return function()
        if vim.fn.exists(":" .. cmd) ~= 0 then
            vim.cmd(cmd)
        else
            vim.cmd("wincmd " .. fallback)
        end
    end
end
map("n", "<C-h>", tmux_or_wincmd("NvimTmuxNavigateLeft", "h"), opts("Move Left"))
map("n", "<C-j>", tmux_or_wincmd("NvimTmuxNavigateDown", "j"), opts("Move Down"))
map("n", "<C-k>", tmux_or_wincmd("NvimTmuxNavigateUp", "k"), opts("Move Up"))
map("n", "<C-l>", tmux_or_wincmd("NvimTmuxNavigateRight", "l"), opts("Move Right"))

-- ==== Harpoon ====
local harpoon = require("harpoon")
map("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts("Toggle UI"))
map("n", "<leader>ha", function() harpoon:list():add() end, opts("Add File"))
map("n", "<leader>hd", function() harpoon:list():remove() end, opts("Remove File"))
map("n", "<leader>hc", function() harpoon:list():clear() end, opts("Clear List"))
for i = 1, 5 do
    map("n", "<leader>h" .. i, function() harpoon:list():select(i) end, opts("Jump to " .. i))
end

-- ==== Snacks ====
local snacks = require("snacks")
map("n", "<leader>og", function() snacks.gitbrowse() end, opts("Open Git"))
map("n", "<leader>gb", function() snacks.git.blame_line() end, opts("Git Blame Line"))
map("n", "<leader>nh", function() snacks.notifier.show_history() end, opts("Notifier History"))
map("n", "<leader>z", function() snacks.toggle.dim():toggle() end, opts("Zen Mode"))

-- ==== render-markdown ====
local md_render = require("render-markdown")
map("n", "<leader>tm", function() md_render.toggle() end, opts("Toggle render-markdown"))

-- ==== Telescope ====
local telescope = require("telescope.builtin")
-- Search
map("n", "<leader>ff", telescope.find_files, opts("TS: Find Files"))
map("n", "<leader>fg", telescope.live_grep, opts("TS: Live Grep"))
map("n", "<leader>fb", telescope.buffers, opts("TS: Search Buffers"))
map("n", "<leader>fh", telescope.help_tags, opts("TS: Help Tags"))
map("n", "<leader>fa", function()
    telescope.find_files({ hidden = true, no_ignore = true, follow = true })
end, opts("Find All Files"))

-- Telescope: Lsp
map("n", "gd", telescope.lsp_definitions, opts("Goto: Definition"))
map("n", "gr", telescope.lsp_references, opts("Goto: References"))
map("n", "gI", telescope.lsp_implementations, opts("Goto: Implementation"))
map("n", "<leader>D", telescope.lsp_type_definitions, opts("Goto: Type Definition"))
map("n", "<leader>ds", telescope.lsp_document_symbols, opts("Open: Document Symbols"))
map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, opts("Open: Workspace Symbols"))

-- ==== LSP ====
local diag_utils = require("user.utils.diagnostic")
map("n", "<leader>fl", vim.diagnostic.setloclist, opts("Open Quickfix list"))
map("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP: Rename"))
map("n", "gD", vim.lsp.buf.declaration, opts("Goto: Declaration"))
map("n", "<leader>ca", vim.lsp.buf.code_action, opts("LSP: Code Action"))
map("n", "<leader>td", function() diag_utils.toggle_virtual_lines() end,
    opts("Toggle Virtual Lines"))

-- ==== LSP Diagnostic Jump ====
local function diagnostic_jump(key, count, label, severity)
    map("n", key, function()
        vim.diagnostic.jump({
            count = count,
            float = true,
            severity = severity and { min = severity } or nil,
        })
    end, opts(label))
end

-- jump_next / jump_prev style bindings
diagnostic_jump("<leader>nd", 1, "Next Diagnostic")
diagnostic_jump("<leader>pd", -1, "Prev Diagnostic")
diagnostic_jump("<leader>ne", 1, "Next Error", vim.diagnostic.severity.ERROR)
diagnostic_jump("<leader>pe", -1, "Prev Error", vim.diagnostic.severity.ERROR)
diagnostic_jump("<leader>nw", 1, "Next Warning", vim.diagnostic.severity.WARN)
diagnostic_jump("<leader>pw", -1, "Prev Warning", vim.diagnostic.severity.WARN)
