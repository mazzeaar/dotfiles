return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
                "pyright",
                "rust_analyzer",
                "cmake",
                "html",
                "bashls",
            },
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        border = "rounded",
                    },
                },
            },
            "neovim/nvim-lspconfig",
            { "j-hui/fidget.nvim", opts = {} },
            {
                "hedyhli/outline.nvim",
                lazy = true,
                cmd = { "Outline" },
                opts = {},
            },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            vim.lsp.enable("julials")
        end,
    },
}
