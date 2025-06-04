local map_util = require("user.utils.keymap")

local default_map = map_util.curry_map("<leader>", "")
local nnoremap = map_util.nnoremap
local vnoremap = map_util.vnoremap

-- ==== General keymaps =====
default_map("w", "<cmd>w<cr>", { desc = "Quick Save", silent = false })
default_map("q", "<cmd>q<cr>", { desc = "Quick Quit", silent = false })
default_map("e", function() require("oil").toggle_float() end, { desc = "File Tree" })

default_map("'", "<C-^>", { desc = "Switch to Last Buffer" })
default_map("no", ":nohlsearch<CR>", { desc = "Clear Search", silent = true })
default_map("ut", ":UndotreeToggle<CR>", { desc = "Undo Tree" })

vnoremap("<leader>p", '"_dP', { desc = "Paste without clobbering yank" })
vnoremap("<", "<gv", { desc = "Indent Left" })
vnoremap(">", ">gv", { desc = "Indent Right" })

nnoremap("U", "<C-r>", { desc = "Redo" })

default_map("sh", function()
    vim.cmd("split")
    vim.cmd("wincmd j")
end, { desc = "Split Horizontal and Move" })

default_map("sv", function()
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
end, { desc = "Split Vertical and Move" })


-- ==== terminal navigation ====
local tnoremap = map_util.tnoremap

tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move Left" })
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move Down" })
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move Up" })
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move Right" })


-- ==== TMUX navigation ====
local tmux_map = map_util.curry_map("", "Tmux", "n")

local function tmux_or_wincmd(cmd, fallback)
    return function()
        if vim.fn.exists(":" .. cmd) ~= 0 then
            vim.cmd(cmd)
        else
            vim.cmd("wincmd " .. fallback)
        end
    end
end

tmux_map("<C-h>", tmux_or_wincmd("NvimTmuxNavigateLeft", "h"), { desc = "Move Left" })
tmux_map("<C-j>", tmux_or_wincmd("NvimTmuxNavigateDown", "j"), { desc = "Move Down" })
tmux_map("<C-k>", tmux_or_wincmd("NvimTmuxNavigateUp", "k"), { desc = "Move Up" })
tmux_map("<C-l>", tmux_or_wincmd("NvimTmuxNavigateRight", "l"), { desc = "Move Right" })


-- ==== Harpoon ====
local harpoon = require("harpoon")
local list = harpoon:list()
local harpoon_map = map_util.curry_map("<leader>h", "Harpoon")

harpoon_map("o", function() harpoon.ui:toggle_quick_menu(list) end, { desc = "Toggle UI" })
harpoon_map("a", function() list:add() end, { desc = "Add File" })
harpoon_map("d", function() list:remove() end, { desc = "Remove File" })
harpoon_map("c", function() list:clear() end, { desc = "Clear List" })
for i = 1, 5 do
    harpoon_map(tostring(i), function() list:select(i) end, { desc = "Jump to " .. i })
end


-- ==== Telescope ====
local telescope = require("telescope.builtin")
local telescope_map = map_util.curry_map("<leader>f", "Telescope")

telescope_map("f", telescope.find_files, { desc = "Find Files" })
telescope_map("g", telescope.live_grep, { desc = "Live Grep" })
telescope_map("b", telescope.buffers, { desc = "Search Buffers" })
telescope_map("h", telescope.help_tags, { desc = "Help Tags" })
telescope_map("a", function() telescope.find_files({ hidden = true, no_ignore = true, follow = true }) end,
    { desc = "Find All Files" })


-- ==== Snacks ====
local snacks = require("snacks")
local snacks_map = map_util.curry_map("<leader>", "Snacks")

snacks_map("og", function() snacks.gitbrowse() end, { desc = "Open Git" })
snacks_map("gb", function() snacks.git.blame_line() end, { desc = "Git Blame Line" })
snacks_map("nh", function() snacks.notifier.show_history() end, { desc = "Notifier History" })
snacks_map("nh", function() snacks.notifier.show_history() end, { desc = "Notifier History" })
snacks_map("z", function() snacks.toggle.dim():toggle() end, { desc = "Zen Mode" })


-- ==== render-markdown ====
nnoremap("<leader>tm", function() require("render-markdown").toggle() end, { desc = "Toggle render-markdown" })

-- ==== LSP ====
local lsp_utils = require("user.utils.lsp")

local lsp_map = lsp_utils.lsp_map
local lsp_multi_map = lsp_utils.lsp_multi_map
local lsp_goto_map = lsp_utils.goto_map
local jump_next = lsp_utils.jump_next
local jump_prev = lsp_utils.jump_prev

jump_next("d", "Diagnostic")
jump_prev("d", "Diagnostic")
jump_next("e", "Error", vim.diagnostic.severity.ERROR)
jump_prev("e", "Error", vim.diagnostic.severity.ERROR)
jump_next("w", "Warning", vim.diagnostic.severity.WARN)
jump_prev("w", "Warning", vim.diagnostic.severity.WARN)

lsp_map('<leader>fl', vim.diagnostic.setloclist, 'Open Quickfix list')
lsp_map('<leader>rn', vim.lsp.buf.rename, 'Rename')

lsp_goto_map('D', vim.lsp.buf.declaration, 'Declaration')

lsp_multi_map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

lsp_goto_map('d', telescope.lsp_definitions, 'Definition')
lsp_goto_map('r', telescope.lsp_references, 'References')
lsp_goto_map('I', telescope.lsp_implementations, 'Implementation')

lsp_map('<leader>D', telescope.lsp_type_definitions, 'Type Definition')
lsp_map('<leader>ds', telescope.lsp_document_symbols, 'Document Symbols')
lsp_map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace Symbols')


default_map("td", function() require("user.utils.diagnostic").toggle_virtual_lines() end,
    { desc = "Toggle Virtual Lines" })
