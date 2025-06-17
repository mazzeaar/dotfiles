-- custom highlight colors
vim.api.nvim_set_hl(0, "hl_group1", { fg = "#5fd7ba" }) -- Soft Mint Cyan
vim.api.nvim_set_hl(0, "hl_group2", { fg = "#9580ff" }) -- Soft Lavender Indigo
vim.api.nvim_set_hl(0, "hl_group3", { fg = "#e0b458" }) -- Amber Gold: warm golden hue, contrasts softly
vim.api.nvim_set_hl(0, "hl_group4", { fg = "#7ed6c2" }) -- Bright Seafoam Teal
vim.api.nvim_set_hl(0, "hl_group5", { fg = "#c2798f" }) -- Dusty Rose: warm dusty pink, gentle on dark backgrounds

return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                ['<Tab>'] = { 'accept', 'fallback' },
                ['<C-j>'] = { "select_next" },
                ['<C-k>'] = { "select_prev" },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = true } },
            signature = { enabled = true, window = { show_documentation = true } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                    },
                },
            },
        },

        opts_extend = { "sources.default" },
    },

    {
        'saghen/blink.pairs',
        version = '*',

        dependencies = 'saghen/blink.download',

        --- @module 'blink.pairs'
        --- @type blink.pairs.Config
        opts = {
            mappings = {
                -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
                enabled = true,
                -- you may also disable with `vim.g.pairs = false` (global) or `vim.b.pairs = false` (per-buffer)
                disabled_filetypes = {},
                -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L12
                pairs = {},
            },
            highlights = {
                enabled = true,
                groups = {
                    "hl_group1",
                    "hl_group2",
                    "hl_group3",
                    "hl_group4",
                    "hl_group5",
                },
                matchparen = {
                    enabled = true,
                    group = 'MatchParen',
                },
            },
            debug = false,
        }
    }
}
