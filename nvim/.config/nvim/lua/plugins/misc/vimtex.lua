return {
    "lervag/vimtex",
    lazy = false, -- load for .tex immediately
    init = function()
        -- General
        vim.g.tex_flavor = "latex"
        vim.opt.conceallevel = 2
        vim.g.vimtex_syntax_conceal_disable = 1

        -- Build: latexmk
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "", -- same dir; set to "build" if you want out-of-source
            callback = 1,
            continuous = 1,
            executable = "latexmk",
            options = {
                "-pdf",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-file-line-error",
                "-shell-escape", -- remove if you don't use minted/tikz externalize
            },
        }

        -- Viewer (macOS: Skim; Linux: zathura)
        if vim.loop.os_uname().sysname == "Darwin" then
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_view_skim_sync = 1
            vim.g.vimtex_view_skim_activate = 1
        else
            vim.g.vimtex_view_method = "zathura"
        end

        -- Quickfix
        vim.g.vimtex_quickfix_mode = 2 -- open on errors/warnings
    end,
}
