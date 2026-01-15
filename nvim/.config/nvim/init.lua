-- Configure Node.js before loading plugins
pcall(function()
  require("config.nodejs").setup({ silent = true })
end)

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
