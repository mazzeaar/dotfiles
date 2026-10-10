return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},

	keys = function()
		local builtin = require("telescope.builtin")

		local ignored = {
			"--glob",
			"!docs/**",
		}

		return {
			-- Files/search
			{
				"<leader>ff",
				function()
					builtin.find_files({
						hidden = true,
						find_command = vim.list_extend({
							"rg",
							"--files",
						}, ignored),
					})
				end,
				desc = "Find Files",
			},

			{
				"<leader>fg",
				function()
					builtin.live_grep({
						additional_args = function()
							return ignored
						end,
					})
				end,
				desc = "Live Grep",
			},

			{ "<leader>fb", builtin.buffers, desc = "Buffers" },
			{ "<leader>fh", builtin.help_tags, desc = "Help Tags" },

			{
				"<leader>fa",
				function()
					builtin.find_files({
						hidden = true,
						no_ignore = true,
						follow = true,
					})
				end,
				desc = "Find All Files",
			},

			-- LSP pickers
			{ "gd", builtin.lsp_definitions, desc = "Goto Definition" },
			{ "gr", builtin.lsp_references, desc = "Goto References" },
			{ "gI", builtin.lsp_implementations, desc = "Goto Implementation" },
			{ "<leader>D", builtin.lsp_type_definitions, desc = "Goto Type Definition" },
			{ "<leader>ds", builtin.lsp_document_symbols, desc = "Document Symbols" },
			{ "<leader>ws", builtin.lsp_dynamic_workspace_symbols, desc = "Workspace Symbols" },
		}
	end,

	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"docs/",
					"build/",
				},

				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<C-n>"] = "cycle_history_next",
						["<C-p>"] = "cycle_history_prev",
					},
					n = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
	end,
}
