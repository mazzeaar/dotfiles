return
{
    "saghen/blink.cmp",
    version = "1.*",

    dependencies = {
        "rafamadriz/friendly-snippets",
    },

    opts = {
        keymap = {
            ["<Tab>"] = { "accept", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            documentation = {
                auto_show = true,
            },
        },

        signature = {
            enabled = true,
            window = {
                show_documentation = true,
            },
        },

        sources = {
            default = {
                "lazydev",
                "lsp",
                "path",
                "snippets",
                "buffer",
            },

            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                },
            },
        },
    },

    opts_extend = {
        "sources.default",
    },
}
