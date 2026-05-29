return {
    cmd = {
        "clangd",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--fallback-style=none",
        "--function-arg-placeholders=false",
        "--log=verbose",
    },
    -- cmd = {
    --     'clangd',
    --     '--header-insertion=never',
    --     '--enable-config',    -- use .clangd config
    --     '--j=8',              -- set threads
    --     '--background-index', -- ram hungry
    --     '--compile-commands-dir=build',
    --     -- '--clang-tidy',       -- everything hungry
    --     --'--all-scopes-completion',    -- cpu hungry
    --     -- '--log=verbose'              -- hungry hungry
    -- },

    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    offsetEncoding = { 'utf-8', 'utf-16' },

    root_markers = {
        'compile_commands.json',
        'compile_flags.txt',
        '.clangd',
        'Makefile',
        'CMakeLists.txt',
        '.git',
    },
}
