-- Adds a vertical guide line that is nicer than the builtin.
local highlight_group = "VirtColumn"

-- Command that runs after the "ColorScheme" event
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- set the vertical line color
		vim.api.nvim_set_hl(0, highlight_group, { fg = "#353857" })
	end,
})

return {
	"lukas-reineke/virt-column.nvim",
	opts = {
		virtcolumn = "80",
		highlight = highlight_group,
	},
}
