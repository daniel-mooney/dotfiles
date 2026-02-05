-- Godsend Netrw replacement + more
return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function ()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		local oil = require('oil')
		oil.setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true
			}
			-- TODO: Explicitly have oil open preview on right, rather than relying on nvim default split to right
			-- float = {
			-- 	preview_split = "right",
			-- },
		})
	end
}
