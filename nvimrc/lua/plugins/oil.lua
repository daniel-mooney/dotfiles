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

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open oil in parent directory" })

		-- -- Run on oil start up:
		-- local ran = false
		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "OilEnter",
		-- 	callback = function ()
		-- 		if ran then return end
		-- 		ran = true
		--
		-- 		-- Initially have preview open
		-- 		local entry = oil.get_cursor_entry()
		-- 		if entry then
		-- 			oil.open_preview()
		-- 		end
		-- 	end
		-- })
	end
}
