return {
	"danymat/neogen", 
	version = "*",
	config = function ()
		-- Keymapping to generate documentation scaffold
		local neogen = require('neogen')
		neogen.setup()

		vim.keymap.set("n", "<leader>nd", function ()
			neogen.generate()
		end, { silent = true, desc = "Auto generate a documentation scaffold for the current function"} )
	end
}
