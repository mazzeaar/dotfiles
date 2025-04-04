-- nvim/lua/plugins/snacks.lua

local macchiato = require("catppuccin.palettes").get_palette("macchiato")

vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = macchiato.mauve })

local filtered_message = { "No information available" }

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        dependencies = {
            {
                "lewis6991/gitsigns.nvim",
                init = function()
                    require("gitsigns").setup()
                end,
            },
        },
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dim = { enabled = true },
            git = { enabled = true },
            gitbrowse = { enabled = true },
            indent = { enabled = true },
            animate = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    local notify = Snacks.notifier.notify
                    ---@diagnostic disable-next-line: duplicate-set-field
                    Snacks.notifier.notify = function(message, level, opts)
                        for _, msg in ipairs(filtered_message) do
                            if message == msg then
                                return nil
                            end
                        end
                        return notify(message, level, opts)
                    end
                end,
            })
        end,
        keys = {
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>gb",
                function()
                    Snacks.git.blame_line()
                end,
                desc = "[G]it [B]lame Line",
            },
            {
                "<leader>go",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "[G]it [O]pen",
                mode = { "n", "v" },
            },
            {
                "<leader>nh",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "[N]otification [H]istory",
            },
            {
                "<leader>z",
                function()
                    Snacks.toggle.dim():toggle()
                end,
                desc = "TOGGLE ZEN MODE!!!!!",
            },
            {
                "<leader>cl",
                function()
                    Snacks.toggle.option("cursorline", { name = "Cursor Line" }):toggle()
                end,
                desc = "Toggle [C]ursor [L]ine",
            },
            {
                "<leader>tt",
                function()
                    local tsc = require("treesitter-context")
                    Snacks.toggle({
                        name = "Treesitter Context",
                        get = tsc.enabled,
                        set = function(state)
                            if state then
                                tsc.enable()
                            else
                                tsc.disable()
                            end
                        end,
                    }):toggle()
                end,
                desc = "[T]oggle [T]reesitter Context",
            },
            {
                "<leader>hl",
                function()
                    local hc = require("nvim-highlight-colors")
                    Snacks.toggle({
                        name = "Highlight Colors",
                        get = function()
                            return hc.is_active()
                        end,
                        set = function(state)
                            if state then
                                hc.turnOn()
                            else
                                hc.turnOff()
                            end
                        end,
                    }):toggle()
                end,
                desc = "Toggle [H]igh[L]ight Colors",
            },
        },
    },
}
