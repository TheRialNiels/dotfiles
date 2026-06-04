local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with the specified configuration
require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- -- Editor plugins
    -- { import = "lazyvim.plugins.extras.editor.harpoon2" },
    -- { import = "lazyvim.plugins.extras.editor.mini-files" },
    -- -- { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
    -- { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    --
    -- -- Debgugging plugins
    -- { import = "lazyvim.plugins.extras.dap.core" },
    --
    -- -- Formatting plugins
    -- { import = "lazyvim.plugins.extras.formatting.biome" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    --
    -- -- Linting plugins
    -- { import = "lazyvim.plugins.extras.linting.eslint" },
    --
    -- -- Language support plugins
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.lang.markdown" },
    --
    -- -- Coding plugins
    -- { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- { import = "lazyvim.plugins.extras.editor.mini-diff" },
    -- { import = "lazyvim.plugins.extras.coding.blink" },
    --
    -- -- Utility plugins
    -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    --
    -- -- AI plugins
    -- { import = "lazyvim.plugins.extras.ai.copilot" },

    -- Import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot of the plugins that support versioning
    -- have outdated releases, which may break your Neovim install.
    version = false, -- Always use the latest git commit
    -- version = "*", -- Try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } }, -- Specify colorschemes to install
  checker = { enabled = true }, -- Automatically check for plugin updates
  performance = {
    rtp = {
      -- Disable some runtime path plugins to improve performance
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
