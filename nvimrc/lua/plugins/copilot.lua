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
				-- auto_trigger = true,
				debounce = 15,
				hide_during_completion = false,
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

		-- Globally toggle auto_trigger. Pluggin auto trigger is only per buffer
		local copilot_auto_trigger = true

		local function set_copilot_auto_trigger(state)
			copilot_auto_trigger = state
			-- Apply to all current buffers
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					vim.b[buf].copilot_suggestion_auto_trigger = state
				end
			end
		end

		local function toggle_copilot_auto_trigger()
			set_copilot_auto_trigger(not copilot_auto_trigger)
		end

		-- Apply global state to every new buffer
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				vim.b.copilot_suggestion_auto_trigger = copilot_auto_trigger
			end,
		})

		-- Keybind to toggle
		vim.keymap.set({"i", "n"}, "<M-P>", toggle_copilot_auto_trigger, { desc = "Toggle Copilot auto-trigger (global)" })
	end,
}
