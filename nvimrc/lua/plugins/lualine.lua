-- Shows a status line on the bottom of the page
return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		require('lualine').setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				refresh = {
					refresh_time = 16,
				}
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		})
	end
}
