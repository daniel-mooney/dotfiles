return {
	'rcarriga/nvim-notify',
	config = function()
		--  Animations have a set period of time which cannot be configured
		--  timeout is a period of time between the end of the start and the
		--  start of the end of the animation.
		require('notify').setup({
			timeout = 500,
			-- stages = 'static',
		})

		vim.notify = require('notify')
	end
}
