return {
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--compile-commands-dir=build',
        '--enable-config', -- use .clangd config
        -- '--clang-tidy',              -- everything hungry
        --'--all-scopes-completion',    -- cpu hungry
        -- '--background-index',        -- ram hungry
        -- '--log=verbose'              -- hungry hungry
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
}
