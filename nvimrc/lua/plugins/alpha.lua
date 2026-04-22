return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-mini/mini.icons' },
	config = function ()
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
			dashboard.button("r", "󱋡  Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "  Configuration", ":Oil ~/.config/nvim <CR>"),
			dashboard.button("q", "󰈆  Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(dashboard.config)
	end
};
