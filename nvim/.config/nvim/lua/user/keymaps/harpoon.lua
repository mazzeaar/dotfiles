local nnoremap = require("user.keymaps.utils").nnoremap

return function()
    local harpoon_mark = require("harpoon.mark")
    local harpoon_ui = require("harpoon.ui")

    nnoremap("<leader>ho", harpoon_ui.toggle_quick_menu, { desc = "Harpoon: Open UI" })
    nnoremap("<leader>ha", harpoon_mark.add_file, { desc = "Harpoon: Add current file" })
    nnoremap("<leader>hr", harpoon_mark.rm_file, { desc = "Harpoon: Remove current file" })

    nnoremap("<leader>1", function()
        harpoon_ui.nav_file(1)
    end, { desc = "Harpoon: jump 1" })

    nnoremap("<leader>2", function()
        harpoon_ui.nav_file(2)
    end, { desc = "Harpoon: jump 2" })

    nnoremap("<leader>3", function()
        harpoon_ui.nav_file(3)
    end, { desc = "Harpoon: jump 3" })

    nnoremap("<leader>4", function()
        harpoon_ui.nav_file(4)
    end, { desc = "Harpoon: jump 4" })

    --[[unused for now

    nnoremap("<leader>hc", function()
        harpoon_mark.clear_all()
    end, { desc = "Harpoon: Remove all files" })

    ]] --
end
