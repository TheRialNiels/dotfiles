return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
      },
    },
    explorer = {
      enabled = true,
      hidden = true,        -- Show hidden files in explorer
      ignored = false,      -- Do NOT hide gitignored files
    },
    picker = {
      enabled = true,
      hidden = true,        -- Show dotfiles everywhere
      ignored = false,      -- Include gitignored files
    },
  },
  keys = {
    -- TODO -> Move this to keybindings file
    { "<leader><space>",  function() Snacks.picker.smart()      end, desc = "Smart Find Files"      },
    { "<leader>fb",       function() Snacks.picker.buffers()    end, desc = "Buffers"               },
    { "<leader>fg",       function() Snacks.picker.grep()       end, desc = "Grep"                  },
    { "<leader>e",        function() Snacks.explorer()          end, desc = "File Explorer"         },
  },
}

