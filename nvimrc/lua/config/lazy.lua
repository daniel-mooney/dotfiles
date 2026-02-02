-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		require('plugins.colorscheme'),
		require('plugins.treesitter'),
		require('plugins.lsp'),
		require('plugins.virt_column'),
		require('plugins.lazydev'),
		require('plugins.nvim_autopairs'),
		require('plugins.telescope'),
		require('plugins.vim_visual_multi'),
		require('plugins.indent_blankline'),
		require('plugins.which_key'),
		require('plugins.git_integrations'),
		require('plugins.lualine'),
		require('plugins.fterm'),
		require('plugins.treesitter-context'),
		require('plugins.neogen'),
		require('plugins.oil'),
		require('plugins.vim-illuminate')
	}
})
