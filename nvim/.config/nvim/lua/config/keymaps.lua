-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Disable default hjkl movement
vim.keymap.set({ "n", "v" }, "h", "<Nop>", opts)
vim.keymap.set({ "n", "v" }, "j", "<Nop>", opts)
vim.keymap.set({ "n", "v" }, "k", "<Nop>", opts)
vim.keymap.set({ "n", "v" }, "l", "<Nop>", opts)

-- New movement keys
vim.keymap.set({ "n", "v" }, "j", "h", opts) -- left
vim.keymap.set({ "n", "v" }, "k", "j", opts) -- down
vim.keymap.set({ "n", "v" }, "l", "k", opts) -- up
vim.keymap.set({ "n", "v" }, "ñ", "l", opts) -- right
