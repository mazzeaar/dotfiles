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

    if virtual_lines_enabled then
        vim.notify("Enabled virtual lines")
    else
        vim.notify("Disabled virtual lines")
    end
end

return M
