local M = {}

--- Unified curry_map that supports both global and buffer-local keymaps
--- If `opts_or_bufnr` is a number, it's treated as a buffer number
function M.curry_map(prefix, base_desc, mode, opts_or_bufnr, base_opts)
    mode = mode or "n"
    local base_opts_resolved = { noremap = true, silent = true }

    if type(opts_or_bufnr) == "number" then
        base_opts_resolved.buffer = opts_or_bufnr
        base_opts = base_opts or {}
    elseif type(opts_or_bufnr) == "table" then
        base_opts = opts_or_bufnr
    end

    base_opts = vim.tbl_extend("force", base_opts_resolved, base_opts or {})

    return function(key, func, desc_or_opts)
        local opts = {}

        if type(desc_or_opts) == "string" then
            opts.desc = base_desc .. ": " .. desc_or_opts
        elseif type(desc_or_opts) == "table" then
            opts = vim.tbl_extend("force", {}, desc_or_opts)
            if opts.desc then
                opts.desc = base_desc .. ": " .. opts.desc
            else
                opts.desc = base_desc
            end
        else
            opts.desc = base_desc
        end

        opts = vim.tbl_extend("force", base_opts, opts)
        local full_key = prefix .. key

        if type(mode) == "table" then
            for _, m in ipairs(mode) do
                vim.keymap.set(m, full_key, func, opts)
            end
        else
            vim.keymap.set(mode, full_key, func, opts)
        end
    end
end

M.map      = M.curry_map("", "", "n")                      -- default normal mode map
M.nmap     = M.curry_map("", "", "n", { noremap = false }) -- non-noremap
M.nnoremap = M.curry_map("", "", "n")
M.vnoremap = M.curry_map("", "Visual", "v")
M.xnoremap = M.curry_map("", "", "x")
M.inoremap = M.curry_map("", "", "i")
M.tnoremap = M.curry_map("", "Terminal", "t")

return M
