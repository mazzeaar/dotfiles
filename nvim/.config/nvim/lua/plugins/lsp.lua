return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "clangd", "pyright", "rust_analyzer", },
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        border = "rounded",
                    }
                }
            },
            "neovim/nvim-lspconfig",
            { "j-hui/fidget.nvim", opts = {} },
            {
                "hedyhli/outline.nvim",
                lazy = true,
                cmd = { "Outline" },
                opts = {
                    -- Your setup opts here
                },
            },
        },
    }
}
