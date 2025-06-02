return {
    {
        'saghen/blink.cmp',

        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        version = '1.*',
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
        -- download prebuilt binaries from github releases
        dependencies = { 'saghen/blink.download' },

        version = '1.*', -- (recommended) only required with prebuilt binaries
        --- @module 'blink.pairs'
        --- @type blink.pairs.Config
        opts = {
            mappings = {
                -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
                enabled = true,
                -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
                pairs = {},
            },
            highlights = {
                enabled = true,
                groups = {
                    'BlinkPairsOrange',
                    'BlinkPairsPurple',
                    'BlinkPairsBlue',
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
