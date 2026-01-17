return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
        },
      },
    },
    window = {
      mappings = {
        -- Disable default hkl
        ["h"] = "noop",
        ["k"] = "noop",
        ["l"] = "noop",

        -- New movement keys
        ["j"] = "close_node",
        ["ñ"] = "open",

        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
  },
}
