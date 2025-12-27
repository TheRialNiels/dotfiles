return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
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
		-- Top Pickers & Explorer
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		-- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		-- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },},
	}

