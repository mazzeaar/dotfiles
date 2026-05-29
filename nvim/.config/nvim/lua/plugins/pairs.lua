local function set_blink_pair_highlights()
    vim.api.nvim_set_hl(0, "BlinkPairsRainbow1", { fg = "#5fd7ba" })
    vim.api.nvim_set_hl(0, "BlinkPairsRainbow2", { fg = "#9580ff" })
    vim.api.nvim_set_hl(0, "BlinkPairsRainbow3", { fg = "#e0b458" })
    vim.api.nvim_set_hl(0, "BlinkPairsRainbow4", { fg = "#7ed6c2" })
    vim.api.nvim_set_hl(0, "BlinkPairsRainbow5", { fg = "#c2798f" })
end

set_blink_pair_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user-blink-pairs-highlights", { clear = true }),
    callback = set_blink_pair_highlights,
})

return {
    "saghen/blink.pairs",
    version = "*",

    dependencies = {
        "saghen/blink.download",
    },

    opts = {
        mappings = {
            enabled = true,
            disabled_filetypes = {
                "oil",
                "TelescopePrompt",
                "snacks_picker_input",
            },
            pairs = {},
        },

        -- This is the important part.
        highlights = {
            enabled = false,
        },

        debug = false,
    },
}
