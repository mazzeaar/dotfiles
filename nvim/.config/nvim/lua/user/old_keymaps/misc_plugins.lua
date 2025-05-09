return function()
	local nnoremap = require("user.keymaps.utils").nnoremap


	nnoremap("zR", require("ufo").openAllFolds, { desc = "Open all folds" })
	nnoremap("zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

	--    nnoremap("<leader>f", function()
	--        local ok, conform = pcall(require, "conform")
	--        if ok then
	--            conform.format({
	--                async = true,
	--                timeout_ms = 500,
	--                lsp_format = "fallback",
	--            })
	--        else
	--            vim.notify("conform not loaded yet", vim.log.levels.WARN)
	--        end
	--    end, { desc = "Format the current buffer" })

	nnoremap("<leader>f", function()
		local conform = require("conform")
		local ft = vim.bo.filetype
		print("Attempting to format buffer with filetype:", ft)

		local by_ft = conform.formatters_by_ft or {}
		local list = by_ft[ft]
		if list then
			print("Available formatters for " .. ft .. ":", vim.inspect(list))
		else
			print("No formatter registered for filetype:", ft)
		end

		conform.format({
			async = false,
			timeout_ms = 1000,
			lsp_fallback = false,
		})
	end, { desc = "Format the current buffer" })

	--[[unused for now
        nnoremap("<leader>oc", function()
            require("copilot.panel").open({})
        end, { desc = "[O]pen [C]opilot panel" })

        nnoremap("<leader>tw", function()
            Snacks.toggle.option("wrap")
        end, { desc = "[T]oggle [Wrap]" })
    ]]
	--
end
