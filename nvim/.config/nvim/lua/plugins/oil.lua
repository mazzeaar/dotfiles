vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.opt_local.colorcolumn = ""
    end,
})

return {
    "stevearc/oil.nvim",
    lazy = false,
    default_file_explorer = true,

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    keys = {
        {
            "<leader>e",
            function()
                require("oil").open_float()
            end,
            desc = "File Tree",
        },
    },

    opts = {
        use_default_keymaps = false,

        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-\\>"] = "actions.select_split",

            -- More reliable than <C-enter>/<C-CR> in terminals
            ["<C-v>"] = "actions.select_vsplit",

            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
        },

        view_options = {
            show_hidden = true,
        },
    },
}
