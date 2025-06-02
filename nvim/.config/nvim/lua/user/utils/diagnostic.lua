local M = {}

local virtual_lines_enabled = false

function M.toggle_virtual_lines()
    virtual_lines_enabled = not virtual_lines_enabled
    vim.diagnostic.config({
        virtual_lines = virtual_lines_enabled and {
            only_current_line = true,
            highlight_whole_line = true,
            prefix = "▎",
            spacing = 4,
        } or false,
    })
end

return M
