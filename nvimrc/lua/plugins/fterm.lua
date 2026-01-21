return {
	"numToStr/FTerm.nvim",
	config = function ()
		local fterm = require("FTerm")

		fterm.setup({
			cmd = os.getenv("SHELL"),
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
			border = "rounded"
		})

		-- Keybindings
		vim.keymap.set('n', '<leader><tab>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
    	vim.keymap.set('t', '<esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
	end
}
