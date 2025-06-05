return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--header-insertion=never',
        '--all-scopes-completion',
        '--background-index',
        '--compile-commands-dir=build',
        -- '--enable-config',
        '--log=verbose'
    },

    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    offsetEncoding = { 'utf-8', 'utf-16' },

    root_markers = {
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
