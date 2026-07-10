-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
map("i", "<C-b>", "<C-o>de")

-- Map Ctrl+c to escape from other modes
map({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

-- Screen Keys
-- map({ "n" }, "<leader>uk", "<cmd>Screenkey<CR>")

-- Scroll down half a page and center the cursor
map("n", "<C-d>", "<C-d>zz", opts)

-- Scroll up half a page and center the cursor
map("n", "<C-u>", "<C-u>zz", opts)

-- Keep search results centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Telescope projects
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
        focusable = true,
      })
    end, { buffer = event.buf, desc = "Hover" })
  end,
})

----- Tmux Navigation ------
local nvim_tmux_nav = require("nvim-tmux-navigation")

map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft) -- Navigate to the left pane
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown) -- Navigate to the bottom pane
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp) -- Navigate to the top pane
map("n", "<C-l", nvim_tmux_nav.NvimTmuxNavigateRight) -- Navigate to the right pane
map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive) -- Navigate to the last active pane
map("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext) -- Navigate to the next pane

----- OBSIDIAN -----
-- map("n", "<leader>oc", "<cmd>ObsidianCheck<CR>", { desc = "Obsidian Check Checkbox" })
-- map("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
-- map("n", "<leader>oo", "<cmd>Obsidian Open<CR>", { desc = "Open in Obsidian App" })
-- map("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
-- map("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
-- map("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
-- map("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
-- map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

----- OIL -----
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
map("n", "<leader>bq", '<Esc>:%bdelete|edit #|normal`"<Return>', { desc = "Delete other buffers but the current one" })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", opts)
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", opts)
vim.api.nvim_set_keymap("x", "J", "<Nop>", opts)
vim.api.nvim_set_keymap("x", "K", "<Nop>", opts)

-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", opts)

-- Grep keybinding for visual mode - search selected text
map("v", "<leader>sg", function()
  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text })
  elseif pcall(require, "fzf-lua") then
    require("fzf-lua").live_grep({ search = selected_text })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text" })

-- Grep keybinding for visual mode with G - search selected text at root level
map("v", "<leader>sG", function()
  -- Get git root or fallback to cwd
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  local root = vim.v.shell_error == 0 and git_root ~= "" and git_root or vim.fn.getcwd()

  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep at root level
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text, cwd = root })
  elseif pcall(require, "fzf-lua") then
    require("fzf-lua").live_grep({ search = selected_text, cwd = root })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text (Root Dir)" })

-- Delete all marks
map("n", "<leader>md", function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z0-9")
  vim.notify("All marks deleted")
end, { desc = "Delete all marks" })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t") -- Get only the filename
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. " Saved!") -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end
