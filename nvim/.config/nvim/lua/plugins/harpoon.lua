local num_jump_keys = 5 -- <leader>h<N> for jumps

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    keys = function()
        local keys = {
            {
                "<leader>ho",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon UI",
            },
            {
                "<leader>ha",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon Add File",
            },
            {
                "<leader>hd",
                function()
                    require("harpoon"):list():remove()
                end,
                desc = "Harpoon Remove File",
            },
            {
                "<leader>hc",
                function()
                    require("harpoon"):list():clear()
                end,
                desc = "Harpoon Clear List",
            },
        }

        for i = 1, num_jump_keys do
            table.insert(keys, {
                "<leader>h" .. i,
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon Jump " .. i,
            })
        end

        return keys
    end,

    config = function()
        require("harpoon"):setup()
    end,
}
