-- Provides language syntax highlighting
local langs = {
	"lua", "rust", "c", "cpp", "python", "markdown", "make", "cmake"
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- install parsers (async; wait if you want it done before UI)
		require("nvim-treesitter").install(langs)

		-- enable highlighting via Neovim (plugin does not auto-enable it)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = langs,
			callback = function() vim.treesitter.start() end,
		})
	end,
}
