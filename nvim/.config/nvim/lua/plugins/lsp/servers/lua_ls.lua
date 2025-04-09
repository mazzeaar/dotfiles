-- lua/plugins/lsp/servers/lua_ls.lua

return {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = {
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                },
            },
            telemetry = { enabled = false },
        },
    },

    filetypes = { "lua" },

    format = "stylua",
}
