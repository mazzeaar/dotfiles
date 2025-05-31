return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--offset-encoding=utf-8',
    },

    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    offsetEncoding = { 'utf-8', 'utf-16' },

    root_markers = {
        'CMakeLists.txt',
        'build/'
    },

    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
    },

    on_attach = function()
        vim.api.nvim_buf_create_user_command(0, 'What', function()
            print("its working wtf?")
        end, { desc = 'testing stuff' })
    end
}
