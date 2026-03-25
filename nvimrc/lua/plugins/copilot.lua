return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
		init = function()
			vim.g.copilot_nes_debounce = 500
		end,
	},
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 15,
				keymap = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[",
					dismiss = "<M-\\>",
					toggle_auto_trigger = "<M-L>",
				},
			},
			nes = {
				enabled = false,
				keymap = {
					accept_and_goto = "<leader>p",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		})

		-- Extra keybindings
		local suggestions = require("copilot.suggestion")
		vim.keymap.set("n", "<M-L>", suggestions.toggle_auto_trigger)
	end,
}
