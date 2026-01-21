-- Adds indentation line guides i.e. lines showing scope
return {
	"lukas-reineke/indent-blankline.nvim",
	main= "ibl",
	opts = {},
	config = function ()
		require("ibl").setup({})
	end
}
