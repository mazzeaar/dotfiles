-- lua/plugins/lsp/lsp.lua

return {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-lua/plenary.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        require("plugins.lsp.lsp_handler").setup()
    end,
}
