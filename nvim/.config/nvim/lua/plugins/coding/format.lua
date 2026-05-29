return {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    opts = {
        formatters_by_ft = {
            python = { "ruff_format" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            cmake = { "cmake_format" },
            cpp = { "clang_format" },
            c = { "clang_format" },
            cuda = { "clang_format" },
            lua = { "stylua" },
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = "fallback",
        },
    },
}
