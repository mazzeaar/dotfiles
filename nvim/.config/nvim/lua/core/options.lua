-- Basic setting
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4 -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.smartindent = true -- Make indenting smart
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.breakindent = true -- Indent wrapped lines

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4 -- Set number column width
vim.opt.signcolumn = "yes" -- Always show the signcolumn

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false -- Don't create backup files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.writebackup = false -- Don't write backup files

-- Search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search pattern has uppercase
vim.opt.incsearch = true -- Show search matches as you type

-- UI config
vim.opt.termguicolors = true
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.scrolloff = 8 -- Minimum number of lines to keep above and below cursor
vim.opt.sidescrolloff = 8 -- Minimum number of columns to keep left and right of cursor
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.cursorline = true -- Highlight the current line

-- UI fold config
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "1" -- Make folds visible
vim.opt.foldnestmax = 5
vim.opt.foldtext = ""

-- Quality of life improvements
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.updatetime = 100 -- Update time to make vim feel nicer
vim.opt.timeoutlen = 300 -- Make LSP snappier

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- disable lsp logs as they get huge and all lsps send to cerr anyway :,)
-- vim.lsp.set_log_level(vim.log.levels.OFF)

-- allow custom loading of .vimrc files for project specific settings
vim.o.exrc = true
vim.o.secure = true
