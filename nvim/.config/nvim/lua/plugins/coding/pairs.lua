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

        highlights = {
            enabled = true,
        },

        debug = false,
    },
}
