-- Multiple cursor functionality
return {
	"mg979/vim-visual-multi",
	event = "VeryLazy",
	config = function ()
		vim.g.VM_default_mappings = 0

		-- TODO: get better cursor highlighting
		-- Key mappings. ĉ = <C-S> + J, Ċ = <C-S> + K
		vim.keymap.set("n", "ĉ", "<Plug>(VM-Add-Cursor-Down)", { desc = "Add Cursor Down" })
		vim.keymap.set("n", "Ċ", "<Plug>(VM-Add-Cursor-Up)", { desc = "Add Cursor Up" })
	end
}
