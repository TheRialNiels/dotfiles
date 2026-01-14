-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable visual line wrapping
vim.opt.wrap = true

-- Wrap at word boundaries rather than splitting words
vim.opt.linebreak = true

-- Display a character (e.g., a curved arrow) where the line visually breaks
vim.opt.showbreak = "↪ "

-- Ensure that whitespace characters are not displayed as text, which can interfere with wrapping
vim.opt.list = false

-- Set the maximum line length
vim.opt.textwidth = 80

-- Search ignoring case
vim.opt.ignorecase = true

-- Disable 'ignorecase' option if the search pattern contains uppercase characters
vim.opt.smartcase = true

-- Use an expression to calculate folds (required for Tree-sitter)
vim.opt.foldmethod = "expr"

-- Let Tree-sitter decide fold levels based on the syntax tree
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Keep all folds open by default (do not start with everything folded)
vim.opt.foldlevel = 99

-- Set the initial fold level when opening a file
vim.opt.foldlevelstart = 99

-- Customize how folds are displayed in the UI
vim.opt.fillchars = {
  fold = " ", -- Character used for folded lines
  foldopen = "", -- Icon shown when a fold is open
  foldclose = "", -- Icon shown when a fold is closed
  foldsep = " ", -- Separator between fold column and text
}

-- Show a dedicated column for fold indicators (like VS Code)
vim.opt.foldcolumn = "1"

-- Disable swap files (prevents .swp files from being created)
vim.opt.swapfile = false

-- Disable backup files (prevents ~ backup files)
vim.opt.backup = false

-- Disable write-backup files when saving
vim.opt.writebackup = false

-- Enable persistent undo (undo history is kept between sessions)
vim.opt.undofile = true

-- Directory where undo history files are stored
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
