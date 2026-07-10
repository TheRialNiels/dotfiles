-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local float_style = {
  border = "rounded",
}

-- local diagnostic_float_auto = vim.tbl_extend("force", float_style, {
--   focusable = false,
--   close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--   source = "always",
--   prefix = " ",
--   scope = "cursor",
-- })

local diagnostic_float_manual = vim.tbl_extend("force", float_style, {
  focusable = true,
  source = "always",
  prefix = " ",
  scope = "cursor",
})

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, diagnostic_float_manual)
end, { desc = "Show diagnostics float" })

-- Auto-show errors when hovering with the cursor
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, diagnostic_float_auto)
--   end,
-- })
