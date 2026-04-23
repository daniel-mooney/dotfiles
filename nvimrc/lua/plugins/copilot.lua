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
			},
			nes = {
				enabled = false,
			},
		})

		local suggestion = require("copilot.suggestion")

		vim.keymap.set("i", "<M-p>", suggestion.accept, { desc = "Accept Copilot suggestion" })
		vim.keymap.set("i", "<M-]>", suggestion.next, { desc = "Next Copilot suggestion" })
		vim.keymap.set("i", "<M-[>", suggestion.prev, { desc = "Previous Copilot suggestion" })
		vim.keymap.set("i", "<M-\\>", suggestion.dismiss, { desc = "Dismiss Copilot suggestion" })
		vim.keymap.set("i", "<M-P>", suggestion.toggle_auto_trigger, { desc = "Toggle Copilot auto trigger" })
		vim.keymap.set("n", "<M-P>", suggestion.toggle_auto_trigger, { desc = "Toggle Copilot auto trigger" })
	end,
}
