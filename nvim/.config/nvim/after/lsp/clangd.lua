return {
    cmd = {
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clangd',
        '--header-insertion=never',
        '--compile-commands-dir=build',
        '--enable-config', -- use .clangd config
        '--j=8',           -- set threads
        -- '--clang-tidy',              -- everything hungry
        --'--all-scopes-completion',    -- cpu hungry
        '--background-index', -- ram hungry
        -- '--log=verbose'              -- hungry hungry
    },

    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    offsetEncoding = { 'utf-8', 'utf-16' },

    root_markers = {
        "CMakeLists.txt",
        "build/",
    },

    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
    },
}
