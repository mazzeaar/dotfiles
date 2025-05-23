-- nvim/lua/plugins/telescope.lua

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                cond = vim.fn.executable("cmake") == 1,
            },
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-x>"] = actions.delete_buffer,
                        },
                    },

                    file_ignore_patterns = {
                        "node_modules",
                        "yarn.lock",
                        ".sl",
                        "_build",
                        ".next",

                        -- dotfiles --
                        ".git",
                        ".clang-tidy",
                        ".clang-format",
                        "%.clangd$", -- clangd hidden file

                        -- folders --
                        "cmake%-build.-/", -- CMake out-of-source builds
                        "build/",          -- generic build folder
                        "bin/",            -- binaries
                        "obj/",            -- object files
                        "%.vscode/",       -- VSCode settings
                        "%.idea/",         -- CLion settings
                        "%.git/",          -- git internals

                        -- files --
                        "%.o$",        -- object files
                        "%.a$",        -- static libs
                        "%.so$",       -- shared libs
                        "%.d$",        -- dependency files
                        "%.gch$",      -- precompiled headers
                        "%.gcno$",     -- gcov profiling
                        "%.gcda$",
                        "%.out$",      -- default output files
                        "%.exe$",      -- Windows binaries
                        "%.log$",      -- logs
                        "%.cache$",    -- cached files
                        "%.DS_Store$", -- macOS metadata
                        "compile_commands%.json",
                        "%.cmake",     -- cmake generated files

                        -- misc --
                        "node_modules/", -- just in case
                    },

                    hidden = true,
                    path_display = {
                        "filename_first",
                    },
                },
            })

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")
        end,
    },
}
