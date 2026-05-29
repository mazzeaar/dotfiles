return {
    cmd = {
        "clangd",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--fallback-style=none",
        "--function-arg-placeholders=false",
    },

    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    offsetEncoding = { "utf-8", "utf-16" },

    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        "Makefile",
        "CMakeLists.txt",
        ".git",
    },
}
