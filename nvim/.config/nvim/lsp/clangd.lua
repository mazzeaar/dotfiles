return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--offset-encoding=utf-8'
    },
    root_markers = {  'CMakeLists.txt', 'build/compile_commands.json'},
    filetypes = { 'c', 'cpp' },
}
