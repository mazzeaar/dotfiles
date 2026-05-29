return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        git = { enabled = true },
        gitbrowse = { enabled = true },
        indent = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        scroll = { enabled = false },
        zen = { enabled = true },
    },

    keys = {
        {
            "<leader>og",
            function()
                require("snacks").gitbrowse()
            end,
            desc = "Open Git",
        },
        {
            "<leader>gb",
            function()
                require("snacks").git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>nh",
            function()
                require("snacks").notifier.show_history()
            end,
            desc = "Notifier History",
        },
        {
            "<leader>tz",
            function()
                require("snacks").toggle.dim():toggle()
            end,
            desc = "Toggle Dim",
        },
    },
}
