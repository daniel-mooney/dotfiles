-- Training wheels for neovim
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 1000,
		-- Window layout
		win = {
			height = { min = 4, max = 25 },
		},
		-- Column layout
		layout = {
			width = { min = 20, max = 50 },
			spacing = 3
		}
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
