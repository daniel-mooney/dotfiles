-- Auto-adds paired characters e.g. closing braces, "", etc
return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
    	local npairs = require('nvim-autopairs')
		npairs.setup({})

		-- local rule = require('nvim-autopairs.rule')
		-- local cond = require('nvim-autopairs.conds')
		--
		-- -- Custom pair rules
		-- npairs.add_rules({
		-- 	rule("<", ">")
		-- 		:with_move(cond.move_right())
		-- })
    end
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
}
