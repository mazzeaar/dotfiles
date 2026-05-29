return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "bashls",
                "lua_ls",
                "pyright",
                "clangd",
                "cmake",
                "texlab",
            },
            automatic_installation = false,
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                -- linters
                "shellcheck",
                "ruff",
                "checkmake",

                -- formatters
                "shfmt",
                "stylua",
                "clang-format",
                "cmakelang",
            },
        },
    },
}
