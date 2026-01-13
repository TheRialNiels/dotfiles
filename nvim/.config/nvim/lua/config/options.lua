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

-- Automatically insert newlines when typing past the textwidth limit
vim.opt.formatoptions:append("t")

-- Search ignoring case
vim.opt.ignorecase = true

-- Disable 'ignorecase' option if the search pattern contains uppercase characters
vim.opt.smartcase = true
