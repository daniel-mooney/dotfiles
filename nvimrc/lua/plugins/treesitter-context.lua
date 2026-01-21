-- Keeps scope context at the top of the screen when scrolling
return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
		{"nvim-treesitter/nvim-treesitter"},
	},
	config = function ()
		local tree_ctx = require("treesitter-context")
		
		-- See github for setup documentation
		tree_ctx.setup({
			multiwindow = true,
		})
	end
}
